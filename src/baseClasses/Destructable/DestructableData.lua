local DataBase = require('utils.DataBase')

---@class Destructable
local Destructable = {
    __type = "DestructableClass",
    __db = DataBase
}
local Destructable_meta = {
    __type = "Destructable",
    __index = Destructable,
    __gc = Destructable.destroy
}

---@param self Destructable
function Destructable_meta.__tostring(self)
    return string.format('Destructable %s (%s) at [%.2f, %.2f, %.2f]',
                         self:getName(), ID2str(self.__id), self:getX(), self:getY(), self:getZ())
end


---@param id string|integer
---@param x number
---@param y number
---@param z number
---@param face number
---@param scale number
---@param variation integer
---@param is_dead boolean
---@return Destructable
function Destructable.new(id, x, y, z, face, scale, variation, is_dead)
    id = ID(id)
    local obj = nil
    if is_dead then
        obj = CreateDeadDestructableZ(id, x, y, z, face, scale, variation)
    else
        obj = CreateDestructableZ(id, x, y, z, face, scale, variation)
    end
    ---@type Destructable
    local destr = {
        __id = id,
        __destructable_obj = obj,
        __visible = true,
        __x = x,
        __y = y,
        __z = z
    }
    setmetatable(destr, Destructable_meta)
    Destructable.__db:add(obj, destr)

    return destr
end

---@return nil
function Destructable:destroy()
    Destructable.__db:remove(self.__destructable_obj)
    RemoveDestructable(self.__destructable_obj)
    self.__destructable_obj = nil
end

---@return nil
function Destructable:kill()
    KillDestructable(self.__destructable_obj)
end

---@param flag boolean
---@return nil
function Destructable:setInvulnerable(flag)
    SetDestructableInvulnerable(self.__destructable_obj, flag)
end

---@return boolean
function Destructable:isInvulnerable()
    return IsDestructableInvulnerable(self.__destructable_obj)
end

---@return integer
function Destructable:getId()
    return self.__id
end

---@return number
function Destructable:getX()
    return self.__x
end

---@return number
function Destructable:getY()
    return self.__y
end

---@return number
function Destructable:getZ()
    return self.__z
end

function Destructable:getPos()
    return Vec3(self.__x, self.__y, self.__z)
end

---@return number
function Destructable:getLife()
    return GetDestructableLife(self.__destructable_obj)
end

---@param life number
---@return nil
function Destructable:setLife(life)
    SetDestructableLife(self.__destructable_obj, life)
end

---@return number
function Destructable:getMaxLife()
    return GetDestructableMaxLife(self.__destructable_obj)
end

---@param max_life any
---@return nil
function Destructable:setMaxLife(max_life)
    SetDestructableMaxLife(self.__destructable_obj, max_life)
end

---@param life number
---@param birth boolean
---@return nil
function Destructable:restoreLife(life, birth)
    DestructableRestoreLife(self.__destructable_obj, life, birth)
end

---@param animation string
---@return nil
function Destructable:playAnimation(animation)
    SetDestructableAnimation(self.__destructable_obj, animation)
end

---@param speed number
---@return nil
function Destructable:setAnimationSpeed(speed)
    SetDestructableAnimationSpeed(self.__destructable_obj, speed)
end

---@param flag boolean
---@return nil
function Destructable:visible(flag)
    ShowDestructable(self.__destructable_obj, flag)
    self.__visible = flag
end

---@param height number
---@return nil
function Destructable:setOccluderHeight(height)
    SetDestructableOccluderHeight(self.__destructable_obj, height)
end

---@return number
function Destructable:getOccluderHeight()
    return GetDestructableOccluderHeight(self.__destructable_obj)
end

---@return string
function Destructable:getName()
    return GetDestructableName(self.__destructable_obj)
end

---@return Destructable
function Destructable.GetSpellTargetDestructable() return Destructable.__db:get(GetSpellTargetDestructable()) end
---@return Destructable
function Destructable.GetOrderTargetDestructable() return Destructable.__db:get(GetOrderTargetDestructable()) end
---@return Destructable
function Destructable.GetTriggerDestructable() return Destructable.__db:get(GetTriggerDestructable()) end
---@return Destructable
function Destructable.GetUnitRallyDestructable() return Destructable.__db:get(GetUnitRallyDestructable()) end

return Destructable