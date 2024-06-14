{pkgs, ...}: {
  home.packages = let
    gnome-wallpaper-fetch = pkgs.writeShellScriptBin "gnome-wallpaper-fetch" (builtins.readFile ./gnome-wallpaper-fetch.sh);
  in
    with pkgs; [
      gnome-wallpaper-fetch
      gnome.baobab
      gnome.gnome-logs
      gnome.gnome-disk-utility
      gnome.gnome-calendar
    ];
  home.file.".config/autostart/gnome-wallpaper-fetch.desktop".text = ''
    [Desktop Entry]
    Exec=sh -c "while true; do if [ -d "$HOME/.wallpaper" ]; then sleep 12h; else sleep 1m; fi; gnome-wallpaper-fetch; done"
    Name=Wallpaper Fetcher
    Terminal=false
    Type=Application
    Version=1.4
  '';

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = ["librewolf.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Console.desktop"];
    };
    "org/gnome/evolution-data-server.calendar" = {
      notify-enable-audio = false; # Silences annoying daily beeps
    };
    "org/gnome/desktop/app-folders" = {folder-children = ["Utilities" "Games"];};
    "org/gnome/desktop/app-folders/folders/Games" = {name = "Games";};
    "org/gnome/desktop/app-folders/folders/Games" = {apps = ["crt.desktop" "steam.desktop"];};
    "org/gnome/desktop/app-folders/folders/Utilities" = {name = "Utilities";};
    "org/gnome/desktop/app-folders/folders/Utilities" = {apps = ["org.gnome.Logs.desktop" "org.gnome.Settings.desktop" "org.gnome.SystemMonitor.desktop" "org.gnome.Characters.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.baobab.desktop" "org.gnome.FileRoller.desktop" "org.gnome.Extensions.desktop"];};
  };
}
