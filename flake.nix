{
  description = "A flake providing the rkdevelop tool used for rk356x chips";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;
      rkdeveloptool = pkgs.stdenv.mkDerivation rec {
        pname = "rkdeveloptool";
        version = "unstable-2024-10-26";
        name = "${name}-${version}";
        src = pkgs.fetchFromGitHub {
          owner = "rockchip-linux";
          repo = "rkdeveloptool";
          rev = "master";
          sha256 = "sha256-eIFzyoY6l3pdfCN0uS16hbVp0qzdG3MtcS1jnDX1Yk0=";
        };
        nativeBuildInputs = with pkgs; [
          automake
          autoconf
          libusb1
          pkg-config
        ];
        preConfigure = ''
          autoreconf -i
        '';
      };
    in
    {
      packages.x86_64-darwin.default = rkdeveloptool;
    };
}
