{
  ...
}:
{
  imports = [
    ../profiles/common.nix
    ../profiles/personal.nix
  ];

  dotfiles = {
    name = "Alex Bechanko";
    email = "alexbechanko@gmail.com";
    host = "tyr";
  };

  home.username = "alex";
}
