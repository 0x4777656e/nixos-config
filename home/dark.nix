{ config, pkgs, nixpkgs, ... }:

{
  home.username = "dark";
  home.homeDirectory = "/home/dark";
  
  imports = [
  ];

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
  #  userName = "0x4777656e";
  #  userEmail = "137141797+0x4777656e@users.noreply.github.com";
  #};

  # user profile packages
  home.packages = with pkgs; [
    # basic
    hyfetch
    ranger

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq
    yq-go
    exa
    fzf

    wget
    curl

    # networking
    mtr
    #iperf3
    dnsutils
    ldns # replaces dig with drill
    aria2 # command-line download utility
    socat # replaces netcat
    ipcalc # ipv4/6 calculator

    # misc.
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix stuff
    nix-output-monitor # replaces nix with nom, provides more detailed logs

    # productivity
    glow # terminal markdown previewer

    btop
    iotop # io monitoring
    iftop # network monitoring

    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="/home/dark/.local/bin:"$PATH
      export EDITOR=nvim

      # if not running interactively, skip
      [[ $- != *i* ]] && return

      # if logged in via ssh, allow processes to continue when the connection is closed
      if [[ -n $SSH_CONNECTION ]] ; then
          loginctl enable-linger
      fi

      # append to history file instead of overwriting
      shopt -s histappend

      # see bash(1)
      HISTSIZE=1000
      HISTFILESIZE=2000
      
      # dynamically update terminal rows/cols
      shopt -s checkwinsize

      # make less better for non-text
      [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
      
      # set color prompt
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      if [ "$color_prompt" = yes ]; then
          PS1='[\[\033[01;38;5;134m\]\u@\h\[\033[00m\]] \[\033[01;30m\]\w\[\033[00m\] \$ '
      else
          PS1='[\u@\h \W] \$'
      fi
      unset color_prompt
    '';

    shellAliases = {
      # colors
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      
      # misc.
      sudo = "sudo ";
      ll = "ls -lAh";
      please = "sudo $(history -p !!)";
      resource = "source ~/.bashrc";
      nc = "socat";

      # nix
      nix-sys = "nix-env --profile /nix/var/nix/profiles/system";

      # python
      py = "python3";
      pyserv = "python3 -m http.server";
    };
  };

  # enable starship
  #programs.starship = {
  #  enable = true;
  #  settings = {
  #    add_newline = false;
  #    aws.disabled = true;
  #    gcloud.disabled = true;
  #    line_break.disabled = true;
  #  };
  #};

  # Konsole (idk if this is necessary)
  #programs.Konsole = {
  #  enable = true;
  #  env.TERM = "xterm-256color";
  #};

  # configuration version compatibility
  home.stateVersion = "23.05";

  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
