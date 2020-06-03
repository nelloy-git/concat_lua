--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType

local GetDestructableX = GetDestructableX
local GetDestructableY = GetDestructableY

--=======
-- Class
--=======

local Destrcutable = Class.new('Destructable', Handle)
---@class Destructable : Handle
local public = Destrcutable.public
---@class DestructableClass : HandleClass
local static = Destrcutable.static
---@type DestructableClass
local override = Destrcutable.override
local private = {}

--=========
-- Static
--=========

---@param id number
---@param x number
---@param y number
---@param z number
---@param face number
---@param scale number
---@param variation number
---@param child_instance Destructable | nil
---@return Destructable
function override.new(id, x, y, z, face, scale, variation, child_instance)
    checkType(id, 'number', 'id')
    checkType(x, 'number', 'x')
    checkType(y, 'number', 'y')
    checkType(z, 'number', 'z')
    checkType(face, 'number', 'face')
    checkType(scale, 'number', 'scale')
    checkType(variation, 'number', 'variation')
    if child_instance then
        checkType(child_instance, Destrcutable, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Destrcutable)
    instance = Handle.new(CreateDestructableZ(id, x, y, z, face, scale, variation), RemoveDestructable, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetDestructableX(self:getHandleData())
end

---@return number
function public:getY()
    return GetDestructableY(self:getHandleData())
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Destructable
function private.newData(self, owner)
    local priv = {
        owner = owner
    }
    private.data[self] = priv
end

return static