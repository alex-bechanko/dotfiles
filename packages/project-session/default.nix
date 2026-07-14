{ pkgs, ... }:
let
  app = pkgs.writeShellApplication {
    name = "project-session";
    runtimeInputs = [
      pkgs.zellij
    ];
    text = builtins.readFile ./project-session.sh;
  };
in
app
