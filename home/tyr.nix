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


{ inputs, lib, config, pkgs, ... }:
  let

    external-pkgs.nvimPlugins = {
      nvim-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "nvim-lspconfig";
        src = inputs.nvim-lspconfig;
      };
      neodev-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "neodev.nvim";
        src = inputs.neodev-nvim;
      };

      lsp-zero = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "lsp-zero";
        src = inputs.lsp-zero;
      };

      nvim-cmp = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "nvim-cmp";
        src = inputs.nvim-cmp;
      };

      cmp-nvim-lsp = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "cmp-nvim-lsp";
        src = inputs.cmp-nvim-lsp;
      };
      
      luasnip = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "luasnip";
        src = inputs.luasnip;
      };
      cmp-luasnip = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "cmp-luasnip";
        src = inputs.cmp-luasnip;
      };
      which-key = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "which-key";
        src = inputs.which-key;
      };
    };

  in {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      (final: prev: external-pkgs)
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  targets.genericLinux.enable = true;

  home = {
    username = "alex";
    homeDirectory = "/home/alex";
  };

  xdg.enable = true;

  home.file.".cobra.yaml".source = ../config/cobra-cli/cobra.yaml;

  home.packages = with pkgs; [
    obsidian
    discord
    bitwarden
    bitwarden-cli
    beancount
    tree
    sumneko-lua-language-server
    ripgrep
  ];

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable    = true;

  programs.git = {
    enable = true;
    userName = "Alex Bechanko";
    userEmail = "alexbechanko@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.pager = "less";
    };
  };


  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ../config/bash/bashrc;
    shellAliases = {
      home-manager = "home-manager --flake /home/alex/Projects/github.com/alex-bechanko/dotfiles#alex@tyr";
    };
  };

  xdg.configFile.nvim = {
    source = ../config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable        = true;
    viAlias       = true;
    vimAlias      = true;
    vimdiffAlias  = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.nix p.lua p.go]))
      pkgs.nvimPlugins.nvim-lspconfig
      pkgs.nvimPlugins.lsp-zero
      pkgs.nvimPlugins.nvim-cmp
      pkgs.nvimPlugins.cmp-nvim-lsp
      pkgs.nvimPlugins.luasnip
      pkgs.nvimPlugins.neodev-nvim
      pkgs.nvimPlugins.which-key
      plenary-nvim
      vim-nix
      onedark-nvim
      indent-blankline-nvim
    ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
