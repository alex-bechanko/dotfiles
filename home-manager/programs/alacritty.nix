{ config, lib, ... }:
{
  config.programs.alacritty = lib.mkIf config.programs.alacritty.enable {
    theme = "gruvbox_dark";
    settings = {
      font.size = 10.0;
      font.bold.family = "IosevkaTerm Nerd Font";
      font.bold.style = "Bold";
      font.normal.family = "IosevkaTerm Nerd Font";
      font.normal.style = "Regular";
      keyboard.bindings = [
        {
          key = "Return";
          mods = "Shift";
          chars = builtins.fromJSON ''"\u001B\r"'';
        }
      ];
      terminal.shell.program = "zellij";
      window.startup_mode = "Maximized";
      window.decorations = "None";
    };
  };
}
