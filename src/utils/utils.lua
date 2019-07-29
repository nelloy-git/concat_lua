local Utils = {}

function  Utils.getErrorPos()
    local str = ''
    local i = 2
    while debug.getinfo(i, 'ln') ~= nil do
        local func = debug.getinfo(i, 'lnS')
        local source_type = func.source:sub(#func.source - 3, #func.source)
        if func.source:sub(#func.source - 3, #func.source) == '.lua' then
            str = '  ' .. func.source .. ':' .. tostring(func.currentline) .. '\n' .. str
        end
        i = i + 1
    end
    return str
end

local __real_print = print
function print(...)
    if is_compiletime == true then
        __real_print(...)
    else
        local s = ''
        for i = 1, select('#', ...) do
            local v = select(i, ...)
            local t = type(v)
            if t == 'number' or t == 'table' or t == 'nil' then
                v = tostring(v)
            end

            if type(v) ~= 'string' then
                v = ''
            end

            s = s..' '..v
        end

        for i = 0, 23 do
            DisplayTimedTextToPlayer(Player(i), 0, 0, 30, '[Debug]: '..s)
        end
    end
end

function ID(id)
    if type(id) == 'string' then
        return string.unpack(">I4", id)
    elseif type(id) == 'number' and math.fmod(id, 1) == 0 then
        return id
    end
    print('Wrong id fromat')
    print(Utils.getErrorPos())
    return nil
end

function id2str(id)
    return string.pack(">I4", id)
end


return Utils