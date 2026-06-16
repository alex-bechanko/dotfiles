{
  config,
  pkgs,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/Projects/github.com/alex-bechanko/dotfiles";
in
{
  imports = [
    ../modules/identity.nix
  ];
  age.secrets.gemini_api_key.file = ../../secrets/gemini_api_key.age;

  home.packages = [ pkgs.agenix-cli ];

  home.sessionVariables = {
    GEMINI_API_KEY = "$(cat ${config.age.secrets.gemini_api_key.path})";
  };

  programs = {
    antigravity-cli.enable = true;

    bash.initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';

    discord = {
      enable = true;
      settings = {
        enableHardwareAcceleration = true;
        openH264Enabled = true;
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        hostname = {
          ssh_only = false;
          format = "[$hostname]($style) ";
        };

        # Disable built-in git modules (replaced by custom modules below)
        git_status.disabled = true;
        git_commit.disabled = true;
        git_metrics.disabled = true;
        git_branch.disabled = true;

        custom = {
          # Custom module for jj status
          jj = {
            description = "The current jj status";
            when = "jj --ignore-working-copy root";
            symbol = "🥋 ";
            command = ''
              jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
                separate(" ",
                  change_id.shortest(4),
                  bookmarks,
                  "|",
                  concat(
                    if(conflict, "💥"),
                    if(divergent, "🚧"),
                    if(hidden, "👻"),
                    if(immutable, "🔒"),
                  ),
                  raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
                  raw_escape_sequence("\x1b[1;32m") ++ coalesce(
                    truncate_end(29, description.first_line(), "…"),
                    "(no description set)",
                  ) ++ raw_escape_sequence("\x1b[0m"),
                )
              '
            '';
          };

          git_status = {
            when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1 && ! jj --ignore-working-copy root >/dev/null 2>&1";
            command = "starship module git_status";
            style = "";
            description = "Only show git_status if we are in a Git repo but NOT a jj repo";
          };

          git_commit = {
            when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1 && ! jj --ignore-working-copy root >/dev/null 2>&1";
            command = "starship module git_commit";
            style = "";
            description = "Only show git_commit if we are in a Git repo but NOT a jj repo";
          };

          git_metrics = {
            when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1 && ! jj --ignore-working-copy root >/dev/null 2>&1";
            command = "starship module git_metrics";
            style = "";
            description = "Only show git_metrics if we are in a Git repo but NOT a jj repo";
          };

          git_branch = {
            when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1 && ! jj --ignore-working-copy root >/dev/null 2>&1";
            command = "starship module git_branch";
            style = "";
            description = "Only show git_branch if we are in a Git repo but NOT a jj repo";
          };
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      shellAliases = {
        home-manager = "home-manager --flake ${dotfilesDir}#${config.home.username}@${config.dotfiles.host}";
        diff = "diff --color -u";
        dotfiles = "cd ${dotfilesDir}";
      };
    };
  };
}
