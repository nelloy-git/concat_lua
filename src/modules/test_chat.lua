local chat = {}

require('blizzard.common')

chat.text.aza = 'azaza '

--[[ 
    Some comments
--]]

local function print(msg)
    -- One line comments
    DisplayTextToPlayer(Player(0),
                        1,
                        0,
                        chat.text.aza..msg)

    local c = function () return 5 end
end

chat.print = print(msg)

return chat