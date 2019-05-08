local chat = {}

require('blizzard.common')

local function print(msg)
    DisplayTextToPlayer(Player(0), 0, 0, msg)
end

chat.print = print(msg)

return chat