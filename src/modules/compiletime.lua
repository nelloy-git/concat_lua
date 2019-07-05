local ObjEdit = {}

function ObjEdit.read(path)
    local f = assert(io.open(path, "rb"))
    local t = f:read("*all")
    f:close()
    return t
end

function ObjEdit.to_hex(str, bytes_per_line)
    local res = ''
    for i = 1, str:len() do
        local c = str:sub(i, i)
        res = res..' '..string.format("%02x", c:byte())
        if i % bytes_per_line == 0 then
            res = res..'\n'
        end
    end
    return res
end

function ObjEdit.int2lend(val)
    local bytes = ''
    for i = 0, 3 do
        bytes = bytes..string.char(val >> (8 * i) & 0xFF)
    end
    return bytes
end

function ObjEdit.lend2int(bytes)
    local res = 0
    for i = 0, 3 do
        res = res << 8
        res = res + bytes:sub(#bytes - i, #bytes - i):byte()
    end
    return res
end

function ObjEdit.parse(bytes)
    local parsed = {}
    parsed.diffs_count = bytes.sub(13, 16)
end

return ObjEdit