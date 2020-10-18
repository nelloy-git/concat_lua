--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Trigger = HandleLib.Trigger or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

---@class InputKeyboard
local Keyboard = {}

local key2data = {
    ['0'] = OSKEY_0,
    ['1'] = OSKEY_1,
    ['2'] = OSKEY_2,
    ['3'] = OSKEY_3,
    ['4'] = OSKEY_4,
    ['5'] = OSKEY_5,
    ['6'] = OSKEY_6,
    ['7'] = OSKEY_7,
    ['8'] = OSKEY_8,
    ['9'] = OSKEY_9,
    ['A'] = OSKEY_A,
    ['B'] = OSKEY_B,
    ['C'] = OSKEY_C,
    ['D'] = OSKEY_D,
    ['E'] = OSKEY_E,
    ['F'] = OSKEY_F,
    ['G'] = OSKEY_G,
    ['H'] = OSKEY_H,
    ['I'] = OSKEY_I,
    ['J'] = OSKEY_J,
    ['K'] = OSKEY_K,
    ['L'] = OSKEY_L,
    ['M'] = OSKEY_M,
    ['N'] = OSKEY_N,
    ['O'] = OSKEY_O,
    ['P'] = OSKEY_P,
    ['Q'] = OSKEY_Q,
    ['R'] = OSKEY_R,
    ['S'] = OSKEY_S,
    ['T'] = OSKEY_T,
    ['U'] = OSKEY_U,
    ['V'] = OSKEY_V,
    ['W'] = OSKEY_W,
    ['X'] = OSKEY_X,
    ['Y'] = OSKEY_Y,
    ['Z'] = OSKEY_Z,
}

local actions = {}
local trigger
if not IsCompiletime() then
    trigger = Trigger.new()
end

---@param key string
---@param callback any
function Keyboard:addAction(key, callback)
    local key_data = key2data[key]
    if not key_data then
        Log:err('Unavailable key.')
    end

    if not actions[key] then
        actions[key] = ActionList.new()

        for i = 0, 3 do
            trigger:addPlayerKeyEvent(GetLocalPlayer(), key_data, 2^i, true)
            trigger:addPlayerKeyEvent(GetLocalPlayer(), key_data, 2^i, false)
        end
    end
end

return Keyboard