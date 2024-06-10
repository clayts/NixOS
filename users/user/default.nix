{
  pkgs,
  inputs,
  ...
}: let
  username = "user";
  description = "User";
in {
  users.users."${username}" = {
    inherit description;
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  imports = [../common/home-manager.nix];
  home-manager.users."${username}" = {
    home.stateVersion = "24.11";
    imports = [
      ../common/zsh
      ../common/fonts.nix

      ./gnome.nix
      ./librewolf.nix
      ./direnv.nix
      ./code
    ];
    home.packages = with pkgs; [
      steam
    ];
  };
}
