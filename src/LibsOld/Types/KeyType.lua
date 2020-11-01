--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local getEnum = UtilsLib.getEnum
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

---@class KeyType
local KeyType = {}

---@type table<integer, oskeytype>
KeyType.Enum = {
    ---@type oskeytype
    ['0'] = OSKEY_0 or getEnum(),
    ---@type oskeytype
    ['1'] = OSKEY_1 or getEnum(),
    ---@type oskeytype
    ['2'] = OSKEY_2 or getEnum(),
    ---@type oskeytype
    ['3'] = OSKEY_3 or getEnum(),
    ---@type oskeytype
    ['4'] = OSKEY_4 or getEnum(),
    ---@type oskeytype
    ['5'] = OSKEY_5 or getEnum(),
    ---@type oskeytype
    ['6'] = OSKEY_6 or getEnum(),
    ---@type oskeytype
    ['7'] = OSKEY_7 or getEnum(),
    ---@type oskeytype
    ['8'] = OSKEY_8 or getEnum(),
    ---@type oskeytype
    ['9'] = OSKEY_9 or getEnum(),
    ---@type oskeytype
    ['A'] = OSKEY_A or getEnum(),
    ---@type oskeytype
    ['B'] = OSKEY_B or getEnum(),
    ---@type oskeytype
    ['C'] = OSKEY_C or getEnum(),
    ---@type oskeytype
    ['D'] = OSKEY_D or getEnum(),
    ---@type oskeytype
    ['E'] = OSKEY_E or getEnum(),
    ---@type oskeytype
    ['F'] = OSKEY_F or getEnum(),
    ---@type oskeytype
    ['G'] = OSKEY_G or getEnum(),
    ---@type oskeytype
    ['H'] = OSKEY_H or getEnum(),
    ---@type oskeytype
    ['I'] = OSKEY_I or getEnum(),
    ---@type oskeytype
    ['J'] = OSKEY_J or getEnum(),
    ---@type oskeytype
    ['K'] = OSKEY_K or getEnum(),
    ---@type oskeytype
    ['L'] = OSKEY_L or getEnum(),
    ---@type oskeytype
    ['M'] = OSKEY_M or getEnum(),
    ---@type oskeytype
    ['N'] = OSKEY_N or getEnum(),
    ---@type oskeytype
    ['O'] = OSKEY_O or getEnum(),
    ---@type oskeytype
    ['P'] = OSKEY_P or getEnum(),
    ---@type oskeytype
    ['Q'] = OSKEY_Q or getEnum(),
    ---@type oskeytype
    ['R'] = OSKEY_R or getEnum(),
    ---@type oskeytype
    ['S'] = OSKEY_S or getEnum(),
    ---@type oskeytype
    ['T'] = OSKEY_T or getEnum(),
    ---@type oskeytype
    ['U'] = OSKEY_U or getEnum(),
    ---@type oskeytype
    ['V'] = OSKEY_V or getEnum(),
    ---@type oskeytype
    ['W'] = OSKEY_W or getEnum(),
    ---@type oskeytype
    ['X'] = OSKEY_X or getEnum(),
    ---@type oskeytype
    ['Y'] = OSKEY_Y or getEnum(),
    ---@type oskeytype
    ['Z'] = OSKEY_Z or getEnum(),
}

local key_type2str = {
    [KeyType.Enum['0']] = '0',
    [KeyType.Enum['1']] = '1',
    [KeyType.Enum['2']] = '2',
    [KeyType.Enum['3']] = '3',
    [KeyType.Enum['4']] = '4',
    [KeyType.Enum['5']] = '5',
    [KeyType.Enum['6']] = '6',
    [KeyType.Enum['7']] = '7',
    [KeyType.Enum['8']] = '8',
    [KeyType.Enum['9']] = '9',
    [KeyType.Enum['A']] = 'A',
    [KeyType.Enum['B']] = 'B',
    [KeyType.Enum['C']] = 'C',
    [KeyType.Enum['D']] = 'D',
    [KeyType.Enum['E']] = 'E',
    [KeyType.Enum['F']] = 'F',
    [KeyType.Enum['G']] = 'G',
    [KeyType.Enum['H']] = 'H',
    [KeyType.Enum['I']] = 'I',
    [KeyType.Enum['J']] = 'J',
    [KeyType.Enum['K']] = 'K',
    [KeyType.Enum['L']] = 'L',
    [KeyType.Enum['M']] = 'M',
    [KeyType.Enum['N']] = 'N',
    [KeyType.Enum['O']] = 'O',
    [KeyType.Enum['P']] = 'P',
    [KeyType.Enum['Q']] = 'Q',
    [KeyType.Enum['R']] = 'R',
    [KeyType.Enum['S']] = 'S',
    [KeyType.Enum['T']] = 'T',
    [KeyType.Enum['U']] = 'U',
    [KeyType.Enum['V']] = 'V',
    [KeyType.Enum['W']] = 'W',
    [KeyType.Enum['X']] = 'X',
    [KeyType.Enum['Y']] = 'Y',
    [KeyType.Enum['Z']] = 'Z',
}

---@param val any
---@return boolean
function KeyType.isKeyType(val)
    if key_type2str[val] then
        return true
    end
    return false
end

---@param key_type oskeytype
---@return string
function KeyType.toStr(key_type)
    local res = key_type2str[key_type]
    if res == nil then
        Log:err('variable \'atk_type\' is not of type attacktype', 3)
    end
    return res
end

return KeyType