{
  pkgs,
  inputs,
  ...
}: let
  extensions = inputs.nix-vscode-extensions.extensions."${pkgs.stdenv.hostPlatform.system}".vscode-marketplace;
  bundles = with extensions;
  with pkgs; [
    {
      # Theme
      extensions = [piousdeer.adwaita-theme file-icons.file-icons];
    }
    {
      # Nix
      extensions = [jnoortheen.nix-ide];
      packages = [alejandra nil];
    }
    {
      # Git
      extensions = [mhutchie.git-graph];
      packages = [git];
    }
  ];
in {
  home.file.".config/VSCodium/User/settings.json".source = ./settings.json;
  home.file.".config/VSCodium/User/keybindings.json".source = ./keybindings.json;
  home.file.".local/share/applications/codium.desktop".source = "${pkgs.vscodium}" + "/share/applications/codium.desktop";
  home.file.".local/share/applications/codium-url-handler.desktop".source = "${pkgs.vscodium}" + "/share/applications/codium-url-handler.desktop";
  home.packages = [
    (pkgs.writeShellApplication
      {
        name = "codium";
        runtimeInputs =
          [
            (pkgs.vscode-with-extensions.override {
              vscode = pkgs.vscodium;
              vscodeExtensions = builtins.concatLists (builtins.catAttrs "extensions" bundles);
            })
          ]
          ++ (builtins.concatLists (builtins.catAttrs "packages" bundles));
        text = ''
          mkdir -p "$HOME/.config/VSCodium/logs"
          exec codium "$@" 2> "$HOME/.config/VSCodium/logs/stderr"
        '';
      })
  ];
}
# Old extensions were:
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

