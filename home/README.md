# Home Manager's Submodules

1. `base`: The base module that is suitable for any NixOS environment.
2. `desktop`: Configuration for desktop environments, such as Hyprland, GNOME, etc.
3. `hyprland`: Hyprland's configuration.
4. `server.nix`: Configuration which is suitable for both servers and desktops. It import only `base` as its submodule.
    1. used by all my nixos servers.
5. `desktop-hyprland.nix`: the entrypoint of hyprland's configuration, it import all the submodules above, except `gnome`.
    1. used by my hyprland desktop.
6. `desktop-gnome.nix`: the entrypoint of gnome configuration, it import all the submodules above, except `hyprland`.
    1. used by my gnome desktop.
