local wezterm = require 'wezterm'

return {
  font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
  font_size = 12.5,
  line_height = 1.1,
  color_scheme = "Builtin Solarized Dark",
  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  hide_mouse_cursor_when_typing = true,
  adjust_window_size_when_changing_font_size = false,
  scrollback_lines = 5000,
  enable_wayland = false,
  window_background_opacity = 0.95,
  window_padding = {
    left = 2,
    right = 2,
    top = 1,
    bottom = 1,
  },
  default_prog = { "/bin/zsh", "-l" },
}
