{ pkgs, lib, ... }:

let
  cliPackages = with pkgs; [
    delta lazygit curl ripgrep fzf fd bat jq
    htop bottom duf ncdu tree neofetch
    gparted e2fsprogs
    autojump zsh-autosuggestions zsh-syntax-highlighting
  ];
in
{
  home.username = "gt";
  home.homeDirectory = "/home/gt";
  home.stateVersion = "25.05";

  home.packages = cliPackages;

  imports = [
    ../../../modules/home/rio.nix
  ];

  programs.rio = {
    enable = true;
    settings = {
      font-family = "MesloLGS NF";
      font-size = "14.0";
      color-palette = "carbon";
      working-directory = "/home/gt";
      blink-cursor = "true";
      bold-formatting = "true";
      scrollback-lines = "10000";
      padding-x = "10.0";
      padding-y = "10.0";
      bell-audio = "/usr/share/sounds/freedesktop/stereo/dialog-information.oga";
      bell-animation = "EaseOutExpo";
      mouse-hide-while-typing = "true";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      co = "git checkout";
    };
    initContent = ''
      export EDITOR=nano
      export VISUAL=nano
      eval "$(zoxide init zsh)"
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.autojump}/share/autojump/autojump.zsh
    '';
  };
}
