{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Alex Bechanko";
      user.email = "alexbechanko@gmail.com";
      init.defaultBranch = "main";
      core.pager = "less";
    };
  };
}
