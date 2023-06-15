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

local options = {
  global = {
    number = true,
    cursorline = true,
    incsearch = true,
    autoindent = true,
    smarttab = true,
    ruler = true,
    timeout = true,
    timeoutlen = 300,
  },
  filetype = {
    go = {
      tabstop = 4,
      softtabstop = 4,
      shiftwidth = 4,
      expandtab = true,
    },
    lua = {
      tabstop = 2,
      shiftwidth = 2,
      expandtab = true,
    },
    nix = {
      tabstop = 2,
      shiftwidth = 2,
      expandtab = true,
    }
  },
}

local function apply_option_table(opts)
  for opt_name, opt_value in pairs(opts) do
    vim.opt[opt_name] = opt_value
  end
end

local function apply_options(all_opts)
  -- apply global options
  apply_option_table(all_opts.global)

  -- apply filetype options
  for filetype, filetype_opts in pairs(all_opts.filetype) do
    vim.api.nvim_create_autocmd('Filetype', {
      pattern = filetype,
      callback = function()
        apply_option_table(filetype_opts)
      end
    })
  end
end

local function setup(opts)
  if opts == nil then
    apply_options(options)
  else
    apply_options(opts)
  end
end

local M = {}
M.options = options
M.setup = setup
return M
