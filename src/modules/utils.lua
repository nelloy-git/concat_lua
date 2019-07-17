local WeUtils = {}

function WeUtils.str2byte(data)
    return data .. '\0'
end

function WeUtils.byte2str(data)
    return data:sub(1, #data - 1)
end

function WeUtils.int2byte(data)
    local bytes = ''
    for i = 0, 3 do
        bytes = bytes..string.char(data >> (8 * i) & 0xFF)
    end
    return bytes
end

function WeUtils.byte2int(data)
    local res = 0
    for i = 0, 3 do
        res = res << 8
        res = res + data:sub(#data - i, #data - i):byte()
    end
    return res
end

function WeUtils.byte2hex(data, bytes_per_line)
    local res = ''
    for i = 1, data:len() do
        local c = data:sub(i, i)
        res = res..' '..string.format("%02x", c:byte())
        if i % bytes_per_line == 0 then
            res = res..'\n'
        end
    end
    return res
end

function WeUtils.byte2float(data)
    local s = 1
    if data >> 31 == 1 then s = -1 end
    local e = (data >> 23) & 0xFF
    local m = 0
    if e ~= 0 then
        m = ((data & 0x7FFFFF ) | 0x800000)
    else
        m = ((data & 0x7FFFFF ) << 1)
    end
    local m1 = m*(2^(-23))
    return s*m1*(2^(e-127))
end

return WeUtils