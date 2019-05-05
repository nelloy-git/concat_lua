import os
import utils as u

def preParseSrc(path, build_path = 'build/'):
    for name in os.listdir(path):
        full_path = path +  name
        if os.path.isfile(full_path):
            if full_path != path + 'war3map.lua':
                parseFile(full_path, build_path)
        else:
            preParseSrc(full_path + '/', build_path)

def parseFile(path, build_path = 'build/'):
    print('Preparsing ' + path + '...')
    f = open(path)
    old_name = u.getModuleName(path)
    new_name = u.path2Name(path)
    lines = f.readlines()

    res_path = build_path + path[path.find('/') + 1:path.rfind('/') + 1] + new_name + '.lua'
    if os.path.isfile(res_path):
        os.remove(res_path)

    if not os.path.exists(res_path[:res_path.rfind('/') + 1]):
        os.makedirs(res_path[:res_path.rfind('/') + 1])

    b_file = open(res_path, 'w')
    lines[0] = 'local ' + new_name + ' = {}\n'
    lines.remove(lines[len(lines) - 1])
    for line in lines:
        b_file.write(line.replace(old_name + '.', new_name + '.'))

def fixRequires(path, src_path = 'src/', build_path = 'build/'):
    for name in os.listdir(path):
        full_path = path + name
        if os.path.isfile(full_path):
            fixRequire(full_path, src_path, build_path)
        else:
            fixRequires(full_path + '/', src_path, build_path)

def fixRequire(path, src_path, build_path):
    print('Fixing requires ' + path + '...')
    f = open(path, 'r')
    lines = f.readlines()
    f.close()

    res = []
    for line in lines:
        if line.replace(' ', '').find('=require(') > -1:
            module = line[line.find('(\'') + 2: line.find('\')')]
            module_path = src_path + u.getRelativeModulePath(line)
            new_name = u.path2Name(module_path)
            new_path = build_path + module_path[module_path.find('/') + 1:module_path.rfind('/') + 1] + new_name + '.lua'
            new_module = u.path2Module(new_path[new_path.find('/') + 1:])
            line = line.replace(module, new_module)
        res.append(line)

    os.remove(path)
    f = open(path, 'w')
    f.writelines(res)
    f.close()
