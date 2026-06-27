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
          note.filename = "{{format-date now '%Y-%m-%d'}}";
          note.extension = "md";
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
      };
    };
    xdg.configFile."zk/templates/daily.hbs".text = ''
      # {{format-date now '%Y-%m-%d %A'}}

      ## Todo

      {{sh "zk day-previous-todos" }}

      ## Daily

      ## Meetings

      {{sh "zk day-meetings" }}

      ## Thanks
    '';
  };
}
