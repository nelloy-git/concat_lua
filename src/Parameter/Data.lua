

---@class ParameterData
local ParamData = {}

---@alias ParameterTypeEnum number

---@type table<string,ParameterTypeEnum>
ParamData.Type = {}
---@type ParameterTypeEnum
ParamData.Type.PDmg = 1
---@type ParameterTypeEnum
ParamData.Type.ASpd = 2
---@type ParameterTypeEnum
ParamData.Type.Armor = 3
---@type ParameterTypeEnum
ParamData.Type.PDmgReduc = 4
---@type ParameterTypeEnum
ParamData.Type.MDmg = 5
---@type ParameterTypeEnum
ParamData.Type.CSpd = 6
---@type ParameterTypeEnum
ParamData.Type.Resist = 7
---@type ParameterTypeEnum
ParamData.Type.MDmgReduc = 8
---@type ParameterTypeEnum
ParamData.Type.Dodge = 9
---@type ParameterTypeEnum
ParamData.Type.CritCh = 10
---@type ParameterTypeEnum
ParamData.Type.CritDmg = 11
---@type ParameterTypeEnum
ParamData.Type.CdReduc = 12
---@type ParameterTypeEnum
ParamData.Type.Health = 13
---@type ParameterTypeEnum
ParamData.Type.Regen = 14
---@type ParameterTypeEnum
ParamData.Type.Mana = 15
---@type ParameterTypeEnum
ParamData.Type.Recov = 16
---@type ParameterTypeEnum
ParamData.Type.Str = 17
---@type ParameterTypeEnum
ParamData.Type.Agi = 18
---@type ParameterTypeEnum
ParamData.Type.Int = 19
---@type ParameterTypeEnum
ParamData.Type.MS = 20

---@param param any
---@return boolean
function ParamData.isParamType(param)
    for _, p in pairs(ParamData.Type) do
        if param == p then
            return true
        end
    end
    return false
end

ParamData.PercentType = {
    [ParamData.Type.PDmgReduc] = true,
    [ParamData.Type.MDmgReduc] = true,
    [ParamData.Type.Dodge] = true,
    [ParamData.Type.CritDmg] = true,
    [ParamData.Type.CdReduc] = true,
    [ParamData.Type.CritCh] = true,
}

---@return boolean
function ParamData.isParamPercent(param)
    return ParamData.PercentType[param] or false
end

ParamData.PhysicType = {
    [ParamData.Type.PDmg] = true,
    [ParamData.Type.ASpd] = true,
    [ParamData.Type.Armor] = true,
    [ParamData.Type.PDmgReduc] = true,
    [ParamData.Type.Health] = true,
    [ParamData.Type.Regen] = true,
}

---@return boolean
function ParamData.isParamPhysic(param)
    return ParamData.PhysicType[param] or false
end

ParamData.MagicType = {
    [ParamData.Type.MDmg] = true,
    [ParamData.Type.CSpd] = true,
    [ParamData.Type.Resist] = true,
    [ParamData.Type.MDmgReduc] = true,
    [ParamData.Type.Mana] = true,
    [ParamData.Type.Recov] = true,
}

---@return boolean
function ParamData.isParamMagic(param)
    return ParamData.MagicType[param] or false
end

ParamData.ShortName = {
    [ParamData.Type.PDmg] = 'PDmg',
    [ParamData.Type.ASpd] = 'ASpd',
    [ParamData.Type.Armor] = 'PDef',
    [ParamData.Type.PDmgReduc] = 'PReduc',
    [ParamData.Type.MDmg] = 'MDmg',
    [ParamData.Type.CSpd] = 'CSpd',
    [ParamData.Type.Resist] = 'Resist',
    [ParamData.Type.MDmgReduc] = 'MReduc',
    [ParamData.Type.Dodge] = 'Dodge',
    [ParamData.Type.CritCh] = 'CritCh',
    [ParamData.Type.CritDmg] = 'CritDmg',
    [ParamData.Type.CdReduc] = 'CDReduc',
    [ParamData.Type.Health] = 'HP',
    [ParamData.Type.Regen] = 'Regen',
    [ParamData.Type.Mana] = 'MP',
    [ParamData.Type.Recov] = 'Recov',
    [ParamData.Type.Str] = 'Str',
    [ParamData.Type.Agi] = 'Agi',
    [ParamData.Type.Int] = 'Int',
    [ParamData.Type.MS] = 'MS',
}
---@param param ParameterTypeEnum
---@return string
function ParamData.getShortName(param)
    if not ParamData.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return ParamData.ShortName[param]
end

ParamData.FullName = {
    [ParamData.Type.PDmg] = 'Physical damage',
    [ParamData.Type.ASpd] = 'Attack speed',
    [ParamData.Type.Armor] = 'Armor',
    [ParamData.Type.PDmgReduc] = 'Physical damage reduction',
    [ParamData.Type.MDmg] = 'Magical damage',
    [ParamData.Type.CSpd] = 'Casting time reduction',
    [ParamData.Type.Resist] = 'Resistance',
    [ParamData.Type.MDmgReduc] = 'Magical damage reduction',
    [ParamData.Type.Dodge] = 'Dodge chance',
    [ParamData.Type.CritCh] = 'Critical strike chance',
    [ParamData.Type.CritDmg] = 'Critical strike damage',
    [ParamData.Type.CdReduc] = 'Cooldown reduction',
    [ParamData.Type.Health] = 'Health',
    [ParamData.Type.Regen] = 'Regeneration',
    [ParamData.Type.Mana] = 'Mana',
    [ParamData.Type.Recov] = 'Recovery',
    [ParamData.Type.Str] = 'Strength',
    [ParamData.Type.Agi] = 'Agility',
    [ParamData.Type.Int] = 'Intelligence',
    [ParamData.Type.MS] = 'Move speed',
}
---@param param ParameterTypeEnum
---@return string
function ParamData.getFullName(param)
    if not ParamData.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return ParamData.FullName[param]
end

local Icon
local _ = Compiletime(function()
    Icon = require('Resources.Icon')
end)
ParamData.Icon = {
    [ParamData.Type.PDmg] = Compiletime(Icon.BTNSteelMelee),
    [ParamData.Type.ASpd] = Compiletime(Icon.BTNCommand),
    [ParamData.Type.Armor] = Compiletime(Icon.BTNDefend),
    [ParamData.Type.PDmgReduc] = Compiletime(Icon.BTNHumanArmorUpThree),
    [ParamData.Type.MDmg] = Compiletime(Icon.BTNAdvancedStrengthOfTheMoon),
    [ParamData.Type.CSpd] = Compiletime(Icon.BTNBansheeMaster),
    [ParamData.Type.Resist] = Compiletime(Icon.BTNResistantSkin),
    [ParamData.Type.MDmgReduc] = Compiletime(Icon.BTNLightningShield),
    [ParamData.Type.Dodge] = Compiletime(Icon.BTNEvasion),
    [ParamData.Type.CritCh] = Compiletime(Icon.BTNCriticalStrike),
    [ParamData.Type.CritDmg] = Compiletime(Icon.BTNDeathPact),
    [ParamData.Type.CdReduc] = Compiletime(Icon.BTNDispelMagic),
    [ParamData.Type.Health] = Compiletime(Icon.BTNHealthStone),
    [ParamData.Type.Regen] = Compiletime(Icon.BTNRegenerate),
    [ParamData.Type.Mana] = Compiletime(Icon.BTNManaStone),
    [ParamData.Type.Recov] = Compiletime(Icon.BTNBrilliance),
    [ParamData.Type.Str] = Compiletime(Icon.BTNStrenghtAttribute),
    [ParamData.Type.Agi] = Compiletime(Icon.BTNAgilityAttribute),
    [ParamData.Type.Int] = Compiletime(Icon.BTNIntelligenceAttribute),
    [ParamData.Type.MS] = Compiletime(Icon.BTNBootsOfSpeed),
}
---@param param ParameterTypeEnum
---@return string
function ParamData.getIcon(param)
    if not ParamData.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return ParamData.Icon[param]
end

ParamData.Const = {
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
ParamData.Tooltip = {
    [ParamData.Type.PDmg] = fmt('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %.0f-%.0f%% of this value as physical damage.', 100 * ParamData.Const.min_pdmg_attack, 100 * ParamData.Const.max_pdmg_attack),
    [ParamData.Type.ASpd] = 'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.',
    [ParamData.Type.Armor] = 'Physical damage is reduced by this value. Works after physical damage reduction.',
    [ParamData.Type.PDmgReduc] = fmt('Physical damage is reduced by this value. Works before armor. Formula: %.0f * rating / (100 + rating) %%.', 100 * ParamData.Const.max_pdmg_reduc),
    [ParamData.Type.MDmg] = fmt('Magical damage of unit attacks and most of magical abilities. Attacks randomly deals %.0f-%.0f%% of this value as magical damage.', 100 * ParamData.Const.min_mdmg_attack, 100 * ParamData.Const.max_mdmg_attack),
    [ParamData.Type.CSpd] = 'Casting speed of abilities is multiplied by this value.',
    [ParamData.Type.Resist] = 'Magical damage is reduced by this value. Works after magical damage reduction.',
    [ParamData.Type.MDmgReduc] = fmt('Magical damage is reduced by this value. Works before resist. Formula: %.0f * (rating / (100 + rating)) %%.', 100 * ParamData.Const.max_mdmg_reduc),
    [ParamData.Type.Dodge] = fmt('Chance to avoid incoming damage. Formula: %.0f * (rating / (100 + rating) %%.', 100 * ParamData.Const.max_dodge_ch),
    [ParamData.Type.CritCh] = fmt('Chance to increase damage by critical damage value. Formula: %d * (rating / (100 + rating)', 100 * ParamData.Const.max_crit_ch),
    [ParamData.Type.CritDmg] = 'Critical attacks and abilities deals bonus damage based on this value.',
    [ParamData.Type.CdReduc] = fmt('Abilities cooldown reduced by this value. Formula: %d * (rating / (100 + rating)',100 * ParamData.Const.max_cd_reduc),
    [ParamData.Type.Health] = 'Maximum health.',
    [ParamData.Type.Regen] = 'Health restoration per second.',
    [ParamData.Type.Mana] = 'Maximum mana.',
    [ParamData.Type.Recov] = 'Mana restoration per second',
    [ParamData.Type.Str] = fmt('Some spell effects depends on this value. Every point of strength increases attack damage by %.2f, armor by %.2f and health by %.2f.', ParamData.Const.pdmg_per_str, ParamData.Const.armor_per_str, ParamData.Const.hp_per_str),
    [ParamData.Type.Agi] = fmt('Some spell effects depends on this value. Every point of agility increases attack speed by %.2f, casting time reduction by %.2f and dodge chance by %.2f.', ParamData.Const.aspd_per_agi, ParamData.Const.cspd_per_agi, ParamData.Const.dodge_per_agi),
    [ParamData.Type.Int] = fmt('Some spell effects depends on this value. Every point of intelligence increases spell damage by %.2f, cooldown reduction by %.2f and mana by %.2f.', ParamData.Const.mdmg_per_int, ParamData.Const.mp_per_int, ParamData.Const.cdr_per_int),
    [ParamData.Type.MS] = 'Move speed',
}
---@param param ParameterTypeEnum
---@return string
function ParamData.getTooltip(param)
    if not ParamData.isParamType(param) then
        Log.error('ParameterData', 'unknown ParameterTypeEnum.', 2)
    end
    return ParamData.Tooltip[param]
end

ParamData.MinValue = {
    [ParamData.Type.PDmg] = 0,
    [ParamData.Type.ASpd] = 0,
    [ParamData.Type.Armor] = -ParamData.Const.max_value,
    [ParamData.Type.PDmgReduc] = -ParamData.Const.max_pdmg_reduc,
    [ParamData.Type.MDmg] = 0,
    [ParamData.Type.CSpd] = 0,
    [ParamData.Type.Resist] = -ParamData.Const.max_value,
    [ParamData.Type.MDmgReduc] = -ParamData.Const.max_mdmg_reduc,
    [ParamData.Type.Dodge] = 0,
    [ParamData.Type.CritCh] = 0,
    [ParamData.Type.CritDmg] = 0.25,
    [ParamData.Type.CdReduc] = -ParamData.Const.max_cd_reduc,
    [ParamData.Type.Health] = 5,
    [ParamData.Type.Regen] = -ParamData.Const.max_value,
    [ParamData.Type.Mana] = 5,
    [ParamData.Type.Recov] = -ParamData.Const.max_value,
    [ParamData.Type.Str] = -ParamData.Const.max_value,
    [ParamData.Type.Agi] = -ParamData.Const.max_value,
    [ParamData.Type.Int] = -ParamData.Const.max_value,
    [ParamData.Type.MS] = 1,
}

ParamData.MaxValue = {
    [ParamData.Type.PDmg] = ParamData.Const.max_value,
    [ParamData.Type.ASpd] = ParamData.Const.max_value,
    [ParamData.Type.Armor] = ParamData.Const.max_value,
    [ParamData.Type.PDmgReduc] = ParamData.Const.max_pdmg_reduc,
    [ParamData.Type.MDmg] = ParamData.Const.max_value,
    [ParamData.Type.CSpd] = ParamData.Const.max_value,
    [ParamData.Type.Resist] = ParamData.Const.max_value,
    [ParamData.Type.MDmgReduc] = ParamData.Const.max_mdmg_reduc,
    [ParamData.Type.Dodge] = ParamData.Const.max_dodge_ch,
    [ParamData.Type.CritCh] = ParamData.Const.max_crit_ch,
    [ParamData.Type.CritDmg] = ParamData.Const.max_value,
    [ParamData.Type.CdReduc] = ParamData.Const.max_cd_reduc,
    [ParamData.Type.Health] = ParamData.Const.max_value,
    [ParamData.Type.Regen] = ParamData.Const.max_value,
    [ParamData.Type.Mana] = ParamData.Const.max_value,
    [ParamData.Type.Recov] = ParamData.Const.max_value,
    [ParamData.Type.Str] = ParamData.Const.max_value,
    [ParamData.Type.Agi] = ParamData.Const.max_value,
    [ParamData.Type.Int] = ParamData.Const.max_value,
    [ParamData.Type.MS] = 512,
}

ParamData.DefaultValue = {
    [ParamData.Type.PDmg] = 1,
    [ParamData.Type.ASpd] = 1,
    [ParamData.Type.Armor] = 0,
    [ParamData.Type.PDmgReduc] = 0,
    [ParamData.Type.MDmg] = 0,
    [ParamData.Type.CSpd] = 0,
    [ParamData.Type.Resist] = 0,
    [ParamData.Type.MDmgReduc] = 0,
    [ParamData.Type.Dodge] = 0,
    [ParamData.Type.CritCh] = 0,
    [ParamData.Type.CritDmg] = 0,
    [ParamData.Type.CdReduc] = 0,
    [ParamData.Type.Health] = 500,
    [ParamData.Type.Regen] = 0,
    [ParamData.Type.Mana] = 0,
    [ParamData.Type.Recov] = 0,
    [ParamData.Type.Str] = 0,
    [ParamData.Type.Agi] = 0,
    [ParamData.Type.Int] = 0,
    [ParamData.Type.MS] = 256,
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

ParamData.Math = {
    [ParamData.Type.PDmg] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.PDmg], ParamData.MaxValue[ParamData.Type.PDmg]) end,
    [ParamData.Type.ASpd] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.ASpd], ParamData.MaxValue[ParamData.Type.ASpd]) end,
    [ParamData.Type.Armor] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Armor], ParamData.MaxValue[ParamData.Type.Armor]) end,
    [ParamData.Type.PDmgReduc] = function(base, mult, additiv) return mathRating(base, mult, additiv, ParamData.MinValue[ParamData.Type.PDmgReduc], ParamData.MaxValue[ParamData.Type.PDmgReduc]) end,
    [ParamData.Type.MDmg] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.MDmg], ParamData.MaxValue[ParamData.Type.MDmg]) end,
    [ParamData.Type.CSpd] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.CSpd], ParamData.MaxValue[ParamData.Type.CSpd]) end,
    [ParamData.Type.Resist] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Resist], ParamData.MaxValue[ParamData.Type.Resist]) end,
    [ParamData.Type.MDmgReduc] = function(base, mult, additiv) return mathRating(base, mult, additiv, ParamData.MinValue[ParamData.Type.MDmgReduc], ParamData.MaxValue[ParamData.Type.MDmgReduc]) end,
    [ParamData.Type.Dodge] = function(base, mult, additiv) return mathRating(base, mult, additiv, ParamData.MinValue[ParamData.Type.Dodge], ParamData.MaxValue[ParamData.Type.Dodge]) end,
    [ParamData.Type.CritCh] = function(base, mult, additiv) return mathRating(base, mult, additiv, ParamData.MinValue[ParamData.Type.CritCh], ParamData.MaxValue[ParamData.Type.CritCh]) end,
    [ParamData.Type.CritDmg] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.CritDmg], ParamData.MaxValue[ParamData.Type.CritDmg]) end,
    [ParamData.Type.CdReduc] = function(base, mult, additiv) return mathRating(base, mult, additiv, ParamData.MinValue[ParamData.Type.CdReduc], ParamData.MaxValue[ParamData.Type.CdReduc]) end,
    [ParamData.Type.Health] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Health], ParamData.MaxValue[ParamData.Type.Health]) end,
    [ParamData.Type.Regen] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Regen], ParamData.MaxValue[ParamData.Type.Regen]) end,
    [ParamData.Type.Mana] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Mana], ParamData.MaxValue[ParamData.Type.Mana]) end,
    [ParamData.Type.Recov] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Recov], ParamData.MaxValue[ParamData.Type.Recov]) end,
    [ParamData.Type.Str] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Str], ParamData.MaxValue[ParamData.Type.Str]) end,
    [ParamData.Type.Agi] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Agi], ParamData.MaxValue[ParamData.Type.Agi]) end,
    [ParamData.Type.Int] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.Int], ParamData.MaxValue[ParamData.Type.Int]) end,
    [ParamData.Type.MS] = function(base, mult, additiv) return mathLinear(base, mult, additiv, ParamData.MinValue[ParamData.Type.MS], ParamData.MaxValue[ParamData.Type.MS]) end,
}

---@param param ParameterTypeEnum
---@param base number
---@param mult number
---@param addit number
function ParamData.mathParam(param, base, mult, addit)
    return ParamData.Math[param](base, mult, addit)
end

return ParamData