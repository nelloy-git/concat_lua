--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')

--- Recursive include
---@type UnitParametersContainerClass
local UnitParameterContainer = require('Class.Unit.Parameters.Container')

--=======
-- Class
--=======

local UnitApplyParameter = Class.new('UnitApplyParameter')
---@class UnitApplyParameter
local public = UnitApplyParameter.public
---@class UnitApplyParameterClass
local static = UnitApplyParameter.static
---@type UnitApplyParameterClass
local override = UnitApplyParameter.override
local private = {}

--=========
-- Static
--=========

---@param target unit
---@param value number
---@param parameter ParameterType
function static.apply(target, value, parameter)
    local func = private.ApplyParameterFunction[parameter]
    if not func then
        Log(Log.Warn, UnitApplyParameter, 'unknown parameter type '..tostring(parameter))
        return
    end
    func(target, value)
end

--========
-- Public
--========

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

function private.applyNothing()
    return nil
end

---@param target unit
---@param value number
function private.PDmg(target, value)
    local dmg = private.min_pdmg_attack * value
    local dice_sides = (private.max_pdmg_attack - private.min_pdmg_attack) * value

    BlzSetUnitBaseDamage(target, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(target, 1, 0)
    BlzSetUnitDiceSides(target, math.floor(dice_sides + 1), 0)
end

---@param target unit
---@param value number
function private.AttackCooldown(target, value)
    BlzSetUnitAttackCooldown(target, value, private.attack_index)
end

---@param target unit
---@param value number
function private.Health(target, value)
    local percent_hp = GetUnitLifePercent(target)
    BlzSetUnitMaxHP(target, math.floor(value))
    SetUnitLifePercentBJ(target, percent_hp)
end

---@param target unit
---@param value number
function private.Regeneration(target, value)
    BlzSetUnitRealField(target, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param target unit
---@param value number
function private.Mana(target, value)
    local percent_mana = GetUnitManaPercent(target)
    BlzSetUnitMaxMana(target, math.floor(value))
    SetUnitManaPercentBJ(target, percent_mana)
end

---@param target unit
---@param value number
function private.Recovery(target, value)
    BlzSetUnitRealField(target, UNIT_RF_MANA_REGENERATION, value)
end

---@param target unit
---@param value number
function private.Strength(target, value)
    SetHeroStr(target, value // 1, true)
    UnitParameterContainer = UnitParameterContainer or require('Class.Unit.Parameters.Container')

    local param_container = UnitParameterContainer.get(target)
    local old_value = param_container:getResult(ParameterType.Str)
    local diff_str = value - old_value

    local diff_hp = diff_str * ParameterType.getHealthPerStr()
    local diff_pdmg = diff_str * ParameterType.getPDmgPerStr()
    local diff_armor = diff_str * ParameterType.getArmorPerStr()

    param_container:addBase(ParameterType.Health, diff_hp)
    param_container:addBase(ParameterType.PDmg, diff_pdmg)
    param_container:addBase(ParameterType.Armor, diff_armor)
end

---@param target unit
---@param value number
function private.Agility(target, value)
    SetHeroAgi(target, value // 1, true)
    UnitParameterContainer = UnitParameterContainer or require('Class.Unit.Parameters.Container')

    local param_container = UnitParameterContainer.get(target)
    local old_value = param_container:getResult(ParameterType.Agi)
    local diff_agi = value - old_value

    local diff_aspd = diff_agi * ParameterType.getASpdPerAgi()
    local diff_cspd = diff_agi * ParameterType.getCSpdPerAgi()
    local diff_dodge = diff_agi * ParameterType.getDodgePerAgi()

    param_container:addBase(ParameterType.ASpd, diff_aspd)
    param_container:addBase(ParameterType.CSpd, diff_cspd)
    param_container:addBase(ParameterType.Dodge, diff_dodge)
end

---@param target unit
---@param value number
function private.Intelligence(target, value)
    SetHeroInt(target, value // 1, true)
    UnitParameterContainer = UnitParameterContainer or require('Class.Unit.Parameters.Container')

    local param_container = UnitParameterContainer.get(target)
    local old_value = param_container:getResult(ParameterType.Int)
    local diff_int = value - old_value

    local diff_mdmg = diff_int * ParameterType.getMDmgPerInt()
    local diff_mana = diff_int * ParameterType.getManaPerInt()
    local diff_cdr = diff_int * ParameterType.getCooldownReductionPerInt()

    param_container:addBase(ParameterType.MDmg, diff_mdmg)
    param_container:addBase(ParameterType.Mana, diff_mana)
    param_container:addBase(ParameterType.CdReduc, diff_cdr)
end

---@param target unit
---@param value number
function private.MoveSpeed(target, value)
    if value <= 1 then
        SetUnitTurnSpeed(target, 0)
    else
        SetUnitTurnSpeed(target, GetUnitDefaultTurnSpeed(target))
    end
    SetUnitMoveSpeed(target, value)
end

private.ApplyParameterFunction = {}
private.ApplyParameterFunction[ParameterType.PDmg] = private.PDmg
private.ApplyParameterFunction[ParameterType.ASpd] = private.AttackCooldown
private.ApplyParameterFunction[ParameterType.Armor] = private.Nothing
private.ApplyParameterFunction[ParameterType.PDmgReduc] = private.Nothing
private.ApplyParameterFunction[ParameterType.MDmg] = private.Nothing
private.ApplyParameterFunction[ParameterType.CSpd] = private.Nothing
private.ApplyParameterFunction[ParameterType.Resist] = private.Nothing
private.ApplyParameterFunction[ParameterType.MDmgReduc] = private.Nothing
private.ApplyParameterFunction[ParameterType.Dodge] = private.Nothing
private.ApplyParameterFunction[ParameterType.CritCh] = private.Nothing
private.ApplyParameterFunction[ParameterType.CritDmg] = private.Nothing
private.ApplyParameterFunction[ParameterType.CdReduc] = private.Nothing
private.ApplyParameterFunction[ParameterType.Health] = private.Health
private.ApplyParameterFunction[ParameterType.Regen] = private.Regeneration
private.ApplyParameterFunction[ParameterType.Mana] = private.Mana
private.ApplyParameterFunction[ParameterType.Recov] = private.Recovery
private.ApplyParameterFunction[ParameterType.Str] = private.Strength
private.ApplyParameterFunction[ParameterType.Agi] = private.Agility
private.ApplyParameterFunction[ParameterType.Int] = private.Intelligence
private.ApplyParameterFunction[ParameterType.MS] = private.MoveSpeed

return static