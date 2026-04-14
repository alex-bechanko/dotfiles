{ ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    exitShellOnExit = true;
    settings = {
      theme = "gruvbox-dark";
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
