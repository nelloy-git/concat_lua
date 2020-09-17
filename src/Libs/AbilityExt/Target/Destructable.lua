--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Destructable = HandleLib.Destructable or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityTarget
local AbilityTarget = require(lib_path..'Target.Base')

--=======
-- Class
--=======

local AbilityTargetDestructable = Class.new('AbilityTargetDestructable', AbilityTarget)
---@class AbilityTargetDestructable : AbilityTarget
local public = AbilityTargetDestructable.public
---@class AbilityTargetDestructableClass : AbilityTargetClass
local static = AbilityTargetDestructable.static
---@type AbilityTargetDestructableClass
local override = AbilityTargetDestructable.override
local private = {}

--=========
-- Static
--=========

---@param destr Destructable
---@param child AbilityTargetDestructable | nil
---@return AbilityTargetDestructable
function override.new(destr, child)
    isTypeErr(destr, Destructable, 'destr')
    if child then isTypeErr(child, AbilityTargetDestructable, 'child') end

    local instance = child or Class.allocate(AbilityTargetDestructable)
    instance = AbilityTarget.new(instance)
    private.newData(instance, destr)

    return instance
end

--========
-- Public
--========

---@return Destructable
function public:getDestructable()
    return private.data[self].destr
end

---@return number
function public:getX()
    return self:getDestructable():getX()
end

---@return number
function public:getY()
    return self:getDestructable():getY()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetDestructable
---@param destr destructable
function private.newData(self, destr)
    local priv = {
        destr = destr
    }
    private.data[self] = priv
end

return static