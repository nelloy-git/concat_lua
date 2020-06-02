--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger

---@type AbilityClass
local Ability = require(lib_modname..'.Ability')

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

---@param owner unit
---@param child_instance AbilitiesContainer | nil
---@return AbilitiesContainer
function static.new(owner, child_instance)
    checkType(owner, 'unit', 'owner')
    if child_instance then
        checkType(child_instance, AbilitiesContainer, 'child_instance')
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

---@param pos number
---@return Ability | nil
function public:get(pos)
    return private.data[self].list[pos]
end

---@param abil_type AbilityType
function public:set(pos, abil_type)
    local priv = private.data[self]
    priv.list[pos] = Ability.new(priv.owner, abil_type)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'kv'})

---@param self AbilitiesContainer
---@param owner unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        list = {}
    }
    private.data[self] = priv
    private.owners[owner] = self
end

return static