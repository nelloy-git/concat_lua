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

local UnitType = Class.new('UnitType')
---@class UnitType
local public = UnitType.public
---@class UnitTypeClass
local static = UnitType.static
---@type UnitTypeClass
local override = UnitType.override
local private = {}

--=========
-- Static
--=========

---@param child_instance UnitType | nil
---@return UnitType
function static.new(child_instance)
    local instance = child_instance or Class.allocate(UnitType)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

---@param instance UnitType
function private.newData(instance)
    local priv = {
    }
    private[instance] = priv
end

---@param instance UnitType
function private.freeData(instance)
    private[instance] = nil
end

return static