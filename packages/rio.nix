{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.rio;
in {
  options.programs.rio = {
    enable = mkEnableOption "Enable Rio terminal emulator";
    settings = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Configuration options for Rio terminal emulator";
    };
  };

  config = mkIf cfg.enable {
    # Installer Rio
    home.packages = [ pkgs.rio ];

    # Skriv settings til config fil
    xdg.configFile."rio/config.toml".text = ''
      ${builtins.concatMapStringsSep "\n" (name: value: "${name} = \"${value}\"") (builtins.attrNames cfg.settings | map (name: { inherit name; value = cfg.settings.${name}; })) }
    '';
  };
}
