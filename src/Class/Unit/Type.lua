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

---@alias UnitTypeClassification string
---@type UnitTypeClassification[]
static.UnitTypeClassification = {
    Unit = 1,
    Hero = 2,
    -- TODO
    --Building = 3
}

---@param classification UnitTypeClassification
---@param child_instance UnitType | nil
---@return UnitType
function static.new(uniq_name, classification, child_instance)
    local instance = child_instance or Class.allocate(UnitType)
    private.newData(instance, uniq_name, classification)

    return instance
end

--========
-- Public
--========

---@return number
function public:getId()
    return private[self].id
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('number', UnitType)
private.compiletime_data = CompiletimeData.new(UnitType)
local _ = Compiletime(function() private.WeUnit = require('compiletime.ObjectEdit').Unit end)

private.BaseId = {
    [static.UnitTypeClassification.Unit] = 'hfoo',
    [static.UnitTypeClassification.Hero] = 'HPal',
    -- TODO
    --[static.UnitTypeClassification.Building] = 'hfoo',
}

---@param classification any
---@return boolean
function private.isUnitTypeClassification(classification)
    for _, v in pairs(static.UnitTypeClassification) do
        if classification == v then
            return true
        end
    end
    return false
end

function private.createWc3UnitType(name, classification)
    if not private.isUnitTypeClassification(classification) then
        Log.error(UnitType, 'wrong target type.', 3)
    end

    local id = require('compiletime.ObjectEdit').getUnitId()
    local unit_type = private.WeUnit.new(id, private.BaseId[classification], name)
    local Fields = private.WeUnit.Field

    -- TODO dummy fields
    unit_type:setField(Fields.Name, name)

    return unit_type
end

---@param instance UnitType
function private.newData(instance, uniq_name, classification)
    local priv = {
        uniq_name = uniq_name,
        classification = classification
    }

    if IsCompiletime() then
        if private.compiletime_data:get(uniq_name) then
            Log.error(UnitType, 'name is not unique.', 3)
        end
        priv.we_unit = private.createWc3UnitType(uniq_name, classification)
        private.compiletime_data:set(uniq_name, priv.we_unit:getId())
    end

    priv.id = ID(private.compiletime_data:get(uniq_name))

    private[instance] = priv
    private.DB:set(priv.id, instance)
end

---@param instance UnitType
function private.freeData(instance)
    private[instance] = nil
end

return static