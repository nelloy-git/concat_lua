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

local DummyAbilityType = Class.new('DummyAbility', BinaryAbility)
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
---@param lvls number
---@param child_instance DummyAbility | nil
---@return DummyAbility
function static.new(target_type, is_area, lvls, child_instance)
    checkTypeErr(target_type, 'string', 'target_type')
    if not (target_type == 'None' or
            target_type == 'Unit' or
            target_type == 'Point' or
            target_type == 'PointOrUnit') then
        Log:err('Got wrong \"target_type\".')
    end
    checkTypeErr(is_area, 'boolean', 'is_area')
    checkTypeErr(lvls, 'number', 'lvls')
    if child_instance then checkTypeErr(child_instance, DummyAbilityType, 'child_instance') end

    local instance = child_instance or Class.allocate(DummyAbilityType)
    local id = BinaryLib.getAbilityId()
    local order_id = BinaryLib.getOrderId()
    instance = BinaryAbility.new(id, private.channel_id, private.id2Str(id))

    instance:setLevels(1)
    instance:setArtCaster('')
    instance:setArtEffect('')
    instance:setArtSpecial('')
    instance:setArtTarget('')
    instance:setDisableOtherAbilities(false, 0)
    instance:setFollowThoughTime(0, 0)
    instance:setArtDuration(0, 0)
    instance:setOptions(true, is_area, false, false, false, 0)
    instance:setOrderId(order_id, 0)
    instance:setTargetType(target_type, 0)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

private.channel_id = string.unpack('>I4', 'ANcl')

---@param id number
---@return string
function private.id2Str(id)
    local s_id = ''
    for i = 0, 3 do
        s_id = string.char(id >> (8 * i) & 0xFF)..s_id
    end
    return s_id
end

return static