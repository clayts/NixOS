{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaCode"];})
    noto-fonts
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = ["Noto Sans"];
      serif = ["Noto Serif"];
      monospace = ["CaskaydiaCove Nerd Font"];
    };
  };
}
