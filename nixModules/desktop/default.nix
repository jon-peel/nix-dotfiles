{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fvwm.nix
    ./xrdp.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "enable Desktop";
  };

  config = lib.mkIf config.desktop.enable {
    desktop.xrdp.enable = lib.mkDefault true;

    # services.xserver.xkb.layout = "us";
    # services.xserver = {
    #  modules = [ pkgs.xorg.xf86videofbdev ];
    #  videoDrivers = [ "hyperv_fb" ];
    # };

    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
    };

  };
}
