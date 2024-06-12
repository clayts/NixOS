{pkgs, ...}: {
  imports = [../common/home-manager.nix];

  users.users."guest" = {
    description = "Guest";
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  home-manager.users."guest" = {
    home.stateVersion = "24.11";
    imports = [
      ../common/fonts.nix
      ../common/zsh
      ../common/librewolf.nix
      ../common/gnome
      ../common/nix.nix
    ];
  };
}
