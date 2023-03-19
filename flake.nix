{
  description = "PnR for Minecraft";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nix = {
      url = "github:nixos/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix, nixpkgs, fenix, flake-utils }:
    (
      flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              fenix.overlays.default
            ];
          };
        in
        {
          devShell =
            pkgs.mkShell {
              name = "sycamore-test-shell";

              buildInputs =
                let
                  toolchain = with pkgs.fenix; combine [
                    (stable.withComponents [
                      "cargo"
                      "rustc"
                      "rust-src"
                      "rustfmt"
                    ])
                    targets.wasm32-unknown-unknown.stable.rust-std
                    rust-analyzer
                  ];
                in with pkgs; [
                  # For formatting Nix expressions
                  nixpkgs-fmt

                  # Rust development
                  toolchain

                  # Web tools
                  trunk
                  wasm-bindgen-cli
                  wabt
                ];

              nativeBuildInputs = with pkgs; [
              ];

              shellHook = ''
                export RUST_SRC_PATH=${fenix.packages.${system}.stable.rust-src}/lib/rustlib/src/rust/library
              '';
            };

          checks = { };
        }
      )
    );
}
