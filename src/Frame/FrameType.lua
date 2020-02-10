--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type CompiletimeDataClass
local CompiletimeData = require('Class.CompiletimeData')

--=======
-- Class
--=======

local FrameType = Class.new('FrameType')
---@class FrameType
local public = FrameType.public
---@class FrameTypeClass
local static = FrameType.static
local override = FrameType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param get_toc fun(name:string):string
---@param child_instance any
---@return FrameType
function static.new(uniq_name, get_toc, child_instance)
    local instance = child_instance or Class.allocate(FrameType)
    private.newData(instance, uniq_name, get_toc)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@return boolean
function public:isSimple()
    Log.error(private.data[self].name, 'virtual function is not declared.', 2)
end

---@return number
function public:getDefaultWidth()
    Log.error(private.data[self].name, 'virtual function is not declared.', 2)
end

---@return number
function public:getDefaultHeight()
    Log.error(private.data[self].name, 'virtual function is not declared.', 2)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.compiletime_data = CompiletimeData.new(FrameType)

---@param self FrameType
---@param uniq_name string
---@param get_toc function
function private.newData(self, uniq_name, get_toc)
    local priv = {}

    if IsCompiletime() then
        if private.compiletime_data:get(uniq_name) then
            Log.error(FrameType, 'name is not unique.', 3)
        end
        local toc = get_toc(uniq_name)
        private.compiletime_data:set(uniq_name, toc)
    end

    priv.name = uniq_name
    priv.toc = private.compiletime_data:get(uniq_name)
    if not IsCompiletime() then
        if not BlzLoadTOCFile(priv.toc) then
            Log.error(FrameType, 'load toc failed.', 3)
        end
    end

    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(priv) end
}

return static