local Vault = {}

local config = require('neovault.config')
local utils  = require('neovault.utils')

Vault.__index = Vault

Vault.default_options = {
    auto_save = true,
}

---Create a new Vault
---@param name string
---@param opts table | nil
---@alias Vault table
---@return Vault
function Vault.new(name, opts)
    return setmetatable({
        meta = {
            name = name,
            actions = {},
            opts = opts and vim.tbl_deep_extend('force', Vault.default_options or {}, opts)
                        or (Vault.default_options or {}),
        },
        data = {
            registers = {}
        }
    }, Vault)
end

function Vault:new_action(action, func)
    if not self.meta.actions then
        self.meta.actions = {}
    end

    self.meta.actions[action] = func
end

function Vault:save()
    local path = self:save_path()
    vim.fn.mkdir(vim.fn.fnamemodify(path, ':p:h'), 'p')

    self.meta.actions = nil

    utils.file_write(path, vim.json.encode(self))
    return self
end

function Vault:save_path()
    return utils.join_paths(config.options.register_dir, self.meta.name)
end

function Vault:load()
    local path = self:save_path()
    if utils.is_file(path) then
        local data = vim.json.decode(utils.file_read(path))
        if not data then
            vim.notify('Nothing to parse', vim.log.levels.ERROR)
            return
        end

        self.meta.name = data.meta.name
        self.meta.actions = {}
        self.meta.opts = data.meta.opts
        self.data.registers = data.data.registers
    end

    return self
end

function Vault:get(register)
    return self.data.registers[register]
end

function Vault:set(register, value)
    if not self.data.registers then
        self.data.registers = {}
    end

    self.data.registers[register] = value
    return self
end

---Run appropriate action function
---@param action string
---@param register string
function Vault:run(action, register)
    if self.meta.actions[action] then
        local value = self.meta.actions[action](self:get(register))
        if value then
            self:set(register, value)
        end
    end
end

return Vault
