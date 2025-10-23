{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./my-darkmode.nix
              ./my-firefox.nix ];

  options = {
    desktop-apps.enable = lib.mkEnableOption "Default Desktop applications";
  };

  config = lib.mkIf config.desktop-apps.enable {
    my-darkmode.enable = lib.mkDefault true;
    my-firefox.enable = lib.mkDefault true;
  };

}
