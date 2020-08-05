local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Log = UtilsLib.DefaultLogger

---@type AbilityDataTypeClass
local AbilityType = require(lib_modname..'.Data.Type')

local TestAbilityType = AbilityType.new('TestAbilityType')

function TestAbilityType:checkConditions(abil)
    print('checkConditions')
    return true
end

function TestAbilityType:onCastingStart(target, caster)
    print('Start casting')
end

function TestAbilityType:onCastingLoop(target, caster, time_left, full_time)
    print('Casting: ', time_left)
end

function TestAbilityType:onCastingCancel(target, caster, time_left, full_time)
    print('onCancel')
end

function TestAbilityType:onCastingInterrupt(target, caster, time_left, full_time)
    print('onInterrupt')
end

function TestAbilityType:onCastingFinish(target, caster, time_left, full_time)
    print('onFinish')
end

function TestAbilityType:getRange(abil)
    return 500
end

function TestAbilityType:getArea(abil)
    return 0
end

function TestAbilityType:getCastingTime(caster)
    print('getCastingTime')
    return 3
end

function TestAbilityType:getChargesForUse()
    return 1
end

function TestAbilityType:getChargeCooldown(abil)
    return 2
end

function TestAbilityType:getChargesMax(abil)
    return 5
end

function TestAbilityType:getManaCost(abil)
    return 0
end

function TestAbilityType:getHealthCost(abil)
    return 5
end

function TestAbilityType:getName(abil)
    return 'TestName'
end

function TestAbilityType:getIcon(abil)
    return "ReplaceableTextures\\\\CommandButtons\\\\BTNAcidBomb.blp"
end

function TestAbilityType:getTooltip(abil)
    return 'TestTooltip'
end

--function TestAbilityType:getAvailableTargets(abil)
--end


return TestAbilityType