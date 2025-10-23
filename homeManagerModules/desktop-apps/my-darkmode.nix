{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my-darkmode.enable = lib.mkEnableOption "Enable darkmode";
  };

  config = lib.mkIf config.my-darkmode.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
    };
  };
}
