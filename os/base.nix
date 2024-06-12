{
  pkgs,
  config,
  ...
}: {
  system.stateVersion = "24.11";

  boot.

  # Boot
  boot = {
    ## Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    ## Boot loader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    plymouth.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 0;
  };

  # Nix
  ## Collect Nix Garbage
  nix = {
    enable = true;
    settings.auto-optimise-store = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      settings.experimental-features = ["nix-command" "flakes"];
    };
  };
  ## Allow unfree and experimental
  nixpkgs.config.allowUnfree = true;
  ## Needed to build flakes etc
  environment.systemPackages = with pkgs; [git gh];
  ## Prevents annoying error messages
  system.activationScripts.empty-channel = {
    text = ''
      mkdir -p /nix/var/nix/profiles/per-user/root/channels
    '';
  };

  # Remove bloat
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [pkgs.gnome-tour];

  # Fix sudo shlvl
  security.sudo.extraConfig = ''
    Defaults:root,%wheel env_keep+=SHLVL
  '';

  # User settings
  environment.localBinInPath = true;
  programs.zsh.enable = builtins.any (user: user.shell == pkgs.zsh) (builtins.attrValues config.users.users);
}
