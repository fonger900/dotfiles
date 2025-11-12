-- ============================================================================
-- WezTerm Configuration
-- ============================================================================
-- A clean, minimal, and highly functional terminal emulator setup tailored for
-- fullstack development. This configuration prioritizes performance, aesthetics,
-- and an intuitive workflow.
-- For detailed documentation, visit: https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================================
-- Visual Appearance & Theming
-- ============================================================================

-- Color Scheme: Defines the terminal's color palette.
-- Tokyo Night is a popular dark theme with pleasant contrast.
config.color_scheme = "Tokyo Night"

-- Font Configuration: Sets the typeface for the terminal.
-- JetBrainsMono Nerd Font is recommended for its excellent readability and glyph support.
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 12.5
config.line_height = 1.15 -- Slightly increased for better readability

-- Window Decorations: Controls the appearance of the window frame and tab bar.
-- "NONE" creates a borderless, minimalist look.
-- config.window_decorations = "NONE"
config.use_fancy_tab_bar = false -- Disables the default fancy tab bar for a cleaner look.
config.hide_tab_bar_if_only_one_tab = true -- Conserves vertical space.

-- Window Padding: Adjusts the inner spacing of the terminal window.
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- ============================================================================
-- Scrollback and Buffer Management
-- ============================================================================

-- Defines the number of lines kept in the scrollback buffer.
config.scrollback_lines = 3000

-- ============================================================================
-- Performance Tuning
-- ============================================================================

-- Sets the maximum frame rate for rendering. 60 FPS is smooth for most displays.
config.max_fps = 60

-- ============================================================================
-- Shell and Environment Configuration
-- ============================================================================

-- Default Program: Specifies the shell to launch. The "-l" flag ensures it's a login shell.
config.default_prog = { "/bin/zsh", "-l" }

-- Environment Variables: Sets environment variables for terminal sessions.
-- TERM="wezterm" enables WezTerm-specific features in applications.
-- COLORTERM="truecolor" advertises 24-bit color support.
config.set_environment_variables = {
  TERM = "wezterm",
  COLORTERM = "truecolor",
}

-- ============================================================================
-- Key Bindings & Actions
-- ============================================================================

local act = wezterm.action

config.keys = {
  -- Tab Management: macOS-style shortcuts for creating and closing tabs.
  { key = "t", mods = "CMD|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },

  -- Tab Navigation: Cycle through tabs using Cmd + Arrow keys.
  { key = "LeftArrow", mods = "CMD", action = act.ActivateTabRelative(-1) },
  { key = "RightArrow", mods = "CMD", action = act.ActivateTabRelative(1) },

  -- Copy/Paste: Standard macOS clipboard shortcuts.
  { key = "c", mods = "CMD", action = act.CopyMode("ClearPattern") },
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

  -- Search: Initiate a search within the terminal buffer.
  { key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },

  -- Font Sizing: Adjust font size on the fly.
  { key = "=", mods = "CMD", action = act.IncreaseFontSize },
  { key = "-", mods = "CMD", action = act.DecreaseFontSize },
  { key = "0", mods = "CMD", action = act.ResetFontSize },
}

-- ============================================================================
-- Tab Appearance & Behavior
-- ============================================================================

-- This function formats the tab title to keep it clean and concise.
-- It truncates long titles to prevent UI clutter.
wezterm.on("format-tab-title", function(tab)
  local title = tab.active_pane.title or "Shell"
  if #title > 20 then
    title = string.sub(title, 1, 17) .. "…"
  end
  return title
end)

-- ============================================================================
-- Final Configuration
-- ============================================================================
return config
