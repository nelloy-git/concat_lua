---@class ParameterData
local Data = {}

---@alias ParameterType number
Data.Type = {}
---@type ParameterType
Data.Type.PDmg = 1
---@type ParameterType
Data.Type.ASpd = 2
---@type ParameterType
Data.Type.Armor = 3
---@type ParameterType
Data.Type.PDmgReduc = 4
---@type ParameterType
Data.Type.MDmg = 5
---@type ParameterType
Data.Type.CSpd = 6
---@type ParameterType
Data.Type.Resist = 7
---@type ParameterType
Data.Type.MDmgReduc = 8
---@type ParameterType
Data.Type.Dodge = 9
---@type ParameterType
Data.Type.CritCh = 10
---@type ParameterType
Data.Type.CritDmg = 11
---@type ParameterType
Data.Type.CdReduc = 12
---@type ParameterType
Data.Type.Health = 13
---@type ParameterType
Data.Type.Regen = 14
---@type ParameterType
Data.Type.Mana = 15
---@type ParameterType
Data.Type.Recov = 16
---@type ParameterType
Data.Type.Str = 17
---@type ParameterType
Data.Type.Agi = 18
---@type ParameterType
Data.Type.Int = 19
---@type ParameterType
Data.Type.MS = 20

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

local Icon
local _ = Compiletime(function()
    Icon = require('compiletime.Icon')
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

Data.Tooltip = {
    [Data.Type.PDmg] = string.format('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %.0f-%.0f%% of this value as physical damage.', 100 * Data.Const.min_pdmg_attack, 100 * Data.Const.max_pdmg_attack),
    [Data.Type.ASpd] = 'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.',
    [Data.Type.Armor] = 'Physical damage is reduced by this value. Works after physical damage reduction.',
    [Data.Type.PDmgReduc] = string.format('Physical damage is reduced by this value. Works before armor. Formula: %.0f * rating / (100 + rating) %%.', 100 * Data.Const.max_pdmg_reduc),
    [Data.Type.MDmg] = string.format('Magical damage of unit attacks and most of magical abilities. Attacks randomly deals %.0f-%.0f%% of this value as magical damage.', 100 * Data.Const.min_mdmg_attack, 100 * Data.Const.max_mdmg_attack),
    [Data.Type.CSpd] = 'Casting speed of abilities is multiplied by this value.',
    [Data.Type.Resist] = 'Magical damage is reduced by this value. Works after magical damage reduction.',
    [Data.Type.MDmgReduc] = string.format('Magical damage is reduced by this value. Works before resist. Formula: %.0f * (rating / (100 + rating)) %%.', 100 * Data.Const.max_mdmg_reduc),
    [Data.Type.Dodge] = string.format('Chance to avoid incoming damage. Formula: %.0f * (rating / (100 + rating) %%.', 100 * Data.Const.max_dodge_ch),
    [Data.Type.CritCh] = string.format('Chance to increase damage by critical damage value. Formula: %d * (rating / (100 + rating)', 100 * Data.Const.max_crit_ch),
    [Data.Type.CritDmg] = 'Critical attacks and abilities deals bonus damage based on this value.',
    [Data.Type.CdReduc] = string.format('Abilities cooldown reduced by this value. Formula: %d * (rating / (100 + rating)',100 * Data.Const.max_cd_reduc),
    [Data.Type.Health] = 'Maximum health.',
    [Data.Type.Regen] = 'Health restoration per second.',
    [Data.Type.Mana] = 'Maximum mana.',
    [Data.Type.Recov] = 'Mana restoration per second',
    [Data.Type.Str] = string.format('Some spell effects depends on this value. Every point of strength increases attack damage by %.2f, armor by %.2f and health by %.2f.', Data.Const.pdmg_per_str, Data.Const.armor_per_str, Data.Const.hp_per_str),
    [Data.Type.Agi] = string.format('Some spell effects depends on this value. Every point of agility increases attack speed by %.2f, casting time reduction by %.2f and dodge chance by %.2f.', Data.Const.aspd_per_agi, Data.Const.cspd_per_agi, Data.Const.dodge_per_agi),
    [Data.Type.Int] = string.format('Some spell effects depends on this value. Every point of intelligence increases spell damage by %.2f, cooldown reduction by %.2f and mana by %.2f.', Data.Const.mdmg_per_int, Data.Const.mp_per_int, Data.Const.cdr_per_int),
    [Data.Type.MS] = 'Move speed',
}

Data.MinValue = {
    [Data.Type.PDmg] = 0,
    [Data.Type.ASpd] = 0,
    [Data.Type.Armor] = -Data.Const.default_max,
    [Data.Type.PDmgReduc] = -Data.Const.max_pdmg_reduc,
    [Data.Type.MDmg] = 0,
    [Data.Type.CSpd] = 0,
    [Data.Type.Resist] = -Data.Const.default_max,
    [Data.Type.MDmgReduc] = -Data.Const.max_mdmg_reduc,
    [Data.Type.Dodge] = 0,
    [Data.Type.CritCh] = 0,
    [Data.Type.CritDmg] = 0.25,
    [Data.Type.CdReduc] = -Data.Const.max_cd_reduc,
    [Data.Type.Health] = 5,
    [Data.Type.Regen] = -Data.Const.default_max,
    [Data.Type.Mana] = 5,
    [Data.Type.Recov] = -Data.Const.default_max,
    [Data.Type.Str] = -Data.Const.default_max,
    [Data.Type.Agi] = -Data.Const.default_max,
    [Data.Type.Int] = -Data.Const.default_max,
    [Data.Type.MS] = 1,
}

Data.MaxValue = {
    [Data.Type.PDmg] = Data.Const.default_max,
    [Data.Type.ASpd] = Data.Const.default_max,
    [Data.Type.Armor] = Data.Const.default_max,
    [Data.Type.PDmgReduc] = Data.Const.max_pdmg_reduc,
    [Data.Type.MDmg] = Data.Const.default_max,
    [Data.Type.CSpd] = Data.Const.default_max,
    [Data.Type.Resist] = Data.Const.default_max,
    [Data.Type.MDmgReduc] = Data.Const.max_mdmg_reduc,
    [Data.Type.Dodge] = Data.Const.max_dodge_ch,
    [Data.Type.CritCh] = Data.Const.max_crit_ch,
    [Data.Type.CritDmg] = Data.Const.default_max,
    [Data.Type.CdReduc] = Data.Const.max_cd_reduc,
    [Data.Type.Health] = Data.Const.default_max,
    [Data.Type.Regen] = Data.Const.default_max,
    [Data.Type.Mana] = Data.Const.default_max,
    [Data.Type.Recov] = Data.Const.default_max,
    [Data.Type.Str] = Data.Const.default_max,
    [Data.Type.Agi] = Data.Const.default_max,
    [Data.Type.Int] = Data.Const.default_max,
    [Data.Type.MS] = 512,
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
    [Data.Type.PDmg] = mathLinear,
    [Data.Type.ASpd] = mathLinear,
    [Data.Type.Armor] = mathLinear,
    [Data.Type.PDmgReduc] = mathRating,
    [Data.Type.MDmg] = mathLinear,
    [Data.Type.CSpd] = mathLinear,
    [Data.Type.Resist] = mathLinear,
    [Data.Type.MDmgReduc] = mathRating,
    [Data.Type.Dodge] = mathRating,
    [Data.Type.CritCh] = mathRating,
    [Data.Type.CritDmg] = mathLinear,
    [Data.Type.CdReduc] = mathRating,
    [Data.Type.Health] = mathLinear,
    [Data.Type.Regen] = mathLinear,
    [Data.Type.Mana] = mathLinear,
    [Data.Type.Recov] = mathLinear,
    [Data.Type.Str] = mathLinear,
    [Data.Type.Agi] = mathLinear,
    [Data.Type.Int] = mathLinear,
    [Data.Type.MS] = mathLinear,
}

return Data