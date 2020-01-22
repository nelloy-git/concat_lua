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

---@alias UnitTypeMode string
---@type UnitTypeMode[]
static.UnitTypeMode = {
    Unit = 1,
    Hero = 2,
    Building = 3
}

---@param type_mode UnitTypeMode
---@param child_instance UnitType | nil
---@return UnitType
function static.new(uniq_name, type_mode, child_instance)
    local instance = child_instance or Class.allocate(UnitType)
    private.newData(instance, uniq_name, type_mode)

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

private.DB = DataBase.new('number', UnitType)
private.CompiletimeData = CompiletimeData.new(UnitType)
local _ = Compiletime(function() private.WeUnit = require('compiletime.ObjectEdit').Unit end)

function private.createDummyUnit()
    
end

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