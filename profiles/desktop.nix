{  pkgs, ... }:

{
  imports = [
    ../modules/system/video.nix
  ];

  # Desktop-specific packages
  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];



  # Enable Plasma 6
  services.desktopManager.plasma6.enable = true;
}
