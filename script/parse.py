import utils as u


def parseFile(path, used_modules, build_path = 'build/'):
    print('Parsing ' + path + '...')
    f = open(path, 'r')
    lines = f.readlines()
    f.close()
    res = []
    for line in lines:
        l = line.replace(' ', '')
        pos = l.find('=require(')
        if pos > 0:
            module_path = build_path + u.getRelativeModulePath(line)
            if not module_path in used_modules:
                module_lines = parseFile(module_path, used_modules, build_path)
                for l in module_lines:
                    res.append(l)
                used_modules.append(module_path)
            res.append(line[:line.find('=')] + '= ' + u.get_module_name(module_path) + '\n')
        else:
            res.append(line)
    return res

def listRequires(path, cur_dir):
    f = open(path)
    lines = f.readlines()
    res = []
    for line in lines:
        line = line.replace(' ', '')
        pos = line.find('=require(')
        if pos > 0:
            res.append(cur_dir + line[line.find('(\''):line.find('\')')])
    f.close()
    return res