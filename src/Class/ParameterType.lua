--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type IconAssetClass
local Icon
local tmp = Compiletime(function()
    Icon = require('compiletime.Icon')
end)
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

local ParameterType = Class.new('ParameterType')
---@class ParameterTypeClass
local static = ParameterType.static
---@class ParameterType
local public = ParameterType.public
---@type ParameterType
local override = ParameterType.override
local private = {}

--========
-- Static
--========

---@return Trigger
function static.getUnitParameterChangedTrigger()
    if not private.UnitParameterChangedTrigger then
        private.UnitParameterChangedTrigger = Trigger.new()
    end
    return private.UnitParameterChangedTrigger
end

---@return Unit
function static.GetUnitWithChangedParameters()
    return nil
end

---@return ParameterType
function static.GetChangedParameterType()
    return nil
end

---@return number
function static.GetChangedParameterOldValue()
    return nil
end

---@return number
function static.GetChangedParameterNewValue()
    return nil
end

---@return number
function static.getMinAttackPDmg()
    return private.min_pdmg_attack
end

---@return number
function static.getMaxAttackPDmg()
    return private.min_pdmg_attack
end

---@return number
function static.getMinAttackMDmg()
    return private.min_mdmg_attack
end

---@return number
function static.getMaxAttackMDmg()
    return private.min_mdmg_attack
end

---@return number
function static.getPDmgPerStr()
    return private.pdmg_per_str
end

---@return number
function static.getArmorPerStr()
    return private.armor_per_str
end

---@return number
function static.getHealthPerStr()
    return private.hp_per_str
end

---@return number
function static.getASpdPerAgi()
    return private.aspd_per_agi
end

---@return number
function static.getCSpdPerAgi()
    return private.cspd_per_agi
end

---@return number
function static.getDodgePerAgi()
    return private.dodge_per_agi
end

---@return number
function static.getMDmgPerInt()
    return private.mdmg_per_int
end

---@return number
function static.getManaPerInt()
    return private.mp_per_int
end

---@return number
function static.getCooldownReductionPerInt()
    return private.cdr_per_int
end

---@return ParameterType[]
function static.getList()
    local copy = {}
    for i = 1, #private.list do
        table.insert(copy, #copy + 1, private.list[i])
    end
    return copy
end

---@param base number
---@param mult number
---@param additive number
---@return number
function public:math(base, mult, additive)
    local priv = private[self]
    return priv.math(base, mult, additive, priv.min, priv.max)
end

---@param target unit
---@param old_value number
---@param new_value number
function public:apply(target, old_value, new_value)
    local priv = private[self]

    priv.apply(target, new_value)

    local prev_unit = static.GetUnitWithChangedParameters
    local prev_param = static.GetChangedParameterType
    local prev_old = static.GetChangedParameterOldValue
    local prev_new = static.GetChangedParameterNewValue

    static.GetUnitWithChangedParameters = function() return target end
    static.GetChangedParameterType = function() return self end
    static.GetChangedParameterOldValue = function() return old_value end
    static.GetChangedParameterNewValue = function() return new_value end

    if private.UnitParameterChangedTrigger then
        private.UnitParameterChangedTrigger:execute()
    end

    static.GetUnitWithChangedParameters = prev_unit
    static.GetChangedParameterType = prev_param
    static.GetChangedParameterOldValue = prev_old
    static.GetChangedParameterNewValue = prev_new
end

---@return string
function public:getShortName()
    local priv = private[self]
    return  priv.short
end

---@return string
function public:getFullName()
    local priv = private[self]
    return  priv.full
end

---@return string
function public:getIcon()
    local priv = private[self]
    return  priv.icon
end

---@return string
function public:getTooltip()
    local priv = private[self]
    return  priv.tooltip
end

---@return number
function public:getMin()
    local priv = private[self]
    return  priv.min_value
end

---@return number
function public:getMax()
    local priv = private[self]
    return  priv.max_value
end


private.UnitParameterChangedTrigger = nil
private.list = {}
private.default_max = 10^10
private.min_pdmg_attack = 0.85
private.max_pdmg_attack = 1.15
private.max_pdmg_reduc = 0.75
private.attack_index = 1
private.min_mdmg_attack = 0.85
private.max_mdmg_attack = 1.15
private.max_ctime_reduc = 0.75
private.max_mdmg_reduc = 0.75
private.max_dodge_ch = 0.50
private.max_crit_ch = 0.75
private.max_cd_reduc = 0.75
private.pdmg_per_str = 0.50
private.armor_per_str = 0.25
private.hp_per_str = 5
private.aspd_per_agi = 1
private.cspd_per_agi = 1
private.dodge_per_agi = 1
private.mdmg_per_int = 1
private.mp_per_int = 5
private.cdr_per_int = 1

---@return ParameterType
function private.new()
    local instance = child_data or Class.allocate(ParameterType)
    local priv = {
        short = "Empty",
        full = "Empty",
        icon = "Empty",
        tooltip = "Empty",
        min_value = 0,
        max_value = 0,
        math = function() return 0 end,
        apply = function() return nil end,
    }
    private[instance] = priv

    table.insert(private.list, #private.list + 1, instance)

    return instance
end

---@param base number
---@param mult number
---@param additive number
---@param max number
---@param min number
---@return number
function private.mathLinear(base, mult, additive, min, max)
    local res = base * mult + additive
    
    if res > max then return max end
    if res < min then return min end
    return res
end

---@param base number
---@param mult number
---@param additive number
---@param max number
---@param min number
---@return number
function private.mathRating(base, mult, additive, min, max)
    local res = base * mult
    if res >= 0 then
        res = res / (100 + res)
        return max * res + additive
    else
        res = -res / (100 - res)
        return min * res + additive
    end
end

function private.applyNothing()
    return nil
end

---@param target unit
---@param value number
function private.applyPDmg(target, value)
    local dmg = private.min_pdmg_attack * value
    local dice_sides = (private.max_pdmg_attack - private.min_pdmg_attack) * value

    BlzSetUnitBaseDamage(target, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(target, 1, 0)
    BlzSetUnitDiceSides(target, math.floor(dice_sides + 1), 0)
end

---@param target unit
---@param value number
function private.applyAttackCooldown(target, value)
    BlzSetUnitAttackCooldown(target, value, private.attack_index)
end

---@param target unit
---@param value number
function private.applyHealth(target, value)
    local percent_hp = GetUnitLifePercent(target)
    BlzSetUnitMaxHP(target, math.floor(value))
    SetUnitLifePercentBJ(target, percent_hp)
end

---@param target unit
---@param value number
function private.applyRegeneration(target, value)
    BlzSetUnitRealField(target, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param target unit
---@param value number
function private.applyMana(target, value)
    local percent_mana = GetUnitManaPercent(target)
    BlzSetUnitMaxMana(target, math.floor(value))
    SetUnitManaPercentBJ(target, percent_mana)
end

---@param target unit
---@param value number
function private.applyRecovery(target, value)
    BlzSetUnitRealField(target, UNIT_RF_MANA_REGENERATION, value)
end

---@param target unit
---@param value number
function private.applyStrength(target, value)
    SetHeroStr(target, value // 1, true)
end

---@param target unit
---@param value number
function private.applyAgility(target, value)
    SetHeroAgi(target, value // 1, true)
end

---@param target unit
---@param value number
function private.applyIntelligence(target, value)
    SetHeroInt(target, value // 1, true)
end

---@param target unit
---@param value number
function private.applyMoveSpeed(target, value)
    if value <= 1 then
        SetUnitTurnSpeed(target, 0)
    else
        SetUnitTurnSpeed(target, GetUnitDefaultTurnSpeed(target))
    end
    SetUnitMoveSpeed(target, value)
end


-- Physical damage.
static.PDmg = private.new()
private[static.PDmg].short = 'PDmg'
private[static.PDmg].full = 'Physical damage'
private[static.PDmg].icon = Compiletime(Icon.BTNSteelMelee)
private[static.PDmg].tooltip = string.format('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %.0f-%.0f%% of this value as physical damage.',
                                              100 * private.min_pdmg_attack, 100 * private.max_pdmg_attack)
private[static.PDmg].min = 0
private[static.PDmg].max = private.default_max
private[static.PDmg].math = private.mathLinear
private[static.PDmg].apply = private.applyPDmg

-- Attack speed.
static.ASpd = private.new()
private[static.ASpd].short = 'ASpd'
private[static.ASpd].full = 'Attack speed'
private[static.ASpd].icon = Compiletime(Icon.BTNCommand)
private[static.ASpd].tooltip = 'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.'
private[static.ASpd].min = 0
private[static.ASpd].max = private.default_max
private[static.ASpd].math = private.mathLinear
private[static.ASpd].apply = private.applyAttackCooldown

-- Armor.
static.Armor = private.new()
private[static.Armor].short = 'PDef'
private[static.Armor].full = 'Armor'
private[static.Armor].icon = Compiletime(Icon.BTNDefend)
private[static.Armor].tooltip = 'Physical damage is reduced by this value. Works after physical damage reduction.'
private[static.Armor].min = -private.default_max
private[static.Armor].max = private.default_max
private[static.Armor].math = private.mathLinear
private[static.Armor].apply = private.applyNothing

-- Physical damage reduction.
static.PDmgReduc = private.new()
private[static.PDmgReduc].short = 'PReduc'
private[static.PDmgReduc].full = 'Physical damage reduction'
private[static.PDmgReduc].icon = Compiletime(Icon.BTNHumanArmorUpThree)
private[static.PDmgReduc].tooltip = string.format('Physical damage is reduced by this value. Works before armor. Formula: %.0f * rating / (100 + rating) %%.',
                                                   100 * private.max_pdmg_reduc)
private[static.PDmgReduc].min = -private.max_pdmg_reduc
private[static.PDmgReduc].max = private.max_pdmg_reduc
private[static.PDmgReduc].math = private.mathRating
private[static.PDmgReduc].apply = private.applyNothing

-- Magical damage.
static.MDmg = private.new()
private[static.MDmg].short = 'MDmg'
private[static.MDmg].full = 'Magical damage'
private[static.MDmg].icon = Compiletime(Icon.BTNAdvancedStrengthOfTheMoon)
private[static.MDmg].tooltip = string.format('Magical damage of unit attacks and most of magical abilities. Attacks randomly deals %.0f-%.0f%% of this value as magical damage.',
                                              100 * private.min_mdmg_attack, 100 * private.max_mdmg_attack)
private[static.MDmg].min = 0
private[static.MDmg].max = private.default_max
private[static.MDmg].math = private.mathLinear
private[static.MDmg].apply = private.applyNothing

-- Casting time reduction.
static.CSpd = private.new()
private[static.CSpd].short = 'CSpd'
private[static.CSpd].full = 'Casting time reduction'
private[static.CSpd].icon = Compiletime(Icon.BTNBansheeMaster)
private[static.CSpd].tooltip = 'Casting speed of abilities is multiplied by this value.'
private[static.CSpd].min = 0
private[static.CSpd].max = private.default_max
private[static.CSpd].math = private.mathLinear
private[static.CSpd].apply = private.applyNothing

-- Resistance.
static.Resist = private.new()
private[static.Resist].short = 'Resist'
private[static.Resist].full = 'Resistance'
private[static.Resist].icon = Compiletime(Icon.BTNResistantSkin)
private[static.Resist].tooltip = 'Magical damage is reduced by this value. Works after magical damage reduction.'
private[static.Resist].min = -private.default_max
private[static.Resist].max = private.default_max
private[static.Resist].math = private.mathLinear
private[static.Resist].apply = private.applyNothing

-- Magical damage reduction.
static.MDmgReduc = private.new()
private[static.MDmgReduc].short = 'MReduc'
private[static.MDmgReduc].full = 'Magical damage reduction'
private[static.MDmgReduc].icon = Compiletime(Icon.BTNLightningShield)
private[static.MDmgReduc].tooltip = string.format('Magical damage is reduced by this value. Works before resist. Formula: %.0f * (rating / (100 + rating)) %%.',
                                                   100 * private.max_mdmg_reduc)
private[static.MDmgReduc].min = -private.max_mdmg_reduc
private[static.MDmgReduc].max = private.max_mdmg_reduc
private[static.MDmgReduc].math = private.mathRating
private[static.MDmgReduc].apply = private.applyNothing

-- Dodge chance.
static.Dodge = private.new()
private[static.Dodge].short = 'Dodge'
private[static.Dodge].full = 'Dodge chance'
private[static.Dodge].icon = Compiletime(Icon.BTNEvasion)
private[static.Dodge].tooltip = string.format('Chance to avoid incoming damage. Formula: %.0f * (rating / (100 + rating) %%.',
                                                100 * private.max_dodge_ch)
private[static.Dodge].min = 0
private[static.Dodge].max = private.max_dodge_ch
private[static.Dodge].math = private.mathRating
private[static.Dodge].apply = private.applyNothing

-- Critical strike chance
static.CritCh = private.new()
private[static.CritCh].short = 'CritCh'
private[static.CritCh].full = 'Critical strike chance'
private[static.CritCh].icon = Compiletime(Icon.BTNCriticalStrike)
private[static.CritCh].tooltip = string.format('Chance to increase damage by critical damage value. Formula: %d * (rating / (100 + rating)',
                                                100 * private.max_crit_ch)
private[static.CritCh].min = 0
private[static.CritCh].max = private.max_crit_ch
private[static.CritCh].math = private.mathRating
private[static.CritCh].apply = private.applyNothing

-- Critical strike damage
static.CritDmg = private.new()
private[static.CritDmg].short = 'CritDmg'
private[static.CritDmg].full = 'Critical strike damage'
private[static.CritDmg].icon = Compiletime(Icon.BTNDeathPact)
private[static.CritDmg].tooltip = 'Critical attacks and abilities deals bonus damage based on this value.'
private[static.CritDmg].min = 0.25
private[static.CritDmg].max = private.default_max
private[static.CritDmg].math = private.mathLinear
private[static.CritDmg].apply = private.applyNothing

-- Cooldown reduction
static.CdReduc = private.new()
private[static.CdReduc].short = 'CDReduc'
private[static.CdReduc].full = 'Cooldown reduction'
private[static.CdReduc].icon = Compiletime(Icon.BTNDispelMagic)
private[static.CdReduc].tooltip = string.format('Abilities cooldown reduced by this value. Formula: %d * (rating / (100 + rating)',
                                                100 * private.max_cd_reduc)
private[static.CdReduc].min = -private.max_cd_reduc
private[static.CdReduc].max = private.max_cd_reduc
private[static.CdReduc].math = private.mathRating
private[static.CdReduc].apply = private.applyNothing

-- Health
static.Health = private.new()
private[static.Health].short = 'HP'
private[static.Health].full = 'Health'
private[static.Health].icon = Compiletime(Icon.BTNHealthStone)
private[static.Health].tooltip = 'Maximum health.'
private[static.Health].min = 5
private[static.Health].max = private.default_max
private[static.Health].math = private.mathLinear
private[static.Health].apply = private.applyHealth

-- Regeneration
static.Regen = private.new()
private[static.Regen].short = 'Regen'
private[static.Regen].full = 'Regeneration'
private[static.Regen].icon = Compiletime(Icon.BTNRegenerate)
private[static.Regen].tooltip = 'Health restoration per second.'
private[static.Regen].min = -private.default_max
private[static.Regen].max = private.default_max
private[static.Regen].math = private.mathLinear
private[static.Regen].apply = private.applyRegeneration

-- Mana
static.Mana = private.new()
private[static.Mana].short = 'MP'
private[static.Mana].full = 'Mana'
private[static.Mana].icon = Compiletime(Icon.BTNManaStone)
private[static.Mana].tooltip = 'Maximum mana.'
private[static.Mana].min = 5
private[static.Mana].max = private.default_max
private[static.Mana].math = private.mathLinear
private[static.Mana].apply = private.applyMana

-- Recovery
static.Recov = private.new()
private[static.Recov].short = 'Recov'
private[static.Recov].full = 'Recovery'
private[static.Recov].icon = Compiletime(Icon.BTNBrilliance)
private[static.Recov].tooltip = 'Mana restoration per second'
private[static.Recov].min = -private.default_max
private[static.Recov].max = private.default_max
private[static.Recov].math = private.mathLinear
private[static.Recov].apply = private.applyRecovery

-- Strenght
static.Str = private.new()
private[static.Str].short = 'Str'
private[static.Str].full = 'Strength'
private[static.Str].icon = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-str.blp"
private[static.Str].tooltip = string.format('Some spell effects depends on this value. Every point of strength increases attack damage by %.2f, armor by %.2f and health by %.2f.',
                                             private.pdmg_per_str, private.armor_per_str, private.hp_per_str)
private[static.Str].min = -private.default_max
private[static.Str].max = private.default_max
private[static.Str].math = private.mathLinear
private[static.Str].apply = private.applyStrength

-- Agility
static.Agi = private.new()
private[static.Agi].short = 'Agi'
private[static.Agi].full = 'Agility'
private[static.Agi].icon = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-agi.blp"
private[static.Agi].tooltip = string.format('Some spell effects depends on this value. Every point of agility increases attack speed by %.2f, casting time reduction by %.2f and dodge chance by %.2f.',
                                             private.aspd_per_agi, private.cspd_per_agi, private.dodge_per_agi)
private[static.Agi].min = -private.default_max
private[static.Agi].max = private.default_max
private[static.Agi].math = private.mathLinear
private[static.Agi].apply = private.applyAgility

-- Intelligence
static.Int = private.new()
private[static.Int].short = 'Int'
private[static.Int].full = 'Intelligence'
private[static.Int].icon = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-int.blp"
private[static.Int].tooltip = string.format('Some spell effects depends on this value. Every point of intelligence increases spell damage by %.2f, cooldown reduction by %.2f and mana by %.2f.',
                                             private.mdmg_per_int, private.mp_per_int, private.cdr_per_int)
private[static.Int].min = -private.default_max
private[static.Int].max = private.default_max
private[static.Int].math = private.mathLinear
private[static.Int].apply = private.applyIntelligence

-- Move speed
static.MS = private.new()
private[static.MS].short = 'MS'
private[static.MS].full = 'Move speed'
private[static.MS].icon = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp"
private[static.MS].tooltip = 'Move speed'
private[static.MS].min = 1
private[static.MS].max = 512
private[static.MS].math = private.mathLinear
private[static.MS].apply = private.applyMoveSpeed

return static