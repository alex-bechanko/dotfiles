{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.onepassword;
in
{
  # NOTE: This does NOT install 1Password. On skoll the desktop app is the
  # system apt/deb package (/opt/1Password). This module only autostarts that
  # already-installed app at login so the Firefox extension never has to
  # cold-start it (which surfaces a transient "unable to connect" error).
  options.programs.onepassword = {
    enable = lib.mkEnableOption "1Password desktop autostart";

    package = lib.mkOption {
      type = lib.types.str;
      default = "/opt/1Password/1password";
      description = "Path to the 1Password desktop binary to launch at login.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.onepassword = {
      Unit = {
        Description = "1Password desktop app (autostart for browser integration)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        # --silent starts the app minimized to the tray without opening a window.
        ExecStart = "${cfg.package} --silent";
        Restart = "on-failure";
        RestartSec = 3;
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
