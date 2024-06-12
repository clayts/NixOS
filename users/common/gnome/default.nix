{
  pkgs,
  config,
  ...
}: let
  rounded-window-corners-reborn = pkgs.callPackage ./rounded-window-corners-reborn.nix {};
in {
  home.packages = with pkgs; [
    bibata-cursors
    papirus-icon-theme
    rounded-window-corners-reborn
    gnomeExtensions.grand-theft-focus
    gnomeExtensions.appindicator

    # Apps
    gnome-console
    gnome.cheese
    loupe
    gnome.file-roller
    gnome.gnome-calculator
    gnome.gnome-system-monitor
    gnome.gnome-characters
    gnome.gnome-screenshot
    gnome.nautilus
    celluloid
    gnome-text-editor
  ];

  # Hide annoying CUPS icon which doesn't do much
  xdg.desktopEntries.cups = {
    name = "";
    noDisplay = true;
  };

  # Disable the hidden micro.desktop file which makes it the default editor for everything in GNOME
  xdg.desktopEntries.micro = {
    name = "";
    noDisplay = true;
  };

  dconf.settings = {
    "org/gnome/TextEditor" = {
      restore-session =
        false;
    };
    "org/gnome/desktop/interface" = {
      font-name = "${(builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0) + " " + "11"}";
      document-font-name = "${(builtins.elemAt config.fonts.fontconfig.defaultFonts.serif 0) + " " + "11"}";
      monospace-font-name = "${(builtins.elemAt config.fonts.fontconfig.defaultFonts.monospace 0) + " " + "Semilight 11"}";
      icon-theme = "Papirus";
      cursor-theme = "Bibata-Modern-Classic";
      gtk-enable-primary-paste = false; # Disable middle-click paste as it can accidentally paste stuff when scrolling
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
      favorite-apps = [
        "librewolf.desktop"
      ];
      enabled-extensions = with pkgs.gnomeExtensions; [
        grand-theft-focus.extensionUuid
        appindicator.extensionUuid
        rounded-window-corners-reborn.extensionUuid
      ];
    };
  };
}
