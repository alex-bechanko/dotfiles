{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Alex Bechanko";
    userEmail = "alexbechanko@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.pager = "less";
    };
  };
}
