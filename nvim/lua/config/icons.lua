-- ============================================================================
-- Icon Configuration
-- ============================================================================
-- Centralized icon definitions used throughout the Neovim configuration.
-- These Unicode symbols provide visual indicators for diagnostics, git status,
-- LSP completion items, and other UI elements.

return {
  -- ============================================================================
  -- Diagnostic Icons
  -- ============================================================================
  -- Icons displayed alongside LSP diagnostics in the gutter and floating windows
  diagnostics = {
    Error = " ", -- Red circle for errors
    Warn = " ",  -- Yellow triangle for warnings
    Hint = " ",  -- Blue lightbulb for hints
    Info = " ",  -- Blue circle for informational messages
  },

  -- ============================================================================
  -- Git Status Icons
  -- ============================================================================
  -- Icons used by git plugins (gitsigns) to show file change status
  git = {
    added = " ",    -- Green plus for new lines
    modified = " ", -- Blue tilde for modified lines
    removed = " ",  -- Red minus for deleted lines
  },

  -- ============================================================================
  -- LSP Completion Item Kinds
  -- ============================================================================
  -- Icons displayed in completion menus to indicate the type of completion item
  -- (variables, functions, classes, etc.)
  kinds = {
    Array = " ",         -- Array/list data structures
    Boolean = " ",       -- Boolean values (true/false)
    Class = " ",         -- Class definitions
    Color = " ",         -- Color values (CSS, etc.)
    Constant = " ",      -- Constants and readonly values
    Constructor = " ",   -- Constructor functions
    Copilot = " ",       -- GitHub Copilot suggestions
    Enum = " ",          -- Enumeration types
    EnumMember = " ",    -- Members of enumerations
    Event = " ",         -- Event handlers/listeners
    Field = " ",         -- Class/struct fields
    File = " ",          -- File references
    Folder = " ",        -- Directory/folder references
    Function = " ",      -- Function definitions
    Interface = " ",     -- Interface definitions
    Key = " ",           -- Object keys/properties
    Keyword = " ",       -- Language keywords
    Method = " ",        -- Class/object methods
    Module = " ",        -- Modules/packages
    Namespace = " ",     -- Namespaces/scopes
    Null = " ",          -- Null/nil values
    Number = " ",        -- Numeric values
    Object = " ",        -- Object instances
    Operator = " ",      -- Operators (+, -, *, etc.)
    Package = " ",       -- Package/library references
    Property = " ",      -- Object properties
    Reference = " ",     -- Reference types/pointers
    Snippet = " ",       -- Code snippets
    String = " ",        -- String/text values
    Struct = " ",        -- Structure definitions
    Text = " ",          -- Plain text
    TypeParameter = " ", -- Generic type parameters
    Unit = " ",          -- Unit types/values
    Value = " ",         -- Generic values
    Variable = " ",      -- Variable names
  },
}
