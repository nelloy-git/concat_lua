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

static.min_pdmg_attack = 0.85
static.max_pdmg_attack = 1.15
static.attack_dispertion = (static.max_attack + static.min_attack) / 2
static.max_pdmg_reduc = 0.75

static.min_mdmg_attack = 0.85
static.max_mdmg_attack = 1.15
static.max_ctime_reduc = 0.75
static.max_mdmg_reduc = 0.75

static.max_dodge_ch = 0.50
static.max_crit_ch = 0.75
static.max_cd_reduc = 0.75

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
                              string.format('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %d-%d%% of this value as physical damage.',
                                             100 * static.min_pdmg_attack, 100 * static.max_pdmg_attack))

    static.ATKS_PER_SEC = static.new('ASpd', 'Attacks per second', Icon.BTNCommand,
                                     'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.')

    static.ARMOR = static.new('PDef', 'Armor', Icon.BTNDefend,
                              'Physical damage is reduced by this value. Works after physical damage reduction.')

    static.PDMG_REDUC = static.new('PReduc', 'Physical damage reduction', Icon.BTNHumanArmorUpThree,
                                   string.format('Physical damage is reduced by this value. Works before armor. Formula: %d * (rating / (100 + rating)).',
                                                  100 * static.max_pdmg_reduc))

    static.MDMG = static.new('MDmg', 'Magical damage', Icon.BTNAdvancedStrengthOfTheMoon,
                             string.format('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %d-%d%% of this value as physical damage.',
                                            100 * static.min_mdmg_attack, 100 * static.max_mdmg_attack))

    static.CAST_TIME_REDUC = static.new('CSpd', 'Casting time reduction', Icon.BTNBansheeMaster,
                                        string.format('Casting time of abilities is reduced by this value. Formula: %d * (rating / (100 + rating)).',
                                                       100 * static.max_ctime_reduc))

    static.RESIST = static.new('MDef', 'Reisistance', Icon.BTNResistantSkin,
                               'Magical damage is reduced by this value. Works after magical damage reduction.')

    static.MDMG_REDUC = static.new('MReduc', 'Magical damage reduction', Icon.BTNLightningShield,
                                   string.format('Magical damage is reduced by this value. Works before resist. Formula: %d * (rating / (100 + rating)).',
                                                  100 * static.max_pdmg_reduc))

    static.DODGE = static.new('Dodge', 'Dodge chance', Icon.BTNEvasion,
                              string.format('Chance to avoid incoming damage. Formula: %d * (rating / (100 + rating)',
                                             100 * static.max_dodge_ch))

    static.CRIT_CH = static.new('CritCh', 'Critical strike chance', Icon.BTNCriticalStrike,
                                string.format('Chance to increase damage by critical damage value. Formula: %d * (rating / (100 + rating)',
                                               100 * static.max_crit_ch))

    static.CRIT_DMG = static.new('CritDmg', 'Critical strike damage', Icon.BTNDeathPact,
                                 'Critical attacks and spells deals this value damage.')

    static.CD_REDUC = static.new('CDReduc', 'Cooldown reduction', Icon.BTNDispelMagic,
                                 string.format('Abilities cooldown reduced by this value. Formula: %d * (rating / (100 + rating)',
                                                100 * static.max_cd_reduc))

    static.HP = static.new('HP', 'Health', Icon.BTNHealthStone,
                           'Maximum health.')

    static.REGEN = static.new('Regen', 'Regeneration', Icon.BTNRegenerate,
                              'Health restoration per second.')

    static.MP = static.new('MP', 'Mana', Icon.BTNManaStone,
                           'Maximum mana.')

    static.RECOV = static.new('Recov', 'Recovery', Icon.BTNBrilliance,
                              'Mana restoration per second')

    static.STR = static.new('Str', 'Strength', "UI\\Widgets\\Console\\Human\\infocard-heroattributes-str.blp",
                             string.format('Some spell effects depends on this value. Every point of strength increases attack damage by %.2f, armor by %.2f and health by %.2f.',
                                            static.pdmg_per_str, static.armor_per_str, static.hp_per_str))

    static.AGI = static.new('Agi', 'Agility', "UI\\Widgets\\Console\\Human\\infocard-heroattributes-agi.blp",
                            string.format('Some spell effects depends on this value. Every point of agility increases attack speed by %.2f, casting time reduction by %.2f and dodge chance by %.2f.',
                                           static.aspd_per_agi, static.cspd_per_agi, static.dodge_per_agi))

    static.INT = static.new('Int', 'Intelligence', "UI\\Widgets\\Console\\Human\\infocard-heroattributes-int.blp",
                            string.format('Some spell effects depends on this value. Every point of intelligence increases spell damage by %.2f, cooldown reduction by %.2f and mana by %.2f.',
                                           static.mdmg_per_int, static.mp_per_int, static.cdr_per_int))

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