local File = require('compiletime_modules.we_object_editing.we_edit_file')
local WeObject = require('compiletime_modules.we_object_editing.we_object')
local WeModification = require('compiletime_modules.we_object_editing.fields.unit')

local foo = WeObject.new('A001', 'hfoo', 'unit')
print(foo)
for k, v in pairs(foo) do
    print(k, v)
end
print(foo:serialize())
local foo_name = WeModification.name('Some new footman name')
print(foo:serialize())

--
--local w3u_file = FileReader.read(__src_dir..'/war3map.w3u')
--
--local obj = ObjEdit.createObject('A001', 'hfoo')
--w3u_file = ObjEdit.writeObject(obj, w3u_file)
--print(FileReader.to_hex(w3u_file, 16))

return nil