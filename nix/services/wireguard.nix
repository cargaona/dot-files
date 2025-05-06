{ ... }:

{
  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
  # Enable WireGuard
  networking.wireguard.interfaces = {
    wg0 = {
      # Server's private key (from /etc/wireguard/privatekey)
      privateKeyFile = "/etc/wireguard/privatekey";

      # Listen on UDP port 51820 (WireGuard default)
      listenPort = 51820;

      # IP address for the server on the VPN subnet
      # This is NOT your home LAN IP (we'll bridge them later)
      ips = [ "10.8.0.1/32" ];

      # NAT configuration to route traffic to your home LAN
      # postSetup = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
      # '';
      # postShutdown = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
      # '';

      # Define your clients (peers)
      peers = [
        # Example client configuration (repeat for more clients)
        {
          # Client's public key (replace with your client's key)
          publicKey = "H1O3M/PnEOb3NOeuSi3MJ+9o1EXNhZ4Avc7v1MmS/kE=";
          # Allowed IPs for this client (VPN IP + home LAN access)
          allowedIPs = [
            # "10.8.0.2/32"
            "0.0.0.0/0"
            # "10.8.0.0/24"
            # "192.168.1.0/24"
          ];
        }
      ];
    };
  };

  # Enable IP forwarding (to route traffic between VPN and LAN)
  networking.firewall.extraCommands = ''
    iptables -A FORWARD -i wg0 -o eth0 -j ACCEPT
    iptables -A FORWARD -i eth0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  '';
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
