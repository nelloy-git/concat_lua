'''

'''
import os

import pathlib
from luaparser import ast

import ast_to_string as ats


def read_contents(module_path, src_dir, file_list, content_list):
    full_src_path = src_dir + '/' + module_path

    with open(full_src_path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)

    # Prepare depencies.
    for node in ast.walk(tree):
        if isinstance(node, ast.Call) and ats.node_to_str(node.func, 0) == 'require':

            # Errors
            if len(node.args) > 1 or not isinstance(node.args[0], ast.String):
                s = ''
                for arg in node.args:
                    s += ats.node_to_str(arg) + ', '
                s = s[:-2]
                print('Error in require(' + s + '). File: ' + src_dir + '/' + module_path)
                print('Require function needs one constant string argument.')
                return False

            # Prepare depency.
            path = ats.name_to_module_path(node.args[0].s)
            file_list, content_list = prepare_module(path, src_dir, file_list, content_list)
            if not file_list:
                return False

    file_list.append(full_src_path)
    content_list.append()
    return file_list, contents



def prepare_module(module_path, src_dir, dst_dir, file_list=[], contents=[]):
    '''
        Function generates files with unique module names.
        Returns list of result file paths.
    '''
    full_src_path = src_dir + '/' + module_path
    full_dst_path = dst_dir + '/' + module_path
    module_name = ats.path_to_module_name(module_path[:-4])

    with open(full_src_path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)

    # Prepare depencies.
    for node in ast.walk(tree):
        if isinstance(node, ast.Call) and ats.node_to_str(node.func, 0) == 'require':
            if len(node.args) > 1 or not isinstance(node.args[0], ast.String):
                s = ''
                for arg in node.args:
                    s += ats.node_to_str(arg) + ', '
                s = s[:-2]
                print('Error in require(' + s + '). File: ' + src_dir + '/' + module_path)
                print('Require function needs one constant string argument.')
                return False

            # Prepare depency.
            path = ats.name_to_module_path(node.args[0].s)
            file_list, contents = prepare_module(path, src_dir, dst_dir, file_list)
            if not file_list:
                return False

    # Generate list of variables for renaming.
    variables = []
    names = []
    print('Preparing ' + src_dir + '/' + module_path)
    for node in tree.body.body:
        if isinstance(node, ast.Assign):
            for targ in node.targets:
                variables.append(targ)
                if type(targ) == ast.Name:
                    names.append(targ.id)
                if type(targ) == ast.Index:
                    names.append(ats.get_index_name(targ).id)
            
    # Rename.
    if module_name != 'war3map' and module_name != 'main':
        for name in names:
            ats.rename(module_name + '_' + name, name, tree)

    # Write file.
    #pathlib.Path(full_dst_path[:full_dst_path.rfind('/')]).mkdir(parents=True, exist_ok=True)

    #if os.path.isfile(dst_dir + '/' + module_path):
    #    os.remove(dst_dir + '/' + module_path)
    #built_module = open(dst_dir + '/' + module_path, 'w')

    content = ats.node_to_str(tree)
    #built_module.write(content)
    file_list.append(dst_dir + '/' + module_path)
    contents.append(content)
    return file_list, contents


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
                if isinstance(val, ast.Call) and ats.node_to_str(val.func) == 'require':
                    print('Error in require(' + ats.path_to_module_name(ats.node_to_str(val.args[0])) + '). File: ' + src_dir + '/' + path + '\nRequire function can not be used in multiple assignment.')
                    return False

        if isinstance(node.values[0], ast.Call) and ats.node_to_str(node.values[0].func) == 'require':
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
        require_path = ats.name_to_module_path(require.values[0].args[0].s)
        if files_list.count(require_path) < 1:
            if not parse_list(require_path, src_dir, files_list, requires_list, content_list, return_list):
                return False
        req_pos = files_list.index(require_path)
        require.values = return_list[req_pos]

    print(src_dir + '/' + path + ' parsed.')

    return True


def link_content(files_list, content_list):
    s = ''
    for i in range(len(files_list) - 1, -1, -1):
        if i != len(files_list) - 1: 
            s += '\n\n'
        s += '-- Module ' + files_list[i] + ' start. --\n\n'
        s += ats.node_to_str(content_list[i])
        s += '\n\n-- Module ' + files_list[i] + ' end. --\n'
    return s

