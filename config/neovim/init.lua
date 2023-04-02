-- Dotfiles and configurations for my machines.
-- Copyright (C) 2023 Alex Bechanko
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


-- Global Options
vim.opt.number     = true
vim.opt.cursorline = true
vim.opt.incsearch  = true
vim.opt.autoindent = true
vim.opt.smarttab   = true
vim.opt.ruler      = true

-- Colorscheme
require('onedark').setup {
  style = 'warmer'
}

require('onedark').load()


-- indent lines
require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- Lua
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "lua",
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    end
})

-- Nix
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "nix",
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    end
})


-- Go
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "go",
    callback = function()
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = false

      require('go').setup()
    end
  }
)

-- Autoformat go files on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
