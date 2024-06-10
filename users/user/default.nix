{pkgs, ...}:
import ../common/base.nix {
  username = "user";
  user = {
    description = "User";
    extraGroups = ["networkmanager" "wheel"];
  };
  home = {
    imports = [
      ./gnome.nix
      ./librewolf.nix
      ./code
    ];
    home.packages = with pkgs; [
      steam
    ];
  };
}
