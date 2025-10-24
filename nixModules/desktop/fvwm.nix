{ config, lib, pkgs, ... }:

{
  options.desktop.fvwm = {
    enable = lib.mkEnableOption "Enable the FVWM Desktop.";
  };


  config = lib.mkIf config.desktop.fvwm.enable {
    desktop.enable = true;
    services.xserver.windowManager.fvwm3.enable = true;
    services.xrdp.defaultWindowManager = lib.mkdefault "fvwm3";
  };

}
