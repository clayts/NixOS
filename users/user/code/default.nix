{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      piousdeer.adwaita-theme
      serayuzgur.crates
      tamasfe.even-better-toml
      file-icons.file-icons
      mhutchie.git-graph
      golang.go
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
    ];
  };
  home.activation = {
    link-code-settings = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run mkdir -p $HOME/.config/Code/User && ln -s /etc/nixos/users/user/code/settings.json $HOME/.config/Code/User/settings.json
    '';
  };
}
