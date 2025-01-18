# My NixOS Configuration

My personal Nixos configurations. They are not intended to be used by others however feel free to take parts for your own configuration. Most application have been styled to match my color scheme [Neutral Dark](https://github.com/RiaruAzaki/neutral-dark).

## Structure

- `flake.nix`: Entrypoint for System and Home Manager configurations
- `systems` System configuration usable with `nh os switch`
  - `share`: Configurations shared across multiple system
    - `global`: Configurations shared across all systems
    - `features`: Optional configurations shared across some systems
  - `lain`: Desktop PC Configuration
  - `shizuku`: Laptop Configuration
  - `fujin`: Server Configuration
    - `services`: Services hosted on this machine
- `users/riaru`: home-manager configuration usable with `nh home switch`
  - `global`: home-manager configurations shared across all machines
  - `programs`: Programs installed and configured with home-manager
- `templates`: Templates for setting up new projects
- `packages`: Custom packages for programs unavailable from nixpkgs
- `overlays`: Patches and version overrides for packages

## Featured Configurations

- KDE / (karousel, krohnkite) / touchegg

TODO: add demo

- Firefox

TODO: add demo

- VSCodium

TODO: add demo

- Kitty / Fish / Starship / Zoxide

TODO: add demo

- Discord

TODO: add demo

- Spotify

TODO: add demo

- Obsidian

TODO: add demo

- Selfhosted Nextcloud

TODO: add demo
