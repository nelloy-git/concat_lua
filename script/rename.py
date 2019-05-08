import os
import utils as u

default_ignore = [
    '/war3map.lua',
    '/common.lua',
    '/blizzard.lua'
]

prev_chars = [
    '.', '=', ':', ' ', '(', ')', '[', ']', '{', '}', '\n', '\t'
]

next_chars = prev_chars + ['']


# Renames files for unique names.
def rename_modules_in_folder(folder, src_root, dst_root, ignore_list=default_ignore):
    for name in os.listdir(folder):
        full_path = folder + name
        if os.path.isfile(full_path):
            if full_path[full_path.rfind('/'):] not in ignore_list and full_path.endswith('.lua'):
                rename_module(full_path, src_root, dst_root)
        else:
            rename_modules_in_folder(full_path + '/', src_root, dst_root, ignore_list)


def rename_module(path, src_root, build_root):
    # Path inside src_root
    rel_path = path[len(src_root):]
    old_name = u.get_module_name(path)
    new_name = u.path2Name(rel_path)

    print('Renaming ' + path + ': ' + old_name + ' -> ' + new_name)

    real_path = build_root + rel_path[:rel_path.rfind('/') + 1] + new_name + '.lua'

    if os.path.isfile(real_path):
        os.remove(real_path)

    if not os.path.exists(real_path[:real_path.rfind('/') + 1]):
        os.makedirs(real_path[:real_path.rfind('/') + 1])

    f = open(path)
    lines = f.readlines()
    f.close()

    b_file = open(real_path, 'w')
    prev_line = '\n'
    for line in lines:
        for prev in prev_chars:
            for next in next_chars:
                if line.find(prev + old_name + next) > -1:
                    line = line.replace(prev + old_name + next, prev + new_name + next)
        for char in next_chars:
            if line.startswith(old_name + char):
                line = line.replace(old_name + char, new_name + char, 1)


        if not (prev_line == '\n' and line == '\n'):
            b_file.write(line)
        prev_line = line