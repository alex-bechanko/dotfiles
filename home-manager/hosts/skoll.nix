{
  pkgs,
  ...
}:
let
  username = "alexbechanko";
  host = "skoll";
  name = "Alex Bechanko";
  email = "abechanko@utilidata.com";
in
{
  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-39.8.10"
      ];
    };
  };

  imports = [
    ../modules/bc.nix
    ../modules/bitwarden-desktop.nix
    ../modules/slack.nix
    ../modules/tree.nix
    ../modules/unzip.nix
    ../modules/zip.nix

  ];

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "22.11";

    sessionPath = [
      "/home/${username}/.local/../bin"
      "/home/${username}/.local/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      PATH = "/usr/bin:/usr/sbin:$PATH";
    };

    packages = with pkgs; [
      just
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      prometheus
      tio
      vivid
      xclip
      yq

      # from this repo
      periodic-note # create daily note file
      setup-aws # little script to setup aws
      project-session # open a zellij tab for a project
      gh-actions-review-sha # little script to check commit SHAs on github actions
      towncrier # wrapper around towncrier to work sanely
      jj-fix-git-lfs # restore git lfs files in jj working copy
    ];
  };

  xdg = {
    enable = true;
    configFile."towncrier/towncrier.toml".text = ''
      [tool.towncrier]
      directory = "changelog.d"
      filename = "CHANGELOG.md"
      title_format = "## {version} - {project_date}"
      issue_format = "[{issue}](https://utilidata.atlassian.net/browse/{issue})"
      underlines = ["", "", ""]

      [[tool.towncrier.type]]
      directory = "breaking"
      name = "Breaking Changes"
      showcontent = true

      [[tool.towncrier.type]]
      directory = "feature"
      name = "New Features"
      showcontent = true

      [[tool.towncrier.type]]
      directory = "fix"
      name = "Fixes"
      showcontent = true

      [[tool.towncrier.type]]
      directory = "misc"
      name = "Miscellaneous"
      showcontent = false
    '';
  };

  fonts.fontconfig.enable = true;

  programs = {
    bat.enable = true;
    bc.enable = true;
    bitwarden-desktop.enable = true;
    fd.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
    };
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;
    slack.enable = true;
    tree.enable = true;
    unzip.enable = true;
    zip.enable = true;

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
        keyboard.bindings = [
          {
            key = "Return";
            mods = "Shift";
            chars = builtins.fromJSON ''"\u001B\r"'';
          }
        ];
      };
    };

    awscli = {
      enable = true;
    };

    bash = {
      enable = true;
      initExtra = ''
        export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
        export PS1="\[\033[38;5;142m\]\u\[\033[38;5;223m\]@\[\033[38;5;108m\]\h\[\033[00m\]:\[\033[01;38;5;109m\]\w\[\033[38;5;208m\]\$\[\033[00m\]"
        export LS_COLORS="$(vivid generate gruvbox-dark)"
        if [ -f ~/.profile.work ]; then
          source ~/.profile.work
        else
          echo "~/.profile.work not found, skipping"
        fi
      '';
      shellAliases = {
        home-manager = "home-manager --flake /home/${username}/Projects/github.com/alex-bechanko/dotfiles#${username}@${host}";
        diff = "diff --color -u";
        dotfiles = "cd /home/alex/Projects/github.com/alex-bechanko/dotfiles";
        ls = "ls --color=auto";
      };
    };

    claude-code = {
      enable = true;
      settings = {
        mcpServers = {
          atlassian = {
            type = "http";
            url = "https://mcp.atlassian.com/mcp";
          };
        };
        permissions = {
          allow = [
            "WebSearch"
            "WebFetch"
            "Read"
            "Glob"
            "Grep"
            "Bash(git status:*)"
            "Bash(git log:*)"
            "Bash(git diff:*)"
            "Bash(git branch:*)"
            "Bash(git show:*)"
            "Bash(cargo:*)"
            "Bash(jj status:*)"
            "Bash(jj log:*)"
            "Bash(jj diff:*)"
            "Bash(jj show:*)"
            "Bash(jj bookmark list:*)"
            "Bash(nix eval:*)"
            "Bash(nix flake show:*)"
            "Bash(nix flake metadata:*)"
            "Bash(nix flake info:*)"
            "Bash(nix flake check:*)"
            "Bash(nix search:*)"
            "Bash(nix path-info:*)"
            "Bash(nix derivation show:*)"
            "Bash(nix store ls:*)"
            "Bash(nix why-depends:*)"
            "Bash(gh pr view:*)"
            "Bash(gh pr list:*)"
            "Bash(gh pr diff:*)"
            "Bash(gh pr checks:*)"
            "Bash(gh issue view:*)"
            "Bash(gh issue list:*)"
            "Bash(gh run list:*)"
            "Bash(gh run view:*)"
            "Bash(gh release list:*)"
            "Bash(gh release view:*)"
            "Bash(gh repo view:*)"
            "Bash(gh api repos:*)"

            # Atlassian MCP - read/search only
            "mcp__claude_ai_Atlassian__atlassianUserInfo"
            "mcp__claude_ai_Atlassian__getAccessibleAtlassianResources"
            "mcp__claude_ai_Atlassian__search"
            "mcp__claude_ai_Atlassian__fetch"
            "mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql"
            "mcp__claude_ai_Atlassian__getJiraIssue"
            "mcp__claude_ai_Atlassian__getVisibleJiraProjects"
            "mcp__claude_ai_Atlassian__getJiraIssueRemoteIssueLinks"
            "mcp__claude_ai_Atlassian__getJiraProjectIssueTypesMetadata"
            "mcp__claude_ai_Atlassian__getJiraIssueTypeMetaWithFields"
            "mcp__claude_ai_Atlassian__getIssueLinkTypes"
            "mcp__claude_ai_Atlassian__getTransitionsForJiraIssue"
            "mcp__claude_ai_Atlassian__getConfluencePage"
            "mcp__claude_ai_Atlassian__getConfluenceSpaces"
            "mcp__claude_ai_Atlassian__getPagesInConfluenceSpace"
            "mcp__claude_ai_Atlassian__getConfluencePageDescendants"
            "mcp__claude_ai_Atlassian__searchConfluenceUsingCql"
            "mcp__claude_ai_Atlassian__getConfluencePageFooterComments"
            "mcp__claude_ai_Atlassian__getConfluencePageInlineComments"
            "mcp__claude_ai_Atlassian__getConfluenceCommentChildren"
          ];
        };
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    discord = {
      enable = true;
      settings = {
        enableHardwareAcceleration = true;
        openH264Enabled = true;
      };
    };

    gh = {
      enable = true;
      settings = {
        extensions = [ pkgs.gh-markdown-preview ];
        git_protocol = "1";
        prompt = "enabled";
      };
    };

    git = {
      enable = true;
      includes = [
        {
          condition = "gitdir:~/Projects/github.com/alex-bechanko/";
          contents.user.email = "alexbechanko@gmail.com";
          contents.core.sshCommand = "ssh -i ~/.ssh/alex-bechanko_ed25519";
        }
      ];
      lfs.enable = true;
      settings = {
        user = {
          inherit name;
          inherit email;
        };
        init.defaultBranch = "main";
        core.pager = "less";
        pull.ff = "only";
        diff.tool = "nvimdiff";
        difftool.prompt = false;
        difftool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
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
          inherit name;
          inherit email;
        };
        aliases = {
          fix-git-lfs = [
            "util"
            "exec"
            "--"
            "jj-fix-git-lfs"
          ];
        };
      };
    };

    zellij = {
      enable = true;
      enableBashIntegration = true;
      exitShellOnExit = true;
      settings = {
        theme = "gruvbox-dark";
        copy_command = "xclip -selection clipboard";
        copy_on_select = true;
        default_layout = "default";
      };
      layouts = {
        default = ''
          layout {
            default_tab_template {
              pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
              }
              children
              pane size=2 borderless=true {
                plugin location="zellij:status-bar"
              }
            }
            tab name="shell" {
              pane
            }
            tab name="notes" {
              pane command="periodic-note" {
                args "day"
              }
            }
          }
        '';
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
  };
  nvim.enable = true;
  systemd.user.startServices = "sd-switch";

  services = {
    flameshot.enable = true;
  };
}
