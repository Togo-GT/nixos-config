{ ... }:

{
  users.users.user1 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
