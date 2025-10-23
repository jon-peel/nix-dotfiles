{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    my-firefox.enable = lib.mkEnableOption "Enable FireFox";
  };

  config = lib.mkIf config.my-firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-SA"
        "en-UK"
        "en"
      ];
      profiles.default = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          darkreader
          ublock-origin
        ];

      };
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true; # Optional: disable Firefox Sync
        DisablePocket = true; # Optional: disable Pocket
      };
    };

  };
}
