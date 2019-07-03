''' Some info
'''

import parse_module as pm
import ast_to_string as ats
import call_lua as cl
import pathlib
import os

from luaparser import ast

src_dir = '/home/bugrov/lua/concat_lua/src'
build_dir = '/home/bugrov/lua/concat_lua/build'
module_path = 'modules/test_chat.lua'

file_list = []
content_list = []
pm.read_content('war3map.lua', src_dir, file_list, content_list)
file_list.reverse()
content_list.reverse()

print('Used files:')
for f in file_list:
    print('  ' + f)

for i, file_path in enumerate(file_list):
    pm.fix_content_return(file_path, content_list[i])

full_content = pm.link_content(file_list, content_list)
pm.compiletime_execution(full_content)

with open(build_dir + '/war3map.lua', 'w') as file:
    file.write(ats.node_to_str(full_content))

#print(ats.node_to_str(require_func))

#new_path = pm.parse_module(module_path, src_dir, dst_dir)
#files_list = []
#requires_list = []
#content_list = []
#return_list = []
#
#done = pm.parse_list('war3map.lua', build_dir, files_list, requires_list, content_list, return_list)
#if not done:
#    print('Parsing failed.')
#
#full_content = pm.link_content(files_list, content_list)
#
#res_path = build_dir[:build_dir.rfind('/')]
#
#pathlib.Path(res_path).mkdir(parents=True, exist_ok=True)
#if os.path.isfile(res_path):
#    os.remove(res_path)
#

#lua_content = cl.load_content(ats.node_to_str(content_list[1]))
#print(lua_content)
