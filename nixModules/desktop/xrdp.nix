{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.desktop.xrdp = {
    enable = lib.mkEnableOption "Enable X Remote Desktop.";
  };

  config = lib.mkIf config.desktop.xrdp.enable {
    services.xrdp = {
      enable = true;
      # defaultWindowManager = "fvwm";
      openFirewall = true;
    };
  };
}
