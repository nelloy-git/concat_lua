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
    local line = ''
    for i = 1, data:len() do
        local c = data:sub(i, i)
        line = line .. string.format("%02x", c:byte()) .. ' '
        if i % bytes_per_line == 0 then
            res = res..'\n'..line:sub(1, #line - 1)
            line = ''
        end
    end
    if line ~= '' then
        res = res..'\n'..line:sub(1, #line - 1)
    end
    return res:sub(2, #res)
end

function WeUtils.byte2float(data)
    data = WeUtils.byte2int(data)
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

local function grab_byte(v)
      return math.floor(v / 256), string.char(math.floor(v) % 256)
end

local log2 = math.log(2)

local frexp = math.frexp or function(x)
	if x == 0 then return 0, 0 end
	local e = math.floor(math.log(math.abs(x)) / log2 + 1)
	return x / 2 ^ e, e
end

function WeUtils.float2byte(x)
    local sign = 0
    if x < 0 then
      sign = 1;
      x = -x
    end
    local mantissa, exponent = frexp(x)
    if x == 0 then
       mantissa = 0;
       exponent = 0
    else
       mantissa = (mantissa * 2 - 1) * 8388608 -- math.ldexp(0.5, 24)
       exponent = exponent + 126
    end
    local v, byte = "" -- convert to bytes
    x, byte = grab_byte(mantissa); v = v..byte -- 7:0
    x, byte = grab_byte(x); v = v..byte -- 15:8
    x, byte = grab_byte(exponent * 128 + x); v = v..byte -- 23:16
    x, byte = grab_byte(sign * 128 + x); v = v..byte -- 31:24
    return v
end

function  WeUtils.getErrorPos()
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

local function nextId(cur_id)
    local p4 = string.byte(cur_id, 1)
    local p3 = string.byte(cur_id, 2)
    local p2 = string.byte(cur_id, 3)
    local p1 = string.byte(cur_id, 4)

    if p1 < 96 then
        p1 = p1 + 1
        while p1 >= 48 and p1 <= 57 do
            p1 = p1 + 1
        end
    elseif p2 < 96 then
        p1 = string.byte('!')
        p2 = p2 + 1
        while p2 >= 48 and p2 <= 57 do
            p2 = p2 + 1
        end
    elseif p3 < 96 then
        p1 = string.byte('!')
        p2 = string.byte('!')
        p3 = p3 + 1
        while p3 >= 48 and p3 <= 57 do
            p3 = p3 + 1
        end
    else 
        print('No valid ids left.')
        return nil
    end
    return string.char(p4)..string.char(p3)..string.char(p2)..string.char(p1)
end

local UNIT_ID = 'x###'
function WeUtils.nextUnitId()
    UNIT_ID = nextId(UNIT_ID)
    return UNIT_ID
end

local HERO_ID = 'HM##'
function WeUtils.nextHeroId()
    HERO_ID = nextId(HERO_ID)
    return HERO_ID
end

local ABIL_ID = 'AM##'
function WeUtils.nextAbilId()
    ABIL_ID = nextId(ABIL_ID)
    return ABIL_ID
end

local BUFF_ID = 'BM##'
function WeUtils.nextBuffId()
    BUFF_ID = nextId(BUFF_ID)
    return BUFF_ID
end

local ITEM_ID = 'IM##'
function WeUtils.nextItemId()
    ITEM_ID = nextId(ITEM_ID)
    return ITEM_ID
end

local UPGR_ID = 'RM##'
function WeUtils.nextUpgrId()
    UPGR_ID = nextId(UPGR_ID)
    return UPGR_ID
end


return WeUtils