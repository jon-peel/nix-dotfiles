{ config, lib, pkgs, ... }:

{
  options.desktop.xfce = {
    enable = lib.mkEnableOption "Enable the XFCE Desktop.";
  };


  config = lib.mkIf config.desktop.xfce.enable {
    desktop.enable = true;
    services.xserver.windowManager.xfce.enable = true;
    services.xrdp.defaultWindowManager = lib.mkDefault "xfce";
  };

}
