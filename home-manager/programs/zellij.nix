{ config, lib, ... }:
{
  config.programs.zellij = lib.mkIf config.programs.zellij.enable {
    enableBashIntegration = true;
    enableZshIntegration = true;
    exitShellOnExit = true;
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
            pane command="zk day" {
              args "day"
            }
          }
        }
      '';
    };

    settings = {
      default_layout = "default";
      theme = "gruvbox-dark";
      copy_command = "xclip -selection clipboard";
      copy_on_select = true;
    };
  };
}
