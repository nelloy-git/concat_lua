--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type BinaryLib
local BinaryLib = depencies.BinaryLib
local BinaryAbility = BinaryLib.Ability
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local ActionList = UtilsLib.ActionList
local Log = UtilsLib.DefaultLogger
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

--endregion

--=======
-- Class
--=======

local DummyAbilityType = Class.new('DummyAbilityType', BinaryAbility)
---@class DummyAbilityType : BinaryAbility
local public = DummyAbilityType.public
---@class DummyAbilityTypeClass : BinaryAbilityClass
local static = DummyAbilityType.static
---@type DummyAbilityClass
local override = DummyAbilityType.override
local private = {}

--=========
-- Static
--=========

---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
---@param child_instance DummyAbility | nil
---@return DummyAbility
function override.new(target_type, is_area, child_instance)
    checkTypeErr(target_type, 'string', 'target_type')
    if not (target_type == 'None' or
            target_type == 'Unit' or
            target_type == 'Point' or
            target_type == 'PointOrUnit') then
        Log:err('Got wrong \"target_type\".', 2)
    end
    checkTypeErr(is_area, 'boolean', 'is_area')
    if child_instance then checkTypeErr(child_instance, DummyAbilityType, 'child_instance') end

    local instance = child_instance or Class.allocate(DummyAbilityType)
    local id = BinaryLib.getAbilityId()
    local order_id = BinaryLib.getOrderId()
    instance = BinaryAbility.new(id, private.channel_id, private.id2Str(id), instance)

    instance:setLevels(1)
    instance:setHero(false)
    --instance:setArtCaster('')
    --instance:setArtEffect('')
    --instance:setArtSpecial('')
    --instance:setArtTarget('')
    --instance:setDisableOtherAbilities(false, 0)
    --instance:setFollowThoughTime(0, 0)
    --instance:setArtDuration(0, 0)
    instance:setOptions(true, is_area, false, false, false, 0)
    --instance:setOrderId(order_id, 0)
    --instance:setTargetType(target_type, 0)

    return instance
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return BinaryAbility
function static.pop(hotkey)
    checkTypeErr(hotkey, 'string', 'hotkey')

    local list = private.pool[hotkey]
    if list == nil then
        Log:err('Wrong hotkey.', 2)
    end
    local dummy = table.remove(list)
    if dummy == nil then
        Log:err('DummyAbilityPool is empty.', 2)
    end

    return dummy
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param abil BinaryAbility
function static.push(hotkey, abil)
    checkTypeErr(hotkey, 'string', 'hotkey')
    checkTypeErr(abil, DummyAbilityType, 'abil')

    local list = private.pool[hotkey]
    if list == nil then
        Log:err('Wrong hotkey.', 2)
    end
    table.insert(list, abil)
end

--========
-- Public
--========

--=========
-- Private
--=========

private.channel_id = string.unpack('>I4', 'ANcl')

private.pool_size_per_hotkey = 2

private.pool = {
    ['Q'] = {},
--    ['W'] = {},
--    ['E'] = {},
--    ['R'] = {},
--    ['T'] = {},
--    ['D'] = {},
--    ['F'] = {}
}

private.pos = {
    ['Q'] = {x = 1, y = 1},
    ['W'] = {x = 2, y = 1},
    ['E'] = {x = 3, y = 1},
    ['R'] = {x = 0, y = 2},
    ['T'] = {x = 1, y = 2},
    ['D'] = {x = 2, y = 2},
    ['F'] = {x = 3, y = 2},
}

---@param id number
---@return string
function private.id2Str(id)
    local s_id = ''
    for i = 0, 3 do
        s_id = string.char(id >> (8 * i) & 0xFF)..s_id
    end
    return s_id
end

for hotkey, _ in pairs(private.pool) do
    local dummy = static.new('None', false)
    --dummy:setHotkey(hotkey)
    --dummy:setButtonPositionNormal(private.pos[hotkey].x, private.pos[hotkey].y)
    static.push(hotkey, dummy)
end

return static