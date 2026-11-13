{ config, lib, ... }:
{
  config.programs.starship = lib.mkIf config.programs.starship.enable (
    lib.mkMerge [
      # only enable zsh integration when zsh is enabled
      (lib.mkIf config.programs.zsh.enable {
        enableZshIntegration = true;
      })

      {
        enableBashIntegration = true;
        settings = {
          format = builtins.concatStringsSep "" [
            "$username$hostname$localip$shlvl$singularity$kubernetes$nats$directory"
            "$vcsh$vcs$custom"
            "$docker_context$package$bun$c$cmake$cobol$cpp$daml$dart$deno$dotnet$elixir$elm$erlang$fennel"
            "$fortran$gleam$golang$gradle$haskell$haxe$helm$java$julia$kotlin$lua$maven$mojo$nim$nodejs"
            "$ocaml$odin$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala"
            "$solidity$swift$terraform$typst$vlang$vagrant$xmake$zig$buf$guix_shell$nix_shell$conda$pixi"
            "$meson$spack$memory_usage$aws$gcloud$openstack$azure$direnv$env_var$mise$crystal$sudo"
            "$cmd_duration$line_break$jobs$battery$time$status$container$netns$os$shell$character"
          ];

          aws = {
            format = "on [$symbol($profile)]($style) ";
          };

          hostname = {
            ssh_only = false;
            format = "[$hostname]($style) ";
          };

          python.format = "via [$symbol$virtualenv]($style) ";

          vcs.order = [
            "jj"
            "git"
          ];

          custom = {
            # Custom module for jj status
            jj = {
              description = "The current jj status";
              when = "jj --ignore-working-copy root";
              symbol = "🥋 ";
              # space at end of command string is intentional
              command = ''jj log -r @ --no-graph --ignore-working-copy --limit 1 -T 'truncate_end(100, description.first_line(), "…")' '';
            };
          };
        };
      }
    ]
  );
}
