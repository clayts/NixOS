{pkgs, ...}: let
  hostfetch = import ./hostfetch.nix pkgs;
in {
  home.packages = with pkgs; [
    fzf
    eza
    fd
  ];
  programs.micro = {
    enable = true;
    settings.colorscheme = "cmc-16";
  };
  home.shellAliases = {
    edit = "$EDITOR";
    open = "xdg-open";
    ls = "eza --icons=always --group-directories-first";
    lt = "eza --tree --icons=always --group-directories-first";
    la = "eza -al --icons=always --time-style=relative --color-scale-mode=gradient --color-scale --group-directories-first";
    cd = "z";
    ls-new = "find . -type f -printf '%TF %TT %p\n' | sort | tail -1";

    # Occasional
    crt = ''SHLVL=0 nix shell nixpkgs#cool-retro-term -c cool-retro-term --fullscreen --profile "Default Pixelated";rm -Rf ~/.config/cool-retro-term ~/.local/share/cool-retro-term'';
  };
  home.sessionVariables = {
    EDITOR = "micro";
    GOPATH = "$HOME/.local/share/go";
    NIXOS_OZONE_WL = "1"; # Ask Electron and Chromium apps to run in wayland mode
    MOZ_ENABLE_WAYLAND = "1"; # Ask librewolf/firefox to run in wayland mode
  };
  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
    history.share = false;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    initExtraFirst = ''
      # fzf-tab
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS} # set list-colors to enable filename colorizing

      # substring search
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey "''${terminfo[kcuu1]}" history-substring-search-up
      bindkey "''${terminfo[kcud1]}" history-substring-search-down

      # syntax highlighting
      source ${pkgs.zsh-f-sy-h}/share/zsh/site-functions/F-Sy-H.plugin.zsh

      # skip in tty
      if [[ -n $DISPLAY ]];
      then
        # hostfetch
        [[ $SHLVL -eq 1 ]] && ${hostfetch}/bin/hostfetch

        # powerlevel10k
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${./powerlevel10k.zsh}

        # shift keybindings
        shift-arrow() {
          ((REGION_ACTIVE)) || zle set-mark-command
          zle $1
        }
        shift-left()  shift-arrow backward-char
        shift-right() shift-arrow forward-char
        zle -N shift-left
        zle -N shift-right

        bindkey $terminfo[kLFT] shift-left
        bindkey $terminfo[kRIT] shift-right
      fi

    '';
  };
}
