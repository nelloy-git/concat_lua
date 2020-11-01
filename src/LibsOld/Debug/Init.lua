--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class
---@type ChatCmd
local ChatCmd = require(lib_path..'.ChatCmd')
---@type UtilsFunctions
local Functions = require(lib_path..'Functions')
local pairsByKeys = Functions.pairsByKeys
---@type UtilsSettings
local Settings = require(lib_path..'Settings')
local Log = Settings.default_logger

--========
-- Module
--========

local Debug = {}

if not Settings.isDebug() then
    return Debug
end

ChatCmd.register('-classes', function()
    local data = Class.getInstancesStatistics()
    local stats = {}
    for class, count in pairs(data) do
        stats[tostring(class)] = tostring(count)
    end

    Log:msg('Class: count')
    for str_class, str_count in pairsByKeys(stats) do
        Log:msg(str_class..': '..str_count)
    end
end, 0)

return Debug