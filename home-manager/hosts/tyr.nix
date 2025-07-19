# Dotfiles and configurations for my machines.
# Copyright (C) 2024 Alex Bechanko
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


{ config, username, pkgs, pkgs-stable, agenix, ... }: {
  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  age.secrets.gemini_api_key.file = ../../secrets/gemini_api_key.age;

  targets.genericLinux.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "22.11";

    file.".cobra.yaml".source = ../../config/cobra-cli/cobra.yaml;

    sessionVariables = {
      GEMINI_API_KEY = "$(cat ${config.age.secrets.gemini_api_key.path})";
    };

    packages = with pkgs; [
      agenix # file encryption for nix
      bat # nice alternative to `cat`
      bc # basic cli calculator
      bind # domain name server
      pkgs-stable.bitwarden # password manager
      cargo-flamegraph # binary debugging tool
      conform # code license management tool
      discord # messaging tool
      fd # nice alternative to `find`
      imagemagick # cli tooling for image manipulation
      jujutsu # git alternative
      jq # cli tool for json querying
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      obsidian # note taking software
      ripgrep # nice alternative to `grep`
      tree # pretty display of directory contents in a tree structure
      unzip # cli tool for unzipping .zip archives
      nodePackages.prettier # code formatter
      zip # cli tool for creating .zip archives
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable    = true;

  systemd.user.startServices = "sd-switch";
}
