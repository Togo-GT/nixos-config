{ ... }:

{
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbVariant = "";
  };

  services.displayManager.sddm.enable = true;
}
