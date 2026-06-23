{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.programs.gh.settings = lib.mkIf config.programs.gh.enable {
    extensions = [ pkgs.gh-markdown-preview ];
    git_protocol = "1";
    prompt = "enabled";
  };
}
