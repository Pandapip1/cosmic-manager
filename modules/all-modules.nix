{ lib, ... }:
let
  inherit (builtins) readDir;
  inherit (lib) foldlAttrs optional;
  inherit (lib.filesystem) listFilesRecursive;

  appletsByName = ./applets/by-name;
  applicationsByName = ./applications/by-name;
  misc = ./misc;
in
[
  ./appearance.nix
  ./compositor.nix
  ./files.nix
  ./idle.nix
  ./panels.nix
  ./shortcuts.nix
  ./system-actions.nix
  ./wallpapers.nix
  (lib.mkRemovedOptionModule [
    "programs"
    "cosmic-manager"
    "enable"
  ] "The cosmic-manager CLI is no longer available. Please remove this option.")
  (lib.mkRemovedOptionModule [
    "programs"
    "cosmic-manager"
    "package"
  ] "The cosmic-manager CLI is no longer available. Please remove this option.")
]
++ foldlAttrs (
  prev: name: type:
  prev ++ optional (type == "directory") (applicationsByName + "/${name}")
) [ ] (readDir applicationsByName)
++ lib.foldlAttrs (
  prev: name: type:
  prev ++ optional (type == "directory") (appletsByName + "/${name}")
) [ ] (readDir appletsByName)
++ listFilesRecursive misc
