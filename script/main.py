''' Some info
'''

import parse_module as pm
import ast_to_string as ats
#import call_lua as cl
import pathlib
import os

src_dir = '/home/bugrov/lua/concat_lua/src'
build_dir = '/home/bugrov/lua/concat_lua/build/scripts'
module_path = 'modules/test_chat.lua'

files_list, contents_list = pm.prepare_module('war3map.lua', src_dir, build_dir)
print(files_list)

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
#with open(res_path + '/war3map.lua', 'w') as file:
#    file.write(full_content)

#lua_content = cl.load_content(ats.node_to_str(content_list[1]))
#print(lua_content)
