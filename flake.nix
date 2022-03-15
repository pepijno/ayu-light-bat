{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      mg = (with pkgs; stdenv.mkDerivation {
        pname = "ayu-light-bat";
        version = "0.1.0";
        src = fetchFromGitHub {
          owner = "pepijno";
          repo = "ayu-light-bat"; # Bat uses sublime syntax for its themes
          rev = "95d4030b98180473262c5628ff6edb3ed9238c9d";
          sha256 = "16s4l9bvg6np2fkfzwkbkv3v5m2hsdrpn8man0586n9if5nr0xzi";
        };
        installPhase = ''
          mkdir -p $out
          mv $TMP/source/ayu-light.tmTheme $out/
        '';
      }
      );
    in
    rec {
      defaultApp = flake-utils.lib.mkApp {
        drv = defaultPackage;
      };
      defaultPackage = mg;
    }
  );
}
