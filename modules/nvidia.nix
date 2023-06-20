{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
  };
  
  # BROKEN
  #services.xserver.screenSection = ''
  #  Option	"metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
  #  Option	"AllowIndirectGLXProtocol" "off"
  #  Option	"TripleBuffer" "on"
  #'';
}   
