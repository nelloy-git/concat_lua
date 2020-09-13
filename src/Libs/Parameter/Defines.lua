local lib_modname = Lib.current().modname
---@type UtilsLib
local UtilsLib = Lib.current().depencies.UtilsLib

---@class ParameterDefines
local Defines = {}
---@type ParameterClass
local Parameter = require(lib_modname..'.Parameter')

Defines.AllParameters = {}
Defines.ApplyToUnit = {}

--=======
-- Utils
--=======

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
    BlzSetUnitBaseDamage(unit, math.floor(0.85 * value), 0)
    BlzSetUnitDiceNumber(unit, 1, 0)
    BlzSetUnitDiceSides(unit, math.floor(0.3 * value + 1), 0)
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
                                       Compiletime(UtilsLib.Icon.BTNSteelMelee),
                                       0, 10^10, 0, applyPhysDmg)

Defines.AttackSpeed = registerParam('ASpd', 'Attack speed',
                                    Compiletime(UtilsLib.Icon.BTNCommand),
                                    0, 10^10, 2, applyAttackSpeed)

Defines.Defence = registerParam('Def', 'Defence',
                                Compiletime(UtilsLib.Icon.BTNDefend),
                                0, 10^10, 0, nil)

Defines.PhysicalDamageReduction = registerParam('PDmgReduc', 'Physical damage reduction',
                                                Compiletime(UtilsLib.Icon.BTNHumanArmorUpThree),
                                                -1, 1, 0, nil)

Defines.MagicalDamage = registerParam('MDmg', 'Magical damage',
                                      Compiletime(UtilsLib.Icon.BTNAdvancedStrengthOfTheMoon),
                                      0, 10^10, 0, nil)

Defines.CooldownReduction = registerParam('CdR', 'Cooldown reduction',
                                          Compiletime(UtilsLib.Icon.BTNDispelMagic),
                                          0, 0.75, 0, nil)

Defines.Resistance = registerParam('Res', 'Resistance',
                                   Compiletime(UtilsLib.Icon.BTNResistantSkin),
                                   0, 10^10, 0, nil)

Defines.MagicalDamageReduction = registerParam('MDmgReduc', 'Magical damage reduction',
                                               Compiletime(UtilsLib.Icon.BTNLightningShield),
                                               -1, 1, 0, nil)

Defines.ControlReduction = registerParam('ConReduc', 'Control reduction',
                                    Compiletime(UtilsLib.Icon.BTNEvasion),
                                    0, 0.75, 0, nil)

Defines.DodgeChance = registerParam('Dodge', 'Dodge chance',
                                    Compiletime(UtilsLib.Icon.BTNAncestralSpirit),
                                    0, 0.75, 0, nil)

Defines.CriticalStrikeChance = registerParam('Crit', 'Critical strike chance',
                                             Compiletime(UtilsLib.Icon.BTNCriticalStrike),
                                             0, 0.75, 0, nil)

Defines.Health = registerParam('HP', 'Health',
                               Compiletime(UtilsLib.Icon.BTNHealthStone),
                               10, 10^10, 0, applyHealth)

Defines.Regeneration = registerParam('Regen', 'Regeneration',
                                     Compiletime(UtilsLib.Icon.BTNRegenerate),
                                     0, 10^10, 0, applyRegen)

Defines.Mana = registerParam('MP', 'Mana',
                             Compiletime(UtilsLib.Icon.BTNManaStone),
                             5, 10^10, 0, applyMana)

Defines.Recovery = registerParam('Recov', 'Recovery',
                                 Compiletime(UtilsLib.Icon.BTNBlink),
                                 0, 10^10, 0, applyRecov)

Defines.MoveSpeed = registerParam('MS', 'Move speed',
                                  Compiletime(UtilsLib.Icon.BTNBootsOfSpeed),
                                  0, 500, 250, applyMoveSpeed)

return Defines