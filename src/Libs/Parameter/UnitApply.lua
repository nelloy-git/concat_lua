---@type ParameterDefines
local Defines = require(__ParameterLib..'Defines')

local ApplyUnit = {}

function ApplyUnit.set(param, base, mult, addit)
    
end

function ApplyUnit.PhysicalDamage()
end

---@type ParameterData
local Data = require('Parameter.Data')
local Param = Data.Type
local Const = Data.Const

local delta_pdmg_attack = Const.max_pdmg_attack - Const.min_pdmg_attack
local apply_function = {
    [Param.PDmg] = function(unit, value)
        local dmg = Const.min_pdmg_attack * value
        local dice_sides = delta_pdmg_attack * value

        BlzSetUnitBaseDamage(unit, math.floor(dmg), 0)
        BlzSetUnitDiceNumber(unit, 1, 0)
        BlzSetUnitDiceSides(unit, math.floor(dice_sides + 1), 0)
    end,

    [Param.ASpd] = function(unit, value)
        BlzSetUnitAttackCooldown(unit, value, 1)
    end,

    [Param.Armor] = nil,
    [Param.PDmgReduc] = nil,
    [Param.MDmg] = nil,
    [Param.CSpd] = nil,
    [Param.Resist] = nil,
    [Param.MDmgReduc] = nil,
    [Param.Dodge] = nil,
    [Param.CritCh] = nil,
    [Param.CritDmg] = nil,
    [Param.CdReduc] = nil,

    [Param.Health] = function(unit, value)
        local percent_hp = GetUnitLifePercent(unit)
        BlzSetUnitMaxHP(unit, math.floor(value))
        SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_MAX_LIFE) * percent_hp * 0.01)
    end,

    [Param.Regen] = function(unit, value)
        BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
    end,

    [Param.Mana] = function(unit, value)
        local percent_mana = GetUnitManaPercent(unit)
        BlzSetUnitMaxMana(unit, math.floor(value))
        SetUnitState(unit, UNIT_STATE_MANA, GetUnitState(unit, UNIT_STATE_MAX_MANA) * percent_mana * 0.01)
    end,

    [Param.Recov] = function(unit, value)
        BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
    end,

    [Param.Str] = function(unit, value)
        SetHeroStr(unit, value // 1, true)
        --[[
        UnitParameterContainer = UnitParameterContainer or require('Unit.Parameters.Container')

        local param_container = UnitParameterContainer.get(unit)
        local old_value = param_container:getResult(ParameterType.Str)
        local diff_str = value - old_value

        local diff_hp = diff_str * ParameterType.getHealthPerStr()
        local diff_pdmg = diff_str * ParameterType.getPDmgPerStr()
        local diff_armor = diff_str * ParameterType.getArmorPerStr()

        param_container:addBase(ParameterType.Health, diff_hp)
        param_container:addBase(ParameterType.PDmg, diff_pdmg)
        param_container:addBase(ParameterType.Armor, diff_armor)
        ]]
    end,

    [Param.Agi] = function(unit, value)
        SetHeroAgi(unit, value // 1, true)
        --[[
        UnitParameterContainer = UnitParameterContainer or require('Unit.Parameters.Container')

        local param_container = UnitParameterContainer.get(unit)
        local old_value = param_container:getResult(ParameterType.Agi)
        local diff_agi = value - old_value

        local diff_aspd = diff_agi * ParameterType.getASpdPerAgi()
        local diff_cspd = diff_agi * ParameterType.getCSpdPerAgi()
        local diff_dodge = diff_agi * ParameterType.getDodgePerAgi()

        param_container:addBase(ParameterType.ASpd, diff_aspd)
        param_container:addBase(ParameterType.CSpd, diff_cspd)
        param_container:addBase(ParameterType.Dodge, diff_dodge)
        ]]
    end,

    [Param.Int] = function(unit, value)
        SetHeroInt(unit, value // 1, true)
        --[[
        UnitParameterContainer = UnitParameterContainer or require('Unit.Parameters.Container')

        local param_container = UnitParameterContainer.get(unit)
        local old_value = param_container:getResult(ParameterType.Int)
        local diff_int = value - old_value

        local diff_mdmg = diff_int * ParameterType.getMDmgPerInt()
        local diff_mana = diff_int * ParameterType.getManaPerInt()
        local diff_cdr = diff_int * ParameterType.getCooldownReductionPerInt()

        param_container:addBase(ParameterType.MDmg, diff_mdmg)
        param_container:addBase(ParameterType.Mana, diff_mana)
        param_container:addBase(ParameterType.CdReduc, diff_cdr)
        ]]
    end,

    [Param.MS] = function(unit, value)
        if value <= 1 then
            SetUnitTurnSpeed(unit, 0)
        else
            SetUnitTurnSpeed(unit, GetUnitDefaultTurnSpeed(unit))
        end
        SetUnitMoveSpeed(unit, value)
    end,
}

---@param unit unit
---@param param ParameterTypeEnum
---@param value number
function ParameterUnitApply(unit, param, value)
    if not Data.isParamType(param) then
        Log.error('ParameterUnitApply', 'unknown ParameterTypeEnum.', 2)
    end
    local func = apply_function[param]
    if not func then
        return
    end
    func(unit, value)
end

return ParameterUnitApply