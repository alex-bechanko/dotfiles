{ config, lib, ... }:
{
  config.programs.git = lib.mkIf config.programs.git.enable {
    ignores = [
      ".envrc"
      ".direnv/"
      "*.swp"
      "*.log"
      "result"
    ];

    lfs.enable = true;

    settings = {
      core.pager = "less";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      difftool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      init.defaultBranch = "main";
      pull.ff = "only";
      user.name = "Alex Bechanko";
    };

    signing.format = null;
  };
}
