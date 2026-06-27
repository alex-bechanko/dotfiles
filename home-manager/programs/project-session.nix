{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.project-session;
in
{
  options.programs.project-session = {
    enable = lib.mkEnableOption "project-session";

    defaultCommand = lib.mkOption {
      type = lib.types.str;
      default = "claude";
      description = "The command to run in the second pane of the project session.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "project-session" ''
        if [ $# -eq 0 ]; then
          exec ${pkgs.project-session}/bin/project-session
        fi
        PROJECT_PATH="$1"
        shift
        if [ $# -eq 0 ]; then
          exec ${pkgs.project-session}/bin/project-session "$PROJECT_PATH" ${lib.escapeShellArgs (lib.splitString " " cfg.defaultCommand)}
        else
          exec ${pkgs.project-session}/bin/project-session "$PROJECT_PATH" "$@"
        fi
      '')
    ];
  };
}
