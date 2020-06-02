local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Log = UtilsLib.DefaultLogger

---@type AbilityTypeClass
local AbilityType = require(lib_modname..'.Type')

local TestAbilityType = AbilityType.new()

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
    Log:msg('getChargesForUse')
    return 1
end

function TestAbilityType:getName(abil)
    Log:msg('getName')
end

function TestAbilityType:getIcon(abil)
    Log:msg('getIcon')
end

function TestAbilityType:getTooltip(abil)
    Log:msg('getTooltip')
end


return TestAbilityType