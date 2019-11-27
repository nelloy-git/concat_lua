local Log = {}

local show_compiletime_errors = true
local show_compiletime_warnings = true
local show_compiletime_messages = true
local show_runtime_errors = true
local show_runtime_warnings = true
local show_runtime_messages = true
local log_file_compiletime = true
local log_file_compiletime_name = 'log.txt'
local log_file_runtime = true
local log_file_runtime_autosave = true
local log_file_runtime_name = 'log.txt'
local log_file_runtime_buffer = {}

local fmt = string.format

local timer
local start_time
local cur_time
local file_path
local log_file
local loop

if is_compiletime then
    start_time = os.clock()
    file_path = _G._dst_dir..package.config:sub(1,1)..log_file_compiletime_name
    log_file = assert(io.open(file_path, "w"))
    log_file:write(fmt("[%0.3f] %s\n", os.clock() - start_time, "Logging started"))
    addCompiletimeFinalize(function()
        log_file:write(fmt("[%0.3f] %s\n", os.clock() - start_time, "Logging finished"))
        log_file:close()
    end)
else
    timer = CreateTimer()
    cur_time = 0
    loop = function ()
        cur_time = cur_time + 0.03125
        TimerStart(timer, 0.03125, false, loop)
    end
    loop()
    start_time = 0
end

local function getLineFileRuntime(str)
    return fmt("\")\r\n\techo [%.3f] %s >> %s \r\n\t(\"", cur_time, str, log_file_runtime_name)
end

local function saveFileRuntime()
    PreloadGenClear()
    PreloadGenStart()
    Preload("\")\r\n\tDEL "..log_file_runtime_name.."\r\n\t(\"")
    for i = 1, #log_file_runtime_buffer do
        Preload(getLineFileRuntime(log_file_runtime_buffer[i]))
    end
    Preload("\")\r\n\tstart "..log_file_runtime_name.."\r\n\t(\"")
    PreloadGenEnd(log_file_runtime_name)
end

---@param log_level LogLevel
---@param header string | any
---@param str string
---@return string
local function getFullStr(log_level, header, str)
    if log_level == Log.Err then
        return string.format('%s ERROR: %s', tostring(header), str)
    elseif log_level == Log.Warn then
        return string.format('%s Warning: %s', tostring(header), str)
    elseif log_level == Log.Msg then
        return string.format('%s Message: %s', tostring(header), str)
    else
        return nil
    end
end

local function runtime_print(full_str)
    local msg = fmt("[%0.3f] %s\n", cur_time, full_str)
    DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, msg)
end

local function log_compiletime(log_level, full_str)
    if log_level == Log.Err then
        if show_compiletime_errors then
            print(full_str)
        end
    elseif log_level == Log.Warn then
        if show_compiletime_warnings then
            print(full_str)
        end
    elseif log_level == Log.Msg then
        if show_compiletime_messages then
            print(full_str)
        end
    end

    if log_file_compiletime then
        log_file:write(fmt("[%0.3f] %s\n", os.clock() - start_time, full_str))
    end
end

local function log_runtime(log_level, full_str)
    if log_level == Log.Err then
        if show_runtime_errors then
            runtime_print(full_str)
        end
    elseif log_level == Log.Warn then
        if show_runtime_warnings then
            runtime_print(full_str)
        end
    elseif log_level == Log.Msg then
        if show_runtime_messages then
            runtime_print(full_str)
        end
    end

    if log_file_runtime then
        table.insert(log_file_runtime_buffer, #log_file_runtime_buffer + 1, getLineFileRuntime(full_str))
        if log_file_runtime_autosave then
            saveFileRuntime()
        end
    end
end

---@param log_level LogLevel
---@param header string | any
---@param str string
function Log.write(log_level, header, str)
    local full_str = getFullStr(log_level, header, str)
    if is_compiletime then
        log_compiletime(log_level, full_str)
    else
        log_runtime(log_level, full_str)
    end
end

function Log.manualRuntimeSave()
    saveFileRuntime()
end

---@alias LogLevel string

---@type LogLevel
Log.Err = 'err'
---@type LogLevel
Log.Warn = 'warn'
---@type LogLevel
Log.Msg = 'msg'

setmetatable(Log, {__call = function(self, log_level, header, str) self.write(log_level, header, str) end})
return Log