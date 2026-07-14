{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "jj-fix-git-lfs";
  runtimeInputs = [
    pkgs.git
    pkgs.git-lfs
    pkgs.jujutsu
  ];
  text = builtins.readFile ./jj-fix-git-lfs.sh;
}
