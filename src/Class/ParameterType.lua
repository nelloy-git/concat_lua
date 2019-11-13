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

private.default_max = 10^10

private.min_pdmg_attack = 0.85
private.max_pdmg_attack = 1.15
private.pdmg_dispertion = (private.min_pdmg_attack + private.max_pdmg_attack) / 2
private.max_pdmg_reduc = 0.75

private.min_mdmg_attack = 0.85
private.max_mdmg_attack = 1.15
private.mdmg_dispertion = (private.min_mdmg_attack + private.max_mdmg_attack) / 2
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

static.min = {}
static.max = {}

--=========
-- Methods
--=========

---@return ParameterType
function private.new()
    local instance = newInstanceData(ParameterType)
    local priv = {
        short = "Empty",
        full = "Empty",
        icon = "Empty",
        tooltip = "Empty",
        min_value = 0,
        max_value = 0,
    }
    private[instance] = priv

    return instance
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

local initialized = false
function static.init()
    if initialized then
        return nil
    end
    initialized = true

    local priv

    -- Physical damage.
    static.PDmg = private.new()
    priv = private[static.PDMG]
    priv.short = 'PDmg'
    priv.full = 'Physical damage'
    priv.icon = Icon.BTNSteelMelee
    priv.tooltip = string.format('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %d-%d%% of this value as physical damage.',
                                  100 * private.min_pdmg_attack, 100 * private.max_pdmg_attack)
    priv.min = 0
    priv.max = private.default_max

    -- Attack speed.
    static.ASpd = private.new()
    priv = private[static.ASpd]
    priv.short = 'ASpd'
    priv.full = 'Attacks per second'
    priv.icon = Icon.BTNCommand
    priv.tooltip = 'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.'
    priv.min = 0
    priv.max = private.default_max

    -- Armor
    static.Armor = private.new()
    priv = private[static.Armor]
    priv.short = 'PDef'
    priv.full = 'Armor'
    priv.icon = Icon.BTNDefend
    priv.tooltip = 'Physical damage is reduced by this value. Works after physical damage reduction.'
    priv.min = -private.default_max
    priv.max = private.default_max

    -- Physical damage reduction
    static.PDmgReduc = static.new()
    priv = private[static.PDmgReduc]
    priv.short = 'PReduc'
    priv.full = 'Physical damage reduction'
    priv.icon = Icon.BTNHumanArmorUpThree
    priv.tooltip = string.format('Physical damage is reduced by this value. Works before armor. Formula: %d * (rating / (100 + rating)).',
                                  100 * private.max_pdmg_reduc)
    priv.min = -private.max_pdmg_reduc
    priv.max = private.max_pdmg_reduc


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
                                                  100 * static.max_mdmg_reduc))

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

    static.max[static.PDMG] = 10^10
    static.max[static.ATKS_PER_SEC] = 10^10
    static.max[static.Armor] = 10^10
    static.max[static.PDmgReduc] = static.max_pdmg_reduc
    static.max[static.MDMG] = 10^10
    static.max[static.CAST_TIME_REDUC] = static.max_ctime_reduc
    static.max[static.RESIST] = 10^10
    static.max[static.MDMG_REDUC] = static.max_mdmg_reduc
    static.max[static.DODGE] = static.max_dodge_ch
    static.max[static.CRIT_CH] = static.max_crit_ch
    static.max[static.CRIT_DMG] = 10^10
    static.max[static.CD_REDUC] = static.max_cd_reduc
    static.max[static.HP] = 10^10
    static.max[static.REGEN] = 10^10
    static.max[static.MP] = 10^10
    static.max[static.RECOV] = 10^10
    static.max[static.STR] = 10^10
    static.max[static.AGI] = 10^10
    static.max[static.INT] = 10^10
    static.max[static.MS] = 512
    
    static.min[static.PDMG] = 0
    static.min[static.ATKS_PER_SEC] = 0
    static.min[static.Armor] = -10^10
    static.min[static.PDmgReduc] = -static.max_pdmg_reduc
    static.min[static.MDMG] = 0
    static.min[static.CAST_TIME_REDUC] = -static.max_ctime_reduc
    static.min[static.RESIST] = -10^10
    static.min[static.MDMG_REDUC] = -static.max_mdmg_reduc
    static.min[static.DODGE] = 0
    static.min[static.CRIT_CH] = 0
    static.min[static.CRIT_DMG] = 0
    static.min[static.CD_REDUC] = -static.max_cd_reduc
    static.min[static.HP] = 5
    static.min[static.REGEN] = -10^10
    static.min[static.MP] = 5
    static.min[static.RECOV] = -10^10
    static.min[static.STR] = -10^10
    static.min[static.AGI] = -10^10
    static.min[static.INT] = -10^10
    static.min[static.MS] = 1
end

-- Physical damage.
static.PDmg = private.new()
private[static.PDmg].short = 'PDmg'
private[static.PDmg].full = 'Physical damage'
private[static.PDmg].icon = Icon.BTNSteelMelee
private[static.PDmg].tooltip = string.format('Physical damage of unit attacks and most of physical abilities. Attacks randomly deals %.0f-%.0f%% of this value as physical damage.',
                                              100 * private.min_pdmg_attack, 100 * private.max_pdmg_attack)
private[static.PDmg].min = 0
private[static.PDmg].max = private.default_max

-- Attack speed.
static.ASpd = private.new()
private[static.ASpd].short = 'ASpd'
private[static.ASpd].full = 'Attack speed'
private[static.ASpd].icon = Icon.BTNCommand
private[static.ASpd].tooltip = 'The frequency with which units attack is measured in attack speed. Base attacks per second multiplied by attack speed.'
private[static.ASpd].min = 0
private[static.ASpd].max = private.default_max

-- Armor.
static.Armor = private.new()
private[static.Armor].short = 'PDef'
private[static.Armor].full = 'Armor'
private[static.Armor].icon = Icon.BTNDefend
private[static.Armor].tooltip = 'Physical damage is reduced by this value. Works after physical damage reduction.'
private[static.Armor].min = -private.default_max
private[static.Armor].max = private.default_max

-- Physical damage reduction.
static.PDmgReduc = private.new()
private[static.PDmgReduc].short = 'PReduc'
private[static.PDmgReduc].full = 'Physical damage reduction'
private[static.PDmgReduc].icon = Icon.BTNHumanArmorUpThree
private[static.PDmgReduc].tooltip = string.format('Physical damage is reduced by this value. Works before armor. Formula: %.0f * rating / (100 + rating) %%.',
                                                   100 * private.max_pdmg_reduc)
private[static.PDmgReduc].min = -private.max_pdmg_reduc
private[static.PDmgReduc].max = private.max_pdmg_reduc

-- Magical damage.
static.MDmg = private.new()
private[static.MDmg].short = 'MDmg'
private[static.MDmg].full = 'Magical damage'
private[static.MDmg].icon = Icon.BTNAdvancedStrengthOfTheMoon
private[static.MDmg].tooltip = string.format('Magical damage of unit attacks and most of magical abilities. Attacks randomly deals %.0f-%.0f%% of this value as magical damage.',
                                              100 * private.min_mdmg_attack, 100 * private.max_mdmg_attack)
private[static.MDmg].min = 0
private[static.MDmg].max = private.default_max

-- Casting time reduction.
static.CSpd = private.new()
private[static.CSpd].short = 'CSpd'
private[static.CSpd].full = 'Casting time reduction'
private[static.CSpd].icon = Icon.BTNBansheeMaster
private[static.CSpd].tooltip = 'Casting speed of abilities is multiplied by this value.'
private[static.CSpd].min = 0
private[static.CSpd].max = private.default_max

-- Resistance.
static.Resist = private.new()
private[static.Resist].short = 'Resist'
private[static.Resist].full = 'Resistance'
private[static.Resist].icon = Icon.BTNResistantSkin
private[static.Resist].tooltip = 'Magical damage is reduced by this value. Works after magical damage reduction.'
private[static.Resist].min = -private.default_max
private[static.Resist].max = private.default_max

-- Magical damage reduction.

static.MDMG_REDUC = static.new('MReduc', 'Magical damage reduction', Icon.BTNLightningShield,
      string.format('Magical damage is reduced by this value. Works before resist. Formula: %d * (rating / (100 + rating)).',
                     100 * static.max_mdmg_reduc))

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

return ParameterType