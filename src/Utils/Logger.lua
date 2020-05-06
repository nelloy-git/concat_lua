--=========
-- Include
--=========

local Class = require(Lib.Class)
---@type TimeClass
local Time = require('Utils.Time')

local fmt = string.format

--=======
-- Class
--=======

local Logger = Class.new('Logger')
---@class Logger
local public = Logger.public
---@class LoggerClass
local static = Logger.static
---@type LoggerClass
local override = Logger.override
local private = {}

--=========
-- Static
--=========

---@alias LogType number
static.LogType = {}
---@type LogType
static.LogType.Err = 1
---@type LogType
static.LogType.Wrn = 2
---@type LogType
static.LogType.Msg = 3

function static.init()
    if IsCompiletime() then
        private.show = {}
        private.show_func = print
        private.show[static.LogType.Err] = true
        private.show[static.LogType.Wrn] = true
        private.show[static.LogType.Msg] = true

        private.write = {}
        private.write_func = private.writeCompiletime
        private.write.autosave = true
        private.write.file_name = 'log.txt'
        private.write.log_dir = 'Log'
        private.write.file = assert(io.open(private.write.log_dir..package.config:sub(1,1)..private.write.file_name, "w"))
        private.write[static.LogType.Err] = true
        private.write[static.LogType.Wrn] = true
        private.write[static.LogType.Msg] = true
    else
        private.show = {}
        private.show_func = print
        private.show[static.LogType.Err] = true
        private.show[static.LogType.Wrn] = true
        private.show[static.LogType.Msg] = true

        private.write = {}
        private.write_func = private.writeRuntime
        private.write.autosave = true
        private.write.file_name = 'rename_to_bat_and_run.txt'
        private.write.file = {}
        private.write[static.LogType.Err] = true
        private.write[static.LogType.Wrn] = true
        private.write[static.LogType.Msg] = true
    end
end

---@param self LoggerClass | nil
---@param log_type LogType
---@param msg string
function static.log(self, log_type, msg)
    if type(self) == 'number' then
        msg = log_type
        log_type = self
    end

    local log_msg = private.getLogMsg(log_type, msg)

    -- Show message
    if private.show[log_type] then
        private.show_func(log_msg)
    end

    -- Add to file
    if private.write[log_type] then
        private.write_func(log_msg)
    end
end

---@param msg string
---@param level number
function static.error(msg, level)
    static.write(nil, static.LogType.Err, msg)
    error('', (level or 1) + 1)
end

--=========
-- Private
--=========

private.LogTypeMessage = {}
private.LogTypeMessage[static.LogType.Err] = 'Error'
private.LogTypeMessage[static.LogType.Wrn] = 'Warn'
private.LogTypeMessage[static.LogType.Msg] = 'Msg'

---@param log_type LogType
---@param msg string
---@return string
function private.getLogMsg(log_type, msg)
    return fmt("[%.3f] {%s} %s", Time.get(), private.LogTypeMessage[log_type], msg)
end

function private.close()
    if IsCompiletime() then
        private.compiletime.write.file:close()
    else
        PreloadGenClear()
        PreloadGenStart()
        Preload("\")\r\n\tDEL "..private.runtime.write.file_name.."\r\n\t(\"")
        for i = 1, #private.runtime.write.file do
            Preload(private.runtime.write.file[i])
        end
        Preload("\")\r\n\tstart "..private.runtime.write.file_name.."\r\n\t(\"")
        PreloadGenEnd(private.runtime.write.file_name)
    end
end

---@param full_msg string
function private.writeRuntime(full_msg)
    local log_msg = fmt("\")\r\n\techo %s >> %s \r\n\t(\"", full_msg, private.write.file_name)
    table.insert(private.write.file, log_msg)

    PreloadGenClear()
    PreloadGenStart()
    Preload("\")\r\n\tDEL "..private.write.file_name.."\r\n\t(\"")
    for i = 1, #private.write.file do
        Preload(private.write.file[i])
    end
    Preload("\")\r\n\tstart "..private.write.file_name.."\r\n\t(\"")
    PreloadGenEnd(private.write.file_name)
end

---@param full_msg string
function private.writeCompiletime(full_msg)
    private.write.file:write(full_msg)
    private.write.file:flush()
end


return static