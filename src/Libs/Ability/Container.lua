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

---@type AbilityDataClass
local AbilityData = require(lib_modename..'.Ability')
---@type AbilityDataTypeClass
local AbilityDataType = require(lib_modename..'.Type')
---@type DummyAbility
local DummyAbility = require(lib_modename..'Dummy.Ability')
--endregion

--=======
-- Class
--=======

local AbilitiesContainer = Class.new('AbilitiesContainer')
---@class AbilitiesContainer
local public = AbilitiesContainer.public
---@class AbilitiesContainerClass
local static = AbilitiesContainer.static
---@type AbilitiesContainerClass
local override = AbilitiesContainer.override
local private = {}

--=========
-- Static
--=========

---@alias SetAbilityDataCallback fun(container:AbilitiesContainer, pos:number, old:AbilityData, new:AbilityData)

---@param owner Unit
---@param child_instance AbilitiesContainer | nil
---@return AbilitiesContainer
function static.new(owner, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    if child_instance then
        checkTypeErr(child_instance, AbilitiesContainer, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilitiesContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owners[owner]
end

--========
-- Public
--========

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return AbilityData | nil
function public:get(hotkey)
    return private.data[self].hotkeys_data[hotkey]
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param abil_type AbilityDataType | nil
function public:set(hotkey, abil_type)
    if abil_type then checkTypeErr(abil_type, AbilityDataType, 'abil_type') end

    local priv = private.data[self]
    local old_dummy = priv.hotkeys_dummy
    if old_dummy ~= nil then old_dummy:destroy() end

    priv.hotkeys_dummy[hotkey] = DummyAbility.new(priv.owner, hotkey)
    priv.hotkeys_data[hotkey] = AbilityData.new(priv.owner, abil_type)

    private.linkDummy(priv.hotkeys_dummy[hotkey], priv.hotkeys_data[hotkey])
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

---@param self AbilitiesContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,

        hotkeys_dummy = {},
        hotkeys_data = {}
    }
    private.data[self] = priv
    private.owners[owner] = self
end

---@param dummy DummyAbility
---@param abil AbilityData
function private.linkDummy(dummy, abil)
end

--function 

return static