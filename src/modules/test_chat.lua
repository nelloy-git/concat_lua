local chat = {}

chat.text.aza = 'azaza '

--[[ 
    Some comments
--]]

local b = 1
chat.b = 1

function chat:wh(a)
    local a = 2
    chat.b = b + 1
    a = 1 + 1
    a = 1 - 1
    a = 1 * 1
    a = 1 / 1
    a = 1 // 1
    a = 1 % 1
    a = 1 ^ 1
end

chat.print = print(msg)

return chat