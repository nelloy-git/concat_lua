--=========
-- Include
--=========

local Class = require('utils.Class')

--=======
-- Class
--=======

local File = Class.newClass('File')

---@class File
local public = File.public
---@class FileClass
local static = File.static
---@type table
local override = File.override
---@type table(File, table)
local private = {}

--=========
-- Static
--=========

---@param filename string
---@param instance_data table | nil
---@return File
function static.new(filename, instance_data)
    local instance = instance_data or Class.newInstanceData(File)
    local priv = private.new(instance, filename)
    
    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

---@return string[]
function public:read()
    local priv = private.get(self)

    local tmp = _G[private.reading_buffer_name]
    _G[private.reading_buffer_name] = {}

    Preloader(priv.name)

    priv.buffer = _G[private.reading_buffer_name]
    _G[private.reading_buffer_name] = tmp

    return priv.buffer
end

---@param str string
function public:write(str)
    table.insert(private.get(self).buffer, str)
end

---@return string[]
function public:getBuffer()
    return private.get(self).buffer
end

function public:clearBuffer()
    private.get(self).buffer = {}
end

---@return boolean
function public:save()
    local priv = private.get(self)

    PreloadGenClear()
    local file_start = string.format(private.file_start_format, private.reading_buffer_name)
	Preload(file_start)
	for i=1, #priv.buffer do
		Preload(private.prefix..priv.buffer[i]..private.suffix)
	end
    PreloadGenEnd(priv.name)
    
    return true
end

--=========
-- Private
--=========

private.reading_buffer_name = 'FileReadingBuffer'
private.file_start_format = '")\nendfunction\n//! beginusercode\nlocal t=_G[%s]\nlocal ins=table.insert--[['
private.prefix = ']]ins(t,[['
private.suffix = ']])--[['

local private_data = {}
---@param self File
---@return FilePrivate
function private.new(self, name)
    ---@class FilePrivate
    local priv = {
        name = name,
        buffer = {}
    }
    private_data[self] = priv
    return priv
end

---@param self File
---@return FilePrivate
function private.get(self)
    return private_data[self]
end

---@param self File
function private.free(self)
    private_data[self] = nil
end

return File