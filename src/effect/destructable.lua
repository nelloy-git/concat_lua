---@type DestructableDB
local DestructableDB = require('effect.destructableDB')

---@class Destructable
local Destructable = {}
local Destructable_meta = {
    __index = Destructable,
    __gc = Destructable.destroy
}

---@param self Destructable
function Destructable_meta.__tostring(self)
    return string.format('Destructable %s (%s) at [%.2f, %.2f, %.2f]',
                         self:getName(), ID2str(self:getId()), self:getX(), self:getY(), self:getZ())
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
        id = id,
        destructable_obj = obj,
        __visible = true,
        __x = x,
        __y = y,
        __z = z
    }
    setmetatable(destr, Destructable_meta)
    DestructableDB.add(destr.destructable_obj, destr)

    return destr
end

---@return nil
function Destructable:destroy()
    DestructableDB.rm(self.destructable_obj)
    RemoveDestructable(self.destructable_obj)
    self.destructable_obj = nil
end

---@return nil
function Destructable:kill()
    KillDestructable(self.destructable_obj)
end

---@param flag boolean
---@return nil
function Destructable:setInvulnerable(flag)
    SetDestructableInvulnerable(self.destructable_obj, flag)
end

---@return boolean
function Destructable:isInvulnerable()
    return IsDestructableInvulnerable(self.destructable_obj)
end

---@return integer
function Destructable:getId()
    return self.id
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

---@return number
function Destructable:getLife()
    return GetDestructableLife(self.destructable_obj)
end

---@param life number
---@return nil
function Destructable:setLife(life)
    SetDestructableLife(self.destructable_obj, life)
end

---@return number
function Destructable:getMaxLife()
    return GetDestructableMaxLife(self.destructable_obj)
end

---@param max_life any
---@return nil
function Destructable:setMaxLife(max_life)
    SetDestructableMaxLife(self.destructable_obj, max_life)
end

---@param life number
---@param birth boolean
---@return nil
function Destructable:restoreLife(life, birth)
    DestructableRestoreLife(self.destructable_obj, life, birth)
end

---@param animation string
---@return nil
function Destructable:playAnimation(animation)
    SetDestructableAnimation(self.destructable_obj, animation)
end

---@param speed number
---@return nil
function Destructable:setAnimationSpeed(speed)
    SetDestructableAnimationSpeed(self.destructable_obj, speed)
end

---@param flag boolean
---@return nil
function Destructable:visible(flag)
    ShowDestructable(self.destructable_obj, flag)
    self.__visible = flag
end

---@param height number
---@return nil
function Destructable:setOccluderHeight(height)
    SetDestructableOccluderHeight(self.destructable_obj, height)
end

---@return number
function Destructable:getOccluderHeight()
    return GetDestructableOccluderHeight(self.destructable_obj)
end

---@return string
function Destructable:getName()
    return GetDestructableName(self.destructable_obj)
end

__replaced_functions = {
    GetSpellTargetDestructable = GetSpellTargetDestructable,
    GetOrderTargetDestructable = GetOrderTargetDestructable,
    GetTriggerDestructable = GetTriggerDestructable,
    GetUnitRallyDestructable = GetUnitRallyDestructable
}

---@return Destructable
function GetSpellTargetDestructable() return DestructableDB.get(__replaced_functions.GetSpellTargetDestructable()) end
---@return Destructable
function GetOrderTargetDestructable() return DestructableDB.get(__replaced_functions.GetOrderTargetDestructable()) end
---@return Destructable
function GetTriggerDestructable() return DestructableDB.get(__replaced_functions.GetTriggerDestructable()) end
---@return Destructable
function GetUnitRallyDestructable() return DestructableDB.get(__replaced_functions.GetUnitRallyDestructable()) end

return Destructable