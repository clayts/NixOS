{
  imports = [../common/librewolf.nix];
  programs.librewolf.settings = {
    "identity.fxaccounts.enabled" = true;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.downloads" = false;
  };
}
