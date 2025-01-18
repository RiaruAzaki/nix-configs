{pkgs, ...}: {
  users.users.riaru = {
    initialPassword = "ChangeMe";
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Riaru Azaki";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKa+gTB3lRBtJpG4GEeP7nFpuXEb7mglmN9bR1Q/Y0S riaru@shizuku"
    ];

    extraGroups = ["networkmanager" "wheel" "docker"];

    packages = [pkgs.home-manager];
  };
}
