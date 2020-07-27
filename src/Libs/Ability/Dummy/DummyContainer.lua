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
local Trigger = UtilsLib.Handle.Trigger

---@type AbilitiesContainerClass
local AbilitiesContainer = require(lib_modname..'.Container')
---@type DummyAbilitiesPool
local DummyAbilitiesPool = require(lib_modname..'.DummyPool')
--endregion

--=======
-- Class
--=======

local DummyContainer = Class.new('DummyContainer', AbilitiesContainer)
---@class DummyContainer : AbilitiesContainer
local public = DummyContainer.public
---@class DummyContainerClass : AbilitiesContainerClass
local static = DummyContainer.static
---@type DummyContainerClass
local override = DummyContainer.override
local private = {}

--=========
-- Static
--=========

--- Owner must have no abilities.
---@param owner Unit
---@param child_instance DummyContainer | nil
---@return DummyContainer
function static.new(owner, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    if child_instance then checkTypeErr(child_instance, DummyContainer, 'child_instance') end

    local instance = child_instance or Class.allocate(DummyContainer)
    instance = AbilitiesContainer.new(owner, instance)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self DummyContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        trigger = Trigger.new(),
        dummies = {}
    }
    private.data[self] = priv


end

return static