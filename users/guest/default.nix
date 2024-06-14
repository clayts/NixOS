{pkgs, ...}: {
  imports = [../common/home-manager.nix];

  users.users."guest" = {
    description = "Guest";
    isNormalUser = true;
  };

  home-manager.users."guest" = {
    home.stateVersion = "24.11";
    imports = [
      ../common/fonts.nix
      ../common/librewolf.nix
      ../common/gnome
      ../common/nix.nix
    ];
  };
}
