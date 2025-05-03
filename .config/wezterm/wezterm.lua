local wezterm = require 'wezterm'
return {
  font = wezterm.font_with_fallback {
    'JetBrainsMono Nerd Font',
    'Monaco'
  },
  font_size = 13.0,
  color_scheme = "Catppuccin Mocha",
  hide_tab_bar_if_only_one_tab = true,
  enable_scroll_bar = false,
  window_background_opacity = 0.90,
  use_fancy_tab_bar = false,
  default_prog = { "/bin/zsh", "-l" },
}
