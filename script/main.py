''' Some info
'''
import parse_module as pm
import ast_to_string as ats

#src_dir = '/home/bugrov/lua/concat_lua/src'
#build_dir = '/home/bugrov/lua/concat_lua/build'

src_dir = './src'
build_dir = './build'

file_list = []
content_list = []
pm.read_content('war3map.lua', src_dir, file_list, content_list)
file_list.reverse()
content_list.reverse()

print('Used files:')
for f in file_list:
    print('  ' + f)

for i, file_path in enumerate(file_list):
    pm.fix_content_return(file_path, content_list[i])

full_content = pm.link_content(content_list)
pm.compiletime_execution(full_content)

with open(build_dir + '/war3map.lua', 'w') as file:
    file.write(ats.node_to_str(full_content))
    
map_files = [
    'war3map.lua',
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

map_folders = [
    'war3mapImported'
]

#path = build_dir + '/map.w3x'
#subprocess.run(['./MPQEditor.exe', 'new', path])
#for f in map_files:
#    subprocess.run(['./MPQEditor.exe', 'add', path, build_dir + '/' + f, f, ' /auto'])
#for folder in map_folders:
#    subprocess.run('./MPQEditor.exe' + ' add ' + path + ' ' + build_dir + '/' + folder + ' ' + folder + ' /auto')

#war3_exe = 'C:\\Program Files\\Warcraft III\\x86_64\\Warcraft III.exe'
#print(os.getcwd() + '\\build\\map.w3x')
#subprocess.call(war3_exe + ' -loadfile ' + os.getcwd() + '\\' + path)