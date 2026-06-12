{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    just
    prometheus
    slack
    tio
    vivid
    yq

    # from this repo
    project-session # open a zellij tab for a project
    gh-actions-review-sha # little script to check commit SHAs on github actions
    towncrier # wrapper around towncrier to work sanely
    jj-fix-git-lfs # restore git lfs files in jj working copy
  ];

  xdg.configFile."towncrier/towncrier.toml".text = ''
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

  programs = {
    # Shift+Return sends a newline escape, mostly for multiline prompts in
    # terminal apps like claude-code
    alacritty.settings.keyboard.bindings = [
      {
        key = "Return";
        mods = "Shift";
        chars = builtins.fromJSON ''"\u001B\r"'';
      }
    ];

    awscli = {
      enable = true;
    };

    bash = {
      initExtra = ''
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

    gh = {
      enable = true;
      settings = {
        extensions = [ pkgs.gh-markdown-preview ];
        git_protocol = "1";
        prompt = "enabled";
      };
    };

    git = {
      includes = [
        {
          condition = "gitdir:~/Projects/github.com/alex-bechanko/";
          contents.user.email = "alexbechanko@gmail.com";
          contents.core.sshCommand = "ssh -i ~/.ssh/alex-bechanko_ed25519";
        }
      ];
      lfs.enable = true;
      settings = {
        pull.ff = "only";
        diff.tool = "nvimdiff";
        difftool.prompt = false;
        difftool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      };
    };

    jujutsu.settings.aliases = {
      fix-git-lfs = [
        "util"
        "exec"
        "--"
        "jj-fix-git-lfs"
      ];
    };

    zellij = {
      settings.default_layout = "default";
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
    };
  };

  services = {
    flameshot.enable = true;
  };
}
