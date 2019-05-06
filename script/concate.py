import sys
sys.path.insert(0, 'utils')

import os
from shutil import copyfile

import rename
import fix_requires
import parse

argc = len(sys.argv)
if (argc > 1 and sys.argv[1] == '-h') or argc < 3:
    print('Arguments:\n1 - source path,\n2 - build path.')
    sys.exit()

src_path = sys.argv[1]
build_path = sys.argv[2]
print('Sourse path: %s\nBuild path: %s\n' % (src_path, build_path))

base_src = src_path + 'war3map.lua'
result_path = build_path + 'war3map.lua'
if os.path.isfile(result_path):
    os.remove(result_path)

if os.path.isfile(base_src):
    copyfile(base_src, result_path)
else:
    print('Can not find %s file.' % base_src)
    sys.exit()

rename.renamePath(src_path, src_path, build_path)
fix_requires.fixRequires(build_path, src_path, build_path)
lines = parse.parseFile(result_path, [], build_path)

if os.path.isfile(build_path + 'war3map.lua'):
    os.remove(build_path + 'war3map.lua')
result = open(build_path + 'war3map.lua', 'w')
result.writelines(lines)
result.close()


#input("Press Enter to continue...")

