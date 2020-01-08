---Globals have to be loaded and initialized first.
local Globals = require('utils.Globals')
local Settings = require('utils.Settings')

if not lua_wc3.isCompiletime() then

    local success, result = pcall(Globals.init)
    if not success then
        Debug(string.format('Error in loading %s\n%s', 'Globals', result))
        return nil
    end

    --for name, _ in pairs(__require_data.module) do
    --    if not  __require_data.loaded[name] then
    --        local success, result = pcall(__require_data.module[name])
    --        if success then
    --            __require_data.result[name] = result
    --            __require_data.loaded[name] = true
    --        else
    --            Debug(string.format('Error in loading %s\n%s', name, result))
    --        end
    --    end
    --    if __require_data.result[name] ~= nil then
    --        if type(__require_data.result[name].initFile) == 'function' then
    --            local success, result = pcall(__require_data.result[name].initFile)
    --            if not success then
    --                Debug(string.format('Error in %s initialization\n%s', name, result))
    --            end
    --        end
    --    end
    --end

    Debug('Initialisation finished')

    --if Settings.debug then
    --    for name, _ in pairs(__require_data.module) do
    --        if type(__require_data.result[name].initFile) == 'function' then
    --            __require_data.result[name].selfTest()
    --        end
    --    end
    --end
end