local chat = {}
local b = 'azaz'

chat.f = compiletime(
    function() 
        return {a = 0, b = b}
    end)

chat.c = compiletime('string')

local function return_2()
    return 2
end

function chat:wh(a)
    local a = 2
    chat.b = b + 1
    a = 1 + 1
    a = 1 - 1
    a = 1 * 1
    a = 1 / 1
    a = 1 % 1
    a = 1 ^ 1
end

--chat.print = print(msg)

return chat