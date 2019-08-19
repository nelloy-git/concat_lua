local Init = {}

---Globals have to be loaded and initialized first.
local Globals = require('utils.global')
Globals.init()

function Init.start()
    for name, _ in pairs(__require_data.module) do
        Debug(name)
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

    if Settings.testTimer then glTimer.test() end
end

return Init