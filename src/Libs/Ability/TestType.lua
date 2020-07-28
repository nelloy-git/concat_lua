local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Log = UtilsLib.DefaultLogger

---@type AbilityDataTypeClass
local AbilityType = require(lib_modname..'.Type')

local TestAbilityType = AbilityType.new('TestAbilityType', 'None', false)

function TestAbilityType:checkConditions(abil)
    Log:msg('checkConditions')
    return true
end

function TestAbilityType:onStart(abil)
    Log:msg('onStart')
end

function TestAbilityType:onCasting(abil)
    Log:msg('onCasting')
end

function TestAbilityType:onCancel(abil)
    Log:msg('onCancel')
end

function TestAbilityType:onInterrupt(abil)
    Log:msg('onInterrupt')
end

function TestAbilityType:onFinish(abil)
    Log:msg('onFinish')
end

function TestAbilityType:getRange(abil)
    return 500
end

function TestAbilityType:getArea(abil)
    return 0
end

function TestAbilityType:getCastingTime(abil)
    Log:msg('getCastingTime')
    return 3
end

function TestAbilityType:getChargeCooldown(abil)
    Log:msg('getChargeCooldown')
    return 3
end

function TestAbilityType:getMaxCharges(abil)
    Log:msg('getMaxCharges')
    return 1
end

function TestAbilityType:getChargesForUse(abil)
    return 1
end

function TestAbilityType:getManaCost(abil)
    return 10
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


return TestAbilityType