{ config, lib, pkgs, ... }:

{
  options.desktop.gnome = {
    enable = lib.mkEnableOption "Enable the Gnome Desktop.";
  };


  config = lib.mkIf config.desktop.gnome.enable {
    # desktop.enable = true;
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    services.gnome.core-utilities.enable = false;

    services.xrdp.defaultWindowManager = lib.mkDefault "gnome-session";
  };

}
