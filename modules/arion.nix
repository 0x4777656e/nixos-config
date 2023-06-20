{ config, pkgs, ... }:

{
  # Don't forget to add a user to the "podman" group

  environment.systemPackages = [
    pkgs.arion
    
    # Not needed if virtualisation.docker.enable = true
    pkgs.docker-client
  ];

  virtualisation = {
    docker.enable = false;
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.dnsname.enable = true;
    };
  };
}
