local Log = {}

local show_compiletime_errors = true
local show_compiletime_warnings = true
local show_compiletime_messages = true
local show_runtime_errors = true
local show_runtime_warnings = true
local show_runtime_messages = true
local log_file_compiletime = true
local log_file_compiletime_name = 'log.txt'
local log_file_runtime = false

local fmt = string.format

local start_time
local file_path
local log_file

if is_compiletime then
    start_time = os.clock()
    file_path = _G._dst_dir..package.config:sub(1,1)..log_file_compiletime_name
    log_file = assert(io.open(file_path, "w"))
    log_file:write(fmt("[%0.3f] %s\n", os.clock() - start_time, "Logging started"))
    addCompiletimeFinalize(function()
        log_file:write(fmt("[%0.3f] %s\n", os.clock() - start_time, "Logging finished"))
        log_file:close()
    end)
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

local function runtime_print(time, ...)
    local s = ''
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        local t = type(v)
        if t == 'nil' then
            v = 'nil'
        elseif t == 'userdata' then
            v = 'userdata'
        elseif t == 'string' then
            v = v
        elseif t == 'integer' or t == 'number' then
            v = tostring(v)
        elseif t == 'table' or t == 'function' then
            v = tostring(v)
        else
            v = ''
        end
        s = string.format(s..' '..v)
    end

    DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, s)
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
        if show_compiletime_errors then
            runtime_print(full_str)
        end
    elseif log_level == Log.Warn then
        if show_compiletime_warnings then
            runtime_print(full_str)
        end
    elseif log_level == Log.Msg then
        if show_compiletime_messages then
            runtime_print(full_str)
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

---@alias LogLevel string

---@type LogLevel
Log.Err = 'err'
---@type LogLevel
Log.Warn = 'warn'
---@type LogLevel
Log.Msg = 'msg'

setmetatable(Log, {__call = function(self, log_level, header, str) self.write(log_level, header, str) end})
return Log