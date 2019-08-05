InitList = {}

function InitList.init()
    for _, init_owner in pairs(InitList) do
        init_owner.init()
    end
end

function InitList.add(init_owner)
    table.insert(InitList, 0, init_owner)
end