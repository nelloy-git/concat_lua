local Log = require('Utils.Log')

---@class ParameterData
local Data = {}

---@alias ParameterTypeEnum number

---@type table<string,ParameterTypeEnum>
Data.Type = {}
---@type ParameterTypeEnum
Data.Type.PDmg = 1
---@type ParameterTypeEnum
Data.Type.ASpd = 2
---@type ParameterTypeEnum
Data.Type.Armor = 3
---@type ParameterTypeEnum
Data.Type.PDmgReduc = 4
---@type ParameterTypeEnum
Data.Type.MDmg = 5
---@type ParameterTypeEnum
Data.Type.CSpd = 6
---@type ParameterTypeEnum
Data.Type.Resist = 7
---@type ParameterTypeEnum
Data.Type.MDmgReduc = 8
---@type ParameterTypeEnum
Data.Type.Dodge = 9
---@type ParameterTypeEnum
Data.Type.CritCh = 10
---@type ParameterTypeEnum
Data.Type.CritDmg = 11
---@type ParameterTypeEnum
Data.Type.CdReduc = 12
---@type ParameterTypeEnum
Data.Type.Health = 13
---@type ParameterTypeEnum
Data.Type.Regen = 14
---@type ParameterTypeEnum
Data.Type.Mana = 15
---@type ParameterTypeEnum
Data.Type.Recov = 16
---@type ParameterTypeEnum
Data.Type.Str = 17
---@type ParameterTypeEnum
Data.Type.Agi = 18
---@type ParameterTypeEnum
Data.Type.Int = 19
---@type ParameterTypeEnum
Data.Type.MS = 20

---@param param any
---@return boolean
function Data.isParamType(param)
    for _, p in pairs(Data.Type) do
        if param == p then
            return true
        end
    end
    return false
end

Data.ShortName = {
    [Data.Type.PDmg] = 'PDmg',
    [Data.Type.ASpd] = 'ASpd',
    [Data.Type.Armor] = 'PDef',
    [Data.Type.PDmgReduc] = 'PReduc',
    [Data.Type.MDmg] = 'MDmg',
    [Data.Type.CSpd] = 'CSpd',
    [Data.Type.Resist] = 'Resist',
    [Data.Type.MDmgReduc] = 'MReduc',
    [Data.Type.Dodge] = 'Dodge',
    [Data.Type.CritCh] = 'CritCh',
    [Data.Type.CritDmg] = 'CritDmg',
    [Data.Type.CdReduc] = 'CDReduc',
    [Data.Type.Health] = 'HP',
    [Data.Type.Regen] = 'Regen',
    [Data.Type.Mana] = 'MP',
    [Data.Type.Recov] = 'Recov',
    [Data.Type.Str] = 'Str',
    [Data.Type.Agi] = 'Agi',
    [Data.Type.Int] = 'Int',
    [Data.Type.MS] = 'MS',
}
---@param param ParameterTypeEnum
---@return string
function Data.getShortName(param)
    if not Data.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return Data.ShortName[param]
end

Data.FullName = {
    [Data.Type.PDmg] = 'Physical damage',
    [Data.Type.ASpd] = 'Attack speed',
    [Data.Type.Armor] = 'Armor',
    [Data.Type.PDmgReduc] = 'Physical damage reduction',
    [Data.Type.MDmg] = 'Magical damage',
    [Data.Type.CSpd] = 'Casting time reduction',
    [Data.Type.Resist] = 'Resistance',
    [Data.Type.MDmgReduc] = 'Magical damage reduction',
    [Data.Type.Dodge] = 'Dodge chance',
    [Data.Type.CritCh] = 'Critical strike chance',
    [Data.Type.CritDmg] = 'Critical strike damage',
    [Data.Type.CdReduc] = 'Cooldown reduction',
    [Data.Type.Health] = 'Health',
    [Data.Type.Regen] = 'Regeneration',
    [Data.Type.Mana] = 'Mana',
    [Data.Type.Recov] = 'Recovery',
    [Data.Type.Str] = 'Strength',
    [Data.Type.Agi] = 'Agility',
    [Data.Type.Int] = 'Intelligence',
    [Data.Type.MS] = 'Move speed',
}
---@param param ParameterTypeEnum
---@return string
function Data.getFullName(param)
    if not Data.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return Data.FullName[param]
end

local Icon
local _ = Compiletime(function()
    Icon = require('Resources.Icon')
end)
Data.Icon = {
    [Data.Type.PDmg] = Compiletime(Icon.BTNSteelMelee),
    [Data.Type.ASpd] = Compiletime(Icon.BTNCommand),
    [Data.Type.Armor] = Compiletime(Icon.BTNDefend),
    [Data.Type.PDmgReduc] = Compiletime(Icon.BTNHumanArmorUpThree),
    [Data.Type.MDmg] = Compiletime(Icon.BTNAdvancedStrengthOfTheMoon),
    [Data.Type.CSpd] = Compiletime(Icon.BTNBansheeMaster),
    [Data.Type.Resist] = Compiletime(Icon.BTNResistantSkin),
    [Data.Type.MDmgReduc] = Compiletime(Icon.BTNLightningShield),
    [Data.Type.Dodge] = Compiletime(Icon.BTNEvasion),
    [Data.Type.CritCh] = Compiletime(Icon.BTNCriticalStrike),
    [Data.Type.CritDmg] = Compiletime(Icon.BTNDeathPact),
    [Data.Type.CdReduc] = Compiletime(Icon.BTNDispelMagic),
    [Data.Type.Health] = Compiletime(Icon.BTNHealthStone),
    [Data.Type.Regen] = Compiletime(Icon.BTNRegenerate),
    [Data.Type.Mana] = Compiletime(Icon.BTNManaStone),
    [Data.Type.Recov] = Compiletime(Icon.BTNBrilliance),
    [Data.Type.Str] = Compiletime(Icon.BTNStrenghtAttribute),
    [Data.Type.Agi] = Compiletime(Icon.BTNAgilityAttribute),
    [Data.Type.Int] = Compiletime(Icon.BTNIntelligenceAttribute),
    [Data.Type.MS] = Compiletime(Icon.BTNBootsOfSpeed),
}
---@param param ParameterTypeEnum
---@return string
function Data.getIcon(param)
    if not Data.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return Data.Icon[param]
end

Data.Const = {
    max_value = 10^10,

    min_pdmg_attack = 0.85,
    max_pdmg_attack = 1.15,
    max_pdmg_reduc = 0.75,
    min_mdmg_attack = 0.85,
    max_mdmg_attack = 1.15,
    max_mdmg_reduc = 0.75,
    max_dodge_ch = 0.50,
    max_crit_ch = 0.75,
    max_cd_reduc = 0.75,
    pdmg_per_str = 0.5,
    armor_per_str = 0.25,
    hp_per_str = 5,
    aspd_per_agi = 1,
    cspd_per_agi = 1,
    dodge_per_agi = 1,
    mdmg_per_int = 1,
    mp_per_int = 5,
    cdr_per_int = 1,
}

local fmt = string.format
Data.Tooltip = {
    [Data.Type.PDmg] = fmt('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %.0f-%.0f%% of this value as physical damage.', 100 * Data.Const.min_pdmg_attack, 100 * Data.Const.max_pdmg_attack),
    [Data.Type.ASpd] = 'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.',
    [Data.Type.Armor] = 'Physical damage is reduced by this value. Works after physical damage reduction.',
    [Data.Type.PDmgReduc] = fmt('Physical damage is reduced by this value. Works before armor. Formula: %.0f * rating / (100 + rating) %%.', 100 * Data.Const.max_pdmg_reduc),
    [Data.Type.MDmg] = fmt('Magical damage of unit attacks and most of magical abilities. Attacks randomly deals %.0f-%.0f%% of this value as magical damage.', 100 * Data.Const.min_mdmg_attack, 100 * Data.Const.max_mdmg_attack),
    [Data.Type.CSpd] = 'Casting speed of abilities is multiplied by this value.',
    [Data.Type.Resist] = 'Magical damage is reduced by this value. Works after magical damage reduction.',
    [Data.Type.MDmgReduc] = fmt('Magical damage is reduced by this value. Works before resist. Formula: %.0f * (rating / (100 + rating)) %%.', 100 * Data.Const.max_mdmg_reduc),
    [Data.Type.Dodge] = fmt('Chance to avoid incoming damage. Formula: %.0f * (rating / (100 + rating) %%.', 100 * Data.Const.max_dodge_ch),
    [Data.Type.CritCh] = fmt('Chance to increase damage by critical damage value. Formula: %d * (rating / (100 + rating)', 100 * Data.Const.max_crit_ch),
    [Data.Type.CritDmg] = 'Critical attacks and abilities deals bonus damage based on this value.',
    [Data.Type.CdReduc] = fmt('Abilities cooldown reduced by this value. Formula: %d * (rating / (100 + rating)',100 * Data.Const.max_cd_reduc),
    [Data.Type.Health] = 'Maximum health.',
    [Data.Type.Regen] = 'Health restoration per second.',
    [Data.Type.Mana] = 'Maximum mana.',
    [Data.Type.Recov] = 'Mana restoration per second',
    [Data.Type.Str] = fmt('Some spell effects depends on this value. Every point of strength increases attack damage by %.2f, armor by %.2f and health by %.2f.', Data.Const.pdmg_per_str, Data.Const.armor_per_str, Data.Const.hp_per_str),
    [Data.Type.Agi] = fmt('Some spell effects depends on this value. Every point of agility increases attack speed by %.2f, casting time reduction by %.2f and dodge chance by %.2f.', Data.Const.aspd_per_agi, Data.Const.cspd_per_agi, Data.Const.dodge_per_agi),
    [Data.Type.Int] = fmt('Some spell effects depends on this value. Every point of intelligence increases spell damage by %.2f, cooldown reduction by %.2f and mana by %.2f.', Data.Const.mdmg_per_int, Data.Const.mp_per_int, Data.Const.cdr_per_int),
    [Data.Type.MS] = 'Move speed',
}
---@param param ParameterTypeEnum
---@return string
function Data.getTooltip(param)
    if not Data.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return Data.Tooltip[param]
end

Data.MinValue = {
    [Data.Type.PDmg] = 0,
    [Data.Type.ASpd] = 0,
    [Data.Type.Armor] = -Data.Const.max_value,
    [Data.Type.PDmgReduc] = -Data.Const.max_pdmg_reduc,
    [Data.Type.MDmg] = 0,
    [Data.Type.CSpd] = 0,
    [Data.Type.Resist] = -Data.Const.max_value,
    [Data.Type.MDmgReduc] = -Data.Const.max_mdmg_reduc,
    [Data.Type.Dodge] = 0,
    [Data.Type.CritCh] = 0,
    [Data.Type.CritDmg] = 0.25,
    [Data.Type.CdReduc] = -Data.Const.max_cd_reduc,
    [Data.Type.Health] = 5,
    [Data.Type.Regen] = -Data.Const.max_value,
    [Data.Type.Mana] = 5,
    [Data.Type.Recov] = -Data.Const.max_value,
    [Data.Type.Str] = -Data.Const.max_value,
    [Data.Type.Agi] = -Data.Const.max_value,
    [Data.Type.Int] = -Data.Const.max_value,
    [Data.Type.MS] = 1,
}

Data.MaxValue = {
    [Data.Type.PDmg] = Data.Const.max_value,
    [Data.Type.ASpd] = Data.Const.max_value,
    [Data.Type.Armor] = Data.Const.max_value,
    [Data.Type.PDmgReduc] = Data.Const.max_pdmg_reduc,
    [Data.Type.MDmg] = Data.Const.max_value,
    [Data.Type.CSpd] = Data.Const.max_value,
    [Data.Type.Resist] = Data.Const.max_value,
    [Data.Type.MDmgReduc] = Data.Const.max_mdmg_reduc,
    [Data.Type.Dodge] = Data.Const.max_dodge_ch,
    [Data.Type.CritCh] = Data.Const.max_crit_ch,
    [Data.Type.CritDmg] = Data.Const.max_value,
    [Data.Type.CdReduc] = Data.Const.max_cd_reduc,
    [Data.Type.Health] = Data.Const.max_value,
    [Data.Type.Regen] = Data.Const.max_value,
    [Data.Type.Mana] = Data.Const.max_value,
    [Data.Type.Recov] = Data.Const.max_value,
    [Data.Type.Str] = Data.Const.max_value,
    [Data.Type.Agi] = Data.Const.max_value,
    [Data.Type.Int] = Data.Const.max_value,
    [Data.Type.MS] = 512,
}

Data.DefaultValue = {
    [Data.Type.PDmg] = 1,
    [Data.Type.ASpd] = 1,
    [Data.Type.Armor] = 0,
    [Data.Type.PDmgReduc] = 0,
    [Data.Type.MDmg] = 0,
    [Data.Type.CSpd] = 0,
    [Data.Type.Resist] = 0,
    [Data.Type.MDmgReduc] = 0,
    [Data.Type.Dodge] = 0,
    [Data.Type.CritCh] = 0,
    [Data.Type.CritDmg] = 0,
    [Data.Type.CdReduc] = 0,
    [Data.Type.Health] = 500,
    [Data.Type.Regen] = 0,
    [Data.Type.Mana] = 0,
    [Data.Type.Recov] = 0,
    [Data.Type.Str] = 0,
    [Data.Type.Agi] = 0,
    [Data.Type.Int] = 0,
    [Data.Type.MS] = 256,
}

---@param base number
---@param mult number
---@param additive number
---@param max number
---@param min number
---@return number
local function mathLinear(base, mult, additive, min, max)
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
local function mathRating(base, mult, additive, min, max)
    local res = base * mult
    if res >= 0 then
        res = res / (100 + res)
        return max * res + additive
    else
        res = -res / (100 - res)
        return min * res + additive
    end
end

Data.Math = {
    [Data.Type.PDmg] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.PDmg], Data.MaxValue[Data.Type.PDmg]) end,
    [Data.Type.ASpd] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.ASpd], Data.MaxValue[Data.Type.ASpd]) end,
    [Data.Type.Armor] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Armor], Data.MaxValue[Data.Type.Armor]) end,
    [Data.Type.PDmgReduc] = function(base, mult, additiv) return mathRating(base, mult, additiv, Data.MinValue[Data.Type.PDmgReduc], Data.MaxValue[Data.Type.PDmgReduc]) end,
    [Data.Type.MDmg] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.MDmg], Data.MaxValue[Data.Type.MDmg]) end,
    [Data.Type.CSpd] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.CSpd], Data.MaxValue[Data.Type.CSpd]) end,
    [Data.Type.Resist] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Resist], Data.MaxValue[Data.Type.Resist]) end,
    [Data.Type.MDmgReduc] = function(base, mult, additiv) return mathRating(base, mult, additiv, Data.MinValue[Data.Type.MDmgReduc], Data.MaxValue[Data.Type.MDmgReduc]) end,
    [Data.Type.Dodge] = function(base, mult, additiv) return mathRating(base, mult, additiv, Data.MinValue[Data.Type.Dodge], Data.MaxValue[Data.Type.Dodge]) end,
    [Data.Type.CritCh] = function(base, mult, additiv) return mathRating(base, mult, additiv, Data.MinValue[Data.Type.CritCh], Data.MaxValue[Data.Type.CritCh]) end,
    [Data.Type.CritDmg] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.CritDmg], Data.MaxValue[Data.Type.CritDmg]) end,
    [Data.Type.CdReduc] = function(base, mult, additiv) return mathRating(base, mult, additiv, Data.MinValue[Data.Type.CdReduc], Data.MaxValue[Data.Type.CdReduc]) end,
    [Data.Type.Health] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Health], Data.MaxValue[Data.Type.Health]) end,
    [Data.Type.Regen] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Regen], Data.MaxValue[Data.Type.Regen]) end,
    [Data.Type.Mana] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Mana], Data.MaxValue[Data.Type.Mana]) end,
    [Data.Type.Recov] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Recov], Data.MaxValue[Data.Type.Recov]) end,
    [Data.Type.Str] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Str], Data.MaxValue[Data.Type.Str]) end,
    [Data.Type.Agi] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Agi], Data.MaxValue[Data.Type.Agi]) end,
    [Data.Type.Int] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.Int], Data.MaxValue[Data.Type.Int]) end,
    [Data.Type.MS] = function(base, mult, additiv) return mathLinear(base, mult, additiv, Data.MinValue[Data.Type.MS], Data.MaxValue[Data.Type.MS]) end,
}

return Data