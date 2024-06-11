{pkgs, ...}: {
  imports = [../common/home-manager.nix];

  users.users."user" = {
    description = "User";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager.users."user" = {
    home.stateVersion = "24.11";
    imports = [
      ../common/fonts.nix
      ../common/zsh
      ../common/librewolf.nix
      ../common/gnome
      ./gnome.nix
      ./librewolf.nix
      ./code
    ];
    home.packages = with pkgs; [
      steam
    ];
  };
}
