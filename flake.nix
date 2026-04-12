{
  description = "macOS dotfiles managed by nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkDarwinSystem =
        modules:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [ ./nix/common.nix ] ++ modules;
        };

      inputs = {
        inherit nixpkgs nix-darwin;
      };
    in
    {
      darwinConfigurations = {
        "tak" = mkDarwinSystem [ ./nix/private.nix ];
        "work" = mkDarwinSystem [ ./nix/work.nix ];
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
