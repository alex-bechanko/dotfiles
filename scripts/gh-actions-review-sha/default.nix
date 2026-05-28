{ pkgs, ... }:
let
  app = pkgs.writeShellApplication {
    name = "gh-actions-review-sha";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.gh
    ];
    text = builtins.readFile ./gh-actions-review-sha.sh;
  };

in
app
