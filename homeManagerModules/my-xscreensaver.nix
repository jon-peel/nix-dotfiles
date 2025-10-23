{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my-xscreensaver.enable = lib.mkEnableOption "Enable XScreenSaver";
  };

  config = lib.mkIf config.my-xscreensaver.enable {
    home.packages = with pkgs; [ xscreensaver ];

    home.file.".xscreensaver".text = ''
      timeout: 0:10:00
      lock: False
      splash: False
      fade: True
      unfade: True
      fadeSeconds: 0:00:03
      fadeTicks: 20
      mode: one
      selected: ${pkgs.xscreensaver}/libexec/xscreensaver/xmatrix

      programs: \
        xmatrix -root \n\
        glmatrix -root \n\
    '';

    services.screen-locker = {
      enable = true;
      lockCmd = "${pkgs.xscreensaver}/bin/xscreensaver-command -activate";
      inactiveInterval = 10; # minutes
    };

    xsession.initExtra = ''
      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "rgb:4e/7c/7b"
      ${pkgs.xscreensaver}/bin/xscreensaver --no-splash &
      xset s off        # Disable screen saver blanking
      xset s noblank   # Disable blanking
    '';
  };
}
