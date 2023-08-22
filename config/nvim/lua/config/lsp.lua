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

local lspconfig = require('lspconfig')
local languages = require('config.languages')
local keymaps = require('config.keymaps')

for _, config in pairs(languages) do
    if config.lspconfig then
        lspconfig[config.lspconfig.server].setup(config.lspconfig.config)
    end
end

keymaps.lsp.global()

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function (args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local buffer = args.buf

        keymaps.lsp.on_lsp_attach(client, buffer)
    end
})
