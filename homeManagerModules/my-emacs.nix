{ config, lib, pkgs, ... }:

{
  options = {
    my-emacs.enable = lib.mkEnableOption "enable Emacs config";
  };

  config = lib.mkIf config.my-emacs.enable {
    my-python.enable = lib.mkDefault true;

    home.sessionPath = [ "$HOME/.config/emacs/bin" ];
  };
}
