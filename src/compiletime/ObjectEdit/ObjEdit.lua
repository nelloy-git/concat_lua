---@class ObjEdit
local ObjEdit = {}

local WeUtils = require('compiletime.ObjectEdit.WeUtils')

ObjEdit.Unit = require('compiletime.ObjectEdit.Unit.WeUnit')
ObjEdit.Ability = require('compiletime.ObjectEdit.Ability.WeAbility')

-- Free id getter
ObjEdit.getUnitId = WeUtils.nextUnitId
ObjEdit.getHeroId = WeUtils.nextHeroId
ObjEdit.getAbilityId = WeUtils.nextAbilityId
ObjEdit.getBuffId = WeUtils.nextBuffId
ObjEdit.getItemId = WeUtils.nextItemId
ObjEdit.getUpgradeId = WeUtils.nextUpgradeId

---Function finish object editing.
function ObjEdit.finish()
    ObjEdit.Unit.save()
    ObjEdit.Ability.save()
end

addCompiletimeFinalize(ObjEdit.finish)

return ObjEdit