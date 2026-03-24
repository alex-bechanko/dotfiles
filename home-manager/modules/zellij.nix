{ ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    exitShellOnExit = true;
    settings = {
      theme = "gruvbox-dark";
    };
  };
}
