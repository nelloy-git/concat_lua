'''

'''
import os

import pathlib
from luaparser import ast

import ast_to_string as ats
import call_lua as cl


def read_requires(module_path, src_dir, file_list, content_list, require_list):
    '''
        Function reads content of all requires of module.
        - module_path  - relative path inside source directory
        - src_dir      - path of source directory
        - file_list    - list to add requireed files
        - content_list - list to add file content (ast tree)
        - require_list - list to add requires for files

        Returns files list, contents list including the module.
    '''

    # Read file.
    full_src_path = src_dir + '/' + module_path
    with open(full_src_path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)

    # Searching depencies.
    module_requires = []
    for node in ast.walk(tree):
        if isinstance(node, (ast.LocalAssign, ast.Assign)):
            require_found = False
            for val in node.values:
                if isinstance(val, ast.Call) and ats.node_to_str(val.func) == 'require':
                    require_found = True
                    break
            if not require_found:
                continue

            if len(node.values) > 1:
                print('Error in require(' + s + '). File: ' + src_dir + '/' + module_path)
                print('Right side of assign with require can have only require call.')
                raise SystemExit
            
            req_call = node.values[0]
            if len(req_call.args) > 1 or not isinstance(req_call.args[0], ast.String):
                s = ''
                for arg in req_call.args:
                    s += ats.node_to_str(arg) + ', '
                s = s[:-2]
                print('Error in require(' + s + '). File: ' + src_dir + '/' + module_path)
                print('Require function needs one constant string argument.')
                raise SystemExit

            # Prepare depency.
            path = ats.name_to_module_path(req_call.args[0].s)
            file_list, content_list, require_list = \
                        read_requires(path, src_dir, file_list, content_list, require_list)
            module_requires.append(node)

    file_list.append(module_path)
    content_list.append(tree)
    require_list.append(module_requires)
    return file_list, content_list, require_list


def fix_content_return(file_path, content):
    module_name = ats.path_to_module_name(file_path)
    for node in content.body.body:
        if isinstance(node, ast.Return):
            pos = content.body.body.index(node)
            func = ast.Function(ast.Name(module_name + '_return'), [], ast.Block([node]))
            content.body.body[pos] = func



def compiletime_execution(module_tree):
    # Run module to get compiletime results list.
    cl.clear_enviroment()
    cl.init_compiletime()
    cl.load_enviroment(ats.node_to_str(module_tree))

    # Get compiletime results.
    cur = 0
    for node in ast.walk(module_tree):
        if not isinstance(node, (ast.Assign, ast.LocalAssign)):
            continue

        new_vals = []
        for val in node.values:
            if isinstance(val, ast.Call) and ats.node_to_str(val.func, 0) == 'compiletime':
                cur += 1
                if len(val.args) > 1:
                    s = ''
                    for arg in node.args:
                        s += ats.node_to_str(arg) + ', '
                    s = s[:-2]
                    print('Error in compiletime(' + s + ').')
                    print('Require function needs only one argument.')
                    return
                val = cl.get_compiletime_result(cur)
                #print(ats.node_to_str(val))
            new_vals.append(val)
        node.values = new_vals


def link_content(files_list, content_list):
    
    mod_node = ast.Name('module')
    require_func = ast.Function(ast.Name('require'), [mod_node], \
                            ast.Block([
                                ast.Assign([mod_node], [ast.Call(ast.Index(ast.String('gsub'), ast.Name('string')), [mod_node, ast.String('%.'), ast.String('_')])]),
                                #ast.Call(ast.Name('print'),[mod_node]),
                                ast.Return([
                                    ast.Call(ast.Index(ast.Concat(mod_node, ast.String('_return')), ast.Name('_G')), [])
                                    ])
                                ])
                            )

    content_list.insert(0, require_func)
    #print(content_list)
    block = ast.Block(content_list)
    return block

