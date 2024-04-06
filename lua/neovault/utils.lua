local M = {}

local uv = vim.loop
local path_sep = uv.os_uname().version:match('Windows') and '\\' or '/'

function M.is_file(path)
	local stat = uv.fs_stat(path)
	return stat and stat.type == 'file' or false
end

function M.is_directory(path)
	local stat = uv.fs_stat(path)
	return stat and stat.type == 'directory' or false
end

function M.join_paths(...)
	return table.concat({...}, path_sep)
end

function M.file_write(filename, data)
    local file = assert(io.open(filename, 'w+'))
    file:write(data)
    file:close()
end

function M.file_read(filename)
    local file = assert(io.open(filename, 'r'))
    local data = file:read('*a')
    file:close()
    return data
end

return M

