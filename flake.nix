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

    claude-code-nix.url = "github:sadjow/claude-code-nix";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nvim,
      agenix,
      claude-code-nix,
      ...
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          claude-code-nix.overlays.default
          nvim.overlays.default
          self.overlays.default
        ];
      };
    in
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "alex@tyr" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/hosts/tyr.nix
            agenix.homeManagerModules.default
            nvim.homeModules.default
          ];
        };
        "alexbechanko@skoll" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/hosts/skoll.nix
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
      packages.x86_64-linux = {
        periodic-note = pkgs.callPackage ./scripts/periodic-note/default.nix { };
        project-session = pkgs.callPackage ./scripts/project-session/default.nix { };
        towncrier = pkgs.callPackage ./scripts/towncrier/default.nix { };
        jj-fix-git-lfs = pkgs.callPackage ./scripts/jj-fix-git-lfs/default.nix { };
      };

      overlays.default = final: prev: self.packages.${prev.stdenv.hostPlatform.system} or { };
    };
}
