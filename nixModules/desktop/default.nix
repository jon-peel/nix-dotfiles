{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./dwm.nix
    ./fvwm.nix
    ./gnome.nix
    ./xfce.nix
    ./xrdp.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "enable Desktop";
  };

  config = lib.mkIf config.desktop.enable {
    desktop.xrdp.enable = lib.mkDefault true;

    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
    };

  };
}
