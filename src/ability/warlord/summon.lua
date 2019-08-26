---@type Unit
local Unit = require('unit.Unit')
---@type UnitEvent
local UnitEvent = require('trigger.events.unitEvent')
---@type Ability
local Ability = require('ability.Ability')
---@type SummonDB
local SummonDB = require('ability.SummonsDB')
---@type WarlordAbilitiesSettings
local FullData = require('ability.warlord.settings')
---@type ChannelCompiletimeData
local AbilityData = FullData.SummonSpearman
---@type HeroCompiletimeData
local SummonData = FullData.SpearmanUnit

---@type Ability
local SummonCrystalSwordmanAbility = Ability.new(AbilityData["Id"])
    
function SummonCrystalSwordmanAbility.init()
    UnitEvent.getTrigger("AnyUnitDie"):addAction(function()
            ---@type Unit
            local unit = Unit.GetDyingUnit()
            local dying_id = unit:getId()

            if dying_id == ID(SummonData["Id"]) then
                SummonDB.rmSlave(unit:getObj())
            end
        end)
end

---@param spell_data SpellData
local function finishCastingCallback(spell_data)
    local caster = spell_data:getCaster()
    local owner = GetOwningPlayer(caster)
    local unit = Unit.new(owner, SummonData["Id"], spell_data:getX(), spell_data:getY(), GetUnitFacing(caster))
    unit:setVertexColor(1, 1, 1, 0.35)
    unit:applyTimedLife(10)

    SummonDB.addSlave(unit:getObj(), caster)

    unit.parameter:setAttacksPerSec(1)
end

---@type Ability
SummonCrystalSwordmanAbility:setName(AbilityData["TooltipNormal"])
SummonCrystalSwordmanAbility:setCastingTimeFunction(function() return AbilityData["CustomCastingTime"] end)
SummonCrystalSwordmanAbility:setCallback(finishCastingCallback, "finish")

return SummonCrystalSwordmanAbility