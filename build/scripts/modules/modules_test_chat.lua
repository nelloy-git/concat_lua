
-- Module modules_test_chat --

local modules_test_chat_chat = {}
modules_test_chat_chat.text.aza = 'azaza '
local modules_test_chat_b = 1
modules_test_chat_chat.b = 1
function modules_test_chat_chat:wh(a)
  local a = 2
  modules_test_chat_chat.b = modules_test_chat_b+1
  a = 1+1
  a = 1-1
  a = 1*1
  a = 1/1
  a = 1//1
  a = 1%1
  a = 1^1
end
modules_test_chat_chat.print = print(msg)
return modules_test_chat_chat