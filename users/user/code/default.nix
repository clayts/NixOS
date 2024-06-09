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
  # MEGAHACK if this flake is installed to /etc/nixos, link to ./settings.json directly, allowing settings to be changed in the app and recorded in version control. Otherwise link the file from the store immutably as normal.
  # To disable this, comment out the home.activation = {...}; section, and uncomment the following line:
  # home.file.".config/Code/User/settings.json".source = ./settings.json;
  home.activation = {
    link-code-settings = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run mkdir -p $HOME/.config/Code/User && if [ ! -f /etc/nixos/users/user/code/settings.json ]; then ln -s /etc/nixos/users/user/code/settings.json $HOME/.config/Code/User/settings.json; else ln -s ${./settings.json} $HOME/.config/Code/User/settings.json;fi
    '';
  };
}
