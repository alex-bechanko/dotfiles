{ config, lib, ... }:
{
  config.programs.discord.settings = lib.mkIf config.programs.discord.enable {
    enableHardwareAcceleration = true;
    openH264Enabled = true;
  };
}
