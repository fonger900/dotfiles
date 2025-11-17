-- ============================================================================
-- Neovim Configuration Entry Point
-- ============================================================================
-- This is the main entry point for the Neovim configuration. It sets up
-- essential globals and loads the modular configuration system.
--
-- Configuration Structure:
--   ├── config/          # Core Neovim settings
--   │   ├── globals.lua  # Early globals (leaders, providers)
--   │   ├── lazy.lua     # Plugin manager setup
--   │   ├── options.lua  # Editor options and behavior
--   │   ├── keymaps.lua  # Key bindings and shortcuts
--   │   └── autocmds.lua # Automatic commands and events
--   └── plugins/         # Plugin configurations
--       ├── core.lua     # Essential UI and utilities
--       ├── lsp.lua      # Language server setup
--       ├── coding.lua   # Completion and coding tools
--       ├── editor.lua   # Text editing enhancements
--       ├── git.lua      # Git integration
--       └── snacks.lua   # Additional functionality

-- Load immutable globals (leader keys, providers, loader) first
require("config.globals")

-- ============================================================================
-- Load Configuration Modules
-- ============================================================================
-- Load configuration in dependency order: plugins first, then settings

require("config.lazy")     -- Plugin manager and plugin loading
require("config.options")  -- Editor options and behavior settings
require("config.keymaps")  -- Key bindings and shortcuts
require("config.autocmds") -- Automatic commands and event handlers
