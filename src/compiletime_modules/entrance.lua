local FileReader = require('compiletime_modules.file_reader')
local ObjEdit = require('compiletime_modules.wc3_object')

local w3u_file = FileReader.read(__src_dir..'\\war3map.w3u')

local obj = ObjEdit.createObject('A001', 'hfoo')
w3u_file = ObjEdit.writeObject(obj, w3u_file)
print(FileReader.to_hex(w3u_file, 16))

return nil