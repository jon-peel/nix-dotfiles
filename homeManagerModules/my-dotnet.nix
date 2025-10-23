{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my-dotnet.enable = lib.mkEnableOption "Enable .Net";

  config = lib.mkIf config.my-dotnet.enable {
    home.packages = with pkgs; [
      (
        with dotnetCorePackages;
        combinePackages [
          sdk_8_0
          sdk_9_0
        ]
      )
    ];
  };
}
