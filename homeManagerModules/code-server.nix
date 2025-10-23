{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.code-server;

  start-code-server = (pkgs.writeShellScriptBin "start-code-server" ''
      code-server --bind-addr 0.0.0.0:8080 --auth none
    '');

  code-server = (pkgs.buildFHSEnv {
        name = "code-server";
        targetPkgs = pkgs: with pkgs; [
          curl
          bash
          coreutils
          glibc
          omnisharp-roslyn
        ];
        runScript = pkgs.writeShellScript "code-server-install" ''
          export EXTENSIONS_GALLERY='{"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery", "itemUrl": "https://marketplace.visualstudio.com/items"}'
          if [ ! -f $HOME/.local/bin/code-server ]; then
            curl -fsSL https://code-server.dev/install.sh | sh
          fi
          exec $HOME/.local/bin/code-server "$@"
        '';
      });
in
{
  options.programs.code-server = {
    enable = mkEnableOption "VS Code Server";
  };

  config = mkIf cfg.enable {
    home.packages = [
      code-server
      start-code-server
    ];
  };
}
