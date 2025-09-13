{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];
}


{
  imports = [
    ../modules/system/locale.nix
    ../modules/system/networking.nix
    ../modules/security/ssh.nix
    ../modules/security/sudo.nix
    ../modules/hardware/audio.nix
    ../modules/hardware/printers.nix
  ];

  # Base packages and configurations that are common to all systems.

  # Enable networking
  networking.networkmanager.enable = true;

  # Nix settings
  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Firewall (part of networking module? or security? We'll create a separate module for firewall)
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  # Some base packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    htop
    neofetch
    tree
    nil
    bash
  ];

  # Programs
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
