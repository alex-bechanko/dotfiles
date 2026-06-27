{
  pkgs,
  ...
}:
{
  imports = [
    ../programs
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  fonts.fontconfig.enable = true;

  home = {
    username = "alex";

    homeDirectory = "/home/alex";

    packages = with pkgs; [
      agenix
      bc
      bitwarden-cli
      bitwarden-desktop
      nerd-fonts.inconsolata
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      tree
      unzip
      xclip
      zip
    ];

    sessionPath = [
      "/home/alex/.local/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      DOTFILES = "/home/alex/Projects/github.com/alex-bechanko/dotfiles";
    };

    stateVersion = "22.11";
  };

  nvim.enable = true;

  programs = {
    alacritty.enable = true;
    antigravity-cli.enable = true;
    bash.enable = true;
    bat.enable = true;
    direnv.enable = true;
    discord.enable = true;
    fd.enable = true;
    gcalcli.enable = true;
    firefox.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    zellij.enable = true;
    zk.enable = true;
    zsh.enable = true;

    project-session = {
      enable = true;
      defaultCommand = "agy --sandbox";
    };

    git = {
      enable = true;
      settings.user.email = "alexbechanko@gmail.com";
    };

    jujutsu = {
      enable = true;
      settings.user.email = "alexbechanko@gmail.com";
    };

  };

  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
}
