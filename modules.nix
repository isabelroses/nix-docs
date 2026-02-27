{
  pkgs,
  inputs,
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
inputs.nuscht-search.packages.${system}.mkMultiSearch {
  title = "Community modules";

  scopes = [
    # rest of our options
    {
      name = "nixos modules";
      optionsJSON =
        (import "${inputs.nixpkgs}/nixos/release.nix" { }).options + /share/doc/nixos/options.json;
      urlPrefix = "https://github.com/NixOS/nixpkgs/tree/master/";
    }
    {
      name = "nix-darwin";
      optionsJSON = inputs.darwin.packages.${system}.optionsJSON + /share/doc/darwin/options.json;
      urlPrefix = "https://github.com/LnL7/nix-darwin/tree/master/";
    }
    {
      name = "home manager";
      optionsJSON =
        inputs.home-manager.packages.${system}.docs-json + /share/doc/home-manager/options.json;
      urlPrefix = "https://github.com/nix-community/home-manager/tree/master/";
    }
    {
      name = "nixos-wsl";
      modules = [
        inputs.nixos-wsl.nixosModules.default
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://github.com/nix-community/NixOS-WSL/blob/main/";
    }
    {
      name = "sops-nix";
      modules = [ inputs.sops.nixosModules.default ];
      urlPrefix = "https://github.com/Mic92/sops-nix/blob/master/";
    }
    {
      name = "catppuccin nixos";
      modules = [
        inputs.catppuccin.nixosModules.catppuccin
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://github.com/catppuccin/nix/blob/main/";
    }
    {
      name = "catppuccin home-manager";
      modules = [
        inputs.catppuccin.homeModules.catppuccin
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://github.com/catppuccin/nix/blob/main/";
    }
    {
      name = "easy-hosts";
      modules = [ inputs.easy-hosts.flakeModule ];
      urlPrefix = "https://github.com/tgirlcloud/easy-hosts/blob/main/";
    }
    {
      name = "tgirlpkgs nixos";
      modules = [
        inputs.tgirlpkgs.nixosModules.default
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://github.com/tgirlcloud/pkgs/blob/main/";
    }
    {
      name = "tgirlpkgs darwin";
      modules = [
        inputs.tgirlpkgs.darwinModules.default
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://github.com/tgirlcloud/pkgs/blob/main/";
    }
    {
      name = "tgirlpkgs home-manager";
      modules = [
        inputs.tgirlpkgs.homeModules.default
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://github.com/tgirlcloud/pkgs/blob/main/";
    }
    {
      name = "simple-nixos-mailserver";
      modules = [
        inputs.simple-nixos-mailserver.nixosModules.default
        # https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/blob/master/flake.nix#L92-96
        {
          mailserver = {
            fqdn = "mx.example.com";
            domains = [ "example.com" ];
          };
        }
      ];
      urlPrefix = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/blob/master/";
    }
    {
      name = "tranquil-pds";
      modules = [
        inputs.tranquil.nixosModules.default
        { _module.args = { inherit pkgs; }; }
      ];
      urlPrefix = "https://tangled.org/tranquil.farm/tranquil-pds/blob/main/";
    }
  ];
}
