{ pkgs, ... }:
let
  app = pkgs.writeShellApplication {
    name = "towncrier";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.python313Packages.towncrier
    ];
    text = builtins.readFile ./towncrier.sh;
  };

in
app
