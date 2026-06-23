{ config, lib, ... }:
{
  config.programs.starship = lib.mkIf config.programs.starship.enable (
    lib.mkMerge [
      # only enable zsh integration when zsh is enabled
      (lib.mkIf config.programs.zsh.enable {
        enableZshIntegration = true;
      })

      {
        enableBashIntegration = true;
        settings = {
          # by default the region is also listed, but thus far I don't care about that
          # on my hosts
          aws = {
            format = "on [$symbol($profile)]($style) ";
          };
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
                      description.first_line(),
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
      }
    ]
  );
}
