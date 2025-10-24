{ config, lib, pkgs, ... }:

{
  options.my-jetbrains = {
    enable = lib.mkEnableOption "Enable Jetbrains IDE and tooling";
  };

  config = lib.mkIf config.my-jetbrains.enable {
    home.packages = with pkgs; [ jetbrains.gateway ];
  };
}
