--=========
-- Include
--=========

--region Include
local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local ActionList = UtilsLib.ActionList
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

---@type AbilityDataTypeClass
local AbilityDataType = require(lib_modename..'.Data.Type')
---@type AbilityDummyClass
local AbilityDummy = require(lib_modename..'.Dummy.Base')
---@type AbilityDummyChargesClass
local AbilityDummyCharges = require(lib_modename..'.Dummy.Charges')
--endregion

--=======
-- Class
--=======

local AbilityData = Class.new('AbilityData')
--region Class
---@class AbilityData
local public = AbilityData.public
---@class AbilityDataClass
local static = AbilityData.static
---@type AbilityDataClass
local override = AbilityData.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param owner Unit
---@param abil_type AbilityDataType
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param child_instance AbilityData | nil
---@return AbilityData
function override.new(owner, abil_type, hotkey, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(abil_type, AbilityDataType, 'abil_type')
    checkTypeErr(hotkey, 'string', 'hotkey')
    if child_instance then checkTypeErr(child_instance, AbilityData, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityData)
    private.newData(instance, owner, abil_type, hotkey)

    return instance
end

override.EVENT = {}


--========
-- Public
--========

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityDataType
function public:getType()
    return private.data[self].abil_type
end

---@param target AbilityTarget
function public:use(target)
    local priv = private.data[self]

    -- Check charges
    local charges = priv.abil_dummy_charges:getChargesLeft()
    local need_charges = priv.abil_type
    if charges < need_charges then
        return
    end
    priv.abil_dummy_charges:setChargesLeft(charges - need_charges)


end

function public:cancel()
end

function public:interrupt()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.dummy2instance = setmetatable({}, {__mode = 'kv'})

---@param self AbilityData
---@param owner Unit
---@param abil_type AbilityDataType
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
function private.newData(self, owner, abil_type, hotkey)
    -- AbilityDummy init
    local abil_dummy = AbilityDummy.new(owner, hotkey)
    abil_dummy:addOnEffectAction(private.onDummyEffect)
    private.dummy2instance[abil_dummy] = self

    -- AbilityDummyCharges init
    local abil_dummy_charges = AbilityDummyCharges.new(abil_dummy, abil_type)

    -- AbilityCasting init

    local priv = {
        owner = owner,
        abil_type = abil_type,
        hotkey = hotkey,

        abil_dummy = abil_dummy,
        abil_dummy_charges = abil_dummy_charges,

        no_charges_actions = ActionList.new(),
    }
    private.data[self] = priv
end

---@type AbilityDummyCallback
private.onDummyEffect = function(abil_dummy)
    ---@type AbilityData
    local self = private.dummy2instance[abil_dummy]
    self:use()
end

return static