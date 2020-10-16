--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type BinaryLib
local BinaryLib = lib_dep.Binary
local BinAbility = BinaryLib.Ability

--=======
-- Module
--========

---@class AbilityExtSettings
local Settings = {}

---@param id number
---@return string
local function id2Str(id)
    local s_id = ''
    for i = 0, 3 do
        s_id = string.char(id >> (8 * i) & 0xFF)..s_id
    end
    return s_id
end

Settings.dummy_hotkey = 'N'
Settings.dummy_type = BinAbility.new(BinaryLib.getAbilityId(),
                                     string.unpack('>I4', 'ANcl'),
                                     id2Str(BinaryLib.getAbilityId()))
Settings.dummy_type:setLevels(1)
Settings.dummy_type:setHero(false)
Settings.dummy_type:setArtCaster('')
Settings.dummy_type:setArtEffect('')
Settings.dummy_type:setArtSpecial('')
Settings.dummy_type:setArtTarget('')
Settings.dummy_type:setDisableOtherAbilities(true, 1)
Settings.dummy_type:setFollowThoughTime(0, 1)
Settings.dummy_type:setArtDuration(0, 1)
Settings.dummy_type:setOptions(true, false, false, false, false, 1)
Settings.dummy_type:setOrderId(BinaryLib.getOrderId(), 1)
Settings.dummy_type:setTargeting('Unit', 1)
Settings.dummy_type:setHotkey(Settings.dummy_hotkey)

return Settings