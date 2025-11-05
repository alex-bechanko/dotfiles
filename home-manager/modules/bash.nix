{ username, hostname, ... }:
{
  programs.bash = {
    enable = true;

    initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';

    shellAliases = {
      home-manager = "home-manager --flake /home/alex/Projects/github.com/alex-bechanko/dotfiles#${username}@${hostname}";
      diff = "diff --color -u";
      grep = "grep -Hn";
      dotfiles = "cd /home/alex/Projects/github.com/alex-bechanko/dotfiles";
    };
  };

}
