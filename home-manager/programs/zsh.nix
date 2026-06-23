{ config, lib, ... }:
{
  config.programs.zsh = lib.mkIf config.programs.zsh.enable {
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = {
      home-manager = "home-manager --flake $DOTFILES";
      diff = "diff --color -u";
    };
  };
}
