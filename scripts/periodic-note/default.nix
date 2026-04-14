{ pkgs, nvim }:
let
  app = pkgs.writeShellApplication {
    name = "periodic-note";
    runtimeInputs = [
      pkgs.coreutils
      nvim
    ];
    text = builtins.readFile ./periodic-note.sh;
  };

  app-with-completion = pkgs.symlinkJoin {
    name = "periodic-note-with-completion";
    paths = [ app ];
    postBuild = ''
      mkdir -p $out/share/bash-completion/completions
      cp ${./completions.sh} $out/share/bash-completion/completions/periodic-note
    '';
  };

in
app-with-completion
