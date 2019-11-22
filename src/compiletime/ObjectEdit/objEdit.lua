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
    ObjEdit.Utils = require('compiletime.objEdit.weUtils')

    --Abilities
    ObjEdit.Ability = {}
    ---@type AuraSlowWeAbility
    ObjEdit.Ability.AuraSlow = require('compiletime.objEdit.objects.ability.weAuraSlow')
    ---@type BladeMasterCriticalStrikeWeAbility
    ObjEdit.Ability.BladeMasterCriticalStrike = require('compiletime.objEdit.objects.ability.weBladeMasterCriticalStrike')
    ---@type ChannelWeAbility
    ObjEdit.Ability.Channel = require('compiletime.objEdit.objects.ability.weChannel')
    ---@type HardenedSkin
    ObjEdit.Ability.HardenedSkin = require('compiletime.objEdit.objects.ability.weHardenedSkin')
    ---@type RunedBracersWeAbility
    ObjEdit.Ability.RunedBracers = require('compiletime.objEdit.objects.ability.weRunedBracers')
    ---@type SpellBookWeAbility
    ObjEdit.Ability.SpellBook = require('compiletime.objEdit.objects.ability.weSpellBook')

    -- Buffs
    ObjEdit.Buff = {}
    ---@type WeBuff
    ObjEdit.Buff.Buff = require('compiletime.objEdit.objects.buff.weBuff')

    -- Units
    ObjEdit.Unit = {}
    ---@type WeBuilding
    ObjEdit.Unit.Building = require('compiletime.objEdit.objects.unit.weBuilding')
    ---@type WeHero
    ObjEdit.Unit.Hero = require('compiletime.objEdit.objects.unit.weHero')
    ---@type WeUnit
    ObjEdit.Unit.Unit = require('compiletime.objEdit.objects.unit.weUnit')

    -- Items
    ObjEdit.Item = {}
    ---@type WeItem
    ObjEdit.Item.Item = require('compiletime.objEdit.objects.item.weItem')

    -- Presets
    ObjEdit.Preset = {}
    ---@type ChannelCompiletimeData
    ObjEdit.Preset.Channel = require('compiletime.objEdit.preset.ChannelData')
    ---@type HeroCompiletimeData
    ObjEdit.Preset.Hero = require('compiletime.objEdit.preset.HeroData')

end

---Function finish object editing.
function ObjEdit.close()
    local WeFile = require('compiletime.objEdit.weFile')
    WeFile.close()
end

return ObjEdit