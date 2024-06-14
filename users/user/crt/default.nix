{...}: {
  xdg.desktopEntries.crt = {
    name = "CRT";
    exec = ''
      TRUE_XDG_CONFIG_HOME=$XDG_CONFIG_HOME TRUE_XDG_DATA_HOME=$XDG_DATA_HOME nix shell nixpkgs#cool-retro-term -c sh -c "XDG_CONFIG_HOME=${./settings} XDG_DATA_HOME=${./settings} cool-retro-term --fullscreen -e sh -c \"SHLVL=0 XDG_CONFIG_HOME=$TRUE_XDG_CONFIG_HOME XDG_DATA_HOME=$TRUE_XDG_DATA_HOME; cd; exec zsh\""
    '';
  };
}
