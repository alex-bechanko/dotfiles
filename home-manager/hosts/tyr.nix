{
  config,
  username,
  pkgs,
  agenix,
  nvim,
  dotfiles-pkgs,
  ...
}:
{
  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [
    ../modules/alacritty.nix
    ../modules/bash.nix
    ../modules/bat.nix
    ../modules/bitwarden.nix
    ../modules/direnv.nix
    ../modules/discord.nix
    ../modules/fd.nix
    ../modules/git.nix
    ../modules/jujutsu.nix
    ../modules/jq.nix
    ../modules/ripgrep.nix
    ../modules/zellij.nix
    agenix.homeManagerModules.default
    nvim.homeModules.default
  ];

  age.secrets.gemini_api_key.file = ../../secrets/gemini_api_key.age;

  targets.genericLinux.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "22.11";

    sessionPath = [
      "/home/${username}/.local/../bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      GEMINI_API_KEY = "$(cat ${config.age.secrets.gemini_api_key.path})";
    };

    packages = with pkgs; [
      agenix # file encryption for nix
      bc # basic cli calculator
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      tree # pretty display of directory contents in a tree structure
      unzip # cli tool for unzipping .zip archives
      zip # cli tool for creating .zip archives

      dotfiles-pkgs.periodic-note # create daily note file
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable = true;

  nvim.enable = true;
  systemd.user.startServices = "sd-switch";
}
