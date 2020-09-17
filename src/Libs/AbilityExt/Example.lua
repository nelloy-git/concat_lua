--[[
local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils
local Log = UtilsLib.Log

---@type AbilityDataTypeClass
local AbilityType = require(lib_path..'.Data.Type') or error('')

local TestAbilityType = AbilityType.new('TestAbilityType')

function TestAbilityType:checkConditions(abil)
    print('checkConditions')
    return true
end

function TestAbilityType:onCastingStart(target, caster)
    print('Start casting')
end

function TestAbilityType:onCastingLoop(target, caster, time_left, full_time)
    --print('Casting: ', time_left)
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

function TestAbilityType:getCastingTime(caster)
    --print('getCastingTime')
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

function TestAbilityType:getName()
    return 'TestName'
end

function TestAbilityType:getRange(owner)
    return 500
end

function TestAbilityType:getArea(owner)
    return 0
end

function TestAbilityType:getTargetingType(owner)
    return 'Unit'
end

function TestAbilityType:getTargetsAllowed(owner)
    return 'friend'
end

function TestAbilityType:getManaCost(owner)
    return 0
end

function TestAbilityType:getHealthCost(owner)
    return 5
end

function TestAbilityType:getIcon(owner)
    return "ReplaceableTextures\\\\CommandButtons\\\\BTNAcidBomb.blp"
end

function TestAbilityType:getTooltip(owner)
    return 'TestTooltip'
end

--function TestAbilityType:getAvailableTargets(abil)
--end


return TestAbilityType
]]