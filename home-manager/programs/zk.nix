{ config, lib, ... }:
{
  config = lib.mkIf config.programs.zk.enable {
    home.sessionVariables = {
      ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Documents/notes";
    };
    programs.zk.settings = {
      note = {
        language = "en";
        extension = "md";
      };
      group = {
        daily = {
          paths = [
            "areas/periodic/daily"
          ];
          note.filename = "{{format-date now '%Y-%m-%d%a'}}";
          note.extension = "md";
          note.template = "daily.hbs";
        };

        weekly = {
          paths = [ "areas/periodic/weekly" ];
          note.filename = "{{format-date now 'wk_%V_%Y-%m-%d'}}";
          note.extension = "md";
          note.template = "weekly.hbs";
        };

        quarterly = {
          paths = [ "areas/periodic/quarterly" ];
          note.filename = ''{{sh "date +qrtr_%Y-Q$(( ($(date +%-m) - 1) / 3 + 1 ))"}}'';
          note.extension = "md";
          note.template = "quarterly.hbs";
        };
      };

      format.markdown = {
        hashtags = false;
        colon-tags = false;
        multiword-tags = false;
      };

      alias = {
        day = ''zk new --no-input --group daily "$ZK_NOTEBOOK_DIR/areas/periodic/daily" ''${1:+--date="$1"}'';
        day-previous-todos = "zk list areas/periodic/daily --sort path- --limit 1 --format '{{abs-path}}' -q | xargs awk '/^## Todo/{found=1; next} found && /^## /{exit} found{print}'";
        day-meetings = ''
          gcalcli agenda --nocolor --tsv --details attendees "$(date +%Y-%m-%d)" "$(date -d tomorrow +%Y-%m-%d)" | awk -F'\t'  'NR > 1 && $2 != "" {printf "### %s–%s %s\n\n", $2, $4, $5}'
        '';
        week = ''
          weekly=$(zk new --no-input --print-path --date "last monday" "$ZK_NOTEBOOK_DIR/areas/periodic/weekly")
          zk edit --force $(zk list areas/periodic/daily --sort path- --limit 7 --format '{{abs-path}}' -q) "$weekly"
        '';
        quarter = ''
          month=$(date +%-m)
          year=$(date +%Y)
          q=$(( (month - 1) / 3 + 1 ))
          qmonth=$(( (q - 1) * 3 + 1 ))
          qstart="$year-$(printf '%02d' $qmonth)-01"
          quarterly=$(zk new --no-input --print-path --group quarterly --date "$qstart" "$ZK_NOTEBOOK_DIR/areas/periodic/quarterly")
          zk edit --force "$quarterly"
        '';
      };
    };
    xdg.configFile."zk/templates/daily.hbs".text = ''
      # {{format-date now '%Y-%m-%d %A'}}

      ## Todo
      <!-- checklist-style todos -->

      {{sh "zk day-previous-todos" }}

      ## Daily
      <!-- work related notes based on the todo list -->

      ## Meetings
      <!-- meeting notes -->

      {{sh "zk day-meetings" }}

      ## Thanks
      <!-- who/what you are thankful for this day  -->
    '';

    xdg.configFile."zk/templates/weekly.hbs".text = ''
      # {{format-date now '%Y-%m-%d Week %V'}}

      ## Goals
      <!-- goals specifically to complete this week -->

      ## Accomplishments
      <!-- accomplishments specific to this week -->

      ## Blockers
      <!-- blockers for work outside of my control -->

      ## Next Week
      <!-- planned goals for next week -->

      ## Time Off
      <!-- Document any time off that needs to be declared to the team -->

      ## Thanks
      <!-- who/what you are thankful for this week based on thanks given in daily notes -->
    '';

    xdg.configFile."zk/templates/quarterly.hbs".text = ''
      # {{sh "date +%Y-Q$(( ($(date +%-m) - 1) / 3 + 1 ))"}}

      ## Theme / Focus
      <!-- One sentence to capture the throughline of work for this quarter -->

      ## Goals
      <!-- goals set at the beginning of a quarter and measure against at the end -->

      ## Accomplishments
      <!-- Distilled from weekly notes. Aim for the format: verb + what + why it mattered -->

      ## Retrospective

      ### What went well
      <!-- patterns to consider repeating -->

      ### What didn't
      <!-- friction points to attempt to avoid in the future -->

      ## Next Quarter
      <!-- Things to continue into the next quarter  -->
    '';
  };
}
