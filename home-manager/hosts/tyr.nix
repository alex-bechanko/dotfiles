{
  config,
  username,
  pkgs,
  agenix,
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

  age.secrets.gemini_api_key.file = ../../secrets/gemini_api_key.age;

  targets.genericLinux.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "22.11";

    file.".cobra.yaml".source = ../../config/cobra-cli/cobra.yaml;

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
      discord # messaging tool
      fd # nice alternative to `find`
      jq # cli tool for json querying
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      ripgrep # nice alternative to `grep`
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
