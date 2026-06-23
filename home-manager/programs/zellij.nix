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
            pane command="periodic-note" {
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
}
