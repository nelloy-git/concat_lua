import os
import pathlib
from luaparser import ast


def chunk_to_str(node, lvl):
    ''' Converts ast.Chunk to str. '''
    return node_to_str(node.body, lvl)


def block_to_str(node, lvl=0):
    ''' Converts ast.Block to str. '''
    s = ''
    loc_vars = []
    for line in node.body:
        if type(line) == ast.LocalAssign:
            for var in line.targets:
                loc_vars.append(node_to_str(var, lvl))

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

    if s_val != '':
        s_targ += ' = '

    return s_targ + s_val


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

    if s_val != '':
        s_targ += ' = '

    return 'local ' + s_targ + s_val


def while_to_str(node, lvl):
    ''' Converts ast.While to str. '''
    return 'while(' + node_to_str(node.test) + ') do\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def do_to_str(node, lvl):
    ''' Converts ast.Do to str. '''
    return 'do\n' + node_to_str(node, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def repeat_to_str(node, lvl):
    ''' Converts ast.Repeat to str. '''
    return 'repeat\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'until(' + node_to_str(node.test, lvl) + ')'


def else_if_to_str(node, lvl):
    ''' Converts ast.ElseIf to str. '''
    s_if = 'elseif (' + node_to_str(node.test, lvl) + ') then\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1))
    if node.orelse is not None:
        if isinstance(node.orelse, ast.ElseIf):
            s_if += node_to_str(node.orelse, lvl) + '\n'
        else:
            s_if += 'else\n' + node_to_str(node.orelse, lvl) + '\n'
            s_if += ('  ' * (lvl-1)) + 'end'
    else:
        s_if += 'end'
    return s_if


def if_to_str(node, lvl):
    ''' Converts ast.If to str. '''
    s_if = 'if (' + node_to_str(node.test, lvl) + ') then\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1))
    if node.orelse is not None:
        if isinstance(node.orelse, ast.ElseIf):
            s_if += node_to_str(node.orelse, lvl) + '\n'
        else:
            s_if += 'else\n' + node_to_str(node.orelse, lvl) + '\n'
            s_if += ('  ' * (lvl-1)) + 'end'
    else:
        s_if += 'end'
    return s_if


def label_to_str(node, lvl):
    ''' Converts ast.Label to str. '''
    return '::' + node.id + '::'


def goto_to_str(node, lvl):
    ''' Converts ast.Goto to str. '''
    return 'goto ' + node_to_str(node.label, lvl)


def semicolon_to_str(node, lvl):
    ''' Converts ast.SemiColon to str. '''
    return ''


def break_to_str(node, lvl):
    ''' Converts ast.Break to str. '''
    return 'break'


def return_to_str(node, lvl):
    ''' Converts ast.Return to str. '''
    s_val = ''
    for val in node.values:
        s_val += node_to_str(val, lvl) + ', '
    s_val = s_val[:-2]

    return 'return ' + s_val


def fornum_to_str(node, lvl):
    ''' Converts ast.Fornum to str. '''
    s_for = 'for ' + node_to_str(node.target, lvl) + ' = ' + node_to_str(node.start, lvl) + ', ' + node_to_str(node.stop, lvl)
    if node.step != 1:
        s_for += ', ' + node_to_str(node.step, lvl)
    s_for += ' do\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'
    return s_for


def forin_to_str(node, lvl):
    ''' Converts ast.Forin to str. '''
    s_for = 'for ' + node_to_str(node.targets, lvl) + ' in ' + node_to_str(node.iter) + ' do\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'
    return s_for


def call_to_str(node, lvl):
    ''' Converts ast.Call to str. '''
    s_arg = ''
    for arg in node.args:
        s_arg += node_to_str(arg, lvl) + ', '
    s_arg = s_arg[:-2]
    return node_to_str(node.func) + '(' + s_arg + ')'


def invoke_to_str(node, lvl):
    ''' Converts ast.invoke to str. '''
    return ''


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
    return 'true'


def false_expr_to_str(node, lvl):
    ''' Converts ast.TrueExpr to str. '''
    return 'false'


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


def table_to_str(node, lvl):
    ''' Converts ast.Table to str. '''
    s_fields = ''
    for field in node.fields:
        s_fields += node_to_str(field, lvl) + ', '
    s_fields = s_fields[:-2]
    return '{' + s_fields + '}'


def dots_to_str(node, lvl):
    ''' Converts ast.Dots to str. '''
    return 'Can not parse dots'


def anon_func_to_str(node, lvl):
    ''' Converts ast.AnonymousFunction to str. '''
    s_arg = ''
    for arg in node.args:
        s_arg += node_to_str(arg) + ', '
    s_arg = s_arg[:-2]

    return 'function(' + s_arg + ')\n' + node_to_str(node.body, lvl) + '\n' + ('  ' * (lvl-1)) + 'end'


def add_to_str(node, lvl):
    ''' Converts ast.AddOp to str. '''
    return node_to_str(node.left, lvl) + '+' + node_to_str(node.right, lvl)


def sub_to_str(node, lvl):
    ''' Converts ast.SubOp to str. '''
    return node_to_str(node.left, lvl) + '-' + node_to_str(node.right, lvl)


def mult_to_str(node, lvl):
    ''' Converts ast.MultOp to str. '''
    return node_to_str(node.left, lvl) + '*' + node_to_str(node.right, lvl)


def float_div_to_str(node, lvl):
    ''' Converts ast.FloatDivOp to str. '''
    return node_to_str(node.left, lvl) + '/' + node_to_str(node.right, lvl)


def floor_div_to_str(node, lvl):
    ''' Converts ast.FloorDivOp to str. '''
    return node_to_str(node.left, lvl) + '//' + node_to_str(node.right, lvl)


def mod_to_str(node, lvl):
    ''' Converts ast.ModOp to str. '''
    return node_to_str(node.left, lvl) + '%' + node_to_str(node.right, lvl)


def expo_to_str(node, lvl):
    ''' Converts ast.Dots to str. '''
    return node_to_str(node.left, lvl) + '^' + node_to_str(node.right, lvl)


def and_bit_to_str(node, lvl):
    ''' Converts ast.BandOp to str. '''
    return node_to_str(node.left, lvl) + '&' + node_to_str(node.right, lvl)


def or_bit_to_str(node, lvl):
    ''' Converts ast.BorOp to str. '''
    return node_to_str(node.left, lvl) + '|' + node_to_str(node.right, lvl)


def xor_bit_to_str(node, lvl):
    ''' Converts ast.BxorOp to str. '''
    return node_to_str(node.left, lvl) + '^^' + node_to_str(node.right, lvl)


def shiftr_bit_to_str(node, lvl):
    ''' Converts ast.BshiftROp to str. '''
    return node_to_str(node.left, lvl) + ' >> ' + node_to_str(node.right, lvl)


def shiftl_bit_to_str(node, lvl):
    ''' Converts ast.BshiftLOp to str. '''
    return node_to_str(node.left, lvl) + ' << ' + node_to_str(node.right, lvl)


def less_to_str(node, lvl):
    ''' Converts ast.LessThanOp to str. '''
    return node_to_str(node.left, lvl) + ' < ' + node_to_str(node.right, lvl)


def greater_to_str(node, lvl):
    ''' Converts ast.GreaterThanOp to str. '''
    return node_to_str(node.left, lvl) + ' > ' + node_to_str(node.right, lvl)


def less_or_eq_to_str(node, lvl):
    ''' Converts ast.LessOrEqThanOp to str. '''
    return node_to_str(node.left, lvl) + ' <= ' + node_to_str(node.right, lvl)


def greater_or_eq_to_str(node, lvl):
    ''' Converts ast.GreaterOrEqThanOp to str. '''
    return node_to_str(node.left, lvl) + ' >= ' + node_to_str(node.right, lvl)


def equal_to_str(node, lvl):
    ''' Converts ast.EqToOp to str. '''
    return node_to_str(node.left, lvl) + ' == ' + node_to_str(node.right, lvl)


def not_equal_to_str(node, lvl):
    ''' Converts ast.NotEqToOp to str. '''
    return node_to_str(node.left, lvl) + ' ~= ' + node_to_str(node.right, lvl)


def and_to_str(node, lvl):
    ''' Converts ast.AndLoOp to str. '''
    return node_to_str(node.left, lvl) + ' and ' + node_to_str(node.right, lvl)


def or_to_str(node, lvl):
    ''' Converts ast.OrLoOp to str. '''
    return node_to_str(node.left, lvl) + ' or ' + node_to_str(node.right, lvl)


def concat_to_str(node, lvl):
    ''' Converts ast.Concat to str. '''
    return node_to_str(node.left, lvl) + '..' + node_to_str(node.right, lvl)


def unary_minus_to_str(node, lvl):
    ''' Converts ast. to str. '''
    return '-' + node_to_str(node.operand, lvl)


def not_bit_to_str(node, lvl):
    ''' Converts ast. to str. '''
    return '~' + node_to_str(node.operand, lvl)


def not_to_str(node, lvl):
    ''' Converts ast. to str. '''
    return 'not ' + node_to_str(node.operand, lvl)


def length_to_str(node, lvl):
    ''' Converts ast. to str. '''
    return '#' + node_to_str(node.operand, lvl)


switcher = [
    (ast.Chunk, chunk_to_str),
    (ast.Block, block_to_str),
    (ast.Name, name_to_str),
    (ast.Index, index_to_str),
    (ast.LocalAssign, loc_assign_to_str),
    (ast.Assign, assign_to_str),
    (ast.While, while_to_str),
    (ast.Do, do_to_str),
    (ast.Repeat, repeat_to_str),
    (ast.ElseIf, else_if_to_str),
    (ast.If, if_to_str),
    (ast.Label, label_to_str),
    (ast.Goto, goto_to_str),
    (ast.SemiColon, semicolon_to_str),
    (ast.Break, break_to_str),
    (ast.Return, return_to_str),
    (ast.Fornum, fornum_to_str),
    (ast.Forin, forin_to_str),
    (ast.Call, call_to_str),
    (ast.Invoke, invoke_to_str),
    (ast.LocalFunction, loc_func_to_str),
    (ast.Function, func_to_str),
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
    (ast.AnonymousFunction, anon_func_to_str),
    # Arithmetic operators.
    (ast.AddOp, add_to_str),
    (ast.SubOp, sub_to_str),
    (ast.MultOp, mult_to_str),
    (ast.FloatDivOp, float_div_to_str),
    (ast.FloorDivOp, floor_div_to_str),
    (ast.ModOp, mod_to_str),
    (ast.ExpoOp, expo_to_str),
    # Bitwise operators.
    (ast.BAndOp, and_bit_to_str),
    (ast.BOrOp, or_bit_to_str),
    (ast.BXorOp, xor_bit_to_str),
    (ast.BShiftROp, shiftr_bit_to_str),
    (ast.BShiftLOp, shiftl_bit_to_str),
    # Relational operators.
    (ast.LessThanOp, less_to_str),
    (ast.GreaterThanOp, greater_to_str),
    (ast.LessOrEqThanOp, less_or_eq_to_str),
    (ast.GreaterOrEqThanOp, greater_or_eq_to_str),
    (ast.EqToOp, equal_to_str),
    (ast.NotEqToOp, not_equal_to_str),
    (ast.AndLoOp, and_to_str),
    (ast.OrLoOp, or_to_str),
    # Concate operator.
    (ast.Concat, concat_to_str),
    # Unary operators.
    (ast.UMinusOp, unary_minus_to_str),
    (ast.UBNotOp, not_bit_to_str),
    (ast.ULNotOp, not_to_str),
    (ast.ULengthOP, length_to_str),
]


def node_to_str(node, lvl=0):
    ''' Converts node to string. '''
    for node_type in switcher:
        if type(node) == node_type[0]:
            return node_type[1](node, lvl)
    return 'Not parsed'


def rename(new, old, tree):
    ''' Rename variable. '''
    for node in ast.walk(tree):
        if type(node) == ast.Name and node.id == old:
            node.id = new


def call_require():
    ''' Require function implementation. '''
    return


def path_to_module_name(path):
    ''' Converts module path to module name. '''
    return path.replace('.', '_').replace('/', '_')


def name_to_module_path(path):
    ''' Converts module name to module path. '''
    return path.replace('.', '/') + '.lua'


def get_index_name(node):
    if type(node) == ast.Name:
        return node
    return get_index_name(node.value)


def preparse_module(module_path, src_dir, dst_dir):

    full_src_path = src_dir + '/' + module_path
    full_dst_path = dst_dir + '/' + module_path
    module_path = module_path[:-4]

    with open(full_src_path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)
    module_name = path_to_module_name(module_path)

    # Generate list of variables for renaming.
    variables = []
    names = []
    for node in ast.walk(tree):
        if isinstance(node, ast.Call) and node_to_str(node.func, 0) == 'require':
            if len(node.args) > 1 or not isinstance(node.args[0], ast.String):
                s = ''
                for arg in node.args:
                    s += node_to_str(arg) + ', '
                s = s[:-2]
                print('Error in require(' + s + '). File: ' + src_dir + '/' + module_path + '.lua')
                print('Require function needs one constant string argument.')
            path = name_to_module_path(node.args[0].s)
            preparse_module(path, src_dir, dst_dir)

    print('Preparing ' + src_dir + '/' + module_path + '.lua')
    for node in tree.body.body:
        if isinstance(node, ast.Assign):
            for targ in node.targets:
                variables.append(targ)
                if type(targ) == ast.Name:
                    names.append(targ.id)
                if type(targ) == ast.Index:
                    names.append(get_index_name(targ).id)
            
    # Rename.
    f_name = module_name
    if f_name != 'war3map' and f_name != 'main':
        for name in names:
            rename(module_name + '_' + name, name, tree)

    # Write file.
    pathlib.Path(full_dst_path[:full_dst_path.rfind('/')]).mkdir(parents=True, exist_ok=True)

    if os.path.isfile(dst_dir + '/' + module_path + '.lua'):
        os.remove(dst_dir + '/' + module_path + '.lua')

    built_module = open(dst_dir + '/' + module_path + '.lua', 'w')
    #built_module.write('\n-- Module ' + module_name + ' start. --\n\n')
    content = node_to_str(tree)
    built_module.write(content)
    #built_module.write('\n\n-- Module ' + module_name + ' end. --')


def print_module(path):
    ''' Prints module '''
    with open(path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)
    print(node_to_str(tree))


def parse_list(path, src_dir, files_list, requires_list, content_list, return_list):
    with open(src_dir + '/' + path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)

    # Add self to lists.
    files_list.append(path)
    requires_list.append([])
    content_list.append(tree)
    return_list.append(None)
    pos = len(files_list) - 1

    # Search requires.
    for node in ast.walk(tree):
        if not isinstance(node, ast.Assign):
            continue

        if len(node.values) > 1:
            for val in node.values:
                if isinstance(val, ast.Call) and node_to_str(val.func) == 'require':
                    print('Error in require(' + path_to_module_name(node_to_str(val.args[0])) + '). File: ' + src_dir + '/' + path + '\nRequire function can not be used in multiple assignment.')
                    return False

        if isinstance(node.values[0], ast.Call) and node_to_str(node.values[0].func) == 'require':
            args = node.values[0].args
            if len(args) != 1:
                print('Error in require function. File: ' + src_dir + '/' + path + '\nRequire function can have only one argument.')
                return False

            if type(args[0]) == ast.String:
                requires_list[pos].append(node)
            else:
                print('Error in require function. File: ' + src_dir + '/' + path + '\nArgument must be constant string.')
                return False

    # Search return in main block.
    for node in tree.body.body:
        if type(node) == ast.Return:
            return_list[pos] = node.values
            tree.body.body.remove(node)

    # Preparse requires.
    for require in requires_list[pos]:
        require_path = name_to_module_path(require.values[0].args[0].s)
        if files_list.count(require_path) < 1:
            if not parse_list(require_path, src_dir, files_list, requires_list, content_list, return_list):
                return False
        req_pos = files_list.index(require_path)
        require.values = return_list[req_pos]

    print(src_dir + '/' + path + ' parsed.')

    return True


def link_content(res_path, files_list, content_list):
    # Write file.
    pathlib.Path(res_path[:res_path.rfind('/')]).mkdir(parents=True, exist_ok=True)

    if os.path.isfile(res_path):
        os.remove(res_path)
    f_res = open(res_path, 'w')

    for i in range(len(files_list) - 1, -1, -1):
        s = ''
        if i != len(files_list) - 1: 
            s += '\n\n'
        s += '-- Module ' + files_list[i] + ' start. --\n\n'
        s += node_to_str(content_list[i])
        s += '\n\n-- Module ' + files_list[i] + ' end. --'
        f_res.write(s)

    f_res.close()

