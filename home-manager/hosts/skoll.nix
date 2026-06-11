{
  config,
  ...
}:
{
  imports = [
    ../profiles/common.nix
    ../profiles/work.nix
  ];

  dotfiles = {
    name = "Alex Bechanko";
    email = "abechanko@utilidata.com";
    host = "skoll";
  };

  home = {
    username = "alexbechanko";

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      PATH = "/usr/bin:/usr/sbin:$PATH";
    };
  };

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };
}
