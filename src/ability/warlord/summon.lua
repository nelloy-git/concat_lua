---@type Unit
local Unit = require('unit.Unit')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type Ability
local Ability = require('ability.Ability')
---@type SummonsDB
local SummonsDB = require('ability.SummonsDB')
---@type WarlordAbilitiesSettings
local FullData = require('ability.warlord.settings')
---@type ChannelCompiletimeData
local AbilityData = FullData.SummonSpearman
---@type HeroCompiletimeData
local SummonData = FullData.SpearmanUnit

local targeting_ability_id = compiletime(Ability.generateDummyAbility(AbilityData))
local SummonCrystalSpearmanAbility = Ability.new(AbilityData["Id"],
                                                 targeting_ability_id,
                                                 AbilityData["HotkeyNormal"])
    
function SummonCrystalSpearmanAbility.init()
    UnitEvent.getTrigger("AnyUnitDie"):addAction(function()
            ---@type Unit
            local unit = Unit.GetDyingUnit()
            local dying_id = unit:getId()

            if dying_id == ID(SummonData["Id"]) then
                SummonsDB.rmSlave(unit:getObj())
            end
        end)
end

---@param spell_data SpellCastingData
local function finishCastingCallback(spell_data)
    local caster = spell_data:getCaster()
    local owner = GetOwningPlayer(caster)
    local unit = Unit.new(owner, SummonData["Id"], spell_data:getX(), spell_data:getY(), GetUnitFacing(caster))
    unit:setVertexColor(1, 1, 1, 0.35)
    unit:applyTimedLife(10)

    SummonsDB.addSlave(unit:getObj(), caster)

    unit.parameter:setAttacksPerSec(1)
end

---@type Ability
SummonCrystalSpearmanAbility:setName(AbilityData["TooltipNormal"])
SummonCrystalSpearmanAbility:setCastingTimeFunction(function() return AbilityData["CustomCastingTime"] end)
SummonCrystalSpearmanAbility:setCallback(finishCastingCallback, "finish")

return SummonCrystalSpearmanAbility