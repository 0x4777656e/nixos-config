{
  project.name = "duckdns";
  services.duckdns = { pkgs, lib, ... }: {
    nixos = {
      useSystemd = false;
      configuration.boot.tmpOnTmpfs = true;
      configuration.services.logrotate = {
        enable = true;
        settings = {
          "/var/log/duckdns.log" = {
            frequency = "daily";
	    rotate = 8;
          };
        };
      };
    };
    service.useHostStore = true;
    image.contents = [ pkgs.echo pkgs.curl ];
    image.command = [
      "echo" "'*/10 * * * * /app/duckdns.sh'" ">>" "/etc/crontab"
    ];
    service.volumes = [ "/home/flint/projects/nixos-config/containers/duckdns/root:/" ];
  };
}
