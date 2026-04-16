{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bitwarden-desktop;
in
{
  options.programs.bitwarden-desktop = {
    enable = lib.mkEnableOption "Bitwarden desktop gui";
    package = lib.mkPackageOption pkgs "bitwarden-desktop" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
