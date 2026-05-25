{
  config,
  pkgs,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/Projects/github.com/alex-bechanko/dotfiles";
in
{
  imports = [
    ../modules/identity.nix
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-39.8.10"
      ];
    };
  };

  home = {
    homeDirectory = "/home/${config.home.username}";

    stateVersion = "22.11";

    sessionPath = [
      "${config.home.homeDirectory}/.local/../bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      bc
      bitwarden-desktop
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      tree
      unzip
      xclip
      zip

      # from this repo
      periodic-note # create daily note file
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs = {
    bat.enable = true;
    fd.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
    };
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;

    alacritty = {
      enable = true;
      theme = "gruvbox_dark";
      settings = {
        window.startup_mode = "Maximized";
        window.decorations = "None";
        font.size = 10.0;
        font.bold.family = "IosevkaTerm Nerd Font";
        font.bold.style = "Bold";
        font.normal.family = "IosevkaTerm Nerd Font";
        font.normal.style = "Regular";
        terminal.shell.program = "zellij";
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        home-manager = "home-manager --flake ${dotfilesDir}#${config.home.username}@${config.dotfiles.host}";
        diff = "diff --color -u";
        dotfiles = "cd ${dotfilesDir}";
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = config.dotfiles.name;
          email = config.dotfiles.email;
        };
        init.defaultBranch = "main";
        core.pager = "less";
      };
      signing.format = null;
      ignores = [
        ".envrc"
        ".direnv/"
        "*.swp"
        "*.log"
        "result"
      ];
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = config.dotfiles.name;
          email = config.dotfiles.email;
        };
      };
    };

    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      exitShellOnExit = true;
      settings = {
        theme = "gruvbox-dark";
        copy_command = "xclip -selection clipboard";
        copy_on_select = true;
      };
      extraConfig = ''
        keybinds {
        normal {
          unbind "Ctrl q"
          bind "Alt s" {
            Run "periodic-note" "day" {
              floating true
              x "0"
              y "0"
              width "100%"
              height "50%"
              close_on_exit true
            }
          }
        }
        session {
          bind "Ctrl q" {
            Quit
          }
        }
        }
      '';

    };
  };
  nvim.enable = true;
  systemd.user.startServices = "sd-switch";
}
