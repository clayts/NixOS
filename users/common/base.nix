{
  username,
  user,
  home,
}: {
  imports = [
    ({
      pkgs,
      config,
      ...
    }: {
      users.users."${username}" = {
        isNormalUser = true;
        shell = pkgs.zsh;
      };

      programs.zsh.enable = true;

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
    })
    {
      users.users."${username}" = user;
      home-manager.users."${username}" = home;
    }
  ];
}
