{
  username,
  hostname,
  pkgs,
  ...
}:
{
  imports = [ ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  targets.genericLinux.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    file.".cobra.yaml".source = ../../config/cobra-cli/cobra.yaml;
    packages = with pkgs; [
      gnumake
      (nerdfonts.override { fonts = [ "Inconsolata" ]; })
      tree
      ripgrep
      unzip
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable = true;

  systemd.user.startServices = "sd-switch";
}
