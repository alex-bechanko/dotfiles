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

local colorscheme = {
  name = 'onedark',
  options = {
    style = 'warmer',
  },
}

local function apply_colorscheme(color)
  local scheme = require(color.name)
  scheme.setup(color.options)
  scheme.load()
end


local function setup(opts)
  if opts == nil then
    apply_colorscheme(colorscheme)
  else
    apply_colorscheme(opts)
  end
end

local M = {}
M.setup = setup
M.colorscheme = colorscheme

return M
