{ config, lib, pkgs, ... }:

{
  imports =
    [ ./desktop
      ./os-hyperv-client.nix ];
}
