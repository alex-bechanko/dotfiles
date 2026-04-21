{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.slack;
in
{
  options.programs.slack = {
    enable = lib.mkEnableOption "Slack messenger";
    package = lib.mkPackageOption pkgs "slack" { };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };

}
