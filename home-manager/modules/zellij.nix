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
