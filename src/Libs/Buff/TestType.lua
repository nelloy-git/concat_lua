local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Log = UtilsLib.DefaultLogger

---@type BuffTypeClass
local BuffType = require(lib_modname..'.Type')

local TestBuffType = BuffType.new('TestBuffType')

function TestBuffType:checkConditions(buff)
    Log:msg('checkConditions')
    return true
end

function TestBuffType:onStart(buff)
    Log:msg('onStart')
end

function TestBuffType:onTick(buff)
    Log:msg('onTick '..buff:getDurationLeft())
end

function TestBuffType:onCancel(buff)
    Log:msg('onCancel')
end

function TestBuffType:onFinish(buff)
    Log:msg('onFinish')
end

function TestBuffType:getDuration(buff)
    Log:msg('getDuration')
    return 3
end

function TestBuffType:getName(buff)
    Log:msg('getName')
end

function TestBuffType:getIcon(buff)
    Log:msg('getIcon')
end

function TestBuffType:getTooltip(buff)
    Log:msg('getTooltip')
end


return TestBuffType