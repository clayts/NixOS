{
  pkgs,
  config,
  ...
}: let
  sabaki = builtins.fetchurl {
    url = "https://github.com/SabakiHQ/Sabaki/releases/download/v0.52.2/sabaki-v0.52.2-linux-x64.AppImage";
    sha256 = "sha256:0inlp5wb8719qygcac5268afim54ds7knffp765csrfdggja7q62";
  };
in {
  xdg.desktopEntries.sabaki = {
    name = "Sabaki";
    # exec = ''sh -c \'tmp="\\$(mktemp -d)-sabaki"; cp "${./dotfiles/sabaki.json}" "\\$tmp/settings.json"; mkdir -p "~/.config/Sabaki"; ln -s "\\$tmp" "~/.config/Sabaki"; ${pkgs.appimage-run}/bin/appimage-run ${sabaki}; rm -Rf "\\$tmp"; rm "~/.config/Sabaki"\' '';
    exec = ''sh -c "${pkgs.appimage-run}/bin/appimage-run ${sabaki}"'';

    icon = "sabaki";
  };
  # home.file.".config/Sabaki/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/user/sabaki.json";
}
