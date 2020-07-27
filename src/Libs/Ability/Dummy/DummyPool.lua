---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

local FourCC = function(id) return string.unpack(">I4", id) end

--========
-- Module
--========

---@class DummyAbilitiesPool
local DummyAbilityPool = {}

local pool_size = 180
local pool = {}

---@param name string
---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
---@param lvls number
---@return BinaryAbility
local function createDummy(name, target_type, is_area, lvls)
    local id = FourCC(BinaryLib.getAbilityId())
    local base_id = FourCC('ANcl')  -- Channel ability.
    local data = BinaryLib.Ability.new(id, base_id, name)
    data:setLevels(lvls)
    data:setArtCaster('')
    data:setArtEffect('')
    data:setArtSpecial('')
    data:setArtTarget('')
    for i = 0, lvls - 1 do
        data:setDisableOtherAbilities(false, i)
        data:setFollowThoughTime(0, i)
        data:setArtDuration(0, i)
        data:setOptions(true, is_area, false, false, false, i)
        data:setOrderId(BinaryLib.getOrderId(), i)
        data:setTargetType(target_type, i)
    end

    return data
end

---@return BinaryAbility
function DummyAbilityPool.pop()
    local dummy = table.remove(pool)
    if dummy == nil then
        Log:err('DummyAbilityPool is empty.', 2)
    end

    return dummy
end

---@param abil BinaryAbility
function DummyAbilityPool.push(abil)
    checkTypeErr(abil, BinaryLib.Ability, 'abil')
    if abil:getBaseId() ~= FourCC('ANcl') then
        Log:err('Can not push ability which is not based on \"ANcl\"', 2)
    end

    table.insert(pool, abil)
end

for i = 1, pool_size do
    local dummy = createDummy(('DummyAbility%d'):format(i), 'None', false, 1)
    DummyAbilityPool.push(pool, dummy)
end

return DummyAbilityPool