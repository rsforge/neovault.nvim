local M = {}

local utils = require('neovault.utils')

---@class Config
---@field prefix? string
---@field vault? VaultConfig

---@class VaultConfig
---@field register_path? string | function
---@field encode? fun(obj: table): string
---@field decode? fun(str: string): table

M.defaults = function()
    return {
        timeout = true,
        vault = {
            register_path = utils.join_paths(vim.fn.stdpath('state'), 'neovault'),
        }
    }
end

return M
