{ config, ... }:
{
  # ... existing configuration
  custom = {
    enable = true;
    greeting = "Hello from NixOS Server!";
  };
}
