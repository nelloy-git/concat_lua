import os
import utils as u

default_ignore = [
    '/war3map.lua',
    '/common.lua',
    '/blizzard.lua'
]

# Renames files for unique names. can run only once
def renamePath(cur_folder, src_path, build_path, ignore_list = default_ignore):
    for name in os.listdir(cur_folder):
        full_path = cur_folder + name
        if os.path.isfile(full_path):
            if (not u.isIgnored(full_path, ignore_list)
                and full_path.endswith('.lua')):
                renameModule(full_path, src_path, build_path)
        else:
            renamePath(full_path + '/', src_path, build_path, ignore_list)

def renameModule(path, src_path, build_path):
    print('Renaming ' + path + '...')
    rel_path = path[len(src_path):]
    f = open(path)
    old_name = u.getModuleName(path)
    new_name = u.path2Name(rel_path)
    lines = f.readlines()

    real_path = build_path + rel_path[:rel_path.rfind('/') + 1] + new_name + '.lua'
    print('New file: ' + real_path)

    if os.path.isfile(real_path):
        os.remove(real_path)

    if not os.path.exists(real_path[:real_path.rfind('/') + 1]):
        os.makedirs(real_path[:real_path.rfind('/') + 1])

    b_file = open(real_path, 'w')
    lines[0] = 'local ' + new_name + ' = {}\n'
    lines.remove(lines[len(lines) - 1])
    for line in lines:
        line = line.replace(old_name + '.', new_name + '.')
        line = line.replace(old_name + '\n', new_name + '\n')
        line = line.replace(old_name + '}', new_name + '}')
        line = line.replace(old_name + ':', new_name + ':')
        b_file.write(line)