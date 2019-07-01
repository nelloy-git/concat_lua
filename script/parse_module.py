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


def prepare_module(file_list, content_list, require_list):
    '''
        Function generates files with unique module names.
        Returns list of result file paths.
    '''
    for i, path in enumerate(file_list):
        print('Preparing ' + path)

        name = ats.path_to_module_name(path)
        content = content_list[i]

        # Generate list of variables for renaming.
        variables = []
        names = []
        for node in content.body.body:
            # Save local variables.
            if isinstance(node, ast.LocalAssign):
                for targ in node.targets:
                    variables.append(targ)
                    if isinstance(targ, ast.Name):
                        names.append(targ.id)
                    if isinstance(targ, ast.Index):
                        names.append(ats.get_index_name(targ).id)
            # Save return.
            if isinstance(node, ast.Return):
                return_node = node
                content.body.body.remove(node)

        # Rename.
        if name not in ('war3map', 'main'):
            for var_name in names:
                ats.rename(name + '_' + var_name, var_name, content)

        for module_requires in require_list:
            for require in module_requires:
                req_call = require.values[0]
                if isinstance(req_call, ast.Call):
                    if len(req_call.args) != 1:
                        print('Error in ' + ats.node_to_str(req_call) + '). \n\
                            Require function can have only one argument')
                    if not isinstance(req_call.args[0], ast.String):
                        print('Error in ' + ats.node_to_str(req_call) + '). \n\
                            Argument must be constant string')

                    req_path = ats.name_to_module_path(ats.node_to_str(req_call.args[0])[1:-1])
                    if path == req_path:
                        pos = module_requires.index(require)
                        module_requires[pos].values = return_node.values
    return


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
    block = ast.Block(content_list)
    return block

