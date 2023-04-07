# Dotfiles
My repository with how I configure all of my machines.

## How to use
All the dotfiles and programs are deployed with the [Home Manager](https://github.com/nix-community/home-manager), a program that builds off of [Nix](https://github.com/NixOS/nix).
So to use this Nix flake, install the Nix package manager.
Next, run `Home Manager` like so to bootstrap the `home-manager` executable and the other packages defined in the flake for my laptop:

```
$ nix run home-manager/master -- --flake .#alex@tyr switch
```

From that point forward, `home-manager` will be accessible and you can run it normally like so:

```
$ home-manager --flake .#alex@tyr switch
```
