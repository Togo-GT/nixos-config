{ ... }:

{
  users.users.gt = {
    isNormalUser = true;
    description = "gt";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "z"
        "sudo"
        "autojump"
        "syntax-highlighting"
        "history-substring-search"
      ];
    };
  };
}
