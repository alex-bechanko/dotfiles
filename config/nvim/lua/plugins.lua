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


local plugins = {
  indent_blankline = {
    show_current_context = true,
    show_current_context_start = true,
  },
  neodev = {
    override = function(root_dir, library)
      if string.match(root_dir, 'dotfiles') then
        library.enabled = true
        library.plugins = true
      end
    end,
  },
  ['which-key'] = {},
}

local function apply_plugins(plugs)
  for plugin_name, plugin_options in pairs(plugs) do
    require(plugin_name).setup(plugin_options)
  end
end

local function setup(opts)
  if opts == nil then
    apply_plugins(plugins)
  else
    apply_plugins(opts)
  end
end

local M = {}
M.options = plugins
M.setup = setup
return M
