---@class ObjectEdit
local ObjEdit = {}

---@type WeAbilityOldClass
ObjEdit.AbilityOld = require('compiletime.ObjectEdit.Object.WeAbilityOld')
---@type WeBuffClass
ObjEdit.Buff = require('compiletime.ObjectEdit.Object.WeBuff')
---@type WeItemClass
ObjEdit.Item = require('compiletime.ObjectEdit.Object.WeItem')
---@type WeUnitClass
ObjEdit.Unit = require('compiletime.ObjectEdit.Object.WeUnit')


ObjEdit.Utils = require('compiletime.Utils')

-- Free id getters
ObjEdit.getUnitId = ObjEdit.Utils.nextUnitId
ObjEdit.getHeroId = ObjEdit.Utils.nextHeroId
ObjEdit.getAbilityOldId = ObjEdit.Utils.nextAbilityOldId
ObjEdit.getBuffId = ObjEdit.Utils.nextBuffId
ObjEdit.getItemId = ObjEdit.Utils.nextItemId
ObjEdit.getUpgradeId = ObjEdit.Utils.nextUpgradeId
ObjEdit.getOrderId = ObjEdit.Utils.nextOrderId

return ObjEdit

--[[ Example

local unit_type = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeUnit = ObjEdit.Unit
    local unit_type = WeUnit.new(ObjEdit.getUnitId(), 'hfoo', 'Paladin')
    unit_type:setField(WeUnit.Field.Name, 'Paladin')
    unit_type:setField(WeUnit.Field.ArmorSoundType, 'Flesh')
    return unit_type:toRuntime()
end)

---->

local unit_type = {['Name'] = 'Paladin',['id'] = 'x##$',['name'] = 'Paladin',['base_id'] = 'hfoo',}

]]