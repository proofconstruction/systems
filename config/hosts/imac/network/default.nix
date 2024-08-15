{ config
, ...
}:

{
  config = {
    networking = {
      computerName = "imac";
      hostName = "imac";
      knownNetworkServices = [ "AX88179A" "USB 10/100/1000 LAN" "Wi-Fi" ];
    };
  };
}
