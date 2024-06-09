{
  pkgs,
  config,
  ...
}: {
  home.packages = let
    wallpaper-fetch = pkgs.writeShellScriptBin "gnome-wallpaper-fetch" (builtins.readFile ./gnome-wallpaper-fetch.sh);
    rounded-window-corners-reborn = pkgs.callPackage ./rounded-window-corners-reborn.nix {};
  in
    with pkgs; [
      bibata-cursors
      papirus-icon-theme
      wallpaper-fetch
      rounded-window-corners-reborn
      gnomeExtensions.grand-theft-focus

      # Apps
      gnome-console
      gnome.baobab
      gnome.cheese
      loupe
      gnome.file-roller
      gnome.gnome-calculator
      gnome.gnome-logs
      gnome.gnome-system-monitor
      gnome.gnome-characters
      gnome.gnome-screenshot
      gnome.gnome-disk-utility
      gnome.nautilus
      gnome.gnome-calendar
      celluloid
      gnome-text-editor
    ];
  xdg.desktopEntries.cups = {
    name = "";
    noDisplay = true;
  };
  home.file.".config/autostart/gnome-wallpaper-fetch.desktop".text = ''
    [Desktop Entry]
    Exec=sh -c "while true; do sleep 12h; gnome-wallpaper-fetch; done"
    Name=Wallpaper Fetcher
    Terminal=false
    Type=Application
    Version=1.4
  '';
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "${(builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0) + " " + "11"}";
      document-font-name = "${(builtins.elemAt config.fonts.fontconfig.defaultFonts.serif 0) + " " + "11"}";
      monospace-font-name = "${(builtins.elemAt config.fonts.fontconfig.defaultFonts.monospace 0) + " " + "9"}";
      icon-theme = "Papirus";
      cursor-theme = "Bibata-Modern-Classic";
      gtk-enable-primary-paste = false;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-fullscreen = ["<Super>f"];
      close = ["<Super>q"];
      switch-windows = ["<Super>Tab"];
      switch-windows-backward = ["<Shift><Super>Tab"];
    };
    "org/gnome/shell" = {
      favorite-apps = ["librewolf.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Console.desktop"];
      enabled-extensions = ["grand-theft-focus@zalckos.github.com" "rounded-window-corners@fxgn"];
    };
  };
}
