{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.programs.zsh.enable {
    home.packages = [
      pkgs.vivid
    ];
    programs.zsh = {
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      shellAliases = {
        home-manager = "home-manager --flake $DOTFILES";
        diff = "diff --color -u";
      };

      initExtra = ''
        export LS_COLORS="$(vivid generate gruvbox-dark)"
      '';
    };
  };
}
