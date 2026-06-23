{ config, lib, ... }:
{
  config.programs.zk.settings = lib.mkIf config.programs.zk.enable {

  };
}
