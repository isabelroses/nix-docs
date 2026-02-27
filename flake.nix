{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    nuscht-search = {
      url = "github:nuschtos/search";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        git-hooks.follows = "";
        flake-compat.follows = "";
        blobs.follows = "";
      };
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tgirlpkgs = {
      url = "github:tgirlcloud/pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    easy-hosts.url = "github:tgirlcloud/easy-hosts";

    tranquil = {
      url = "git+https://tangled.org/tranquil.farm/tranquil-pds";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function nixpkgs.legacyPackages.${system}
        );
    in
    {
      packages = forAllSystems (pkgs: {
        docs = pkgs.callPackage ./modules.nix { inherit inputs; };
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.docs;
      });
    };
}
