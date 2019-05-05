local M = {}

M.aaa = require('test_dir.test')

function M.some_action(a, b)
    return a+b
end

return M