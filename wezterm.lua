-- ==========================================
-- Wezterm Configuration for Fullstack Development
-- Author: fonger
-- Updated: 2025-11-14
-- ==========================================

local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ==========================================
-- Font Configuration
-- ==========================================
config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font', weight = 'Medium' },
  { family = 'FiraCode Nerd Font', weight = 'Medium' },
  { family = 'Cascadia Code NF', weight = 'Medium' },
}
config.font_size = 12.5
config.line_height = 1.2
config.freetype_load_target = 'HorizontalLcd'
config.freetype_render_target = 'HorizontalLcd'

-- Enable ligatures for better code display
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- ==========================================
-- Color Scheme
-- ==========================================
config.color_scheme = 'Catppuccin Mocha'

-- Custom tab bar colors
config.colors = {
  tab_bar = {
    background = '#1e1e2e',
    active_tab = {
      bg_color = '#313244',
      fg_color = '#cdd6f4',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#1e1e2e',
      fg_color = '#6c7086',
    },
    inactive_tab_hover = {
      bg_color = '#181825',
      fg_color = '#cdd6f4',
    },
    new_tab = {
      bg_color = '#1e1e2e',
      fg_color = '#6c7086',
    },
    new_tab_hover = {
      bg_color = '#181825',
      fg_color = '#cdd6f4',
    },
  },
}

-- ==========================================
-- Window Configuration
-- ==========================================
config.window_background_opacity = 0.95
config.macos_window_background_blur = 30

config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 8,
}

config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'NeverPrompt'

-- Initial window size
config.initial_cols = 120
config.initial_rows = 30

-- ==========================================
-- Tab Bar Configuration
-- ==========================================
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 32

-- Custom tab title formatting
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.tab_title
  -- Use the current working directory basename if no title is set
  if title and #title > 0 then
    title = title
  else
    title = tab.active_pane.title
  end
  
  -- Extract just the directory name
  local cwd = title:match("([^/]+)/?$") or title
  
  -- Add icon based on process
  local process_icons = {
    ['docker'] = '🐳',
    ['docker-compose'] = '🐳',
    ['node'] = '⬢',
    ['npm'] = '📦',
    ['yarn'] = '📦',
    ['pnpm'] = '📦',
    ['python'] = '🐍',
    ['python3'] = '🐍',
    ['nvim'] = '',
    ['vim'] = '',
    ['git'] = '',
    ['zsh'] = '',
    ['bash'] = '',
  }
  
  local process_name = tab.active_pane.foreground_process_name
  local icon = '  '
  if process_name then
    for proc, proc_icon in pairs(process_icons) do
      if process_name:find(proc) then
        icon = proc_icon .. ' '
        break
      end
    end
  end
  
  local index = tab.tab_index + 1
  
  return {
    { Text = ' ' .. index .. ': ' .. icon .. cwd .. ' ' },
  }
end)

-- ==========================================
-- Cursor Configuration
-- ==========================================
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 700
config.cursor_thickness = '2px'

-- ==========================================
-- Scrollback Configuration
-- ==========================================
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- ==========================================
-- Performance Configuration
-- ==========================================
config.front_end = 'WebGpu'
config.max_fps = 120
config.animation_fps = 60

-- ==========================================
-- Key Bindings for Fullstack Development
-- ==========================================
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

-- ==========================================
-- Mouse Bindings
-- ==========================================
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

-- ==========================================
-- Launch Menu for Quick Project Access
-- ==========================================
config.launch_menu = {
  {
    label = '🚀 New Full Stack Project',
    args = { 'zsh', '-c', 'cd ~/Projects && pwd' },
  },
  {
    label = '🐍 Python Virtual Environment',
    args = { 'zsh', '-c', 'cd ~/Projects && source venv/bin/activate && zsh' },
  },
  {
    label = '⬢ Node Development',
    args = { 'zsh', '-c', 'cd ~/Projects && node --version && zsh' },
  },
  {
    label = '🐳 Docker Dashboard',
    args = { 'zsh', '-c', 'docker ps -a' },
  },
  {
    label = '📝 Edit Configs',
    args = { 'zsh', '-c', 'cd ~/dotfiles && nvim .' },
  },
}

-- ==========================================
-- Hyperlink Rules (clickable URLs and paths)
-- ==========================================
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Add custom rules for localhost URLs
table.insert(config.hyperlink_rules, {
  regex = [[\blocalhost:\d+\b]],
  format = 'http://$0',
})

-- Add custom rules for common dev ports
table.insert(config.hyperlink_rules, {
  regex = [[127\.0\.0\.1:\d+]],
  format = 'http://$0',
})

-- GitHub PR/Issue numbers
table.insert(config.hyperlink_rules, {
  regex = [[#\d+]],
  format = 'https://github.com/$1',
})

-- ==========================================
-- Quick Select Patterns (for easy text selection)
-- ==========================================
config.quick_select_patterns = {
  -- File paths
  '(?:[~./]|[a-zA-Z]:)[a-zA-Z0-9_\\-./]+',
  -- Git commit hashes
  '[a-f0-9]{7,40}',
  -- UUIDs
  '[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}',
  -- IP addresses
  '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}',
  -- Docker container IDs
  '[a-f0-9]{12,64}',
}

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

