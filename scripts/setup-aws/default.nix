{ pkgs, ... }:
let
  app = pkgs.writeShellApplication {
    name = "setup-aws";
    runtimeInputs = [
      pkgs.awscli2
    ];
    text = builtins.readFile ./setup-aws.sh;
  };
in
app
