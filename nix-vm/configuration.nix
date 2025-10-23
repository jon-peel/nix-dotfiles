# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:



{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  os-hyperv-client.enable = true;

  networking.hostName = "nix-vm"; # Define your hostname.
  
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone./
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 networking.nameservers = [ "1.1.1.1" "8.8.8.8" "100.100.100.100" ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  };



  # Enable the X11 windowing system.
  services.xserver.desktopManager.xfce.enableScreensaver = false;
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    # desktopManager.xfce.enable = true;
    windowManager.fvwm.enable = true;
    # windowManager.ctwm.enable = true;
    # windowManager.ctwm.enable = true;
    #
     # Create a custom session
    #displayManager.sessionCommands = ''
    #  ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "rgb:4e/7c/7b"
    #'';
    #
    #windowManager.session = [{
    #  name = "mwm";
    #  start = ''
    #    ${pkgs.motif}/bin/mwm &
    #    waitPID=$!
    #  '';
    #}];

  };
  services.xrdp = {
    enable = true;
    # defaultWindowManager = "${pkgs.xfce.xfce4-session}/bin/xfce4-session";
    # defaultWindowManager = "twm";
    defaultWindowManager = "fvwm";
    #defaultWindowManager = "${pkgs.motif}/bin/mwm";
    openFirewall = true;
  };
  #environment.etc."xrdp/startwm.sh" = {
    #text = ''
    #  #!/bin/sh
    #  . /etc/profile
    #  ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "rgb:4e/7c/7b"
    #  ${pkgs.motif}/bin/mwm
    #  # twm
    #'';
    #mode = "0755";
  #};
  programs.dconf.enable = true;

  
  security.polkit.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver = {
    modules = [ pkgs.xorg.xf86videofbdev ];
    videoDrivers = [ "hyperv_fb" ];
  };
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


  environment.variables = {
    PATH = "$PATH:$HOME/.config/emacs/bin";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "podman" "docker" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      emacs
      tree
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vscode
    home-manager
    # Help with Hyper-V
    xrdp
    xorg.xhost
    xorg.xorgserver
    xclip

    motif
  ];


  programs.zsh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  programs.mosh.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

   # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?


  ### podman ###
  virtualisation = {
   containers.enable = true;
   podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
    dockerSocket.enable = true; 
  };
  };
}
