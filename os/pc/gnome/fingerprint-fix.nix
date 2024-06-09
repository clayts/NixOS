{config, ...}: {
  # GDM should not allow fingerprint authentication for login as it breaks the keyring.
  # In addition, fingerprint authentication seems to be slow and buggy without these hacks.
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
