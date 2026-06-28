{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.programs.antigravity-cli = lib.mkIf config.programs.antigravity-cli.enable {
    package = pkgs.google-antigravity-cli;
    context.GEMINI = ''
      # GEMINI.md
      - always allow the user to preview code changes before applying them to the repo
    '';
  };
}
