---@meta

-- Neovim LSP Client type definitions for better LSP support
-- This file provides type definitions for common Neovim types

---@class lsp.Client
---@field name string
---@field id number
---@field supports_method fun(method: string, opts?: table): boolean
---@field request fun(method: string, params?: table, handler?: function, bufnr?: number): boolean, number
---@field request_sync fun(method: string, params?: table, timeout_ms?: number, bufnr?: number): any, string
---@field notify fun(method: string, params?: table): boolean
---@field cancel_request fun(id: number): boolean
---@field stop fun(force?: boolean)
---@field is_stopped fun(): boolean

---@class LazyFormatter
---@field name string
---@field primary boolean
---@field priority number
---@field format fun(opts?: table)
---@field null_ls? boolean
---@field id? number

---@class LazyFormatterState
---@field active LazyFormatter[]
---@field available LazyFormatter[]
---@field null_ls boolean

---@class vim.lsp.Client : lsp.Client
