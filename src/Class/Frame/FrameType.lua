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
---@param create_fdf function
---@param child_instance any
---@return FrameType
function static.new(uniq_name, create_fdf, child_instance)
    local instance = child_instance or Class.allocate(FrameType)
    private.newData(instance, uniq_name, create_fdf)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private[self].name
end

---@return boolean
function public:isSimple()
    Log.error(private[self].name, 'virtual function is not declared.', 2)
    return false
end

function public:free()
    private.free(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.compiletime_data = CompiletimeData.new(FrameType)

---@param instance FrameType
---@param uniq_name string
---@param create_fdf function
function private.newData(instance, uniq_name, create_fdf)
    local priv = {
        name = uniq_name,
    }

    if IsCompiletime() then
        if private.compiletime_data:get(uniq_name) then
            Log.error(FrameType, 'name is not unique.', 3)
        end
        local file = create_fdf(uniq_name)
        private.compiletime_data:set(uniq_name, file.toc)
    end

    priv.toc = private.compiletime_data:get(uniq_name)
    if not IsCompiletime() then
        BlzLoadTOCFile(priv.toc)
    end

    private[instance] = priv
end

---@param self FrameType
function private.freeData(self)
    private[self] = nil
end

return static