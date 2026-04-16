{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.unzip;
in
{
  options.programs.unzip = {
    enable = lib.mkEnableOption "unzip - list, test and extract compressed files in a ZIP archive";
    package = lib.mkPackageOption pkgs "unzip" { };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
