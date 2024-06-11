{pkgs, ...}: {
  users.users."user" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "User";
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.zsh.enable = true;

  imports = [../common/home-manager.nix];
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
