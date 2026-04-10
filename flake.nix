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
    {
      darwinConfigurations = {
        # プライベートPC
        "tak" = nix-darwin.lib.darwinSystem {
          modules = [
            ./nix/common.nix
            ./nix/hosts/private.nix
          ];
        };

        # 仕事用PC (hostname を適宜変更)
        "work" = nix-darwin.lib.darwinSystem {
          modules = [
            ./nix/common.nix
            ./nix/work.nix
            ./nix/hosts/work.nix
          ];
        };
      };
    };
}
