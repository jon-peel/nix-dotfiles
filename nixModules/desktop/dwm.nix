{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.desktop.dwm = {
    enable = lib.mkEnableOption "Enable the DWM Desktop.";
  };

  config = lib.mkIf config.desktop.dwm.enable {
    desktop.enable = true;

    services = {
      xserver.windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs (oldAttrs: {
          postPatch = ''
            sed -i 's/Mod1Mask/Mod4Mask/g' config.def.h
          '';
        });
      };
      xrdp.defaultWindowManager = lib.mkDefault "dwm";
    };

    environment.systemPackages = with pkgs; [
      dmenu
      st
    ];
  };

}
