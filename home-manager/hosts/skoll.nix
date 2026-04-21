{
  config,
  pkgs,
  nvim,
  dotfiles-pkgs,
  ...
}:
let
  username = "alexbechanko";
  host = "skoll";
  name = "Alex Bechanko";
  email = "abechanko@utilidata.com";
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
    ../modules/bc.nix
    ../modules/bitwarden-desktop.nix
    ../modules/slack.nix
    ../modules/tree.nix
    ../modules/unzip.nix
    ../modules/zip.nix

    nvim.homeModules.default
  ];

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "22.11";

    sessionPath = [
      "/home/${username}/.local/../bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      nerd-fonts.inconsolata # font
      nerd-fonts.iosevka # font
      nerd-fonts.iosevka-term # font
      vivid

      dotfiles-pkgs.periodic-note # create daily note file
    ];
  };

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs = {
    bat.enable = true;
    bc.enable = true;
    bitwarden-desktop.enable = true;
    claude-code.enable = true;
    fd.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    firefox.enable = true;
    htop.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;
    slack.enable = true;
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

    awscli = {
      enable = true;
    };

    bash = {
      enable = true;
      initExtra = ''
        export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
        export PS1="\[\033[38;5;142m\]\u\[\033[38;5;223m\]@\[\033[38;5;108m\]\h\[\033[00m\]:\[\033[01;38;5;109m\]\w\[\033[38;5;208m\]\$\[\033[00m\]"
        export LS_COLORS="$(vivid generate gruvbox-dark)"
      '';
      shellAliases = {
        home-manager = "home-manager --flake /home/${username}/Projects/github.com/alex-bechanko/dotfiles#${username}@${host}";
        diff = "diff --color -u";
        dotfiles = "cd /home/alex/Projects/github.com/alex-bechanko/dotfiles";
        ls = "ls --color=auto";
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

    gh = {
      enable = true;
      settings = {
        extensions = [ pkgs.gh-markdown-preview ];
        git_protocol = "1";
        prompt = "enabled";
      };
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
