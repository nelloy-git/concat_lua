local Log = {}

local is_runtime = not IsCompiletime()
local ctime = {
    show_errors = true,
    show_warnings = true,
    show_messages = true,

    use_log_file = true,
    file_name = 'log.txt',
    file_link = nil
}

local rtime = {
    show_errors = true,
    show_errors_time = 60,
    show_warnings = true,
    show_warnings_time = 45,
    show_messages = true,
    show_messages_time = 30,

    use_log_file = true,
    file_name = 'change_format_to_bat_and_run.txt',
    timer = nil,
    file_autosave = true,
    buffer = {}
}

local fmt = string.format

local start_time = 0
local cur_time = 0

-- Initialization
if is_runtime then
    rtime.timer = CreateTimer()

    local loop
    loop = function ()
        cur_time = cur_time + 0.03125
        TimerStart(rtime.timer, 0.03125, false, loop)
    end
    loop()
else
    start_time = os.clock()
    if ctime.use_log_file then
        local path = GetSrcDir()..package.config:sub(1,1)..ctime.file_name
        ctime.file_link = assert(io.open(path, "w"))
        ctime.file_link:write(fmt("[%0.3f] %s\n", os.clock() - start_time, "Logging started"))
        
        AddCompileFinal(function()
            ctime.file_link:write(fmt("[%0.3f] %s", os.clock() - start_time, "Logging finished"))
            ctime.file_link:close()
        end)
    end
end

---@return number
local function getTime()
    if is_runtime then
        return cur_time - start_time
    else
        return os.clock() - start_time
    end
end

---@param log_level LogLevel
---@param header string | any
---@param str string
---@return string
local function getFullStr(log_level, header, str)
    return fmt("[%.3f] {%s} %s: %s", getTime(), log_level, tostring(header), str)
end

---@param full_str string
---@return string
local function convertToBat(full_str)
    return fmt("\")\r\n\techo %s >> %s \r\n\t(\"", full_str, rtime.file_name)
end

local function saveFileRuntime()
    PreloadGenClear()
    PreloadGenStart()
    Preload("\")\r\n\tDEL "..rtime.file_name.."\r\n\t(\"")
    for i = 1, #rtime.buffer do
        Preload(convertToBat(rtime.buffer[i]))
    end
    Preload("\")\r\n\tstart "..rtime.file_name.."\r\n\t(\"")
    PreloadGenEnd(rtime.file_name)
end

---@param log_level LogLevel
---@param header string | any
---@param str string
function Log.write(log_level, header, str)
    local full_str = getFullStr(log_level, header, str)
    if is_runtime then
        if rtime.use_log_file then
            table.insert(rtime.buffer, #rtime.buffer + 1, convertToBat(full_str))
            if rtime.file_autosave then
                saveFileRuntime()
            end
        end

        if log_level == Log.Err and rtime.show_errors then
            DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, rtime.show_errors_time, full_str)
        elseif log_level == Log.Warn and rtime.show_warnings then
            DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, rtime.show_warnings_time, full_str)
        elseif log_level == Log.Msg and rtime.show_messages then
            DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, rtime.show_messages_time, full_str)
        end
    else
        if log_level == Log.Err and ctime.show_errors then
            print(full_str)
        elseif log_level == Log.Warn and ctime.show_warnings then
            print(full_str)
        elseif log_level == Log.Msg and ctime.show_messages then
            print(full_str)
        end

        if ctime.use_log_file then
            ctime.file_link:write(full_str..'\n')
        end
    end
end

function Log.manualRuntimeSave()
    saveFileRuntime()
end

---@alias LogLevel string

---@type LogLevel
Log.Err = 'ERROR'
---@type LogLevel
Log.Warn = 'Warning'
---@type LogLevel
Log.Msg = 'Message'

---@overload fun(message:string, level:number)
---@param prefix any
---@param message string
---@param level number | nil
function Error(prefix, message, level)
    Log.write(Log.Err, prefix, message)
    error(tostring(prefix)..': '..message, (level or 0) + 1)
end

setmetatable(Log, {__call = function(self, log_level, header, str) self.write(log_level, header, str) end})
return Log