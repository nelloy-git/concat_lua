# Function returns file's module name.
def getModuleName(path):
    m_file = open(path)
    first_line = m_file.readline()
    m_file.close()

    start = first_line.find('local ') + 5
    l = first_line.replace(' ', '')
    end = l.find('={}')

    return l[start:end]

# Converts path to file name
def path2Name(path):
    return path[path.find('/') + 1:].replace('/', '_')[:-4]

# Converts path to module name
def path2Module(path):
    name_end = path.rfind('.') - 1
    return path.replace('/', '.')[:name_end]

# Function gets path from line with 'require'
def getRelativeModulePath(line):
    module = line[line.find('(\'') + 2:line.find('\')')]
    return module.replace('.', '/') + '.lua'

# Function returns build path for source file
def getBuiltFilePath(src_path, build_path = 'build/'):
    return build_path + src_path[src_path.find('/') + 1:]

def isIgnored(path, ignore_list):
    for ignore in ignore_list:
        if path.endswith(ignore):
            return True
    return False