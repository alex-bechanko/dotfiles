{
  description = "My programs and configurations";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Pinned solely to hold bitwarden-desktop at 2026.6.0 while copy/paste is broken for 2026.7.0
    nixpkgs-bitwarden.url = "github:nixos/nixpkgs/b5aa0fbd538984f6e3d201be0005b4463d8b09f8";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    nvim.url = "github:alex-bechanko/nvim";
    nvim.inputs.nixpkgs.follows = "nixpkgs";

    claude-code-nix.url = "github:sadjow/claude-code-nix";
    claude-code-nix.inputs.nixpkgs.follows = "nixpkgs";

    antigravity-nix.url = "github:jacopone/antigravity-nix";
    antigravity-nix.inputs.nixpkgs.follows = "nixpkgs";

    rtk.url = "github:rtk-ai/rtk/v0.43.0";
    rtk.flake = false;

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-bitwarden,
      home-manager,
      nixos-hardware,
      nvim,
      agenix,
      antigravity-nix,
      claude-code-nix,
      rtk,
      ...
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          agenix.overlays.default
          antigravity-nix.overlays.default
          claude-code-nix.overlays.default
          nvim.overlays.default
          self.overlays.bitwarden-pin
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
            agenix.homeManagerModules.default
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
        project-session = pkgs.callPackage ./packages/project-session/default.nix { };
        towncrier = pkgs.callPackage ./packages/towncrier/default.nix { };
        jj-fix-git-lfs = pkgs.callPackage ./packages/jj-fix-git-lfs/default.nix { };
        rtk = pkgs.callPackage ./packages/rtk/default.nix { src = rtk; };
      };

      overlays.default = final: prev: self.packages.${prev.stdenv.hostPlatform.system} or { };

      overlays.bitwarden-pin =
        final: prev:
        let
          pinned = import nixpkgs-bitwarden {
            inherit (prev.stdenv.hostPlatform) system;
            config.permittedInsecurePackages = [
              # bitwarden-desktop 2026.6.0 is built against an EOL electron
              "electron-39.8.10"
            ];
          };
        in
        prev.lib.getAttrs [
          "bitwarden-desktop"
        ] pinned;
    };
}
