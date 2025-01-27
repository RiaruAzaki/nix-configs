{
  description = "Riaru's Nixos Configuration Flake";

  inputs = {
    # Package Repositories
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/24.05";

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Applications

    xremap-flake.url = "github:xremap/nix-flake";

    # Application Additions
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # kwin-effects-forceblur = {
    #   url = "github:taj-ny/kwin-effects-forceblur";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    settings = rec {
      # --- Primary User Settings ---
      username = "riaru";
      username-full = "Aki Riaru";
      email = "riaruazaki@proton.me";

      # --- Themeing ---
      accent = purple;
      secondary = teal;
      tertiary = red;

      gap-s = 2; # px
      gap-m = 6; # px
      gap-l = 12; # px

      radius-s = 6; # px
      radius = 8; # px

      text = white;
      subtext = grey;

      base = "#080808";
      section = "#181818";
      card = "#222222";

      red = "#ff596b";
      orange = "#ffa062";
      yellow = "#fffb77";
      green = "#99ff82";
      teal = "#80ffc1";
      cyan = "#7ef8fe";
      blue = "#83bbff";
      purple = "#a386ff";
      pink = "#fe99fe";
      brown = "#ba8d70";
      white = "#ffffff";
      grey = "#272727";
      black = "#000000";

      font = "Inter";
      font-monospace = "JetBrainsMono";

      keyboard = "dvorak";
    };

    inherit (self) outputs;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs outputs;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      # Desktop
      lain = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs settings;};
        modules = [
          ./systems/lain/configuration.nix
        ];
      };

      # Laptop
      shizuku = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs settings;};
        modules = [
          ./systems/shizuku/configuration.nix
        ];
      };

      # Server
      fujin = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs settings;};
        modules = [
          ./systems/fujin/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      # Desktop
      "${settings.username}@lain" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs settings;};
        modules = [
          ./users/riaru/lain.nix
        ];
      };

      # Laptop
      "${settings.username}@shizuku" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs settings;};
        modules = [
          ./users/riaru/shizuku.nix
        ];
      };

      # Server
      "${settings.username}@fujin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs settings;};
        modules = [
          ./users/riaru/fujin.nix
        ];
      };
    };

    templates = {
      web.path = ./templates/web;
      cpp.path = ./templates/cpp;
      rust.path = ./templates/rust;
      python.path = ./templates/python;
      typescript.path = ./templates/typescript;
    };
  };
}
