username: description: {pkgs, ...}: {
  users.users."${username}" = {
    inherit description;
    isNormalUser = true;
    shell = pkgs.zsh;
  };
  imports = [../common/home-manager.nix];
  home-manager.users."${username}" = {
    home.stateVersion = "24.11";
    imports = [
      ../common/fonts.nix
      ../common/zsh
      ../common/librewolf.nix
      ../common/gnome
    ];
  };
}
