local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback { "JetBrainsMono Nerd Font", "MesloLGS NF" },
  font_size = 13.0,
  color_scheme = "Tokyo Night",
  enable_tab_bar = false,
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
  default_prog = { "/bin/zsh" },
}
