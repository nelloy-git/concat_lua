--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local ActionList = UtilsLib.ActionList
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

---@type DummyAbilityType
local DummyAbilityType = require(lib_modname..'.Dummy.Type')
--endregion

--=======
-- Class
--=======

local DummyAbility = Class.new('DummyAbility')
---@class DummyAbility
local public = DummyAbility.public
---@class DummyAbilityClass
local static = DummyAbility.static
---@type DummyAbilityClass
local override = DummyAbility.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param abil_type DummyAbilityType
---@param child_instance DummyAbility | nil
---@return DummyAbility
function static.new(owner, abil_type, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(abil_type, DummyAbilityType, 'abil_type')
    if child_instance then checkTypeErr(child_instance, DummyAbility, 'child_instance') end

    local instance = child_instance or Class.allocate(DummyAbility)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param pos number
---@return Ability | nil
function public:get(pos)
    return private.data[self].list[pos]
end

---@param pos number
---@param abil_type AbilityType | nil
function public:set(pos, abil_type)
    if abil_type then checkTypeErr(abil_type, DummyAbilityType, 'abil_type') end

    local priv = private.data[self]
    local old = priv.list[pos]
    local new = Ability.new(priv.owner, abil_type)
    priv.list[pos] = new

    private.set_action_list:run(self, pos, old, new)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

private.set_action_list = ActionList.new()

---@param self DummyAbility
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        list = {}
    }
    private.data[self] = priv
    private.owners[owner] = self
end

return static