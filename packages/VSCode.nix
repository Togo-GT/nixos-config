{pkgs, ... }:

{
# ----------------------------
# VSCode Configuration (UPDATED)
# ----------------------------
programs.vscode = {
  enable = true;
  package = pkgs.vscodium;
  # Use the new configuration format (without profiles)
  extensions = with pkgs.vscode-extensions; [
    ms-python.python
    eamodio.gitlens
    vscodevim.vim
    ms-toolsai.jupyter
  ];
  userSettings = {
    "editor.fontSize" = 14;
    "window.zoomLevel" = 1;
    "git.useForcePushWithLease" = true;
  };
};
}
