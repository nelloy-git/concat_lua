''' Some info
'''

from luaparser import ast
import ast_to_lua as atl

path = './src/modules/test_chat.lua'

with open(path, 'r') as file:
    data = file.read()
tree = ast.parse(data)

print(ast.to_pretty_str(tree))

print(atl.node_to_str(tree))
    