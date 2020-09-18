--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type BinaryLib
local BinaryLib = lib_dep.Binary or error('')
local BinaryAbility = BinaryLib.Ability or error('')
---@type TypesLib
local TypesLib = lib_dep.Types or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local AbilityExtDummyPool = Class.new('AbilityExtDummyPool')
---@class AbilityExtDummyPool : BinaryAbility
local public = AbilityExtDummyPool.public
---@class AbilityExtDummyPoolClass : BinaryAbilityClass
local static = AbilityExtDummyPool.static
---@type AbilityExtDummyPool
local override = AbilityExtDummyPool.override
local private = {}

--=========
-- Static
--=========

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return BinaryAbility
function static.pop(hotkey)
    isTypeErr(hotkey, 'string', 'hotkey')

    local list = private.pool[hotkey]
    if list == nil then
        Log:err('Wrong hotkey.', 2)
    end
    local dummy = table.remove(list)
    if dummy == nil then
        Log:err('AbilityPoolDummy is empty. Can be increased with private.pool_size_per_hotkey', 2)
    end

    return dummy
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param abil BinaryAbility
function static.push(hotkey, abil)
    isTypeErr(hotkey, 'string', 'hotkey')
    isTypeErr(abil, BinaryAbility, 'abil')

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

---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
---@param child AbilityExtDummy | nil
---@return AbilityExtDummy
function private.newDummy(target_type, is_area, child)
    isTypeErr(target_type, 'string', 'target_type')
    if not (target_type == 'None' or
            target_type == 'Unit' or
            target_type == 'Point' or
            target_type == 'PointOrUnit') then
        Log:err('Got wrong \"target_type\".', 2)
    end
    isTypeErr(is_area, 'boolean', 'is_area')
    if child then isTypeErr(child, AbilityExtDummyPool, 'child') end

    local id = BinaryLib.getAbilityId()
    local order_id = BinaryLib.getOrderId()
    local instance = BinaryAbility.new(id, private.channel_id, private.id2Str(id))

    instance:setLevels(1)
    instance:setHero(false)
    instance:setArtCaster('')
    instance:setArtEffect('')
    instance:setArtSpecial('')
    instance:setArtTarget('')
    instance:setDisableOtherAbilities(false, 1)
    instance:setFollowThoughTime(0, 1)
    instance:setArtDuration(0, 1)
    instance:setOptions(true, is_area, false, false, false, 1)
    instance:setOrderId(order_id, 1)
    instance:setTargeting(target_type, 1)
    --instance:setTargetsAllowed({
    --    TargetType.ENEMIES,
    --    TargetType.FRIEND,
    --    TargetType.SELF}, 1)

    return instance
end

private.channel_id = string.unpack('>I4', 'ANcl')

private.pool_size_per_hotkey = 10

private.hotkeys = {
    'Q', 'W', 'E', 'R', 'T', 'D', 'F'
}

private.pool = {}
for i = 1, #private.hotkeys do
    private.pool[private.hotkeys[i]] = {}
end

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

for j = 1, private.pool_size_per_hotkey do
    for i = 1, #private.hotkeys do
        local hotkey = private.hotkeys[i]
        local dummy = private.newDummy('None', false)
        dummy:setHotkey(hotkey)
        dummy:setButtonPositionNormal(private.pos[hotkey].x, private.pos[hotkey].y)
        static.push(hotkey, dummy)
    end
end

return static