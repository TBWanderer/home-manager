{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    stylix.url = "github:danth/stylix";
  };
  outputs = { nixpkgs, home-manager, ... }@inputs:
  let system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system;};
  in {
    homeConfigurations.x = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix inputs.stylix.homeManagerModules.stylix];
    };
  };
}
