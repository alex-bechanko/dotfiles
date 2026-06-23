{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.programs.jujutsu.enable {
    home.packages = [ pkgs.jj-fix-git-lfs ];
    programs.jujutsu.settings = {
      aliases = {
        fix-git-lfs = [
          "util"
          "exec"
          "--"
          "jj-fix-git-lfs"
        ];
      };
      user.name = "Alex Bechanko";
    };
  };
}
