{ config, pkgs, ... }:


{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # System defaults
      ../../modules/system.nix
      ../../modules/plasma.nix

      # Docker+Arion base
      ../../modules/arion.nix
      # Docker applications
      #../../modules/docker/swag.nix
      #../../modules/docker/duckdns.nix
      #../../modules/docker/minecraft.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flint = {
    isNormalUser = true;
    description = "Gwen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman" 
    ];
    packages = with pkgs; [
    #  firefox
    #  kate
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [
      # TODO put a key here
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};


  networking = {
    hostName = "night"; # Define your hostname.
    networkmanager.enable = true;
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    #defaultGateway = "x.x.x.x"; # Sets default gateway

    # Open ports in the firewall.
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #firewall.enable = false;

    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
