--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityTarget
local AbilityTarget = require(lib_path..'Target.Base') or error('')

--=======
-- Class
--=======

local AbilityTargetPoint = Class.new('AbilityTargetPoint', AbilityTarget)
---@class AbilityTargetPoint : AbilityTarget
local public = AbilityTargetPoint.public
---@class AbilityTargetPointClass : AbilityTargetClass
local static = AbilityTargetPoint.static
---@type AbilityTargetPointClass
local override = AbilityTargetPoint.override
local private = {}

--=========
-- Static
--=========

---@param x number
---@param y number
---@param child AbilityTargetPoint | nil
---@return AbilityTargetPoint
function override.new(x, y, child)
    isTypeErr(x, 'number', 'x')
    isTypeErr(y, 'number', 'y')
    if child then
        isTypeErr(child, AbilityTargetPoint, 'child')
    end

    local instance = child or Class.allocate(AbilityTargetPoint)
    instance = AbilityTarget.new(instance)
    private.newData(instance, x, y)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return private.data[self].x
end

---@return number
function public:getY()
    return private.data[self].y
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetPoint
---@param x number
---@param y number
function private.newData(self, x, y)
    local priv = {
        x = x,
        y = y
    }
    private.data[self] = priv
end

return static