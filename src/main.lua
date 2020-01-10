require('utils.Class.Class')

local unit_type = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local Unit = ObjEdit.Unit
    local unit_type = Unit.new(ObjEdit.getHeroId(), 'hPal', 'Paladin')
    unit_type:setField(Unit.Field.Name, 'Paaladin')
    unit_type:setField(Unit.Field.ArmorSoundType, 'Flesh')
end)

return function()
    local icon = Compiletime(function() return require('compiletime.Icon').static.BTN3M1 end)
end