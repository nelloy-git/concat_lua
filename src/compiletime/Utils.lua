---@class WeUtils
local WeUtils = {}

---@param data string
---@return string
function WeUtils.str2byte(data)
    return data .. '\0'
end

---@param data string
---@return string
function WeUtils.byte2str(data)
    return data:sub(1, #data - 1)
end

---@param data integer
---@return string
function WeUtils.int2byte(data)
    local bytes = ''
    for i = 0, 3 do
        bytes = bytes..string.char(data >> (8 * i) & 0xFF)
    end
    return bytes
end

---@param data string
---@return integer
function WeUtils.byte2int(data)
    local res = 0
    for i = 0, 3 do
        res = res << 8
        res = res + data:sub(#data - i, #data - i):byte()
    end
    return res
end

---@param data string
---@param bytes_per_line integer
---@return string
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

---@param data string
---@return number
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

---@param data number
---@return string
function WeUtils.float2byte(data)
    local sign = 0
    if data < 0 then
      sign = 1
      data = -data
    end
    local mantissa, exponent = frexp(data)
    if data == 0 then
       mantissa = 0
       exponent = 0
    else
       mantissa = (mantissa * 2 - 1) * 8388608 -- math.ldexp(0.5, 24)
       exponent = exponent + 126
    end
    local v, byte = "" -- convert to bytes
    data, byte = grab_byte(mantissa)
    v = v..byte -- 7:0
    data, byte = grab_byte(data)
    v = v..byte -- 15:8
    data, byte = grab_byte(exponent * 128 + data)
    v = v..byte -- 23:16
    data, byte = grab_byte(sign * 128 + data)
    v = v..byte -- 31:24
    return v
end

---@param we_type string
---@return boolean
function WeUtils.isDataType(we_type)
    if we_type == 'bool' or
       we_type == 'int' or
       we_type == 'real' or
       we_type == 'unreal' or
       we_type == 'string' then
        return true
    end
    return false
end

---data type = 'bool'|'int'|'real'|'unreal'|'string'
---@param data_type string
---@return string
function WeUtils.type2bytes(data_type)
	if data_type == 'bool' then return WeUtils.int2byte(0) end
	if data_type == 'int' then return WeUtils.int2byte(0) end
	if data_type == 'real' then return WeUtils.int2byte(1) end
	if data_type == 'unreal' then return WeUtils.int2byte(2) end
	if data_type == 'string' then return WeUtils.int2byte(3) end
end

---data_type = 'bool'|'int'|'real'|'unreal'|'string'
---@param data boolean|number|string
---@param data_type string
---@return string|nil
function WeUtils.data2byte(data, data_type)
	if data_type == 'bool' then
		if data == true then
			return WeUtils.int2byte(1)
		else
			return WeUtils.int2byte(0)
		end
	elseif data_type == 'int' then
		return WeUtils.int2byte(data)
	elseif data_type == 'real' or data_type == 'unreal' then
		return WeUtils.float2byte(data)
	elseif data_type == 'string' then
		return WeUtils.str2byte(data)
	else
		print('Wrong data type')
		print(WeUtils.getErrorPos())
		return nil
	end
end

---@return string
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

---@param cur_id string
---@return string
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
---@return string
function WeUtils.nextUnitId()
    UNIT_ID = nextId(UNIT_ID)
    return UNIT_ID
end

local HERO_ID = 'HM##'
---@return string
function WeUtils.nextHeroId()
    HERO_ID = nextId(HERO_ID)
    return HERO_ID
end

local ABIL_ID = 'AM##'
---@return string
function WeUtils.nextAbilityId()
    ABIL_ID = nextId(ABIL_ID)
    return ABIL_ID
end

local BUFF_ID = 'BM##'
---@return string
function WeUtils.nextBuffId()
    BUFF_ID = nextId(BUFF_ID)
    return BUFF_ID
end

local ITEM_ID = 'IM##'
---@return string
function WeUtils.nextItemId()
    ITEM_ID = nextId(ITEM_ID)
    return ITEM_ID
end

local UPGR_ID = 'RM##'
---@return string
function WeUtils.nextUpgradeId()
    UPGR_ID = nextId(UPGR_ID)
    return UPGR_ID
end

local current_pos = 0
---@type string[]
local orders = {"absorb", "acidbomb", "acolyteharvest", "whirlwind", "ambush", "ancestralspirit", "ancestralspirittarget", "animatedead", "antimagicshell", "webon", "weboff", "web", "attributemodskill", "auraunholy", "auravampiric", "autodispel", "autodispeloff", "autodispelon", "autoentangle", "autoentangleinstant", "wateryminion", "waterelemental", "avatar", "avengerform", "awaken", "banish", "barkskin", "barkskinoff", "barkskinon", "battleroar",
	            "battlestations", "bearform", "berserk", "blackarrow", "blackarrowoff", "blackarrowon", "blight", "blink", "blizzard", "bloodlust", "bloodlustoff", "bloodluston", "board", "breathoffire", "breathoffrost", "ward", "burrow", "cannibalize", "carrionscarabs", "carrionscarabsinstant", "carrionscarabsoff", "carrionscarabson", "carrionswarm", "chainlightning", "channel", "charm", "chemicalrage", "cloudoffog", "clusterrockets", "coldarrows",
	            "coldarrowstarg", "controlmagic", "corporealform", "corrosivebreath", "coupleinstant", "coupletarget", "creepanimatedead", "creepdevour", "creepheal", "creephealoff", "creephealon", "creepthunderbolt", "creepthunderclap", "cripple", "curse", "curseoff", "curseon", "cyclone", "darkconversion", "darkportal", "darkritual", "darksummoning", "deathanddecay", "deathcoil", "deathpact", "windwalk", "defend", "detectaoe", "detonate", "devour",
	            "devourmagic", "disassociate", "disenchant", "dismount", "dispel", "divineshield", "doom", "drain", "dreadlordinferno", "dropitem", "drunkenhaze", "earthquake", "eattree", "elementalfury", "wispharvest", "ensnareoff", "ensnareon", "entangle", "entangleinstant", "entanglingroots", "etherealform", "evileye", "faeriefire", "faeriefireoff", "faeriefireon", "fanofknives", "farsight", "fingerofdeath", "firebolt", "flamestrike",
	            "flamingarrows", "flamingarrowstarg", "flamingattack", "flamingattacktarg", "flare", "forceboard", "forceofnature", "forkedlightning", "freezingbreath", "frenzy", "frenzyoff", "frenzyon", "frostarmor", "frostarmoroff", "frostarmoron", "frostnova", "getitem", "gold2lumber", "grabtree", "harvest", "heal", "healingspray", "healingward", "healingwave", "healoff", "healon", "hex", "voodoo", "holybolt", "howlofterror",
	            "humanbuild", "immolation", "impale", "incineratearrow", "incineratearrowoff", "incineratearrowon", "inferno", "innerfire", "innerfireoff", "innerfireon", "instant", "invisibility", "lavamonster", "lightningshield", "load", "loadarcher", "loadcorpse", "loadcorpseinstant", "locustswarm", "lumber2gold", "magicdefense", "magicleash", "magicundefense", "manaburn", "manaflareoff", "manaflareon", "manashieldoff", "manashieldon", "massteleport", "mechanicalcritter",
	            "metamorphosis", "militia", "militiaconvert", "militiaoff", "militiaunconvert", "mindrot", "mirrorimage", "monsoon", "mount", "mounthippogryph", "vengeanceoff", "nagabuild", "neutraldetectaoe", "neutralinteract", "neutralspell", "nightelfbuild", "orcbuild", "parasite", "parasiteoff", "parasiteon", "patrol", "phaseshift", "phaseshiftinstant", "phaseshiftoff", "phaseshifton", "phoenixfire", "phoenixmorph", "poisonarrows", "poisonarrowstarg", "polymorph",
	            "possession", "preservation", "purge", "rainofchaos", "rainoffire", "raisedead", "raisedeadoff", "raisedeadon", "ravenform", "recharge", "rechargeoff", "rechargeon", "rejuvination", "renew", "renewoff", "renewon", "repair", "repairoff", "repairon", "replenish", "replenishlife", "replenishlifeoff", "replenishlifeon", "replenishmana", "replenishmanaoff", "replenishmanaon", "replenishoff", "replenishon", "request_hero", "requestsacrifice",
	            "restoration", "restorationoff", "restorationon", "resumebuild", "resumeharvesting", "resurrection", "returnresources", "revenge", "revive", "roar", "robogoblin", "root", "sacrifice", "sanctuary", "scout", "selfdestruct", "selfdestructoff", "selfdestructon", "sentinel", "setrally", "shadowsight", "shadowstrike", "shockwave", "silence", "sleep", "slow", "slowoff", "slowon", "vengeanceon", "soulburn",
	            "soulpreservation", "spellshield", "spellshieldaoe", "spellsteal", "spellstealoff", "spellstealon", "spies", "spiritlink", "spiritofvengeance", "spirittroll", "spiritwolf", "stampede", "standdown", "starfall", "stasistrap", "steal", "stomp", "stoneform", "volcano", "submerge", "summonfactory", "summongrizzly", "summonphoenix", "summonquillbeast", "summonwareagle", "tankdroppilot", "tankloadpilot", "tankpilot", "taunt", "thunderbolt",
	            "thunderclap", "tornado", "townbelloff", "townbellon", "tranquility", "transmute", "unavatar", "unavengerform", "unbearform", "unburrow", "uncoldarrows", "uncorporealform", "undeadbuild", "undefend", "undivineshield", "unetherealform", "unflamingarrows", "unflamingattack", "unholyfrenzy", "unimmolation", "unload", "unloadall", "unloadallcorpses", "unloadallinstant", "unpoisonarrows", "unravenform", "unrobogoblin", "unroot", "unstableconcoction", "unstoneform",
	            "unsubmerge", "unsummon", "unwindwalk", "vengeance", "vengeanceinstant",
}
function WeUtils.nextOrderId()
    current_pos = current_pos + 1
    if current_pos > #orders then
        print('No empty orders for channel ability')
        print(WeUtils.getErrorPos())
        return nil
    end
    return orders[current_pos]
end

return WeUtils