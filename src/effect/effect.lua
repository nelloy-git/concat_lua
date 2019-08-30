---@class Effect
local Effect = {}
local Effect_meta = {
    __index = Effect,
    __gc = Effect.destroy
}

---@param self Effect
---@return string
function Effect_meta.__tostring(self)
    return string.format('Effect %s at [%.2f, %.2f, %.2f]',
                          self.getModel(), self:getX(), self:getY(), self:getZ())
end

---@param model string
---@param x number
---@param y number
---@return Effect
function Effect.new(model, x, y, z)
    ---@type Effect
    local effect = {
        effect_obj = AddSpecialEffect(model, x, y),
        __model = model,
        __x = x,
        __y = y,
        __z = z,
        __yaw = 0,
        __pitch = 0,
        __roll = 0,
        __size_x = 1,
        __size_y = 1,
        __size_z = 1
    }
    BlzSetSpecialEffectZ(effect.effect_obj, z)
    setmetatable(effect, Effect_meta)
    return effect
end

---@return nil
function Effect:destroy()
    BlzSetSpecialEffectZ(self.effect_obj, -10000)
    DestroyEffect(self.effect_obj)
end

---@return string
function Effect:getModel()
    return self.__model
end

---@param red number
---@param green number
---@param blue number
---@param alpha number|nil
---@return nil
function Effect:setColor(red, green, blue, alpha)
    BlzSetSpecialEffectColor(self.effect_obj, red, green, blue)
    if alpha ~= nil then BlzSetSpecialEffectAlpha(self.effect_obj, alpha) end
end

---@param scale number
---@return nil
function Effect:setSize(scale)
    BlzSetSpecialEffectScale(self.effect_obj, scale)
    self.__size_x = scale
    self.__size_y = scale
    self.__size_z = scale
end

---@return number, number, number
function Effect:getSize()
    return self.__size_x, self.__size_y, self.__size_z
end

---@param size_x number
---@param size_y number
---@param size_z number
---@return nil
function Effect:setSizeAxis(size_x, size_y, size_z)
    self.__size_x = size_x
    self.__size_y = size_y
    self.__size_z = size_z
    BlzSetSpecialEffectMatrixScale(self.effect_obj, self.__size_x, self.__size_y, self.__size_z)
end

---@param size_x number
---@return nil
function Effect:setSizeX(size_x)
    self:setSizeAxis(size_x, self.__size_y. self.size_z)
end

---@param size_y number
---@return nil
function Effect:setSizeY(size_y)
    self:setSizeAxis(self.__size_x, size_y. self.size_z)
end

---@param size_z number
---@return nil
function Effect:setSizeZ(size_z)
    self:setSizeAxis(self.__size_x, self.__size_y. size_z)
end

---@param x number
---@param y number
---@param z number
---@return nil
function Effect:setPos(x, y, z)
    BlzSetSpecialEffectPosition(self.effect_obj, x, y, z)
    self.__x = x
    self.__y = y
    self.__z = z
end

---@param x number
---@return nil
function Effect:setX(x)
    BlzSetSpecialEffectX(self.effect_obj, x)
    self.__x = x
end

---@param y number
---@return nil
function Effect:setY(y)
    BlzSetSpecialEffectY(self.effect_obj, y)
    self.__y = y
end

---@param z number
---@return nil
function Effect:setZ(z)
    BlzSetSpecialEffectZ(self.effect_obj, z)
    self.__z = z
end

---@return number, number, number
function Effect:getPos()
    return self.__x, self.__y, self.__z
end

---@return number
function Effect:getX()
    return self.__x
end

---@return number
function Effect:getY()
    return self.__y
end

---@return number
function Effect:getZ()
    return self.__z
end

---@param x number
---@return nil
function Effect:setX(x)
    BlzSetSpecialEffectX(self.effect_obj, x)
    self.__x = x
end

---@param y number
---@return nil
function Effect:setY(y)
    BlzSetSpecialEffectY(self.effect_obj, y)
    self.__y = y
end

---@param z number
---@return nil
function Effect:setZ(z)
    BlzSetSpecialEffectZ(self.effect_obj, z)
    self.__z = z
end

---@param yaw number
---@param pitch number
---@param roll number
---return nil
function Effect:setAngles(yaw, pitch, roll)
    BlzSetSpecialEffectOrientation(self.effect_obj, yaw, pitch, roll)
    self.__yaw = yaw
    self.__pitch = pitch
    self.__roll = roll
end

---@return number, number, number
function Effect:getAngles()
    return self.__yaw, self.__pitch, self.__roll
end

---@param yaw number
---@return nil
function Effect:setYaw(yaw)
    BlzSetSpecialEffectYaw(self.effect_obj, yaw)
    self.__yaw = yaw
end

---@param pitch number
---@return nil
function Effect:setPitch(pitch)
    BlzSetSpecialEffectPitch(self.effect_obj, pitch)
    self.__pitch = pitch
end

---@param roll number
---@return nil
function Effect:setRoll(roll)
    BlzSetSpecialEffectRoll(self.effect_obj, roll)
    self.__roll = roll
end

---@param speed number
---@return nil
function Effect:setAnimationSpeed(speed)
    BlzSetSpecialEffectTimeScale(self.effect_obj, speed)
end

---@param time number
---@return nil
function Effect:setAnimationTime(time)
    BlzSetSpecialEffectTime(self.effect_obj, time)
end

---@param sub_anim subanimtype
---@return nil
function Effect:addSubAnimation(sub_anim)
    BlzSpecialEffectAddSubAnimation(self.effect_obj, sub_anim)
end

---@param sub_anim subanimtype
---@return nil
function Effect:removeSubAnimation(sub_anim)
    BlzSpecialEffectRemoveSubAnimation(self.effect_obj, sub_anim)
end

---@return nil
function Effect:clearSubAnimations()
    BlzSpecialEffectClearSubAnimations(self.effect_obj)
end

---@param anim_type animtype
---@param time_scale number
---@return nil
function Effect:playAnimation(anim_type, time_scale)
    BlzPlaySpecialEffectWithTimeScale(self.effect_obj, anim_type, time_scale)
end

return Effect