{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
          inherit system;
        });
  in {
    devShells = forEachSupportedSystem ({
      pkgs,
      system,
    }: {
      default = pkgs.mkShell {
        buildInputs = [
            # Elm
            pkgs.elmPackages.elm
            pkgs.elmPackages.elm-format
            pkgs.elmPackages.elm-test-rs
            pkgs.elmPackages.elm-json
            pkgs.elmPackages.elm-language-server
            pkgs.elm2nix

            # JS
            pkgs.nodejs_24
            pkgs.typescript

            # Nix
            pkgs.alejandra

            # Scripts
            pkgs.just
            pkgs.bun

            # Tailwind
            pkgs.rustywind
          ];
        shellHook = ''
          npm install
          export PATH="$PWD/node_modules/.bin/:$PATH"
        '';
      };
    });
  };
}
