{
  config,
  pkgs,
  ...
}:
{
  imports = [ ];

  fonts.fontconfig.enable = true;

  home = {
    username = "alex";

    homeDirectory = "/home/alex";

    packages = with pkgs; [
      bc
      bitwarden-desktop
      nerd-fonts.inconsolata
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      tree
      unzip
      xclip
      zip
    ];

    sessionPath = [
      "/home/alex/.local/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "22.11";
  };

  nvim.enable = true;

  programs = {
    antigravity-cli.enable = true;
    bash.enable = true;
    bat.enable = true;
    fd.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;

    alacritty = {
      enable = true;
      theme = "gruvbox_dark";
      settings = {
        window.startup_mode = "Maximized";
        window.decorations = "None";
        font.size = 10.0;
        font.bold.family = "IosevkaTerm Nerd Font";
        font.bold.style = "Bold";
        font.normal.family = "IosevkaTerm Nerd Font";
        font.normal.style = "Regular";
        terminal.shell.program = "zellij";
      };
    };

    discord = {
      enable = true;
      settings = {
        enableHardwareAcceleration = true;
        openH264Enabled = true;
      };
    };

    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Alex Bechanko";
          email = "alexbechanko@gmail.com";
        };
        init.defaultBranch = "main";
        core.pager = "less";
      };
      signing.format = null;
      ignores = [
        ".envrc"
        ".direnv/"
        "*.swp"
        "*.log"
        "result"
      ];
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Alex Bechanko";
          email = "alexbechanko@gmail.com";
        };
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

    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      exitShellOnExit = true;
      settings = {
        theme = "gruvbox-dark";
        copy_command = "xclip -selection clipboard";
        copy_on_select = true;
      };
      extraConfig = ''
        keybinds {
        normal {
          unbind "Ctrl q"
          bind "Alt s" {
            Run "periodic-note" "day" {
              floating true
              x "0"
              y "0"
              width "100%"
              height "50%"
              close_on_exit true
            }
          }
        }
        session {
          bind "Ctrl q" {
            Quit
          }
        }
        }
      '';

    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      shellAliases = {
        home-manager = "home-manager --flake /home/alex/Projects/github.com/alex-bechanko/dotfiles#alex@tyr";
        diff = "diff --color -u";
      };
    };
  };

  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
}
