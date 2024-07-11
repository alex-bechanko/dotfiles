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

  };

  outputs = { nixpkgs, nixpkgs-24-05, home-manager, ... }@inputs: {
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "alex@tyr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          config_id = "alex@tyr";
          pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
        };
        modules = [ ./home/tyr.nix ];
      };
      "alex@odin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          config_id = "alex@odin";
          pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
        };
        modules = [ ./home/odin.nix ];
      };
      "alex@magni" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          config_id = "alex@odin";
          pkgs-stable = nixpkgs-24-05.legacyPackages.x86_64-linux;
        };
        modules = [ ./home/magni.nix ];
      };
    };

    inherit home-manager;
    inherit (home-manager) packages;
  };

}
