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
            pane command="zk" {
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
          unbind "Ctrl g" "Ctrl p" "Ctrl t" "Ctrl n" "Ctrl h" "Ctrl s" "Ctrl o" "Ctrl q"

          shared_except "locked" {
              bind "Alt g" { SwitchToMode "locked"; }
              bind "Alt p" { SwitchToMode "pane"; }
              bind "Alt t" { SwitchToMode "tab"; }
              bind "Alt r" { SwitchToMode "resize"; }
              bind "Alt m" { SwitchToMode "move"; }
              bind "Alt s" { SwitchToMode "scroll"; }
              bind "Alt w" { SwitchToMode "session"; }
              bind "Alt q" { Quit; }
          }
          locked {
              bind "Alt g" { SwitchToMode "normal"; }
          }
          pane {
              bind "Alt p" { SwitchToMode "normal"; }
          }
          tab {
              bind "Alt t" { SwitchToMode "normal"; }
          }
          resize {
              bind "Alt r" { SwitchToMode "normal"; }
          }
          move {
              bind "Alt m" { SwitchToMode "normal"; }
          }
          scroll {
              bind "Alt s" { SwitchToMode "normal"; }
          }
          session {
              bind "Alt w" { SwitchToMode "normal"; }
          }
      }
    '';
  };
}
