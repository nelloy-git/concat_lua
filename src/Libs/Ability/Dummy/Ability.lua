--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Ability = UtilsLib.Handle.Ability
local AbilityPublic = Class.getPublic(Ability)
local ActionList = UtilsLib.ActionList
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

---@type DummyAbilityType
local DummyAbilityType = require(lib_modname..'.Dummy.Type')
--endregion

--=======
-- Class
--=======

local DummyAbility = Class.new('DummyAbility', Ability)
---@class DummyAbility : Ability
local public = DummyAbility.public
---@class DummyAbilityClass : AbilityClass
local static = DummyAbility.static
---@type DummyAbilityClass
local override = DummyAbility.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param child_instance DummyAbility | nil
---@return DummyAbility
function override.new(owner, hotkey, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(hotkey, 'string', 'hotkey')
    if child_instance then checkTypeErr(child_instance, DummyAbility, 'child_instance') end

    local abil_type = DummyAbilityType.pop(hotkey)
    local instance = child_instance or Class.allocate(DummyAbility)
    instance = Ability.new(owner:getHandleData(), abil_type:getId(), instance)
    private.newData(instance, owner, abil_type, hotkey)

    return instance
end

--========
-- Public
--========

---@param name string
function public:setName(name)
    BlzSetAbilityTooltip(private.data[self].abil_type:getId(), name, 0)
end

---@param tooltip string
function public:setTooltip(tooltip)
    BlzSetAbilityExtendedTooltip(private.data[self].abil_type:getId(), tooltip, 0)
end

---@param icon string
function public:setIcon(icon)
    BlzSetAbilityIcon(private.data[self].abil_type:getId(), icon)
end

function public:destroy()
    local priv = private.data[self]
    DummyAbilityType.push(priv.hotkey, priv.abil_type)
    AbilityPublic.destroy()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self DummyAbility
---@param owner Unit
function private.newData(self, owner, abil_type, hotkey)
    local priv = {
        owner = owner,
        abil_type = abil_type,
        hotkey = hotkey
    }
    private.data[self] = priv
end

return static