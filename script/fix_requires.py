import os
import utils as u

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
        if line.replace(' ', '').find('require(') > -1:
            module = line[line.find('(\'') + 2: line.find('\')')]
            if module == 'blizzard.common' or module == 'blizzard.blizzard':
                continue
            module_path = path[:path.rfind('/') + 1] + u.getRelativeModulePath(line)
            new_name = u.path2Name(module_path)
            new_path = build_path + module_path[module_path.find('/') + 1:module_path.rfind('/') + 1] + new_name + '.lua'
            new_module = u.path2Module(new_path[new_path.find('/') + 1:])
            line = line.replace(module, new_module)
        res.append(line)

    os.remove(path)
    f = open(path, 'w')
    f.writelines(res)
    f.close()
