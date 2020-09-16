--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type AssetLib
local AssetLib = lib_dep.Asset or error('')
local Icon = AssetLib.IconDefault or error('')

---@type ParameterClass
local Parameter = require(lib_path..'Parameter') or error('')
---@type ParameterSettings
local Settings = require(lib_path..'Settings') or error('')

--========
-- Module
--========

---@class ParameterDefines
local Defines = {}

Defines.AllParameters = {}
Defines.ApplyToUnit = {}

local function registerParam(short_name, full_name, icon,
                             min_value, max_value, default_value,
                             apply_to_unit_func)

    local param = Parameter.new(short_name, full_name, icon,
                                min_value, max_value, default_value)
    table.insert(Defines.AllParameters, param)
    Defines.ApplyToUnit[param] = apply_to_unit_func

    return param
end

local function applyPhysDmg(unit, value)
    BlzSetUnitBaseDamage(unit, math.floor((1 - 0.5 * Settings.PAtkDispersion) * value), 0)
    BlzSetUnitDiceNumber(unit, 1, 0)
    BlzSetUnitDiceSides(unit, math.floor(Settings.PAtkDispersion * value + 1), 0)
end

local function applyAttackSpeed(unit, value)
    BlzSetUnitAttackCooldown(unit, value, 0)
end

local function applyHealth(unit, value)
    local percent_hp = GetUnitLifePercent(unit)
    BlzSetUnitMaxHP(unit, math.floor(value))
    SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_MAX_LIFE) * percent_hp * 0.01)
end

local function applyRegen(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

local function applyMana(unit, value)
    local percent_mana = GetUnitManaPercent(unit)
    BlzSetUnitMaxMana(unit, math.floor(value))
    SetUnitState(unit, UNIT_STATE_MANA, GetUnitState(unit, UNIT_STATE_MAX_MANA) * percent_mana * 0.01)
end

local function applyRecov(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
end

local function applyMoveSpeed(unit, value)
    if value <= 1 then
        SetUnitTurnSpeed(unit, 0)
    else
        SetUnitTurnSpeed(unit, GetUnitDefaultTurnSpeed(unit))
    end
    SetUnitMoveSpeed(unit, value)
end

--============
-- Parameters
--============

Defines.PhysicalDamage = registerParam('PDmg', 'Physical damage',
                                       Icon.BTNSteelMelee,
                                       0, 10^10, 0, applyPhysDmg)

Defines.AttackSpeed = registerParam('ASpd', 'Attack speed',
                                    Icon.BTNCommand,
                                    0, 10^10, 2, applyAttackSpeed)

Defines.Defence = registerParam('Def', 'Defence',
                                Icon.BTNDefend,
                                0, 10^10, 0, nil)

Defines.PhysicalDamageReduction = registerParam('PReduc', 'Physical damage reduction',
                                                Icon.BTNHumanArmorUpThree,
                                                -1, 1, 0, nil)

Defines.MagicalDamage = registerParam('MDmg', 'Magical damage',
                                      Icon.BTNAdvancedStrengthOfTheMoon,
                                      0, 10^10, 0, nil)

Defines.CooldownReduction = registerParam('CdR', 'Cooldown reduction',
                                          Icon.BTNDispelMagic,
                                          0, 0.75, 0, nil)

Defines.Resistance = registerParam('Res', 'Resistance',
                                   Icon.BTNResistantSkin,
                                   0, 10^10, 0, nil)

Defines.MagicalDamageReduction = registerParam('MReduc', 'Magical damage reduction',
                                               Icon.BTNLightningShield,
                                               -1, 1, 0, nil)

Defines.ControlReduction = registerParam('CReduc', 'Control reduction',
                                    Icon.BTNEvasion,
                                    0, 0.75, 0, nil)

Defines.DodgeChance = registerParam('Dodge', 'Dodge chance',
                                    Icon.BTNAncestralSpirit,
                                    0, 0.75, 0, nil)

Defines.CriticalStrikeChance = registerParam('Crit', 'Critical strike chance',
                                             Icon.BTNCriticalStrike,
                                             0, 0.75, 0, nil)

Defines.Health = registerParam('HP', 'Health',
                               Icon.BTNHealthStone,
                               10, 10^10, 0, applyHealth)

Defines.Regeneration = registerParam('Regen', 'Regeneration',
                                     Icon.BTNRegenerate,
                                     0, 10^10, 0, applyRegen)

Defines.Mana = registerParam('MP', 'Mana',
                             Icon.BTNManaStone,
                             5, 10^10, 0, applyMana)

Defines.Recovery = registerParam('Recov', 'Recovery',
                                 Icon.BTNBlink,
                                 0, 10^10, 0, applyRecov)

Defines.MoveSpeed = registerParam('MS', 'Move speed',
                                  Icon.BTNBootsOfSpeed,
                                  0, 500, 250, applyMoveSpeed)

return Defines