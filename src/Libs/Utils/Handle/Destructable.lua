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
local checkTypeErr = Functions.checkTypeErr

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
    checkTypeErr(id, 'number', 'id')
    checkTypeErr(x, 'number', 'x')
    checkTypeErr(y, 'number', 'y')
    checkTypeErr(z, 'number', 'z')
    checkTypeErr(face, 'number', 'face')
    checkTypeErr(scale, 'number', 'scale')
    checkTypeErr(variation, 'number', 'variation')
    if child_instance then
        checkTypeErr(child_instance, Destrcutable, 'child_instance')
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