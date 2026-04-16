{
  description = "My programs and configurations";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    nvim.url = "github:alex-bechanko/nvim";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nvim,
      agenix,
      ...
    }:
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "alex@tyr" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            username = "alex";
            hostname = "tyr";
            agenix = agenix.packages.x86_64-linux.default;
            dotfiles-pkgs = self.packages.x86_64-linux;
          };
          modules = [
            ./home-manager/hosts/tyr.nix

            ./home-manager/modules/alacritty.nix
            ./home-manager/modules/bash.nix
            ./home-manager/modules/bat.nix
            ./home-manager/modules/bitwarden.nix
            ./home-manager/modules/direnv.nix
            ./home-manager/modules/discord.nix
            ./home-manager/modules/fd.nix
            ./home-manager/modules/git.nix
            ./home-manager/modules/jujutsu.nix
            ./home-manager/modules/jq.nix
            ./home-manager/modules/ripgrep.nix
            ./home-manager/modules/zellij.nix

            agenix.homeManagerModules.default
            nvim.homeModules.default
          ];
        };
        "alex@odin" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            username = "alex";
            hostname = "odin";
          };
          modules = [
            ./home-manager/hosts/odin.nix

            ./home-manager/modules/bash.nix
            ./home-manager/modules/git.nix
            ./home-manager/modules/direnv.nix

            nvim.homeModules.default
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
            agenix.nixosModules.default
          ];
        };
      };

      inherit home-manager;

      packages.x86_64-linux.periodic-note =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.callPackage ./scripts/periodic-note/default.nix {
          inherit pkgs;
          nvim = nvim.packages.x86_64-linux.default;
        };
    };
}
