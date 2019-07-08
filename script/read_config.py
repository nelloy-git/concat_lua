import os

war3_key = 'Warcraft III.exe path'
src_key = 'Map folder path'
dst_key = 'Build folder path'

script_path = os.path.abspath(os.path.join(os.path.realpath(__file__), os.pardir))
conf_path = os.path.join(script_path, 'config.txt')
empty_conf = war3_key + ': \"\"\n' + src_key + ': \"\"\n' + dst_key + ': \"\"'

def get_paths():
    f = None
    try:
        f = open(conf_path, 'r')
    except:
        pass

    print(conf_path)
    if f is None:
        print('Can not find \'config.txt\'. Generating new one.')
        f = open(conf_path, 'w')
        f.write(empty_conf)
        return None, None, None

    for line in f.readlines():
        if line.find(war3_key) > -1:
            war3_path = line[line.find('\"') + 1:line.rfind('\"')]
            continue
        if line.find(src_key) > -1:
            src_path = line[line.find('\"') + 1:line.rfind('\"')]
            continue
        if line.find(dst_key) > -1:
            dst_path = line[line.find('\"') + 1:line.rfind('\"')]
            continue
    f.close()

    return war3_path, src_path, dst_path