{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bc;
in
{
  options.programs.bc = {
    enable = lib.mkEnableOption "BC - an arbitrary precision calculator language";
    package = lib.mkPackageOption pkgs "bc" { };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
