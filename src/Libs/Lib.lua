Lib = {}

require('Libs.LibList')

function Lib.getModname()
    if not IsCompiletime then
        error('Lib.getModname() can be called in compiletime only.', 2)
    end
    local sep = package.config:sub(1,1)

    ---@type string
    local path = debug.getinfo(2, "S").source:sub(2)

    local modname = path:gsub(GetSrcDir(), '')
    modname = modname:gsub(sep, '.')
    modname = modname:gsub('.lua', '')

    --print(modname)
    local pos = modname:reverse():find('%.') - 1
    pos = modname:len() - pos

    modname = modname:sub(1, pos - 1)
    return modname
end

local libs_stack = {}

---@return table
function Lib.current()
    return libs_stack[#libs_stack]
end

---@param modname string
function Lib.start(modname)
    if not modname then
        error('modname is nil.', 2)
    end


    local lib = {
        modname = modname,
        depencies = {}
    }
    table.insert(libs_stack, lib)
end

function Lib.finish()
    print('Loaded '..libs_stack[#libs_stack].modname)
    table.remove(libs_stack)
end

return Lib