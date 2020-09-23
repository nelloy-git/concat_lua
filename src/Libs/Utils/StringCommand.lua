--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type ActionClass
local Action = require(lib_path..'Action') or error('')
---@type UtilsFunctions
local Functions = require(lib_path..'Functions') or error('')
local isTypeErr = Functions.isTypeErr or error('')

--========
-- Module
--========

---@class StringCommand
local StringCommand = {}

local CmdList = {}

--- Register command for execution. Input parameters must be string type.
---@param cmd_str string
---@param func function
function StringCommand.register(cmd_str, func)
    isTypeErr(cmd_str, 'string', 'cmd_str')
    isTypeErr(func, 'function', 'func')
    CmdList[cmd_str] = Action.new(func, StringCommand)
end

--- Executes string cmd if registered.
--- Example:
--- StringCommand.register('-print', print)
--- StringCommand.execute('-print arg1 arg2 arg3')
---@param cmd string
---@return any
function StringCommand.execute(cmd)
    isTypeErr(cmd, 'string', 'cmd')

    local argv = {}
    for word in cmd:gmatch("%S+") do table.insert(argv, word) end

    local cmd_str = table.remove(argv, 1)
    local action = CmdList[cmd_str]
    if action then
        return action:run(table.unpack(argv))
    end
    return
end

--[[
if not IsCompiletime() then
    StringCommand.trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        StringCommand.trigger:addPlayerChatEvent(Player(i), '', false)
    end
    StringCommand.trigger:addAction(function()
        local msg = GetEventPlayerChatString()
        StringCommand.execute(msg)
    end)
end
]]

return StringCommand