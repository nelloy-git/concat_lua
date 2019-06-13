from luaparser import ast


def chunk_to_str(node, lvl):
    ''' Converts ast.Chunk to str. '''
    return node_to_str(node.body, lvl)


def block_to_str(node, lvl=0):
    ''' Converts ast.Block to str. '''
    s = ''
    for line in node.body:
        s += '  ' * lvl + node_to_str(line, lvl + 1) + '\n'
    s = s[:-1]
    return s


def name_to_str(node, _):
    ''' Converts ast.Name to str. '''
    return node.id


def index_to_str(node, lvl):
    ''' Converts ast.Index to str. '''
    if isinstance(node.idx, ast.String):
        return node_to_str(node.value, lvl) + '.' + node_to_str(node.idx, lvl)[1:-1]
    return node_to_str(node.value, lvl) + '[' + node_to_str(node.idx, lvl) + ']'


def assign_to_str(node, lvl):
    ''' Converts ast.Assign to str. '''
    s_targ = ''
    for targ in node.targets:
        s_targ += node_to_str(targ, lvl) + ', '
    s_targ = s_targ[:-2]

    s_val = ''
    for val in node.values:
        s_val += node_to_str(val, lvl) + ', '
    s_val = s_val[:-2]

    return s_targ + ' = ' + s_val


def loc_assign_to_str(node, lvl):
    ''' Converts ast.LocalAssign to str. '''
    s_targ = ''
    for targ in node.targets:
        s_targ += node_to_str(targ, lvl) + ', '
    s_targ = s_targ[:-2]

    s_val = ''
    for val in node.values:
        s_val += node_to_str(val, lvl) + ', '
    s_val = s_val[:-2]

    return 'local ' + s_targ + ' = ' + s_val


def while_to_str(node, lvl):
    ''' Converts ast.While to str. '''
    return 'while(' + node_to_str(node.test) + ') do\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def do_to_str(node, lvl):


def repeat_to_str(node, lvl):


def elseIf_to_str(node, lvl):


def if_to_str(node, lvl):


def label_to_str(node, lvl):


def goto_to_str(node, lvl):


def semiColon_to_str(node, lvl):


def break_to_str(node, lvl):


def return_to_str(node, lvl):


def fornum_to_str(node, lvl):


def forin_to_str(node, lvl):


def call_to_str(node, lvl):


def invoke_to_str(node, lvl):




def func_to_str(node, lvl):
    ''' Converts ast.Function to str. '''
    s_arg = ''
    for arg in node.args:
        s_arg += node_to_str(arg) + ', '
    s_arg = s_arg[:-2]

    return 'function ' + node_to_str(node.name, lvl) + '(' + s_arg + ')\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def loc_func_to_str(node, lvl):
    ''' Converts ast.LocalFunction to str. '''
    s_arg = ''
    for arg in node.args:
        s_arg += node_to_str(arg) + ', '
    s_arg = s_arg[:-2]
    return 'local function ' + node_to_str(node.name, lvl) + '(' + s_arg + ')\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def method_to_str(node, lvl):
    ''' Converts ast.Method to str. '''
    s_arg = ''
    for arg in node.args:
        s_arg += node_to_str(arg) + ', '
    s_arg = s_arg[:-2]

    return 'function ' + node_to_str(node.source, lvl) + ':' + node_to_str(node.name, lvl) + '(' + s_arg + ')\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def nil_to_str(node, lvl):
    ''' Converts ast.Nil to str. '''
    return 'nil'


def true_expr_to_str(node, lvl):
    ''' Converts ast.TrueExpr to str. '''
    return '=='


def false_expr_to_str(node, lvl):
    ''' Converts ast.TrueExpr to str. '''
    return '!='


def number_to_str(node, lvl):
    ''' Converts ast.Number to str. '''
    return str(node.n)


def varargs_to_str(node, lvl):
    ''' Converts ast.Varargs to str. '''
    return '...'


def string_to_str(node, lvl):
    ''' Converts ast.String to str. '''
    return '\'' + node.s + '\''


def field_to_str(node, lvl):
    ''' Converts ast.Field to str. '''
    return node_to_str(node.key) + ' = ' + node_to_str(node.value)


def table_to_str(table, lvl):
    ''' Converts ast.Table to str. '''
    s_fields = ''
    for field in table.fields:
        s_fields += node_to_str(field, lvl) + ', '
    s_fields = s_fields[:-2]


    return '{' + s_fields + '}'


def dots_to_str(table, lvl):
    ''' Converts ast.Dots to str. '''
    return 'Can not parse dots'


def anon_func_to_str(func, lvl):
    ''' Converts ast.AnonymousFunction to str. '''
    s_arg = ''
    for arg in func.args:
        s_arg += node_to_str(arg) + ', '
    s_arg = s_arg[:-2]

    return 'function(' + s_arg + ')\n' + node_to_str(func.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'





switcher = [
    (ast.Chunk, chunk_to_str),
    (ast.Block, block_to_str),
    (ast.Name, name_to_str),
    (ast.Index, index_to_str),
    (ast.Assign, assign_to_str),
    (ast.LocalAssign, loc_assign_to_str),
    (ast.While, while_to_str),

    (ast.Do, do_to_str),
    (ast.Repeat, repeat_to_str),
    (ast.ElseIf, elseIf_to_str),
    (ast.If, if_to_str),
    (ast.Label, label_to_str),
    (ast.Goto, goto_to_str),
    (ast.SemiColon, semiColon_to_str),
    (ast.Break, break_to_str),
    (ast.Return, return_to_str),
    (ast.Fornum, fornum_to_str),
    (ast.Forin, forin_to_str),
    (ast.Call, call_to_str),
    (ast.Invoke, invoke_to_str),

    (ast.Function, func_to_str),
    (ast.LocalFunction, loc_func_to_str),
    (ast.Method, method_to_str),
    (ast.Nil, nil_to_str),
    (ast.TrueExpr, true_expr_to_str),
    (ast.FalseExpr, false_expr_to_str),
    (ast.Number, number_to_str),
    (ast.Varargs, varargs_to_str),
    (ast.String, string_to_str),
    (ast.Field, field_to_str),
    (ast.Table, table_to_str),
    (ast.Dots, dots_to_str),
    (ast.AnonymousFunction, anon_func_to_str)
]


def node_to_str(node, lvl=0):
    ''' Converts node to string. '''
    for i in range(0, len(switcher)):
        if isinstance(node, switcher[i][0]):
            return switcher[i][1](node, lvl)
    return 'Not parsed'
