---@class ObjEdit
local ObjEdit = {}

local WeUtils = require('compiletime.ObjectEdit.WeUtils')

ObjEdit.Ability = require('compiletime.ObjectEdit.Object.WeAbility')
ObjEdit.Buff = require('compiletime.ObjectEdit.Object.WeBuff')
ObjEdit.Item = require('compiletime.ObjectEdit.Object.WeItem')
ObjEdit.Unit = require('compiletime.ObjectEdit.Object.WeUnit')

ObjEdit.Utils = require('compiletime.ObjectEdit.WeUtils')

-- Free id getters
ObjEdit.getUnitId = WeUtils.nextUnitId
ObjEdit.getHeroId = WeUtils.nextHeroId
ObjEdit.getAbilityId = WeUtils.nextAbilityId
ObjEdit.getBuffId = WeUtils.nextBuffId
ObjEdit.getItemId = WeUtils.nextItemId
ObjEdit.getUpgradeId = WeUtils.nextUpgradeId

---Function finish object editing.
function ObjEdit.finish()
    ObjEdit.Ability.save()
    ObjEdit.Buff.save()
    ObjEdit.Item.save()
    ObjEdit.Unit.save()
end

addCompiletimeFinalize(ObjEdit.finish)

return ObjEdit