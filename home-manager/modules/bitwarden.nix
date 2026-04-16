{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.programs.bitwarden-desktop.enable = lib.mkEnableOption "Bitwarden desktop gui";
  config = lib.mkIf config.programs.bitwarden-desktop.enable {
    home.packages = [ pkgs.bitwarden-desktop ];
  };
}
