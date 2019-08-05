local InitList = {
    list = {}
}

function InitList.init()
    TriggerSleepAction(0)
    print('Initialization start.')
    for k, init_owner in ipairs(InitList.list) do
            print(k)
        if init_owner.init ~= nil then
            init_owner.init()
        end
    end
    print('Initialization finished.')
end

function InitList.add(init_owner)
    table.insert(InitList.list, 0, init_owner)
end

return InitList