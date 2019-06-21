''' Some info
'''

import ast_to_lua as atl
import call_lua as cl
import pathlib
import os

src_dir = '/home/bugrov/lua/concat_lua/src'
dst_dir = '/home/bugrov/lua/concat_lua/build/scripts'
module_path = 'modules/test_chat.lua'

atl.preparse_module('war3map.lua', src_dir, dst_dir)

#new_path = atl.parse_module(module_path, src_dir, dst_dir)
files_list = []
requires_list = []
content_list = []
return_list = []

done = atl.parse_list('war3map.lua', dst_dir, files_list, requires_list, content_list, return_list)
if not done:
    print('Parsing failed.')

full_content = atl.link_content(files_list, content_list)

res_path = dst_dir[:dst_dir.rfind('/')]

pathlib.Path(res_path).mkdir(parents=True, exist_ok=True)
if os.path.isfile(res_path):
    os.remove(res_path)

with open(res_path + '/war3map.lua', 'w') as file:
    file.write(full_content)

lua_content = cl.load_content(atl.node_to_str(content_list[1]))
print(lua_content)
