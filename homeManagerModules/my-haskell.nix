{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my-haskell = {
    enable = lib.mkEnableOption "Enable Haskell, and LSP.";
  };

  config = lib.mkIf config.my-haskell.enable {
    home.packages = with pkgs; [
      (haskellPackages.ghcWithPackages (
        hpkgs: with hpkgs; [
          # Add specific packages you need
          text
          aeson
          lens
        ]
      ))
      cabal-install
      haskell-language-server
    ];
  };
}
