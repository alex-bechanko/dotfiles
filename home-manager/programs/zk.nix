{ config, lib, ... }:
{
  config = lib.mkIf config.programs.zk.enable {
    home.sessionVariables = {
      ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Documents/notes";
    };
    programs.zk.settings = { };
  };
}
