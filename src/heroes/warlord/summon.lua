---@type Unit
local Unit = require('unit.Unit')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type Ability
local Ability = require('ability.Ability')
---@type SummonsDB
local SummonsDB = require('ability.SummonsDB')
---@type WarlordAbilitiesSettings
local FullData = require('heroes.warlord.settings')
---@type ChannelCompiletimeData
local AbilityData = FullData.SummonSpearman
---@type HeroCompiletimeData
local SummonData = FullData.SpearmanUnit

local targeting_ability_id = compiletime(Ability.generateDummyAbility(AbilityData))
---@type Ability
local SummonCrystalSpearmanAbility = Ability.new(AbilityData["Id"],
                                                 AbilityData["HotkeyNormal"])
SummonCrystalSpearmanAbility:setDummyAbility(targeting_ability_id)
    
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
    Debug("here")
    local caster = spell_data:getCaster()
    Debug("here")
    local owner = GetOwningPlayer(caster)
    Debug("here")
    local pos = spell_data:getTargetPos()
    Debug("here")
    local unit = runFuncInDebug(Unit.new, owner, SummonData["Id"], 0, 0, 0)
    --local unit = Unit.new(owner, SummonData["Id"], pos.x, pos.y, GetUnitFacing(caster))
    Debug("here")
    unit:setVertexColor(1, 1, 1, 0.35)
    Debug("here")
    unit:applyTimedLife(10)
    Debug("here")

    SummonsDB.addSlave(unit:getObj(), caster)

    unit.parameter:setAttacksPerSec(1)
end

---@type Ability
SummonCrystalSpearmanAbility:setName(AbilityData["TooltipNormal"])
SummonCrystalSpearmanAbility:setCastingTimeFunction(function() return AbilityData["CustomCastingTime"] end)
SummonCrystalSpearmanAbility:setCallback("Finish", finishCastingCallback)

return SummonCrystalSpearmanAbility