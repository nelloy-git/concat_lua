---@class ObjEdit
local ObjEdit = {}

local WeUtils = require('compiletime.ObjectEdit.WeUtils')

ObjEdit.Unit = require('compiletime.ObjectEdit.Unit.WeUnit')

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
end

return ObjEdit