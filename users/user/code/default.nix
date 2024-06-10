{
  pkgs,
  inputs,
  ...
}: let
  bundles = with extensions;
  with pkgs; [
    {
      # Theme
      extensions = [piousdeer.adwaita-theme file-icons.file-icons];
      packages = [];
    }
    {
      # Nix
      extensions = [jnoortheen.nix-ide];
      packages = [alejandra nil];
    }
    {
      # Git
      extensions = [mhutchie.git-graph];
    }
    # {
    #   # Direnv
    #   extensions = [mkhl.direnv];
    # }
    # {
    #   # Rust
    #   extensions = [serayuzgur.crates tamasfe.even-better-toml rust-lang.rust-analyzer];
    # }
    # {
    #   # Go
    #   extensions = [golang.go];
    # }
  ];
  extensions = inputs.nix-vscode-extensions.extensions."${pkgs.stdenv.hostPlatform.system}".vscode-marketplace;
in {
  home.file.".config/VSCodium/User/settings.json".source = ./settings.json;
  home.file.".config/VSCodium/User/keybindings.json".source = ./keybindings.json;
  home.packages = [
    (pkgs.symlinkJoin
      {
        name = "code";
        paths =
          [
            (pkgs.vscode-with-extensions.override {
              vscode = pkgs.vscodium;
              vscodeExtensions = builtins.concatLists (builtins.catAttrs "extensions" bundles);
            })
          ]
          ++ (builtins.concatLists (builtins.catAttrs "packages" bundles));
      })
  ];
}
