local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ==========================================
-- Visuals
-- ==========================================
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback({ 
  'JetBrainsMono NF', 
  'JetBrainsMono Nerd Font', 
  'JetBrains Mono',
  'Consolas' 
})
config.font_size = 13.0
config.window_background_opacity = 0.95
config.window_padding = { left = 5, right = 5, top = 5, bottom = 0 }
config.enable_tab_bar = false

-- ==========================================
-- Performance & Backend
-- ==========================================
config.front_end = "OpenGL" 
config.max_fps = 120
config.enable_wayland = true -- Better for Sway/Wayland

-- ==========================================
-- OS Specific
-- ==========================================
if wezterm.target_triple:find('windows') then
    config.default_prog = { 'powershell.exe', '-NoLogo' }
    config.window_decorations = 'TITLE | RESIZE'
    
    config.launch_menu = {
        {
            label = 'WSL: Ubuntu (Tmux)',
            args = { 'wsl.exe', '-d', 'Ubuntu', 'tmux', 'new-session', '-A', '-s', 'main' },
        },
        {
            label = 'WSL: Ubuntu (Zsh)',
            args = { 'wsl.exe', '-d', 'Ubuntu', 'zsh' },
        },
        {
            label = 'PowerShell Core',
            args = { 'pwsh.exe', '-NoLogo' },
        },
    }
elseif wezterm.target_triple:find('linux') then
    -- Use login shell to ensure /etc/profile and ~/.zprofile are sourced
    config.default_prog = { 'zsh', '--login' }
end

-- ==========================================
-- Keybindings
-- ==========================================
config.keys = {
    -- Show Launcher (Access WSL/Tmux here)
    { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowLauncher },
    
    -- Essential Management
    { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = false } },
    
    -- Pane Splits
    { key = 'e', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'o', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
}

return config
