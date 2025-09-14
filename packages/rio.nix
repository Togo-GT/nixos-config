{ config, pkgs, lib, ... }:

let
  cfg = config.home.rio;

  # Funktion til at generere én TOML-linje pr. indstilling
  renderSetting = name: "${name} = \"${toString cfg.settings.${name}}\"";

  # Kombinerer alle linjer til én streng
  renderSettings = builtins.concatStringsSep "\n" (map renderSetting (builtins.attrNames cfg.settings));
in
{
  home.file.".config/rio/config.toml".text = ''
    ${renderSettings}
  '';
}
