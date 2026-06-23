{ config, lib, ... }:
{
  config.programs.bash = lib.mkIf config.programs.bash.enable {
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
      else
        echo "~/.profile.work not found, skipping"
      fi
      if ! aws sts get-caller-identity &>/dev/null; then
        echo "AWS credentials expired or missing, logging in..."
        aws sso login
      fi
    '';
    shellAliases = {
      home-manager = "home-manager --flake $DOTFILES";
      diff = "diff --color -u";
      ls = "ls --color=auto";
    };
  };
}
