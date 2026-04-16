{
  config,
  pkgs,
  agenix,
  nvim,
  dotfiles-pkgs,
  ...
}:
let
  username = "alex";
  host = "tyr";
  name = "Alex Bechanko";
  email = "alexbechanko@gmail.com";
in
{
  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [
    ../modules/agenix-cli.nix
    ../modules/bc.nix
    ../modules/bitwarden-desktop.nix
    ../modules/tree.nix
    ../modules/unzip.nix
    ../modules/zip.nix

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
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font

      dotfiles-pkgs.periodic-note # create daily note file
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs = {
    agenix-cli.enable = true;
    bat.enable = true;
    bc.enable = true;
    bitwarden-desktop.enable = true;
    fd.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    firefox.enable = true;
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;
    tree.enable = true;
    unzip.enable = true;
    zip.enable = true;

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
      initExtra = ''
        export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
      '';
      shellAliases = {
        home-manager = "home-manager --flake /home/alex/Projects/github.com/alex-bechanko/dotfiles#${username}@${host}";
        diff = "diff --color -u";
        dotfiles = "cd /home/alex/Projects/github.com/alex-bechanko/dotfiles";
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    discord = {
      enable = true;
      settings = {
        enableHardwareAcceleration = true;
        openH264Enabled = true;
      };
    };

    git = {
      enable = true;
      settings = {
        user = {
          inherit name;
          inherit email;
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
          inherit name;
          inherit email;
        };
      };
    };

    zellij = {
      enable = true;
      enableBashIntegration = true;
      exitShellOnExit = true;
      settings = {
        theme = "gruvbox-dark";
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
