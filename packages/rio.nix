{ config, pkgs, lib, ... }:

let
  cfg = config.home.rio;

  renderSetting = name: "${name} = \"${toString cfg.settings.${name}}\"";
  renderSettings = builtins.concatStringsSep "\n" (map renderSetting (builtins.attrNames cfg.settings));
in
{
  home.file.".config/rio/config.toml".text = ''
    ${renderSettings}
  '';
}
