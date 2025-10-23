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
      userName = "Jonathan Peel";
      userEmail = "me@jonathanpeel.co.za";
      extraConfig = {
        credential.helper = "store";
      };
    };
  };
}
