# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  os-hyperv-client.enable = true;
  desktop.fvwm.enable = true;

  networking.hostName = "browsers"; # Define your hostname.

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone./
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
    "100.100.100.100"
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";
  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  programs.dconf.enable = true;

  security.polkit.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # sound.enable = true;
  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "docker"
      "video"
    ]; # Enable ‘sudo’ for the user.
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    home-manager
  ];

  programs.zsh.enable = true;
  programs.mosh.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
