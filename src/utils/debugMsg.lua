local Debug = {
    is_debug = true
}

function Debug.print(msg)
    for i = 0, 24 do
        DisplayTextToPlayer(Player(i), 0, 0, '[Debug]: '..msg)
    end
end

return Debug