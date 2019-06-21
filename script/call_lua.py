import lua

def load_content(content):
    lua.execute('content_str = [[return {\n' + content + '\n}]]')
    lua.execute('content_getter, err = loadstring(content_str)')
    lua.execute('if content_getter ~= nil')
    lua.execute('content, err = loadstring(content_str)')
    lua.execute('print(content.return_2())')
    print(lua.globals().content.return_2())
    return lua.globals().content
