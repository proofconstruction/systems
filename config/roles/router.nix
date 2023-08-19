{ config
, pkgs
, lib
, ...
}:

let
  cfg = config.networking.interfaces;
  WAN = cfg.wan.name;
  LAN = cfg.lan.name;
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
        ipv4.addresses = [{ address = "10.0.0.1"; prefixLength = 24; }];
      };

      nftables = {
        enable = true;
        ruleset = ''
          flush ruleset

          define LAN = ${LAN}
          define WAN = ${WAN}

          table ip global {
              chain inbound_private_lan {
                  # allow pinging
                  icmp type echo-request limit rate 5/second accept

                  # allow dhcp, dns and ssh
                  ip protocol . th dport vmap { tcp . 22 : accept, udp . 53 : accept, tcp . 53 : accept, udp . 67 : accept}
              }

              chain inbound {
                  type filter hook input priority 0; policy drop;

                  ct state vmap { established : accept, related : accept, invalid : drop }

                  # allow loopback traffic and specified lan traffic
                  # drop everything else including inbound traffic from outside the lan
                  iifname vmap { lo : accept, $LAN : jump inbound_private_lan }
              }

              chain forward {
                  type filter hook forward priority 0; policy drop;
                  # allow trusted lan connections to egress to wan
                  iifname { $LAN } oifname { $WAN } accept
                  # allow established/related connections to return traffic back to lan
                  iifname { $WAN } oifname { $LAN } ct state { established, related } accept

                  # connections from the internal network to the internet are allowed
                  iifname $LAN accept
              }

               # allow all other outgoing connections
               chain output {
                   type filter hook forward priority 0;
                   accept
               }

              chain postrouting {
                  type nat hook postrouting priority 100; policy accept;

                  # masquerade private ip addresses
                  oifname $WAN counter masquerade
              }
          }
        '';
      };
    };

    # assign addresses to LAN devices
    services.dhcpd4 = {
      enable = true;
      interfaces = [ LAN ];
      extraConfig = ''
        subnet 10.0.0.0 netmask 255.255.255.0 {
          option routers 10.0.0.1;
          option domain-name-servers 8.8.8.8;
          option subnet-mask 255.255.255.0;
          interface ${LAN};
          range 10.0.0.2 10.0.0.254;
        }
      '';
    };

    environment.systemPackages = with pkgs; [ dnsmasq bridge-utils ];
  };
}
