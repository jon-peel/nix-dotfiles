{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my-python.enable = lib.mkEnableOption "Enable python";
  };

  config = lib.mkIf config.my-python.enable {

    home.packages = with pkgs; [
      (python3.withPackages (
        ps: with ps; [
          matplotlib
          numpy
          pandas
          seaborn
        ]
      ))
    ];

  };
}
