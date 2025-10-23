{ config, lib, pkgs, ... }:

{
  options = {
    my-oneDrive = {
      enable = lib.mkEnableOption "Enable OneDrive";
      syncList = lib.mkOption {
        type = lib.types.lines;
        description = "Files and directories to sync";
        default = ''
          org/*
        '';
      };

      threads = lib.mkOption {
        type = lib.types.int;
        description = "Number of threads";
        default = 4;
      };
    };
  };

  config = lib.mkIf config.my-oneDrive.enable {
    home.packages = with pkgs; [ onedrive ];

    home.file."OneDrive/.keep".text = "";

    xdg.configFile = {
      "onedrive/config".text = ''
        # Directory where OneDrive files will be synced

        # Skip dotfiles/dirs
        skip_dotfiles = "false"

        # Monitor interval in seconds
        monitor_interval = "300"

        # Download only, no uploads (set to "true" if you only want to download)
        download_only = "false"

        # Upload only, no downloads
        upload_only = "false"

        # Number of threads (will auto-cap to CPU cores)
        threads = "${builtins.toString config.my-oneDrive.threads}"

        # Sync only specific directories (we'll use sync_list file below)
        # sync_list is specified in a separate file
      '';

      "onedrive/sync_list".text = config.my-oneDrive.syncList;
    };
  };
}
