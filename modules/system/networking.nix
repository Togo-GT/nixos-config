{ ... }:

{
  # This module enables networkmanager and sets the hostname?
  # But note: hostname is set in the host configuration.

  networking.networkmanager.enable = true;

    # Host-specific configuration
  networking.hostName = "nixos-btw"; # This could be here or in a module. Since it's host-specific, we leave it here.
  }

