import os
from shutil import copyfile


# Function returns file's module name.
def get_module_name(path):
    f = open(path)
    line = f.readline().strip()
    while not (line.replace(' ', '').endswith('={') or line.replace(' ', '').endswith('={}')):
        line = f.readline().strip()
    f.close()

    start = line.find('local ')
    if start == -1:
        start = 0
    else:
        start += 5
    end = line.find('=')
    line = line[start:end].strip()

    return line


# Converts path to file name
def path2Name(path):
    return path.replace('/', '_')[:path.rfind('.')]


# Converts path to module name
def path2Module(path):
    name_end = path.rfind('.')
    return path.replace('/', '.')[:name_end]


# Function gets path from line with 'require'
def getRelativeModulePath(line):
    module = line[line.find('(\'') + 2:line.find('\')')]
    return module.replace('.', '/') + '.lua'


# Function returns build path for source file
def getBuiltFilePath(src_path, build_path = 'build/'):
    return build_path + src_path[src_path.find('/') + 1:]


def replaceFile(dst, src):
    if os.path.isfile(dst):
        os.remove(dst)
    copyfile(src, dst)