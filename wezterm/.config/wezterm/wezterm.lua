-- Minimal, fast WezTerm configuration

local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder and wezterm.config_builder() or {}

-- ==========================================
-- OS Detection
-- ==========================================

local function is_windows()
  return wezterm.target_triple:find('windows') ~= nil
end

-- ==========================================
-- Helper Functions
-- ==========================================

local function apply_font_and_colors(config)
  -- Windows might use different font name variants
  local font_name = 'JetBrainsMono Nerd Font'
  if is_windows() then
    -- Try common Windows variants if the primary one isn't found
    config.font = wezterm.font_with_fallback {
      'JetBrainsMono NF',
      'JetBrainsMono Nerd Font',
      'Consolas',
    }
    config.font_size = 10

  else
    config.font = wezterm.font(font_name, { weight = 'Regular' })
    config.font_size = 12.5

  end

  config.line_height = 1.2
  config.color_scheme = 'Catppuccin Mocha'
end

local function apply_window(config)
  config.window_background_opacity = 0.95
  
  if is_windows() then
    config.window_decorations = 'TITLE | RESIZE'
  else
    config.window_decorations = 'RESIZE'
  end

  config.window_close_confirmation = 'NeverPrompt'
  config.initial_cols = 120
  config.initial_rows = 30
  
  config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  }
end

local function apply_tab_bar(config)
  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = false
end

local function apply_cursor_and_scrollback(config)
  config.default_cursor_style = 'BlinkingBar'
  config.cursor_blink_rate = 700
  config.cursor_thickness = '2px'

  config.scrollback_lines = 10000
  config.enable_scroll_bar = false
end

local function apply_performance(config)
  -- OpenGL is often more stable as a primary front-end on Windows
  config.front_end = 'OpenGL'
  config.max_fps = 120
  config.animation_fps = 60
end

local function apply_os_settings(config)
  if is_windows() then
    -- WSL Domains allow easy access to WSL distributions
    config.wsl_domains = {
      {
        name = 'WSL:Ubuntu',
        distribution = 'Ubuntu',
      },
    }
    
    -- Windows-specific shell options
    -- Use powershell.exe by default as it's guaranteed to be there
    config.default_prog = { 'powershell.exe', '-NoLogo' }
  end
end

local function apply_keybindings(config)
  config.keys = {
    -- ========== Pane Management ==========
    -- Split panes
    {
      key = 'e',
      mods = 'CTRL|SHIFT',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'd',
      mods = 'CMD',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'd',
      mods = 'CMD|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    -- Navigate panes (Vim-style with Alt)
    {
      key = 'h',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Down',
    },

    -- Resize panes
    {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Left', 5 },
    },
    {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Right', 5 },
    },
    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Up', 5 },
    },
    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Down', 5 },
    },

    -- Close pane
    {
      key = 'w',
      mods = 'CMD',
      action = act.CloseCurrentPane { confirm = false },
    },

    -- Zoom pane
    {
      key = 'z',
      mods = 'CTRL|SHIFT',
      action = act.TogglePaneZoomState,
    },

    -- ========== Tab Management ==========
    -- Create new tab
    {
      key = 't',
      mods = 'CMD',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = act.SpawnTab 'CurrentPaneDomain',
    },

    -- Navigate tabs
    {
      key = '[',
      mods = 'CMD',
      action = act.ActivateTabRelative(-1),
    },
    {
      key = ']',
      mods = 'CMD',
      action = act.ActivateTabRelative(1),
    },

    -- Move tabs
    {
      key = '[',
      mods = 'CMD|SHIFT',
      action = act.MoveTabRelative(-1),
    },
    {
      key = ']',
      mods = 'CMD|SHIFT',
      action = act.MoveTabRelative(1),
    },

    -- Direct tab access (1-9)
    {
      key = '1',
      mods = 'CMD',
      action = act.ActivateTab(0),
    },
    {
      key = '2',
      mods = 'CMD',
      action = act.ActivateTab(1),
    },
    {
      key = '3',
      mods = 'CMD',
      action = act.ActivateTab(2),
    },
    {
      key = '4',
      mods = 'CMD',
      action = act.ActivateTab(3),
    },
    {
      key = '5',
      mods = 'CMD',
      action = act.ActivateTab(4),
    },
    {
      key = '6',
      mods = 'CMD',
      action = act.ActivateTab(5),
    },
    {
      key = '7',
      mods = 'CMD',
      action = act.ActivateTab(6),
    },
    {
      key = '8',
      mods = 'CMD',
      action = act.ActivateTab(7),
    },
    {
      key = '9',
      mods = 'CMD',
      action = act.ActivateTab(8),
    },

    -- ========== Search & Selection ==========
    -- Search mode
    {
      key = 'f',
      mods = 'CMD',
      action = act.Search 'CurrentSelectionOrEmptyString',
    },

    -- Quick select mode (URL, paths, git hashes)
    {
      key = 'Space',
      mods = 'CTRL|SHIFT',
      action = act.QuickSelect,
    },

    -- Copy mode (vim-like navigation)
    {
      key = 'x',
      mods = 'CTRL|SHIFT',
      action = act.ActivateCopyMode,
    },

    -- ========== Miscellaneous ==========
    -- Show launcher menu
    {
      key = 'l',
      mods = 'CMD|SHIFT',
      action = act.ShowLauncher,
    },

    -- Command palette
    {
      key = 'p',
      mods = 'CMD|SHIFT',
      action = act.ActivateCommandPalette,
    },

    -- Reload configuration
    {
      key = 'r',
      mods = 'CMD|SHIFT',
      action = act.ReloadConfiguration,
    },

    -- Clear scrollback
    {
      key = 'k',
      mods = 'CMD',
      action = act.ClearScrollback 'ScrollbackAndViewport',
    },

    -- Toggle fullscreen
    {
      key = 'Enter',
      mods = 'ALT',
      action = act.ToggleFullScreen,
    },
  }
end

local function apply_mouse_bindings(config)
  config.mouse_bindings = {
    -- Open URLs with Cmd+Click (macOS) or Ctrl+Click
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
  }
end

local function apply_launch_menu(config)
  if is_windows() then
    config.launch_menu = {
      {
        label = 'WSL: Ubuntu (zsh)',
        args = { 'wsl.exe', '-d', 'Ubuntu', 'zsh' },
      },
      {
        label = 'WSL: Ubuntu (tmux)',
        args = { 'wsl.exe', '-d', 'Ubuntu', 'tmux', 'new-session', '-A', '-s', 'main' },
      },
      {
        label = 'PowerShell Core',
        args = { 'pwsh.exe', '-NoLogo' },
      },
      {
        label = 'PowerShell Desktop',
        args = { 'powershell.exe', '-NoLogo' },
      },
      {
        label = 'Command Prompt',
        args = { 'cmd.exe' },
      },
    }
  else
    config.launch_menu = nil
  end
end

local function apply_hyperlink_rules(config)
  config.hyperlink_rules = wezterm.default_hyperlink_rules()
end

local function apply_quick_select_patterns(config)
  config.quick_select_patterns = nil
end

-- ==========================================
-- Apply Configuration Sections
-- ==========================================

apply_font_and_colors(config)
apply_window(config)
apply_tab_bar(config)
apply_cursor_and_scrollback(config)
apply_performance(config)
apply_keybindings(config)
apply_mouse_bindings(config)
apply_os_settings(config) -- Apply OS specific overrides
apply_launch_menu(config)
apply_hyperlink_rules(config)
apply_quick_select_patterns(config)

-- ==========================================
-- Session Management & Workspace Layouts
-- ==========================================
-- Uncomment to enable workspace-specific sessions
-- wezterm.on('update-right-status', function(window, pane)
--   local cwd = pane:get_current_working_dir()
--   if cwd then
--     local workspace_name = cwd:match('([^/]+)/?$')
--     window:set_right_status(wezterm.format {
--       { Foreground = { Color = '#cdd6f4' } },
--       { Text = '  ' .. workspace_name .. '  ' },
--     })
--   end
-- end)

return config
