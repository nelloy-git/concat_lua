import os
import utils as u

default_ignore = [
    'blizzard.common',
    'blizzard.blizzard'
]

def fixRequires(path, src_path, build_path, ignore_list = default_ignore):
    for name in os.listdir(path):
        full_path = path + name
        if os.path.isfile(full_path):
            fixRequire(full_path, src_path, build_path, ignore_list)
        else:
            fixRequires(full_path + '/', src_path, build_path, ignore_list)

def fixRequire(path, src_path, build_path, ignore_list):
    print('Fixing requires ' + path + '...')
    rel_path = path[len(src_path):]
    f = open(path, 'r')
    lines = f.readlines()
    f.close()

    res = []
    for line in lines:
        if line.replace(' ', '').find('require(') > -1:
            module = line[line.find('(\'') + 2: line.find('\')')]
            if module in ignore_list:
                continue
            module_path = rel_path[:rel_path.rfind('/') + 1] + u.getRelativeModulePath(line)
            new_name = u.path2Name(module_path)
            print(new_name)
            new_path = module_path[module_path.find('/') + 1:module_path.rfind('/') + 1] + new_name + '.lua'
            print(new_path)
            new_module = u.path2Module(new_path[new_path.find('/') + 1:])
            line = line.replace(module, new_module)
        res.append(line)

    os.remove(path)
    f = open(path, 'w')
    f.writelines(res)
    f.close()
