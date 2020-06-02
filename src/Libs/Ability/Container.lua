--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = require(Lib.Class)

---@type UtilsLib
local UtilsLib = require(Lib.Utils)
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
---@param size number
---@param child_instance AbilitiesContainer | nil
---@return AbilitiesContainer
function override.new(owner, size, child_instance)
    checkType(size, 'number', 'size')
    if child_instance then
        checkType(child_instance, AbilitiesContainer, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilitiesContainer)
    private.newData(instance, size, owner)

    return instance
end

--========
-- Public
--========

---@param pos number
---@return Ability | nil
function public:get(pos)
    local priv = private.data[self]

    if pos < 1 or pos > priv.size then
        Log:wrn(tostring(self)..': selected position ('..pos..') is not allowed. Returned \'nil\'.')
    end

    return priv.list[pos]
end

---@param abil_type AbilityType
function public:set(pos, abil_type)
    local priv = private.data[self]

    if pos < 1 or pos > priv.size then
        Log:wrn(tostring(self)..': selected position ('..pos..') is not allowed.')
        return
    end

    priv.list[pos] = Ability.new(priv.owner, abil_type)
end

---@return number
function public:getSize()
    return private.data[self].size
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilitiesContainer
---@param size number
---@param owner unit
function private.newData(self, size, owner)
    local priv = {
        size = size,
        owner = owner,
        list = {}
    }
    private.data[self] = priv
end

return static