{ flakeRoot, ... }:

{
  imports = [
    ./hardware-configuration.nix
    (import (flakeRoot + "/modules/system/boot.nix"))
    (import (flakeRoot + "/modules/system/networking.nix"))
    (import (flakeRoot + "/modules/system/locale.nix"))
    (import (flakeRoot + "/modules/system/audio.nix"))
    (import (flakeRoot + "/modules/desktop/xserver.nix"))
    (import (flakeRoot + "/modules/desktop/display-manager.nix"))
    (import (flakeRoot + "/modules/desktop/plasma.nix"))
    (import (flakeRoot + "/modules/security/ssh.nix"))
    (import (flakeRoot + "/modules/security/sudo.nix"))
    (import (flakeRoot + "/modules/security/firewall.nix"))
    (import (flakeRoot + "/profiles/base.nix"))
    (import (flakeRoot + "/profiles/desktop.nix"))
    (import (flakeRoot + "/users/gt/default.nix"))
    (import (flakeRoot + "/system/stateversion.nix"))
  ];
}
