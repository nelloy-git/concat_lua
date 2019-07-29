---@class ObjEdit
local ObjEdit = {}

---Function initialize object editing.
---@param src_path string
---@param dst_path string
function ObjEdit.init(src_path, dst_path)
    --Initialize object files
    ---@type WeFile
    local WeFile = require('compiletime.objEdit.weFile')
    WeFile.init(src_path, dst_path)

    -- Utils
    ---@type WeUtils
    ObjEdit.Utils = require('compiletime.objEdit.utils')

    --Abilities
    ObjEdit.Ability = {}
    ---@type AuraSlowWeAbility
    ObjEdit.Ability.AuraSlow = require('compiletime.objEdit.objects.auraSlow')
    ---@type ChannelWeAbility
    ObjEdit.Ability.Channel = require('compiletim.objEdit.objects.ability.channel')
    ---@type BladeMasterCriticalStrikeWeAbility
    ObjEdit.Ability.BladeMasterCriticalStrike = require('compiletime.objEdit.objects.ability.bladeMasterCriticalStrike')
    ---@type RunedBracersWeAbility
    ObjEdit.Ability.RunedBracers = require('compiletime.objEdit.objects.ability.runedBracers')

    -- Buffs
    ---@type WeBuff
    ObjEdit.Buff.Buff = require('compiletime.objEdit.objects.buff.buff')

    -- Units
    ObjEdit.Unit = {}
    ---@type WeBuilding
    ObjEdit.Unit.Building = require('compiletime.objEdit.objects.unit.building')
    ---@type WeUnit
    ObjEdit.Unit.Hero = require('compiletime.objEdit.objects.unit.hero')
    ---@type WeHero
    ObjEdit.Unit.Unit = require('compiletime.objEdit.objects.unit.unit')
end

---Function finish object editing.
function ObjEdit.close()
    local WeFile = require('compiletime.objEdit.weFile')
    WeFile.close()
end

return ObjEdit