import sys
import os
from shutil import copyfile

import rename
import fix_requires
import parse

argc = len(sys.argv)
if argc < 4:
    build_path = 'build/'
else:
    build_path = sys.argv[3]

if argc < 3:
    src_path = 'src/'
else: 
    src_path = sys.argv[2]

if argc < 2:
    main_path = 'src/'
else:
    main_path = sys.argv[1]
    
#print(main_path + '\n' + src_path + '\n' + build_path)

included_list = []
if os.path.isfile(build_path + 'war3map.lua'):
    os.remove(build_path + 'war3map.lua')

if os.path.isfile(src_path + 'war3map.lua'):
    copyfile(main_path + 'war3map.lua', build_path + 'war3map.lua')
else:
    print('Can not find war3map.lua file.')
    sys.exit()

rename.renameSrc(src_path)
fix_requires.fixRequires(build_path, src_path, build_path)
lines = parse.parseFile(build_path + 'war3map.lua', [])

if os.path.isfile(build_path + 'war3map.lua'):
    os.remove(build_path + 'war3map.lua')
result = open(build_path + 'war3map.lua', 'w')
result.writelines(lines)
result.close()


#input("Press Enter to continue...")

