--=======
-- Class
--=======

---@type ParameterTypeClass
local ParameterType = newClass('ParameterType')

---@class ParameterType
local public = ParameterType.public
---@class ParameterTypeClass
local static = ParameterType.static
---@type table
local override = ParameterType.override
---@type table(ParameterType, table)
local private = {}

local min_attack_dmg = tostring(100*(1 - Settings.Unit.attack_dispersion))
local max_attack_dmg = tostring(100*(1 + Settings.Unit.attack_dispersion))

local atk_per_str = tostring(Settings.Unit.p_dmg_per_str)
local armor_per_str = tostring(Settings.Unit.armor_per_str)
local hp_per_str = tostring(Settings.Unit.health_per_str)

local aspd_per_agi = tostring(Settings.Unit.attack_speed_per_agi)
local ctr_per_agi = tostring(Settings.Unit.casting_time_reduction_per_agi)
local dodge_per_agi = tostring(Settings.Unit.dodge_chance_per_agi)

local mdmg_per_int = tostring(Settings.Unit.m_dmg_per_int)
local cdr_per_int = tostring(Settings.Unit.cooldown_reduction_per_int)
local mp_per_int = tostring(Settings.Unit.mana_per_int)

local Description = {}
Description[ParameterType.Id.P_DMG] = 
Description[ParameterType.Id.ATKS_PER_SEC] = 
Description[ParameterType.Id.ARMOR] = 
Description[ParameterType.Id.P_DMG_REDUC] = 
Description[ParameterType.Id.M_DMG] = 
Description[ParameterType.Id.CAST_TIME_REDUC] = 
Description[ParameterType.Id.RESIST] = 
Description[ParameterType.Id.M_DMG_REDUC] = 
Description[ParameterType.Id.DODGE] = 
Description[ParameterType.Id.CRIT_CH] = 
Description[ParameterType.Id.CRIT_DMG] = 
Description[ParameterType.Id.CD_REDUC] = 
Description[ParameterType.Id.HP] = 
Description[ParameterType.Id.REGEN] = 
Description[ParameterType.Id.MP] = 
Description[ParameterType.Id.RECOV] = 
Description[ParameterType.Id.STR] = 
Description[ParameterType.Id.AGI] = 
Description[ParameterType.Id.INT] = 
Description[ParameterType.Id.MS] = 
--=========
-- Methods
--=========

---@param short_name string
---@param full_name string
---@param icon string
---@param tooltip string
---@param instance_data table | nil
---@return ParameterType
function static.new(short_name, full_name, icon, tooltip, instance_data)
    local instance = instance_data or newInstanceData(ParameterType)
    local priv = {
        short = short_name,
        full = full_name,
        icon = icon,
        tooltip = tooltip
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    freeInstanceData(self)
end

function static.init()
    static.P_DMG = static.new('PDmg', 'Attack damage', "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp",
                              'Physical damage of unit with attacks and some physical damage spells. Attacks randomly deals'..min_attack_dmg..'-'..max_attack_dmg..'% of this value.')
    static.ATKS_PER_SEC = static.new('ASpd', 'Attacks per second', "ReplaceableTextures\\CommandButtons\\BTNCommand.blp",
                              'Number of attacks dealing by unit per second.')
    static.ARMOR = static.new('PDef', 'Armor', "ReplaceableTextures\\CommandButtons\\BTNDefend.blp",
                              'Physical damage is reduced by this value. Works after physical damage reduction.')
    static.P_DMG_REDUC = static.new('PRed', 'Physical damage reduction', "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpThree.blp",
                              'Physical damage is reduced by this value. Works before armor. Maximum: '..tostring(100 * Settings.Unit.maximum_physical_damage_reduction)..'%.')
    static.M_DMG = static.new('MDmg', 'Spell damage', "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheMoon.blp",
                              'Magic power of unit. Icreases damage dealt by magic abilities.')
    static.CAST_TIME_REDUC = static.new('CSpd', 'Casting time reduction', "ReplaceableTextures\\CommandButtons\\BTNBansheeMaster.blp",
                              'Casting time of abilities is reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_casting_time_reduction)..'%.')
    static.RESIST = static.new('MDef', 'Reisistance', "ReplaceableTextures\\CommandButtons\\BTNResistantSkin.blp",
                              'Magical damage is reduced by this value. Works after magical damage reduction.')
    static.M_DMG_REDUC = static.new('MRed', 'Magical damage reduction', "ReplaceableTextures\\CommandButtons\\BTNLightningShield.blp",
                              'Magical damage is reduced by this value. Works before resistance. Maximum: '..tostring(100 * Settings.Unit.maximum_magical_damage_reduction)..'%.')
    static.DODGE = static.new('Dodge', 'Dodge chance', "ReplaceableTextures\\CommandButtons\\BTNEvasion.blp",
                              'Chance to avoid incoming damage. Maximum: '..tostring(100 * Settings.Unit.maximum_dodge_chance)..'%.')
    static.CRIT_CH = static.new('CritCh', 'Critical strike chance', "ReplaceableTextures\\CommandButtons\\BTNCriticalStrike.blp",
                              'Chance to increase damage by critical damage value. Maximum: '..tostring(100 * Settings.Unit.maximum_crit_chance)..'%.')
    static.CRIT_DMG = static.new('CritDmg', 'Critical strike damage', "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp",
                              'Critical attack or spell deals this value damage.')
    static.CD_REDUC = static.new('CDRed', 'Cooldown reduction', "ReplaceableTextures\\CommandButtons\\BTNDispelMagic.blp",
                              'Abilities cooldown reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_cooldown_reduction)..'%.')
    static.HP = static.new('HP', 'Health', "ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp",
                              'Maximum health.')
    static.REGEN = static.new('Regen', 'Regeneration', "ReplaceableTextures\\CommandButtons\\BTNRegenerate.blp",
                              'Health restoration per second.')
    static.MP = static.new('MP', 'Mana', "ReplaceableTextures\\CommandButtons\\BTNManaStone.blp",
                              'Maximum mana.')
    static.RECOV = static.new('Recov', 'Recovery', "ReplaceableTextures\\CommandButtons\\BTNBrilliance.blp",
                              'Mana restoration per second')
    static.STR = static.new('Str', 'Strength', "UI\\Widgets\\Console\\Human\\infocard-heroattributes-str.blp",
                              'Some spell effects depends on this value. Every point of strength increases attack damage by '..atk_per_str..', armor by '..armor_per_str..' and health by '..hp_per_str..'.')
    static.AGI = static.new('Agi', 'Agility', "UI\\Widgets\\Console\\Human\\infocard-heroattributes-agi.blp",
                              'Some spell effects depends on this value. Every point of agility increases attack speed by '..aspd_per_agi..', casting time reduction by '..ctr_per_agi..' and dodge chance by '..dodge_per_agi..'.')
    static.INT = static.new('Int', 'Intelligence', "UI\\Widgets\\Console\\Human\\infocard-heroattributes-int.blp",
                              'Some spell effects depends on this value. Every point of intelligence increases spell damage by '..mdmg_per_int..', cooldown reduction by '..cdr_per_int..' and mana by '..mp_per_int..'.')
    static.MS = static.new('MS', 'Move speed', "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp",
                              'Move speed')
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

return ParameterType