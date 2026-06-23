{ config, lib, ... }:
{
  config.programs.direnv = lib.mkIf config.programs.direnv.enable (
    lib.mkMerge [
      {
        enableBashIntegration = true;
        nix-direnv.enable = true;
      }
      (lib.mkIf config.programs.zsh.enable {
        # always have bash integration, but only add zsh integration if we use zsh
        enableZshIntegration = true;
      })
    ]
  );
}
