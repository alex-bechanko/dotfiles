{
  config,
  username,
  pkgs,
  pkgs-stable,
  agenix,
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
      GEMINI_API_KEY = "$(cat ${config.age.secrets.gemini_api_key.path})";
    };

    packages = with pkgs; [
      agenix # file encryption for nix
      bat # nice alternative to `cat`
      bc # basic cli calculator
      bind # domain name server
      pkgs-stable.bitwarden # password manager
      cargo-flamegraph # binary debugging tool
      conform # code license management tool
      discord # messaging tool
      fd # nice alternative to `find`
      imagemagick # cli tooling for image manipulation
      jujutsu # git alternative
      jq # cli tool for json querying
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      obsidian # note taking software
      ripgrep # nice alternative to `grep`
      tree # pretty display of directory contents in a tree structure
      unzip # cli tool for unzipping .zip archives
      nodePackages.prettier # code formatter
      zip # cli tool for creating .zip archives
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
