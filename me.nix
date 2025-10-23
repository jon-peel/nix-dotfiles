{ config, pkgs, inputs, ... }:
let
lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };

in {

  # programs.code-server.enable = true;

  home.username = "me"; # Replace with your actual username
  home.homeDirectory = "/home/me"; # Replace with your actual username
  home.stateVersion = "24.05";

  desktop-apps.enable = true;
  my-dotnet.enable = true;
  my-oneDrive.enable = true;

  # Add to user PATH

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  # Zsh configuration with powerline
  # Install powerline and fonts
  home.packages = with pkgs; [
    podman-compose
    docker-compose

    liberation_ttf  # Liberation Sans is Arial-compatible
    dejavu_fonts
    noto-fonts

    stalonetray
    powerline
    powerline-fonts
    # Other useful packages
    git
    curl
    wget
    vim
    htop
    nodejs
    kitty
    rofi

    ripgrep
    fd
    pandoc
    nixfmt-rfc-style
    shellcheck
    nerd-fonts.symbols-only
    #
  ];


  programs.home-manager.enable = true;


}
