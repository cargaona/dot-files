{ pkgs, ... }:
{
  systemd.services.docker-compose-myapp = {
    description = "Start docker Compose stack for MyApp";
    after = [
      "docker.service"
      "network.target"
    ]; # Wait for docker and network
    requires = [ "docker.service" ];
    path = [
      pkgs.docker
    ]; # Add docker and Compose to PATH
    serviceConfig = {
      # User = "char";
      # Group = "wheel";
      Type = "oneshot";
      RemainAfterExit = true; # Mark service as "active" after exit
      WorkingDirectory = "/home/char/projects/personal/code/home-server/"; # Directory with docker-compose.yml
      ExecStart = "${pkgs.docker}/bin/docker compose up -d"; # Start containers
      ExecStop = "${pkgs.docker}/bin/docker compose down"; # Stop containers
    };
    wantedBy = [ "multi-user.target" ]; # Start at boot
  };
}
