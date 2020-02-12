--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type CompiletimeDataClass
local CompiletimeData = require('Utils.CompiletimeData')

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

private.compiletime_data = CompiletimeData.new(UnitType)
local _ = Compiletime(function()
    private.ObjEdit = require('compiletime.ObjectEdit')
end)

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

    local ObjEdit = private.ObjEdit
    local id
    if classification == static.UnitTypeClassification.Unit then
        id = ObjEdit.getUnitId()
    elseif classification == static.UnitTypeClassification.Hero then
        id = ObjEdit.getHeroId()
    end
    local unit_type = ObjEdit.Unit.new(id, private.BaseId[classification], name)
    local Fields = ObjEdit.Unit.Field

    -- TODO dummy fields
    unit_type:setField(Fields.Name, name)
    unit_type:setField(Fields.CollisionSize, 0)
    unit_type:setField(Fields.NormalAbilities, 'AInv')

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
end

return static