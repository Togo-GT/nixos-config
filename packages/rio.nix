{ config, pkgs, lib, ... }:

let
  # Hvis Home Manager og rio findes, brug settings derfra; ellers tomt objekt
  cfg = if config ? home && config.home ? rio then config.home.rio else { settings = {}; };

  # Funktion til at generere én TOML-linje pr. indstilling
  renderSetting = name: "${name} = \"${toString cfg.settings.${name}}\"";

  # Kombiner alle linjer til én streng
  renderSettings = builtins.concatStringsSep "\n" (map renderSetting (builtins.attrNames cfg.settings));
in
{
  # Opret fil i /etc (virker både med og uden Home Manager)
  environment.etc."rio/config.toml".text = renderSettings;
}
