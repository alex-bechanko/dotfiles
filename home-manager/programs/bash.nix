{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.programs.bash.enable {
    home.packages = [
      pkgs.vivid
    ];
    programs.bash = {
      historySize = 100000;
      historyFileSize = 200000;
      historyControl = [
        "ignorespace"
        "ignoredups"
        "erasedups"
      ];
      historyIgnore = [
        "ls"
        "ll"
        "la"
        "cd"
        "pwd"
        "exit"
        "clear"
      ];
      shellOptions = [ "histappend" ];
      initExtra = ''
        HISTTIMEFORMAT="%F %T  "
        PROMPT_COMMAND="''${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

        export PS1="\[\033[38;5;142m\]\u\[\033[38;5;223m\]@\[\033[38;5;108m\]\h\[\033[00m\]:\[\033[01;38;5;109m\]\w\[\033[38;5;208m\]\$\[\033[00m\]"
        export LS_COLORS="$(vivid generate gruvbox-dark)"
        if [ -f ~/.profile.work ]; then
          source ~/.profile.work
        fi
      '';
      shellAliases = {
        home-manager = "home-manager --flake $DOTFILES";
        diff = "diff --color -u";
        ls = "ls --color=auto";
      };
    };
  };
}
