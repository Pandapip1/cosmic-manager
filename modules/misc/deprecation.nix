{ lib, ... }:
{
  imports = [
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
  ];
}
