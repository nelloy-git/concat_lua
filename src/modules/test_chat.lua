local chat = {}

require('blizzard.common')

function chat.print(msg)
    DisplayTextToPlayer(Player(0), 0, 0, msg)
end

return chat