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


{
  description = "My programs and configurations";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs-channels/nixos-unstable";
  
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # neovim plugins
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    neodev-nvim = {
      url = "github:folke/neodev.nvim";
      flake = false;
    };

    lsp-zero = {
      url = "github:VonHeikemen/lsp-zero.nvim/v2.x";
      flake = false;
    };

    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };

    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };

    luasnip = {
      url = "github:L3MON4D3/LuaSnip"; 
      flake = false;
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "alex@tyr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [ ./home.nix ];
      };
    };

    inherit home-manager;
    inherit (home-manager) packages;
  };

}
