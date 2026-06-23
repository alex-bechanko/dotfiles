{ config, lib, ... }:
{
  config.programs.firefox = lib.mkIf config.programs.firefox.enable {
    configPath = ".mozilla/firefox";
  };
}
