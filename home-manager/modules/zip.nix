{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.zip;
in
{
  options.programs.zip = {
    enable = lib.mkEnableOption "zip - package and compress (archive) files";
    package = lib.mkPackageOption pkgs "zip" { };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
