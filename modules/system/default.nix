# ./modules/system/default.nix
{ config, lib, ... }:

with lib;

let
  cfg = config.custom;
in {
  options = {
    custom = {
      enable = mkEnableOption "Enable custom greeting file";
      greeting = mkOption {
        type = types.str;
        default = "Hello";
        description = "The greeting text to display in /etc/greeting";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.etc."greeting" = {
      text = cfg.greeting;
      mode = "0644";
    };
  };
}
