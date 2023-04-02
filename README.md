# Dotfiles
My repository with how I configure all of my machines.

## How to use
All the dotfiles and programs are deployed with the [Home Manager](https://github.com/nix-community/home-manager), a program that builds off of [Nix](https://github.com/NixOS/nix).
So to use this Nix flake, install the Nix package manager, and Home Manager.
After that, you can set your machine's configuration to my laptop like so:

```
$ home-manager --flake .#alex@tyr switch
```

