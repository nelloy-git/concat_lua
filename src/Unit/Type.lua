--=========
-- Include
--=========


local Class = require('Utils.Class.API')

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

---@alias UnitTypeClassEnum number

---@type UnitTypeClassEnum[]
static.Classification = {}
---@type UnitTypeClassEnum
static.Classification.UNIT = 1
---@type UnitTypeClassEnum
static.Classification.HERO = 2

---@param uniq_name string
---@param unit_class UnitTypeClassEnum
---@param child_instance UnitType | nil
---@return UnitType
function override.new(uniq_name, unit_class, child_instance)
    local instance = child_instance or Class.allocate(UnitType)
    private.newData(instance, uniq_name, unit_class)

    return instance
end

--========
-- Public
--========

---@return number
function public:getId()
    return private.data[self].id
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'kv'})

private.compiletime_data = CompiletimeData.new(UnitType)
local _ = Compiletime(function()
    private.ObjEdit = require('compiletime.ObjectEdit')
end)

private.BaseId = {
    [static.Classification.UNIT] = 'hfoo',
    [static.Classification.HERO] = 'HPal',
}

---@param unit_class any
---@return boolean
function private.isUnitTypeClassEnum(unit_class)
    for _, v in pairs(static.Classification) do
        if unit_class == v then
            return true
        end
    end
    return false
end

---@param name string
---@param unit_class UnitTypeClassEnum
function private.createWc3UnitType(name, unit_class)
    if not private.isUnitTypeClassEnum(unit_class) then
        Log.error(UnitType, 'wrong unit type.', 4)
    end

    local ObjEdit = private.ObjEdit
    local id
    if unit_class == static.Classification.UNIT then
        id = ObjEdit.getUnitId()
    elseif unit_class == static.Classification.HERO then
        id = ObjEdit.getHeroId()
    end
    local we_unit = ObjEdit.Unit.new(id, private.BaseId[unit_class], name)
    local Fields = ObjEdit.Unit.Field

    we_unit:setField(Fields.Name, name)
    we_unit:setField(Fields.NormalAbilities, 'AInv')

    return we_unit
end

---@param self UnitType
function private.newData(self, uniq_name, unit_class)
    local priv = {}

    if IsCompiletime() then
        if private.compiletime_data:get(uniq_name) then
            Log.error(UnitType, 'name is not unique.', 3)
        end

        priv.we_unit = private.createWc3UnitType(uniq_name, unit_class)
        private.compiletime_data:set(uniq_name, priv.we_unit:getId())
    end

    priv.id = ID(private.compiletime_data:get(uniq_name))
    priv.name = uniq_name

    private.data[self] = priv
end

return static