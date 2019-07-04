import lua
from luaparser import ast


lua_compiletime = \
    '''
    compiletime_results = {}

    function compiletime(body)
        local l = table.getn(compiletime_results)
        if type(body) == \'function\' then
            compiletime_results[l + 1] = body()
        else
            compiletime_results[l + 1] = body
        end
    end
    '''

lua_require = \
    '''
    function require(module)
        module = module:gsub(\'%.\', \'_\')
        local func = _G[module..\'_return\']
        if func == nil then
            return nil
        end
        return func()
    end
    '''


def init_compiletime():
    lua.execute(lua_compiletime)

def load_enviroment(content):
    try:
        lua.execute(content)
    except RuntimeError as err:
        print('RuntimeError: ', err)

def lua_to_ast(val, val_type):
    if val_type == 'nil':
        return ast.Nil()
    elif val_type == 'number':
        return ast.Number(val)
    elif val_type == 'string':
        return ast.String(val)
    elif val_type == 'table':
        fields = []
        for field_name in val:
            field_val = lua_to_ast(val[field_name], lua.globals().type(val[field_name]))
            field = ast.Field(ast.Name(field_name), field_val)
            fields.append(field)
        return ast.Table(fields)

    print('Error: compiletime function can return only nil, number, string or table (with nils, numbers, strings and tables etc.).')
    return False

def get_compiletime_result(pos):
    lg = lua.globals()
    res = lg.compiletime_results[pos]
    res_type = lg.type(lg.compiletime_results[pos])
    return lua_to_ast(res, res_type)

def clear_enviroment():
    lua.execute('for k, v in pairs(_G) do k = nil end')