local test = {}

test.aaa = require('test_dir.test_dir_test')

function test.some_action(a, b)
    return a+b
end

