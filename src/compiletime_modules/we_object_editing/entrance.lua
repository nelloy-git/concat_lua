local File = require('compiletime_modules.we_object_editing.we_edit_file')
local WeObject = require('compiletime_modules.we_object_editing.we_object')
local WeModification = require('compiletime_modules.we_object_editing.fields.unit')
local utils = require('compiletime_modules.we_object_editing.utils')

local foo = WeObject.new('A001', 'hfoo', 'unit')
--print(foo:serialize())
local foo_name = WeModification.name('Some new footman name')
foo:addModification(foo_name)
local w3u = File.read(src_dir .. '\\' .. 'war3map.w3u')
w3u:add(foo)
print(utils.byte2hex(w3u.content, 16))
w3u:write(dst_dir .. '\\' .. 'war3map.w3u')

--
--local w3u_file = FileReader.read(__src_dir..'/war3map.w3u')
--
--local obj = ObjEdit.createObject('A001', 'hfoo')
--w3u_file = ObjEdit.writeObject(obj, w3u_file)
--print(FileReader.to_hex(w3u_file, 16))

return nil