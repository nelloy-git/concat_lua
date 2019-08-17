local Init = {}

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
        if __require_data.result[name].init ~= nil then
            local success, result = pcall(__require_data.result[name].init)
            if not success then
                Debug(string.format('Error in %s initialization\n%s', name, result))
            end
        end
    end
    Debug('Initialisation finished')
end

return Init