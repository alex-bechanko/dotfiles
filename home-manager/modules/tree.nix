{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.tree;
in
{
  options.programs.tree = {
    enable = lib.mkEnableOption "tree - list contents of directories in a tree-like format";
    package = lib.mkPackageOption pkgs "tree" { };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
