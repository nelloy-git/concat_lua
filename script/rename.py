import os
import utils as u

default_ignore = [
    '/war3map.lua',
    '/common.lua',
    '/blizzard.lua'
]

# Renames files for unique names.
def renameSrc(path, build_path = 'build/', ignore_list = default_ignore):
    for name in os.listdir(path):
        full_path = path + name
        if os.path.isfile(full_path):
            if (not u.isIgnored(full_path, ignore_list)):
                renameModule(full_path, build_path)
        else:
            renameSrc(full_path + '/', build_path, ignore_list)

def renameModule(path, build_path = 'build/'):
    print('Renaming ' + path + '...')
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
