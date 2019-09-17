---@type Unit
local Unit = require('baseClasses.Unit')
---@type Ability
local Ability = require('baseClasses.Ability')
---@type WarlordAbilitiesSettings
local FullData = require('heroes.warlord.settings')

---@type ChannelCompiletimeData
local AbilityData = FullData.SummonSpearman
---@type HeroCompiletimeData
local SummonData = FullData.SpearmanUnit

---@type Ability
local SummonSwordman = Ability.new(AbilityData["Id"])

---@param caster Unit
---@param target Vec2
local function start(caster, target)
    caster:setFacingTo(target)
    caster:queueAnimation("Spell")
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@param timeout number
local function finish(caster, target, timeout)
    local owner = caster:getOwner()
    --- Spell is targeting point only
    local summon = Unit.new(owner, SummonData["Id"], target.x, target.y, 180 - caster:getFacing())
    Ability.registerSlave(summon, caster)
end

local format_tooltip = [[Summons invulnerable spirit warrior with %d attack damage and %.2f attacks per second.]]
---@param unit Unit
---@return string
local function getTooltip(unit)
    return string.format(format_tooltip, unit:getAttackDamage(), unit:getAttacksPerSecond())
end

---@type Ability
SummonSwordman:setName("Summon swordman spirit")
SummonSwordman:setTooltipFunc(getTooltip)
SummonSwordman:setFinishCallback(finish)
SummonSwordman:setStartCallback(start)

return SummonSwordman