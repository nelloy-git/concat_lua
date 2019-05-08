local modules_test_chat = {}


local function print(msg)
    DisplayTextToPlayer(Player(0), 0, 0, msg)
end

modules_test_chat.print = print(msg)

return modules_test_chat