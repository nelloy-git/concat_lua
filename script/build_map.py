'''
    Docs
'''

import sys
import os
import shutil
import subprocess

import parse
import fix_requires
import rename
import utils as u
from luaparser import ast


argc = len(sys.argv)
if (argc > 1 and sys.argv[1] == '-h') or argc < 4:
    print('Arguments:\n1 - source path,\n2 - build path,\n3 - wc3 execution path.')
    sys.exit()

src_path = sys.argv[1]
build_path = sys.argv[2] + 'scripts/'
war3_exe = ''
for i in range(3, argc):
    war3_exe += ' ' + sys.argv[i]
war3_exe = war3_exe[1:]

print('Sourse path: %s\nBuild path: %s\n' % (src_path, build_path))

base_src = src_path + 'war3map.lua'
result_path = build_path + 'war3map.lua'

if not os.path.exists(result_path[:result_path.rfind('/')]):
    os.mkdir(result_path[:result_path.rfind('/')])

if os.path.isfile(result_path):
    os.remove(result_path)

if os.path.isfile(base_src):
    shutil.copyfile(base_src, result_path)
else:
    print('Can not find %s file.' % base_src)
    sys.exit()


rename.rename_modules_in_folder(src_path, src_path, build_path)
fix_requires.fixRequires(build_path, build_path)
lines = parse.parseFile(result_path, [], build_path)

if os.path.isfile(build_path + 'war3map.lua'):
    os.remove(build_path + 'war3map.lua')
result = open(build_path + 'war3map.lua', 'w')
result.writelines(lines)
result.close()

u.replaceFile(sys.argv[2] + 'war3map.lua', result_path)

other_files = [
    'war3map.doo',
    'war3map.mmp',
    'war3map.shd',
    'war3map.w3c',
    'war3map.w3e',
    'war3map.w3i',
    'war3map.w3r',
    'war3map.wct',
    'war3map.wpm',
    'war3map.wtg',
    'war3map.wts',
    'war3mapMap.blp',
    'war3mapUnits.doo',
]

for name in other_files:
    u.replaceFile(sys.argv[2] + name, src_path + name)

folders = [
    'war3mapImported'
]

for folder in folders:
    if os.path.exists(sys.argv[2] + folder):
        shutil.rmtree(sys.argv[2] + folder)
    shutil.copytree(src_path + folder, sys.argv[2] + folder)

path = sys.argv[2] + 'map.w3x'
if os.path.exists(path):
    os.remove(path)

#run_mpq_cmd = ''
#if os.name == 'posix':
#    run_mpq_cmd = ['wine', './script/MPQEditor.exe', 'new', path
#elif os.name == 'nt':
#    run_mpq_cmd = ''

print(['./script/MPQEditor.exe', 'new', path])
subprocess.run(['./script/MPQEditor.exe', 'new', path])
subprocess.run(['./script/MPQEditor.exe', 'add', path, sys.argv[2] + 'war3map.lua', 'war3map.lua', '/auto'])
for file in other_files:
    subprocess.run(['./script/MPQEditor.exe', 'add', path, sys.argv[2] + file, file, ' /auto'])
for folder in folders:
    subprocess.run('./script/MPQEditor.exe' + ' add ' + path + ' ' + sys.argv[2] + folder + ' ' + folder + ' /auto')

#if os.name == 'posix':
#    print([run_mpq_cmd, './script/MPQEditor.exe', 'open', './' + path])
#    subprocess.run([run_mpq_cmd, './script/MPQEditor.exe', 'open', path])

#path = os.path.abspath(path)

print(war3_exe + ' -loadfile ./' + path)
subprocess.call(war3_exe + ' -loadfile ./' + path)


#input("Press Enter to continue...")

