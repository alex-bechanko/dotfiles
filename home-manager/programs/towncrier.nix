{
  config,
  lib,
  pkgs,
  ...
}:
let
  towncrierConfig = ''
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
in
{
  options.programs.towncrier.enable = lib.mkEnableOption "towncrier";

  config = lib.mkIf config.programs.towncrier.enable (
    lib.mkMerge [
      {
        home.packages = [ pkgs.towncrier ];
      }
      # put config file in XDG_CONFIG_HOME if enabled
      (lib.mkIf config.xdg.enable {
        xdg.configFile."towncrier/towncrier.toml".text = towncrierConfig;
      })
      # put config file in ~/.towncrier if XDG_CONFIG_HOME not enabled
      (lib.mkIf (!config.xdg.enable) {
        home.file.".towncrier.toml".text = towncrierConfig;
      })
    ]
  );
}
