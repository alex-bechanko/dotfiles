{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.agenix-cli;
in
{
  options.programs.agenix-cli = {
    enable = lib.mkEnableOption "Agenix command line interface";
    package = lib.mkPackageOption pkgs "agenix-cli" { };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
