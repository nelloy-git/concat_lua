---@class ObjectEdit
local ObjEdit = {}

---@type WeAbilityClass
ObjEdit.Ability = require('compiletime.ObjectEdit.Object.WeAbility')
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
ObjEdit.getAbilityId = ObjEdit.Utils.nextAbilityId
ObjEdit.getBuffId = ObjEdit.Utils.nextBuffId
ObjEdit.getItemId = ObjEdit.Utils.nextItemId
ObjEdit.getUpgradeId = ObjEdit.Utils.nextUpgradeId

return ObjEdit