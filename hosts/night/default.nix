{ config, pkgs, ... }:


{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # System defaults
      ../../modules/system.nix
    ];
  
  nixpkgs.config.allowUnfreePredicate = (pkg: true); # wacky workaround

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Podman stuff
    podman-compose
    slirp4netns
    redir

    # UPS tools
    nut
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dark = {
    isNormalUser = true;
    description = "dark";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman" 
    ];
    subUidRanges = [ 
      {
        count = 65535;
	startUid = 131072;
      }
    ];
    subGidRanges = [ 
      {
        count = 65535;
	startGid = 131072;
      }
    ];
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDq5AlWizFRK6H4QsTdaVNehWmjbJDdNYFHl2WFJg94Btn1WLIGr8QnQfQ9B6xrN+1k/2WKwqEZBGZkDdnjNLzb+ab0WrhNCb0va2VnXfL+TAat9+Z0pIfkNAiZK4Exx0foUSMDzAl0yoxFT/1gltuHZgt0uo/WGipmgGdJt4G5t9FodoD49TO7YcWniukroK2IoU47ZVRk67aqS0n8y0o1/x+tPdJsVBvJdRhm4aD5IjMZthhHU4XTI+1WF9etQ7DhBwuIfakJfuuRR5z38NBp2506xudXGRZfE1ySACdhDab/K7s5uAgOoWm/0u213jV4veE5RO/C9rtwRWNe90+KOEb+Y9JoYa+nc6X83jx16AaX+xL3n6ZqJIq+s80H8XTKSlIpEWAGc4S9+2hvpfRxSQCLVHyFY0wkjlTxCvlXT2G1jt2Jtl2ZJCMyAjMXsRMCpg+tfHZsSuiudZ4/3+GBEvaI9tB6pqZZcu0EH9wE+VWhHCfVmfFXvg8v/CCKfg8= flint@steel"
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
    networkmanager.enable = true; # Enables internet via networkManager. Mutually exclusive with wpa_supplicant
    #networkmanager.dhcp = "internal";
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    #useDHCP = true;
    #dhcpcd.enable = false;
    defaultGateway = "192.168.0.1"; # Sets default gateway
    nameservers = [ "8.8.8.8" ];
    #interfaces.enp4s0.useDHCP = true;
    interfaces.enp4s0.ipv4.addresses = [ {
      address = "192.168.0.3";
      prefixLength = 24;
    } ];

    # Open ports in the firewall.
    firewall.enable = true;
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    firewall.extraCommands = ''
      iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
      iptables -A INPUT -p tcp -s localhost --dport 25575 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 8112 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 6767 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 7878 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 8989 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 8686 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 9696 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 5055 -j ACCEPT
      iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport 8096 -j ACCEPT
      iptables -A INPUT -p udp -s 192.168.0.0/16 --dport 7359 -j ACCEPT
      iptables -A INPUT -p udp -s 192.168.0.0/16 --dport 1900 -j ACCEPT
      iptables -A INPUT -p tcp --dport 25575 -j DROP
    '';
      # Minecraft
      # Minecraft RCON
      # Deluge webconfig
      # bazarr
      # radarr
      # sonarr
      # lidarr
      # prowlarr
      # jellyseerr
      # jellyfin
      # jellyfin discovery
      # jellyfin DNLA
      # DROP all else

    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
