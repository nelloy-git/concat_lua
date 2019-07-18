local WeFile = require('compiletime.we_object_editing.we_edit_file')
local WeUnit = require('compiletime.we_object_editing.objects.unit')
local utils = require('compiletime.we_object_editing.utils')

local foo = WeUnit.new('h001', 'hpea')
foo:setName('Test footman')

local w3u = WeFile.readFromSrc('unit')
w3u:add(foo)
w3u:writeToDst()

local w3a = WeFile.readFromSrc('ability')
print(utils.byte2hex(w3a.content, 16))

return nil