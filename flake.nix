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
            inherit agenix;
            inherit nvim;
            dotfiles-pkgs = self.packages.x86_64-linux;
          };
          modules = [
            ./home-manager/hosts/tyr.nix
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
