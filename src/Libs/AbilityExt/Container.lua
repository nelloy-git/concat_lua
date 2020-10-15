--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtClass
local AbilityExt = require(lib_path..'Ability')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local Event = AbilityExtEventModule.Enum or error('')
---@type AbilityExtTypeTargetingClass
local AbilityExtTypeTargeting = require(lib_path..'Type.Targeting') or error('')
---@type AbilityExtTypeClass
local AbilityExtType = require(lib_path..'Type')

--=======
-- Class
--=======

local AbilityExtContainer = Class.new('AbilityExtContainer')
---@class AbilityExtContainer
local public = AbilityExtContainer.public
---@class AbilityExtContainerClass
local static = AbilityExtContainer.static
---@type AbilityExtContainerClass
local override = AbilityExtContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child AbilityExtContainer | nil
---@return AbilityExtContainer
function override.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, AbilityExtContainer, 'child') end

    local instance = child or Class.allocate(AbilityExtContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owners[owner]
end

--========
-- Public
--========

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@param pos number
---@param targeting_type AbilityExtTypeTargetingClass
---@param abil_type AbilityExtType | nil
function public:set(pos, targeting_type, abil_type)
    isTypeErr(pos, 'number', 'pos')
    isTypeErr(targeting_type, AbilityExtTypeTargeting, 'targeting_type')
    if abil_type then isTypeErr(abil_type, AbilityExtType, 'abil_type') end

    local priv = private.data[self]

    local prev = priv.abil_list[pos]
    if prev then
        private.abil2container[prev] = nil
    end

    local abil = nil
    if abil_type then
        abil = AbilityExt.new(priv.owner, targeting_type, abil_type)
    end
    priv.abil_list[pos] = abil
end

---@param pos number
---@return AbilityExt | nil
function public:get(pos)
    return private.data[self].abil_list[pos]
end

---@return table<number, AbilityExt>
function public:getAll()
    local priv = private.data[self]

    local copy = {}
    for k,v in pairs(priv.abil_list) do
        copy[k] = v
    end

    return copy
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        abil_list = {}
    }
    private.data[self] = priv
    private.owners[owner] = self
end

return static