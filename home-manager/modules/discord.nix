{ ... }:
{
  programs.discord = {
    enable = true;
    settings = {
      enableHardwareAcceleration = true;
      openH264Enabled = true;
    };
  };
}
