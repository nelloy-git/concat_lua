local chat = {}

require('blizzard.common')

chat.text.aza = 'azaza '

--[[ 
    Some comments
--]]

function chat:wh(...)
    local arg = {...}
    local t = function () arg = {} end
end

chat.print = print(msg)

return chat