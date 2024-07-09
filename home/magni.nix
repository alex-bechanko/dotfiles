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

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./programs/nvim.nix
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
    packages = with pkgs; [
      bitwarden
      discord
      obsidian
      ripgrep
      tree
      unzip
      (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })
    ];
  };

  xdg = {
    enable = true;
    configFile.nvim = {
      source = ../config/nvim;
      recursive = true;
    };
  };

  programs = {
    bash = {
      enable = true;
      bashrcExtra = builtins.readFile ../config/bash/bashrc;
      shellAliases = {
        home-manager = "home-manager --flake /home/alex/Projects/github.com/alex-bechanko/dotfiles#alex@magni";
        diff = "diff --color -u";
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "Alex Bechanko";
      userEmail = "alex.bechanko@everactive.com";
      extraConfig = {
        init.defaultBranch = "main";
        core.pager = "less";
      };
    };
    home-manager.enable = true;
    htop.enable = true;
  };
}

