-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

M.ui = {
  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "encoding", "eol", "lsp", "cwd", "cursor" },
    modules = {
      encoding = function()
        if vim.list_contains({ "help" }, vim.bo.filetype) then
          return ""
        end
        local encoding = vim.bo.fileencoding:upper()
        if encoding == "" then
          return ""
        end
        return " %*" .. encoding .. " " -- "%*" is used to clear highlight group (use default highlight)
      end,
      eol = function()
        if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
          return ""
        end
        if vim.list_contains({ "help", "terminal", "NvimTree", "nvdash" }, vim.bo.filetype) then
          return ""
        end
        -- LF, CRLF or CR
        local file_format = vim.bo.fileformat
        local eol
        if file_format == "unix" then
          eol = "LF"
        elseif file_format == "dos" then
          eol = "CRLF"
        elseif file_format == "mac" then
          eol = "CR"
        end
        return " %*" .. eol .. " " -- "%*" is used to clear highlight group (use default highlight)
      end,
    },
  },
}

M.term = { float = { row = 0.05, col = 0.1, width = 0.8, height = 0.8 } }

return M
