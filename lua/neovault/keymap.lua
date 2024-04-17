local M = {}

local config = require('neovault.config')

function M.setup()
    local opts = {
        buffer = nil,
        noremap = true,
        nowait = false,
        silent = true,
        expr = false,
        script = false,
        unique = false,
        replace_keycodes = nil,

    }
    vim.keymap.set('n', config.options.prefix, function()
        if not config.options.timeout then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(config.options.prefix, true, true, true), '', false)
        end
    end, opts)

    vim.keymap.set('n', config.options.prefix .. '<Esc>', function()
    end, opts)

    vim.keymap.set('n', config.options.prefix .. '<BS>', function()
    end, opts)

    for register in config.options.registers:gmatch('.') do
        vim.keymap.set('n', config.options.prefix .. register, function()
            local neovault = require('neovault')
            neovault.active_vault:run(neovault.action, register)
        end, vim.tbl_deep_extend('force', opts or {}, { desc = register .. '-register' }))
    end
end

return M
