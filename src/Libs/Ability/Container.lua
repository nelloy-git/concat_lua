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

---@type AbilityClass
local Ability = require(lib_modname..'.Ability')
---@type AbilityTypeClass
local AbilityType = require(lib_modname..'.Type')
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

---@alias SetAbilityCallback fun(container:AbilitiesContainer, pos:number, old:Ability, new:Ability)

--- Owner must have no abilities.
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

---@param callback SetAbilityCallback
---@return Action
function static.addSetAbilityAction(callback)
    return private.set_action_list:add(callback)
end

---@param action Action
---@return boolean
function static.removeSetAbilityAction(action)
    return private.set_action_list:remove(action)
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
    if abil_type then checkTypeErr(abil_type, AbilityType, 'abil_type') end

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

---@param self AbilitiesContainer
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