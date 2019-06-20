''' Some info
'''

import ast_to_lua as atl

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

atl.link_content(dst_dir[:dst_dir.rfind('/')] + '/war3map.lua', files_list, content_list)
