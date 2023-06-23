{ config, pkgs, ... }:

{
  # Set your time zone
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

#  fonts = {
#    fonts = with pkgs; [
      # icon fonts
#      material-design-icons

      # normal fonts
#      noto-fonts
#      noto-fonts-cjk
#      noto-fonts-emoji

      # nerdfonts
#      (derdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
#    ];

    # Use specified fonts
#    enableDefaultFonts = false;

    # User defined fonts
#    fontconfig.defaultFonts = {
#      serif = [ "Noto Serif" "Noto Color Emoji" ];
#      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
#      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
#      emoji = [ "Noto Color Emoji" ];
#    };
#  };
  
  # Open ports in the firewall
  #networking.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether
  #networking.firewall.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search packageName
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    curl
    iptables
    git
    sysstat
    hyfetch
    ranger
  ];

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  # List services that you want to enable:
  services = {
    # Enable pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };

    # Enable the OpenSSH daemon
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
	PasswordAuthentication = false;
	LogLevel = "VERBOSE";
      };
      openFirewall = true;
    };

    # Enable the Fail2Ban service
    fail2ban = {
      enable = true;
    };
  };
}
