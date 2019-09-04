local Init = {}

---Globals have to be loaded and initialized first.
local Globals = require('utils.Globals')
if not is_compiletime then
    Globals.init()
end

function Init.start()
    for name, _ in pairs(__require_data.module) do
        if not  __require_data.loaded[name] then
            local success, result = pcall(__require_data.module[name])
            if success then
                __require_data.result[name] = result
                __require_data.loaded[name] = true
            else
                Debug(string.format('Error in loading %s\n%s', name, result))
            end

        end
        if __require_data.result[name] ~= nil then
            if __require_data.result[name].init ~= nil then
                local success, result = pcall(__require_data.result[name].init)
                if not success then
                    Debug(string.format('Error in %s initialization\n%s', name, result))
                end
            end
        end
    end
    Debug('Initialisation finished')

    -- Tests

    ---@type Settings
    local Settings = require('utils.Settings')

    if Settings.Timer.run_test then
        ---@type Timer
        local Timer = require("utils.timer.Timer")
        Debug("Timer test.")
        local success, result = pcall(Timer.test)
        if not success then
            Debug(result)
        end
    end
end

return Init