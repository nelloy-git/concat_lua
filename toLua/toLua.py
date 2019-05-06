import os
import re

replace_types = [
    ('integer ', 'int_'),
    ('string ', 'str_'),
    ('real ', 'r_'),
    ('boolean ', 'b_'),
    ('handle ', 'handle_'),
    ('code ', 'code_')
]

def converTypes(line):
    for pair in replace_types:
        line = line.replace(' ' + pair[0], ' ' + pair[1])
        line = line.replace('(' + pair[0], '(' + pair[1])
        line = line.replace(',' + pair[0], ', ' + pair[1])
    return line

def processFunc(line):
    takes_start = line.find(' takes ')
    line = line.replace(line[takes_start:takes_start + 7], '(')
    line = line.replace(' returns', ') return')
    line = line + ' end'
    return line

def convertFile(path):
    f = open(path)
    lua = jass2lua(f.readlines())
    f.close()

    new_path = path[:path.rfind('.')] + '.lua'
    if os.path.exists(new_path):
        os.remove(new_path)
    f = open(new_path, 'w')
    prev_line = '\n'
    for line in lua:
        if line != '\n' and prev_line != '\n':
            f.write(line)
        prev_line = line
    f.close()

def jass2lua(lines):
    res = []
    for line in lines:
        line = line.strip()
        line = line.replace('\t', ' ')
        line = re.sub(' +', ' ', line)
        line = line.replace('$', '0x')

        if line.startswith('//'):
            line = line.replace('//', '--')
        elif line.startswith('type'):
            name_start = line.find('type') + 5
            name_end = line.find(' ', name_start + 1, len(line)) 
            name = line[name_start: name_end]
            replace_types.append(tuple((name + ' ', name + '_')))
            line = ''
        elif line.startswith('native'):
            line = converTypes(line)
            line = line.replace('native', 'function')
            line = processFunc(line)
        elif line.startswith('constant native'):
            line = converTypes(line)
            line = line.replace('constant native', 'function')
            line = processFunc(line)
        elif line.startswith('constant'):
            type_end = line.find(' ', 9, len(line)) + 1
            line = line.replace(line[:type_end], '')
        elif line.startswith('function'):
            line = converTypes(line)
            line = processFunc(line)
        else:
            line = ''

        line = line.replace('return nothing ', '')
        line = line.replace('nothing', '')
        res.append(line + '\n')
    return res

convertFile('src/blizzard/common.j')
convertFile('src/blizzard/blizzard.j')