{ config, lib, ... }:
{
  config.programs.fzf = lib.mkIf config.programs.fzf.enable (
    lib.mkMerge [
      (lib.mkIf config.programs.zsh.enable {
        enableZshIntegration = true;

      })
      {
        enableBashIntegration = true;
      }
    ]
  );
}
