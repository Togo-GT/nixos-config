{ config, pkgs, lib, ... }:

let
  # Tjek om Home Manager og rio er aktivt
  hasRio = config ? home && config.home ? rio;

  cfg = if hasRio then config.home.rio else { settings = {}; };

  renderSetting = name: "${name} = \"${toString cfg.settings.${name}}\"";

  renderSettings = builtins.concatStringsSep "\n" (map renderSetting (builtins.attrNames cfg.settings));
in
{
  # Generer kun config.toml hvis Home Manager og rio findes
  home.file.".config/rio/config.toml".text = if hasRio then ''
    ${renderSettings}
  '' else null;
}
