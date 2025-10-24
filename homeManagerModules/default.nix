{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop-apps
              ./my-dotnet.nix
              ./my-emacs.nix
              ./my-git.nix
              ./my-haskell.nix
              ./my-jetbrains.nix
              ./my-onedrive.nix
              ./my-python.nix
              ./my-xscreensaver.nix
              ./my-zsh.nix ];

  my-emacs.enable = lib.mkDefault true;
  my-git.enable = lib.mkDefault true;
  my-zsh.enable = lib.mkDefault true;
}
