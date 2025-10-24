{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my-git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.my-git.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Jonathan Peel";
        email = "me@jonathanpeel.co.za";
        credential.helper = "store";
      };
    };
  };
}
