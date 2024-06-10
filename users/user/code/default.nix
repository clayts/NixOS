{
  pkgs,
  inputs,
  ...
}: {
  home.file.".config/VSCodium/User/settings.json".source = ./settings.json;
  home.file.".config/VSCodium/User/keybindings.json".source = ./keybindings.json;
  home.packages = let
    extensions = inputs.nix-vscode-extensions.extensions."${pkgs.stdenv.hostPlatform.system}".vscode-marketplace;
  in [
    (pkgs.symlinkJoin
      {
        name = "code";
        paths = [
          # Nix
          pkgs.nil
          pkgs.alejandra

          (pkgs.vscode-with-extensions.override {
            vscode = pkgs.vscodium;
            vscodeExtensions = with extensions; [
              # Theme
              piousdeer.adwaita-theme
              file-icons.file-icons

              # Rust
              serayuzgur.crates
              tamasfe.even-better-toml
              rust-lang.rust-analyzer

              # Go
              golang.go

              # Nix
              jnoortheen.nix-ide

              # Git
              mhutchie.git-graph

              # Direnv
              mkhl.direnv
            ];
          })
        ];
      })
  ];
}
