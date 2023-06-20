{ config, pkgs, ... }:

{
  virtualisation.arion.projects = {
    "swag" = settings.services."swag".service = {
      image = "";
      restart = "unless-stopped";
    };
  };
}
