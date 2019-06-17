local chat = {}

require('blizzard.common')

chat.text.aza = 'azaza '

--[[ 
    Some comments
--]]

function chat:wh(...)
    local a = 2
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