local WeFile = require('compiletime.we_object_editing.we_edit_file')
local WeUnit = require('compiletime.we_object_editing.objects.unit')

local foo = WeUnit.new('h001', 'hpea')
foo:setName('Test footman')

local w3u = WeFile.readFromSrc('unit')
w3u:add(foo)
w3u:writeToDst()

return nil