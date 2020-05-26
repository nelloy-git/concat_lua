Lib = {}

require('Libs.LibList')

function Lib.getModname()
    local sep = '\\'
    if IsCompiletime() then
        sep = package.config:sub(1,1)
    end

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
    local lib = {
        modname = modname,
        depencies = {}
    }
    table.insert(libs_stack, lib)

    if IsCompiletime() then
        print('Loading library '..libs_stack[#libs_stack]. modname)
    end
end

function Lib.finish()
    if IsCompiletime() then
        print('Loaded library '..libs_stack[#libs_stack]. modname)
    end
    table.remove(libs_stack)
end

return Lib