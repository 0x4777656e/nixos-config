{ config, pkgs, ... }:

{
  home.username = "flint";
  home.homeDirectory = "/home/flint";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi
  #xresources.properties = {
  #  Xcursor.size = 16;
  #  Xft.dpi = 172;
  #};

  # basic git config
  #programs.git = {
  #  enable = true;
  #  userName = "Gwenadier";
  #  userEmail = "gwen.srvr@gmail.com";
  #};

  # user profile packages
  home.packages = [
    pkgs.htop
    pkgs.btop
  ];

  # enable starship
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # Konsole (idk if this is necessary)
  programs.Konsole = {
    enable = true;
    env.TERM = "xterm-256color";
  };

  # configuration version compatibility
  home.stateVersion = "22.11";

  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
