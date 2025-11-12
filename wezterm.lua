-- ============================================================================
-- WezTerm Configuration
-- ============================================================================
-- Clean, minimal terminal emulator setup for fullstack development

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================================
-- Visual Appearance
-- ============================================================================

-- Color scheme
config.color_scheme = "Tokyo Night"

-- Font - Clean monospace
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 11.0
config.line_height = 1.15

-- Minimal window decoration
-- config.window_decorations = "NONE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Compact padding
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- ============================================================================
-- Scrollback and Buffer
-- ============================================================================

config.scrollback_lines = 3000

-- ============================================================================
-- Performance
-- ============================================================================

config.max_fps = 60

-- ============================================================================
-- Shell and Environment
-- ============================================================================

-- Use zsh as default shell
config.default_prog = { "/bin/zsh", "-l" }

-- Set environment variables
config.set_environment_variables = {
  TERM = "wezterm",
  COLORTERM = "truecolor",
}

-- ============================================================================
-- Key Bindings
-- ============================================================================

local act = wezterm.action

config.keys = {
  -- Tab management
  { key = "t", mods = "CMD|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
  
  -- Tab navigation
  { key = "LeftArrow", mods = "CMD", action = act.ActivateTabRelative(-1) },
  { key = "RightArrow", mods = "CMD", action = act.ActivateTabRelative(1) },
  
  -- Copy/Paste
  { key = "c", mods = "CMD", action = act.CopyMode("ClearPattern") },
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  
  -- Search
  { key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },
  
  -- Font sizing
  { key = "=", mods = "CMD", action = act.IncreaseFontSize },
  { key = "-", mods = "CMD", action = act.DecreaseFontSize },
  { key = "0", mods = "CMD", action = act.ResetFontSize },
}

-- ============================================================================
-- Tab Appearance
-- ============================================================================

wezterm.on("format-tab-title", function(tab)
  local title = tab.active_pane.title or "Shell"
  if #title > 20 then
    title = string.sub(title, 1, 17) .. "…"
  end
  return title
end)

-- ============================================================================
-- Return Configuration
-- ============================================================================

return config
