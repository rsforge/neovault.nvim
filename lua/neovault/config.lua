local M = {}

local utils = require('neovault.utils')

M.default_options = {
    register_dir = utils.join_paths(vim.fn.stdpath('state'), 'neovault'),
    prefix = '<C-Q>',
    registers = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"',
    timeout = {
        enabled = false,
        timeoutlen = 2500,
    },
}

M.options = {}

---Setup all options
---@param opts table
function M.setup(opts)
    M.options = opts and vim.tbl_deep_extend('force', (M.default_options or {}), opts) or (M.default_options or {})
end

return M
