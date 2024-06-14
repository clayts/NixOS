{...}: {
  xdg.desktopEntries.crt = {
    name = "CRT";
    exec = ''sh -c "${./crt.sh} ${./settings}"'';
  };
}
