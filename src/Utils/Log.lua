--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

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

---@alias LogLevel string
---@type LogLevel
static.Err = 'ERROR'
---@type LogLevel
static.Wrn = 'Warning'
---@type LogLevel
static.Msg = 'Msg'

---@param log_level LogLevel
---@param header any
---@param message string
function static.write(_, log_level, header, message)
    local log_msg = private.getLogMsg(log_level, private.time(), header, message)

    -- Show message
    if private.show[log_level] then
        private.show_func(log_msg)
    end
    -- Add to file
    if private.write[log_level] then
        private.write_func(log_msg)
    end
end
local meta = getmetatable(static)
meta.__call = static.write

---@param header any
---@param message string
---@param level number
function static.error(header, message, level)
    static.write(nil, static.Err, header, message)
    error('', (level or 1) + 1)
end

function static.close()
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

--=========
-- Private
--=========

local fmt = string.format

if IsCompiletime() then
    private.show = {}
    private.show[static.Err] = true
    private.show[static.Wrn] = true
    private.show[static.Msg] = true
    private.show_func = print
    private.write = {}
    private.write.autosave = true
    private.write.file_name = 'log.txt'
    private.write.file = assert(io.open(GetSrcDir()..package.config:sub(1,1)..private.write.file_name, "w"))
    private.write[static.Err] = true
    private.write[static.Wrn] = true
    private.write[static.Msg] = true
    private.write_func = function(log_msg)
        private.write.file:write(log_msg)
        if private.write.autosave then
            private.write.file:flush()
        end
    end
else
    private = {}
    private.show = {}
    private.show[static.Err] = true
    private.show[static.Wrn] = true
    private.show[static.Msg] = true
    private.show_func = print
    private.write = {}
    private.write.autosave = true
    private.write.file_name = 'rename_to_bat_and_run.txt'
    private.write.file = {}
    private.write[static.Err] = true
    private.write[static.Wrn] = true
    private.write[static.Msg] = true
    private.write_func = function(log_msg)
        log_msg = fmt("\")\r\n\techo %s >> %s \r\n\t(\"", log_msg, private.write.file_name)
        table.insert(private.write.file, log_msg)
        if private.write.autosave then
            PreloadGenClear()
            PreloadGenStart()
            Preload("\")\r\n\tDEL "..private.write.file_name.."\r\n\t(\"")
            for i = 1, #private.write.file do
                Preload(private.write.file[i])
            end
            Preload("\")\r\n\tstart "..private.write.file_name.."\r\n\t(\"")
            PreloadGenEnd(private.write.file_name)
        end
    end
end


---@param log_level LogLevel
---@param time number
---@param header string | any
---@param str string
---@return string
function private.getLogMsg(log_level, time, header, str)
    return fmt("[%.3f] {%s} %s: %s", time, log_level, tostring(header), str)
end

if IsCompiletime() then
    private.start_time = os.time()
else
    private.current_time = 0
    TimerStart(CreateTimer(), 0.03125, true, function() private.current_time = private.current_time + 0.03125 end)
end

---@return number
function private.time()
    if IsCompiletime() then
        return os.time() - private.start_time
    else
        return private.current_time
    end
end

return static