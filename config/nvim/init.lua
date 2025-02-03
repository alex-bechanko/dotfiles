-- Dotfiles and configurations for my machines.
-- Copyright (C) 2024 Alex Bechanko
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

require('config.color')
require('config.default')

-- due to how lsp configuration works, it's necessary to pass these
-- modules to the lsp setup to be used when the lsp attaches
local languages = {
  dhall = require('config.filetype.dhall'),
  gleam = require('config.filetype.gleam'),
  go = require('config.filetype.go'),
  lua = require('config.filetype.lua'),
  nix = require('config.filetype.nix'),
  rust = require('config.filetype.rust'),
}
for _, language_module in pairs(languages) do
  language_module.setup()
end

require('config.lsp').setup(languages)
require('config.autocomplete')
require('mini.indentscope').setup()
