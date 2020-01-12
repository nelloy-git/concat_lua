local Class = require('utils.Class.Class')
require('utils.Globals')
---@type UnitClass
local Unit = require('Class.Unit')

local unit_type = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local Unit = ObjEdit.Unit
    local unit_type = Unit.new(ObjEdit.getUnitId(), 'hfoo', 'Paladin')
    unit_type:setField(Unit.Field.Name, 'Paladin')
    unit_type:setField(Unit.Field.ArmorSoundType, 'Flesh')
    return unit_type:toRuntime()
end)

local icon = Compiletime(function() return require('compiletime.Icon').BTN3M1 end)
--print(Class.type('azaza', 'string'))

if not IsCompiletime() then
    Unit.new(Player(0), unit_type.id, 0, 0, 0)
    --local u = CreateUnit(Player(0), ID(unit_type.id), 0, 0, 0)
end