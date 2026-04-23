{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs._1password-gui;
in
{
  options.programs._1password-gui = {
    enable = lib.mkEnableOption "1password gui interface";
    package = lib.mkPackageOption pkgs "_1password-gui" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
