local modules_test_chat_chat = {}
local modules_test_chat_b = 1
modules_test_chat_chat.b = 1
function return_2()
  return 2
end
function modules_test_chat_chat:wh(a)
  local a = 2
  modules_test_chat_chat.b = modules_test_chat_b+1
  a = 1+1
  a = 1-1
  a = 1*1
  a = 1/1
  a = 1%1
  a = 1^1
end
return modules_test_chat_chat