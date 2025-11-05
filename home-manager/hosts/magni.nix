{
  lib,
  pkgs,
  pkgs-stable,
  ...
}:
{
  imports = [

  ];
  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  targets.genericLinux.enable = true;

  systemd.user.startServices = "sd-switch";

  fonts.fontconfig.enable = true;

  home = {
    username = "alex";
    homeDirectory = "/home/alex";
    stateVersion = "22.11";
    file.".cobra.yaml".source = ../config/cobra-cli/cobra.yaml;
    packages = with pkgs; [
      pkgs-stable.bitwarden
      discord
      go
      go-mockery
      go-task
      golangci-lint
      natscli
      (nerdfonts.override { fonts = [ "Inconsolata" ]; })
      obsidian
      _1password
      _1password-gui
      ripgrep
      slack
      tree
      unzip
      xh
      yq
    ];
  };

  xdg.enable = true;

  programs = {
    git.userEmail = lib.mkForce "alex.bechanko@everactive.com";
    home-manager.enable = true;
    htop.enable = true;
  };

  nvim.enable = true;
}
