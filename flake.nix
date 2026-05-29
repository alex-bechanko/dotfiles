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
            inherit agenix;
            inherit nvim;
            dotfiles-pkgs = self.packages.x86_64-linux;
          };
          modules = [
            ./home-manager/hosts/tyr.nix
          ];
        };
        "alexbechanko@skoll" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit nvim;
            dotfiles-pkgs = self.packages.x86_64-linux;
          };
          modules = [
            ./home-manager/hosts/skoll.nix
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
      packages.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          script-package-with-pkgs =
            pkgs: script:
            pkgs.callPackage script {
              inherit pkgs;
            };
          script-package = script-package-with-pkgs pkgs;
        in
        {
          periodic-note = pkgs.callPackage ./scripts/periodic-note/default.nix {
            inherit pkgs;
            nvim = nvim.packages.x86_64-linux.default;
          };

          setup-aws = script-package ./scripts/setup-aws/default.nix;

          project-session = script-package ./scripts/project-session/default.nix;

          gh-actions-review-sha = script-package ./scripts/gh-actions-review-sha/default.nix;

          towncrier = script-package ./scripts/towncrier/default.nix;
        };
    };
}
