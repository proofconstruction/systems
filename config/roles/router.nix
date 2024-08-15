{ config
, pkgs
, lib
, ...
}:

let
  cfg = config.networking.interfaces;
  WAN = cfg.wan.name;
  LAN = cfg.lan.name;

  dns = {
    google = [ "8.8.8.8" "8.8.4.4" ];
    quad9 = [ "9.9.9.9" ];
  };

  internalPrefix = "10.10.10";
  gateway = "10.0.0.1";
  wanMask = 32;
  lanMask = 24;
  hostSuffix = 1;
  routerAddr = internalPrefix + "." + (toString hostSuffix);
  cidrBlock = internalPrefix + ".0/${toString lanMask}";
  blockMin = 2;
  blockMax = 254;
  dhcpRange = "${internalPrefix}.${toString blockMin},${internalPrefix}.${toString blockMax}";
  leaseDurationHours = 12;
  dhcpRangeWithLeaseDuration = dhcpRange + "," + (toString leaseDurationHours) + "h";
in
{
  options.roles.router = lib.mkEnableOption "stuff for my home router";

  config = lib.mkIf config.roles.router {
    mine.redistributableFirmware.enable = true;

    boot.kernel.sysctl = {
      "net.ipv4.conf.all.forwarding" = true;
    };

    networking = {
      interfaces.${LAN} = {
        useDHCP = false;
        ipv4.addresses = [{ address = gateway; prefixLength = wanMask; }];
      };

      nftables =
        let
          buildChains = name: cfg: "chain ${name} " + cfg;

          chains = {
            inbound_private_lan = ''{
              # allow pinging
              icmp type echo-request limit rate 5/second accept

              # allow dhcp, dns and ssh
              ip protocol . th dport vmap { tcp . 22 : accept, udp . 53 : accept, tcp . 53 : accept, udp . 67 : accept}
            }'';

            inbound = ''{
              type filter hook input priority 0; policy drop;

              ct state vmap { established : accept, related : accept, invalid : drop }

              # allow loopback traffic and specified lan traffic
              # drop everything else including inbound traffic from outside the lan
              iifname vmap { lo : accept, ${LAN} : jump inbound_private_lan }
            }'';

            forward = ''{
              type filter hook forward priority 0; policy drop;
              # allow trusted lan connections to egress to wan
              iifname { ${LAN} } oifname { ${WAN} } accept
              # allow established/related connections to return traffic back to lan
              iifname { ${WAN} } oifname { ${LAN} } ct state { established, related } accept

              # connections from the internal network to the internet are allowed
              iifname ${LAN} accept
            }'';

            output = ''{
              # allow all other outgoing connections
              type filter hook forward priority 0;
              accept
            }'';

            postrouting = ''{
              type nat hook postrouting priority 100; policy accept;

              # masquerade private ip addresses
              oifname ${WAN} counter masquerade
            }'';
          };
        in
        {
          enable = true;
          flushRuleset = true;
          tables = {
            global = {
              enable = true;
              family = "ip";
              content = lib.mapAttrs buildChains chains;
            };
          };
        };
    };

    services = {
      # SSH
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
      };

      # VPN
      tailscale = {
        enable = true;
        useRoutingFeatures = "both";
        extraUpFlags = [
          "--ssh"
          "--advertise-routes=${cidrBlock}"
          "--snat-subnet-routes=false"
          "--accept-routes"
        ];
      };

      # DHCP
      dnsmasq = {
        enable = true;
        resolveLocalQueries = true;
        settings = {
          log-queries = true;
          server = with dns; google ++ quad9;
          domain-needed = true;
          expand-hosts = true;
          bogus-priv = true;
          dhcp-range = [ dhcpRangeWithLeaseDuration ];
          dhcp-option = [
            "option:router,${routerAddr}"
            "option:dns-server,${routerAddr}"
          ];
          dhcp-authoritative = true;
          listen-address = [ "127.0.0.1" routerAddr ];
          interface = [ LAN WAN ];
          domain = config.networking.domain;
        };
      };
    };

    environment.systemPackages = with pkgs; [ dnsmasq bridge-utils ];
  };
}
