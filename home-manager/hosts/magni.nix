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

{ lib, pkgs, pkgs-stable, ... }: {
  imports = [
    
  ];
  nixpkgs = {
    overlays = [];
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
}

