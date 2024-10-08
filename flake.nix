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


{
  description = "My programs and configurations";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
  
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

  };

  outputs = { nixpkgs, nixpkgs-24-05, home-manager, nixos-hardware, ... }: {
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "alex@tyr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          username = "alex";
          hostname = "tyr";
          pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
        };
        modules = [
          ./home-manager/hosts/tyr.nix

          ./home-manager/modules/alacritty.nix
          ./home-manager/modules/bash.nix
          ./home-manager/modules/direnv.nix
          ./home-manager/modules/git.nix
          ./home-manager/modules/nvim.nix
          ./home-manager/modules/zellij.nix
        ];
      };
      "everactive@tyr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            username = "everactive";
            hostname = "tyr";
            pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
          };
          modules = [
            ./home-manager/users/everactive.nix
            ./home-manager/hosts/tyr.nix

            ./home-manager/modules/alacritty.nix
            ./home-manager/modules/bash.nix
            ./home-manager/modules/direnv.nix
            ./home-manager/modules/git.nix
            ./home-manager/modules/nvim.nix
            ./home-manager/modules/zellij.nix
          ];
      };
      "alex@odin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          username = "alex";
          hostname = "odin";
          pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
        };
        modules = [
          ./home-manager/hosts/odin.nix

          ./home-manager/modules/nvim.nix
          ./home-manager/modules/bash.nix
          ./home-manager/modules/git.nix
          ./home-manager/modules/direnv.nix
        ];
      };
      "alex@magni" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          username = "alex";
          hostname = "magni";
          pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
        };
        modules = [
          ./home-manager/hosts/magni.nix

          ./home-manager/modules/nvim.nix
          ./home-manager/modules/bash.nix
          ./home-manager/modules/git.nix
          ./home-manager/modules/direnv.nix
        ];
      };
    };

    nixosConfigurations = {
      "tyr" = nixpkgs.lib.nixosSystem {
        system = "x86_64";
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s
          ./nixos/tyr/configuration.nix
          ./nixos/tyr/hardware-configuration.nix
        ];
      };
    };

    inherit home-manager;
    inherit (home-manager) packages;
  };

}
