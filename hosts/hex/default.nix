inputs:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs;};
  modules = [
    # Hostname
    {networking.hostName = "hex";}

    # Hardware
    ./hardware.nix

    # OS
    ../../os/pc
    ../../language/uk.nix

    # Users
    ../../users/user
    ../../users/guest
  ];
}
