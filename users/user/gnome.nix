{
  imports = [../common/gnome];
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = ["org.gnome.Nautilus.desktop" "org.gnome.Console.desktop"];
    };
    "org/gnome/evolution-data-server.calendar" = {
      notify-enable-audio = false;
    };
  };
}
