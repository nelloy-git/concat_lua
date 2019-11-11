--=========
-- Include
--=========

local Icon = require('assets.Icon')

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

static.min_attack = 0.85
static.max_attack = 1.15
static.attack_dispertion = (static.max_attack + static.min_attack) / 2

static.pdmg_per_str = 0.50
static.armor_per_str = 0.25
static.hp_per_str = 5

static.aspd_per_agi = 1
static.cspd_per_agi = 1
static.dodge_per_agi = 1

static.mdmg_per_int = 1
static.mp_per_int = 5
static.cdr_per_int = 1

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
    static.PDMG = static.new('PDmg', 'Physical damage', Icon.BTNSteelMelee,
                              string.format('Physical damage of unit attacks and some physical abilities. Attacks randomly deals %d-%d%% of this value.',
                                             static.min_attack, static.max_attack))
    static.ATKS_PER_SEC = static.new('ASpd', 'Attacks per second', Icon.BTNCommand,
                              'The frequency with which units attack is measured in attack speed.')
    static.ARMOR = static.new('PDef', 'Armor', Icon.BTNDefend,
                              'Physical damage is reduced by this value. Works after physical damage reduction.')
    static.PDMG_REDUC = static.new('PRed', 'Physical damage reduction', Icon.BTNHumanArmorUpThree,
                              'Physical damage is reduced by this value. Works before armor. Maximum: '..tostring(100 * Settings.Unit.maximum_physical_damage_reduction)..'%.')
    static.MDMG = static.new('MDmg', 'Spell damage', Icon.BTNAdvancedStrengthOfTheMoon,
                              'Magic power of unit. Icreases damage dealt by magic abilities.')
    static.CAST_TIME_REDUC = static.new('CSpd', 'Casting time reduction', Icon.BTNBansheeMaster,
                              'Casting time of abilities is reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_casting_time_reduction)..'%.')
    static.RESIST = static.new('MDef', 'Reisistance', Icon.BTNResistantSkin,
                              'Magical damage is reduced by this value. Works after magical damage reduction.')
    static.MDMG_REDUC = static.new('MRed', 'Magical damage reduction', Icon.BTNLightningShield,
                              'Magical damage is reduced by this value. Works before resistance. Maximum: '..tostring(100 * Settings.Unit.maximum_magical_damage_reduction)..'%.')
    static.DODGE = static.new('Dodge', 'Dodge chance', Icon.BTNEvasion,
                              'Chance to avoid incoming damage. Maximum: '..tostring(100 * Settings.Unit.maximum_dodge_chance)..'%.')
    static.CRIT_CH = static.new('CritCh', 'Critical strike chance', Icon.BTNCriticalStrike,
                              'Chance to increase damage by critical damage value. Maximum: '..tostring(100 * Settings.Unit.maximum_crit_chance)..'%.')
    static.CRIT_DMG = static.new('CritDmg', 'Critical strike damage', Icon.BTNDeathPact,
                              'Critical attack or spell deals this value damage.')
    static.CD_REDUC = static.new('CDRed', 'Cooldown reduction', Icon.BTNDispelMagic,
                              'Abilities cooldown reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_cooldown_reduction)..'%.')
    static.HP = static.new('HP', 'Health', Icon.BTNHealthStone,
                              'Maximum health.')
    static.REGEN = static.new('Regen', 'Regeneration', Icon.BTNRegenerate,
                              'Health restoration per second.')
    static.MP = static.new('MP', 'Mana', Icon.BTNManaStone,
                              'Maximum mana.')
    static.RECOV = static.new('Recov', 'Recovery', Icon.BTNBrilliance,
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