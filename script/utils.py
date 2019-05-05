def getModuleName(path):
    m_file = open(path)
    first_line = m_file.readline()
    m_file.close()

    start = first_line.find('local ') + 5
    l = first_line.replace(' ', '')
    end = l.find('={}')

    return l[start:end]

def path2Name(path):
    return path[path.find('/') + 1:].replace('/', '_')[:-4]

def path2Module(path):
    return path.replace('/', '.')[:-4]

def getRelativeModulePath(line):
    module = line[line.find('(\'') + 2:line.find('\')')]
    return module.replace('.', '/') + '.lua'

def getBuiltFilePath(src_path, build_path = 'build/'):
    return build_path + src_path[src_path.find('/') + 1:]