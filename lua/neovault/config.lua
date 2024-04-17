local M = {}

local utils = require('neovault.utils')

---@class Config
---@field prefix? string
---@field vault? VaultConfig

---@class VaultConfig
---@field register_path? string | function
---@field key? string | fun(): string
---@field encode? fun(obj: table): string
---@field decode? fun(str: string): table

---Get the default Neovault config
---@return Config
M.defaults = function()
    ---@type Config
    local defaults = {
        timeout = true,
        vault = {
            register_path = utils.join_paths(vim.fn.stdpath('state'), 'neovault'),
            key = function()
                return assert(vim.loop.cwd())
            end,
            encode = function(obj)
                return assert(vim.json.encode(obj))
            end,
            decode = function(str)
                return assert(vim.json.decode(str))
            end,
        }
    }

    return defaults
end

return M
