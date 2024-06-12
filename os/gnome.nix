{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  services.gnome = {
    core-utilities.enable = false;
    gnome-online-accounts.enable = true;
  };
  environment.gnome.excludePackages = [pkgs.gnome-tour];

  # GDM should not allow fingerprint authentication for login as it breaks the keyring.
  # In addition, fingerprint authentication seems to be slow and buggy without these hacks.
  # Most of these options don't seem to work as expected individually, but in combination
  # produce an adequate result.
  programs.dconf =
    if config.services.fprintd.enable
    then {
      enable = true;
      profiles.gdm.databases = [
        {
          settings = {
            "org/gnome/login-screen".enable-fingerprint-authentication = false;
          };
        }
      ];
    }
    else {};
  security.pam.services =
    if config.services.fprintd.enable
    then {
      gdm-fingerprint.fprintAuth = true;
      login.fprintAuth = false;
    }
    else {};
}
