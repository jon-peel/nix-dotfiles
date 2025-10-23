{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    vscode-server.url = "github:nix-community/nixos-vscode-server";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      vscode-server,
      firefox-addons,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nix-vm = nixpkgs.lib.nixosSystem {
	  inherit system;
          modules = [
            vscode-server.nixosModules.default
            ./nix-vm/configuration.nix
	  ];
	};
      };
      homeConfigurations = {
          "me@nix-vm" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./me.nix
            ./homeManagerModules
          ];
        };
      };
    };
}
