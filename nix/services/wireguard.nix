{ pkgs, ... }:

{
  networking.nat.enable = true; # Enable NAT to allow VPN clients to access external networks
  networking.nat.externalInterface = "eth0"; # Specify the external (internet-facing) interface
  networking.nat.internalInterfaces = [ "wg0" ]; # Specify the internal (VPN) interface
  networking.firewall = { # Configure firewall to allow WireGuard traffic
    allowedUDPPorts = [ 51820 ]; # Allow UDP traffic on WireGuard's default port
  };
  # Enable WireGuard
  networking.wireguard.interfaces = {
    wg0 = {
      # Server's private key (from /etc/wireguard/privatekey)
      privateKeyFile = "/etc/wireguard/privatekey"; # Path to the server's private key

      # Listen on UDP port 51820 (WireGuard default)
      listenPort = 51820; # WireGuard server listens on this UDP port

      # IP address for the server on the VPN subnet
      # This is NOT your home LAN IP (we'll bridge them later)
      ips = [ "10.8.0.1/24" ]; # Assign the server an IP address on the VPN subnet

      # NAT configuration to route traffic to your home LAN
      postSetup = '' # Add NAT rule to route VPN traffic to the external interface
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
      '';
      postShutdown = '' # Remove NAT rule when WireGuard stops
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
      '';

      # Define your clients (peers)
      peers = [
        {
          # Client's public key (replace with your client's key)
          publicKey = "H1O3M/PnEOb3NOeuSi3MJ+9o1EXNhZ4Avc7v1MmS/kE="; # Replace with the client's public key
          # Allowed IPs for this client (VPN IP + home LAN access)
          allowedIPs = [ # Define the networks the client can access
            "0.0.0.0/0" # Allow the client to access any network (internet and beyond)
            "192.168.1.0/24" # Allow the client to access the local network (LAN)
          ];
        }
      ];
    };
  };

# Enable IP forwarding (to route traffic between VPN and LAN)
# - `iptables -A FORWARD -i wg0 -o eth0 -j ACCEPT`: 
# Allows traffic from the VPN interface (`wg0`) to the external interface (`eth0`).
# - `iptables -A FORWARD -i eth0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT`: 
# Allows return traffic from the external interface (`eth0`) to the VPN interface (`wg0`).
# - `iptables -A FORWARD -i wg0 -o br0 -j ACCEPT`: 
# Allows traffic from the VPN interface (`wg0`) to the LAN interface (`br0`).
# - `iptables -A FORWARD -i br0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT: 
# Allows return traffic from the LAN interface (`br0`) to the VPN interface (`wg0`).

  networking.firewall.extraCommands = '' # Add firewall rules to forward traffic between VPN and LAN
    ;
        iptables -A FORWARD -i wg0 -o eth0 -j ACCEPT 
        ## Allows traffic from the VPN interface (`wg0`) to the external interface (`eth0`).
        iptables -A FORWARD -i eth0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
        iptables -A FORWARD -i wg0 -o br0 -j ACCEPT # Allow forwarding to LAN
        iptables -A FORWARD -i br0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  '';
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1; # Enable IP forwarding to route traffic between networks
}
