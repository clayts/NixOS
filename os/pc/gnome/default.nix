{...}: {
  imports = [./fingerprint-fix.nix];
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  services.gnome = {
    gnome-online-accounts.enable = true;
  };
}
