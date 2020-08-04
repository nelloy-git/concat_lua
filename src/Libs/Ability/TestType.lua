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

function TestAbilityType:onCastingStart(abil)
    print('onStart')
end

function TestAbilityType:onCastingLoop(abil)
    print('onCasting')
end

function TestAbilityType:onCastingCancel(abil)
    print('onCancel')
end

function TestAbilityType:onCastingInterrupt(abil)
    print('onInterrupt')
end

function TestAbilityType:onCastingFinish(abil)
    print('onFinish')
end

function TestAbilityType:getRange(abil)
    return 500
end

function TestAbilityType:getArea(abil)
    return 0
end

function TestAbilityType:getCastingTime(abil)
    print('getCastingTime')
    return 3
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