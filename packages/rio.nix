{ config, ... }:
{
  programs.rio = {
    enable = true;
    settings = {
      # Skrifttype og størrelse
      font-family = "MesloLGS NF";
      font-size = 14.0;

      # Farvetema (Rio's indbyggede temaer: carbon, moon, dawn, daylight, dusk)
      color-palette = "carbon";

      # Terminalindstillinger
      blink-cursor = true;
      bold-formatting = true;
      working-directory = "/home/"+config.home.username+"/";
      disable-unfocused-render = false;

      # Padding og layout
      padding-x = 10.0;
      padding-y = 10.0;

      # Scroll back linjer
      scrollback-lines = 10000;

      # Performance optimeringer
      render-throttle = 5;
      use-thin-strokes = true;

      # Bell-lyd
      bell-audio = "/usr/share/sounds/freedesktop/stereo/dialog-information.oga";
      bell-animation = "EaseOutExpo";

      # Musestøtte
      mouse-hide-while-typing = true;
    };
  };
}
