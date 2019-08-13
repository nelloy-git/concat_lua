local Init = {}

function Init.start()
    for name, _ in pairs(__require_data.module) do
        if not  __require_data.loaded[name] then
            __require_data.result[name] = __require_data.module[name]()
            __require_data.loaded[name] = true
        end
        if __require_data.result[name].init ~= nil then
            debug(name)
            __require_data.result[name].init()
        end
    end
    debug('Initialisation finished')
end

return Init