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
    username = "alexbechanko";
    homeDirectory = "/home/alexbechanko";

    packages = with pkgs; [
      agenix
      bc
      bitwarden-cli
      bitwarden-desktop
      just
      nerd-fonts.inconsolata
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      prometheus
      slack
      tio
      tree
      unzip
      xclip
      yq
      zip
    ];

    sessionPath = [
      "/home/alexbechanko/.local/bin"
      "/usr/bin"
      "/usr/sbin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      DOTFILES = "/home/alexbechanko/Projects/github.com/alex-bechanko/dotfiles/";
    };

    stateVersion = "22.11";
  };

  nvim.enable = true;

  programs = {
    alacritty.enable = true;
    awscli.enable = true;
    bash.enable = true;
    bat.enable = true;
    claude-code.enable = true;
    direnv.enable = true;
    firefox.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gcalcli.enable = true;
    gh.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    towncrier.enable = true;
    zellij.enable = true;
    zk.enable = true;

    project-session = {
      enable = true;
      defaultCommand = "claude";
    };

    git = {
      enable = true;

      includes = [
        {
          condition = "gitdir:~/Projects/github.com/alex-bechanko/";
          contents.user.email = "alexbechanko@gmail.com";
          contents.core.sshCommand = "ssh -i ~/.ssh/alex-bechanko_ed25519";
        }
      ];

      settings.user.email = "abechanko@utilidata.com";
    };

    jujutsu = {
      enable = true;
      settings.user.email = "abechanko@utilidata.com";
    };

  };

  services.flameshot.enable = true;

  systemd.user.startServices = "sd-switch";

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  xdg.enable = true;
}
