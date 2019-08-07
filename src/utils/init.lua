local Init = {}

function Init.start()
    for name, _ in __require_data.module do
        __require_data.result[name] = __require_data.module[name]()
        if __require_data.result[name].init ~= nil then
            __require_data.result[name].init()
        end
        __require_data.loaded[name] = true
    end
end

return Init