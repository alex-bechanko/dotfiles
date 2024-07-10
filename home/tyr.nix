# Dotfiles and configurations for my machines.
# Copyright (C) 2023 Alex Bechanko
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


{lib, config, pkgs, pkgs-stable, ... }: {
  imports = [
    ../modules/nvim.nix
    ../modules/bash.nix
    ../modules/git.nix
    ../modules/direnv.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  targets.genericLinux.enable = true;

  home = {
    username = "alex";
    homeDirectory = "/home/alex";
    stateVersion = "22.11";
    file.".cobra.yaml".source = ../config/cobra-cli/cobra.yaml;
    packages = with pkgs; [
      pkgs-stable.bitwarden
      discord
      (nerdfonts.override { fonts = [ "Inconsolata" ]; })
      obsidian
      ripgrep
      tree
      unzip
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable    = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
