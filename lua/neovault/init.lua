local M = {}

M.vaults = {}
M.active_vault = nil
M.action = ''

local config = require('neovault.config')
local keymap = require('neovault.keymap')
local vault  = require('neovault.vault')

function M.setup(opts)
    config.setup(opts)
    keymap.setup()
end

function M.create_vault(name)
    M.vaults[name] = vault.new(name)
    return M.vaults[name]
end

function M.get_vault(name)
    return M.vaults[name] or M.create_vault(name)
end

function M.set_active(name)
    M.active_vault = M.get_vault(name)
end

---Feed prefix
---@param action string
function M.run(action)
    M.action = action
    vim.print('Select a Register')
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(config.options.prefix, true, true, true), '', false)
end

return M
