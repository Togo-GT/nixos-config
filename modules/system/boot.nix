{ ... }:
{
  # Boot loader (could be in a module, but since it's hardware-specific, we might leave it here or in a hardware module)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
}
