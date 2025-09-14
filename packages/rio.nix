{ config, pkgs, lib, ... }:

let
  cfg = config.home.rio; # OK nu, fordi Home Manager modul
in {
  options.home.rio = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Rio terminal";
    };
    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.any;
      default = {};
      description = "Rio settings";
    };
  };

  config = lib.mkIf cfg.enable {
    home.files.".config/rio/config.toml".text = ''
      ${lib.concatMapStringsSep "\n" (name: "${name} = \"${toString cfg.settings.${name}}\"") (builtins.attrNames cfg.settings)}
    '';
  };
}
