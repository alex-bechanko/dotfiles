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


{ username, pkgs, pkgs-stable, ... }: {
  nixpkgs = {
    overlays = [];
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
      bat
      bc
      bind
      pkgs-stable.bitwarden
      cargo-flamegraph
      conform
      discord
      fd
      imagemagick
      jujutsu
      jq
      nerd-fonts.inconsolata
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      obsidian
      ripgrep
      tree
      unzip
      nodePackages.prettier
      zip
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable    = true;

  systemd.user.startServices = "sd-switch";
}
