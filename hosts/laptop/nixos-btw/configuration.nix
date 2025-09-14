{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/audio.nix
    ../../modules/desktop/xserver.nix
    ../../modules/desktop/display-manager.nix
    ../../modules/desktop/plasma.nix
    ../../modules/security/ssh.nix
    ../../modules/security/sudo.nix
    ../../modules/security/firewall.nix
    ../../profiles/base.nix
    ../../profiles/desktop.nix
    ../../modules/system/rio.nix
    ../../users/gt/gt.nix
    ../../modules/system/stateversion.nix
  ];
}
