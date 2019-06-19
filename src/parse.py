''' Some info
'''

import ast_to_lua as atl

src_dir = '/home/bugrov/lua/concat_lua/src'
dst_dir = '/home/bugrov/lua/concat_lua/build/scripts'
module_path = 'modules/test_chat.lua'

atl.parse_module(module_path, src_dir, dst_dir)
    