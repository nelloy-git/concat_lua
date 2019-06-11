''' Some info
'''

from luaparser import ast


def chunk_to_str(chunk, lvl):
    ''' Converts ast.Chunk to str.
    '''
    return chunk.body.str(lvl)


def block_to_str(block, lvl):
    ''' Converts ast.Block to str.
    '''
    lvl += 1
    s = ''
    for node in block.body:
        s += '  ' * lvl + node_to_str(node, lvl) + '\n'
    s = s[:-1]
    return s


def name_to_str(name):
    ''' Converts ast.Name to str.
    '''
    return name.id


def index_to_str(index, lvl):
    ''' Converts ast.Index to str.
    '''
    return node_to_str(index.value, lvl) + '.' + string_to_str(index.idx, lvl)[1:-1]


def assign_to_str(assign, lvl):
    ''' Converts ast.Assign to str.
    '''
    s_targ = ''
    for node in assign.targets:
        s_targ += node_to_str(node, lvl) + ', '
    s_targ = s_targ[:-2]

    s_val = ''
    for node in assign.values:
        s_val += node_to_str(node, lvl) + ', '
    s_val = s_val[:-2]

    return s_targ + ' = ' + s_val


def loc_assign_to_str(assign, lvl):
    ''' Converts ast.LocalAssign to str.
    '''
    s_targ = ''
    for node in assign.targets:
        s_targ += node_to_str(node, lvl) + ', '
    s_targ = s_targ[:-2]

    s_val = ''
    for node in assign.values:
        s_val += node_to_str(node, lvl) + ', '
    s_val = s_val[:-2]

    return 'local ' + s_targ + ' = ' + s_val


def node_to_str(node, lvl):
    ''' Converts node to string
    '''
    if isinstance(node, ast.Block):
        return block_to_str(node, lvl)
    if isinstance(node, ast.Chunk):
        return chunk_to_str(node, lvl)
    if isinstance(node, ast.Name):
        return name_to_str(node)
    


path = './src/war3map.lua'

with open(path, 'r') as file:
    data = file.read()
tree = ast.parse(data)
#print(ast.to_pretty_str(tree))

print(tree.body.str(-1))
    