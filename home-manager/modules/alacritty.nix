{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
      window.decorations = "None";
      font.size = 10.0;
      font.bold.family = "IosevkaTerm Nerd Font";
      font.bold.style = "Bold";
      font.normal.family = "IosevkaTerm Nerd Font";
      font.normal.style = "Regular";
      terminal.shell.program = "zellij";
      terminal.shell.args = [
        "--session"
        "term"
      ];
    };
  };
}
