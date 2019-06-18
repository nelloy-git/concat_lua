from luaparser import ast


def get_vars_from_block(node, cur_globals):
    ''' Returns lists of used local and global variables. '''
    loc_vars = []
    gl_vars = []
    for line in node.body:
        loc, glob = get_vars(line, cur_globals)
        loc_vars.append(loc)
        gl_vars.append(glob)
    return loc_vars, gl_vars


def get_vars_from_loc_assign(node, cur_globals):
    ''' Returns lists of used local and global variables. '''
    loc_values = []
    gl_values = []
    for val in node.values:
        loc, glob = get_vars(val, cur_globals)
        loc_values.append(loc)
        gl_values.append(glob)

    loc_targets = []
    for targ in node.targets:

    return node.targets, []


def get_vars(node, cur_globals):
    loc_vars = []
    gl_vars = []

    return loc_vars, gl_vars