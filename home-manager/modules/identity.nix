{
  lib,
  ...
}:
{
  options.dotfiles = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Full name, used for git and jujutsu commits";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Email address, used for git and jujutsu commits";
    };
    host = lib.mkOption {
      type = lib.types.str;
      description = "Hostname, used to pick the home-manager flake output";
    };
  };
}
