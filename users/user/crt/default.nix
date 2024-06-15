{...}: {
  xdg.desktopEntries.crt = {
    name = "CRT";
    exec = ''sh -c "${./crt.sh} ${./settings}"'';
    icon = "cool-retro-term";
  };
}
