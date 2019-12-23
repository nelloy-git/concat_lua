---@class ObjEdit
local ObjEdit = {}

ObjEdit.Ability = require('compiletime.ObjectEdit.Object.WeAbility')
ObjEdit.Buff = require('compiletime.ObjectEdit.Object.WeBuff')
ObjEdit.Item = require('compiletime.ObjectEdit.Object.WeItem')
ObjEdit.Unit = require('compiletime.ObjectEdit.Object.WeUnit')

ObjEdit.Fdf = {}
ObjEdit.Fdf.File = require('compiletime.ObjectEdit.FdfFile')
ObjEdit.Fdf.Backdrop = require('compiletime.ObjectEdit.Object.Fdf.FdfBackdrop')
ObjEdit.Fdf.Text = require('compiletime.ObjectEdit.Object.Fdf.FdfText')

ObjEdit.Utils = require('compiletime.Utils')

-- Free id getters
ObjEdit.getUnitId = ObjEdit.Utils.nextUnitId
ObjEdit.getHeroId = ObjEdit.Utils.nextHeroId
ObjEdit.getAbilityId = ObjEdit.Utils.nextAbilityId
ObjEdit.getBuffId = ObjEdit.Utils.nextBuffId
ObjEdit.getItemId = ObjEdit.Utils.nextItemId
ObjEdit.getUpgradeId = ObjEdit.Utils.nextUpgradeId

---Function finish object editing.
function ObjEdit.finish()
    ObjEdit.Ability.save()
    ObjEdit.Buff.save()
    ObjEdit.Item.save()
    ObjEdit.Unit.save()
end

addCompiletimeFinalize(ObjEdit.finish)

return ObjEdit