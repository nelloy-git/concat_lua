import os
import utils as u

def parseFile(path, build_path = 'build/'):
    print('Parsing ' + path + '...')
    f = open(path, 'r')
    cur_dir = path[:path.rfind('/') + 1]
    lines = f.readlines()
    f.close()
    res = []
    for line in lines:
        l = line.replace(' ', '')
        pos = l.find('=require(')
        if pos > 0:
            module_path = cur_dir + u.getRelativeModulePath(line)
            print(module_path)
            module_lines = parseFile(module_path)
            for l in module_lines:
                res.append(l)
            res.append(line[:line.find('=')] + ' = ' + getModuleName(module_path) + '\n')
        else:
            res.append(line)
    return res

def getModuleName(path):
    m_file = open(path)
    first_line = m_file.readline()
    m_file.close()

    start = first_line.find('local ') + 5
    l = first_line.replace(' ', '')
    end = l.find('={}')

    return l[start:end]

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