---@class Effect
local Effect = {}
local Effect_meta = {
    __index = Effect,
    __gc = Effect.destroy
}

---@param self Effect
---@return string
function Effect_meta.__tostring(self)
    return string.format('Effect %s\nPos:[%.2f, %.2f, %.2f]\nAngles:[%.2f, %.2f,%.2f]\nSize:[%.2f, %.2f, %.2f]\n',
                          self.model,
                          self.x, self.y, self.z,
                          self.yaw, self.pitch, self.roll,
                          self.size_x, self.size_y, self.size_z)
end

---@param model string
---@param x number
---@param y number
---@return Effect
function Effect.new(model, x, y, z)
    ---@type Effect
    local effect = {
        effect_obj = AddSpecialEffect(model, x, y),
        model = model,
        x = x,
        y = y,
        z = z,
        yaw = 0,
        pitch = 0,
        roll = 0,
        size_x = 1,
        size_y = 1,
        size_z = 1
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
    self.size_x = scale
    self.size_y = scale
    self.size_z = scale
end

---@return number, number, number
function Effect:getSize()
    return self.size_x, self.size_y, self.size_z
end

---@param size_x number
---@param size_y number
---@param size_z number
---@return nil
function Effect:setSizeAxis(size_x, size_y, size_z)
    self.size_x = size_x
    self.size_y = size_y
    self.size_z = size_z
    BlzSetSpecialEffectMatrixScale(self.effect_obj, self.size_x, self.size_y, self.size_z)
end

---@param size_x number
---@return nil
function Effect:setSizeX(size_x)
    self:setSizeAxis(size_x, self.size_y. self.size_z)
end

---@param size_y number
---@return nil
function Effect:setSizeY(size_y)
    self:setSizeAxis(self.size_x, size_y. self.size_z)
end

---@param size_z number
---@return nil
function Effect:setSizeZ(size_z)
    self:setSizeAxis(self.size_x, self.size_y. size_z)
end

---@param x number
---@param y number
---@param z number
---@return nil
function Effect:setPos(x, y, z)
    BlzSetSpecialEffectPosition(self.effect_obj, x, y, z)
    self.x = x
    self.y = y
    self.z = z
end

---@return number, number, number
function Effect:getPos()
    return self.x, self.y, self.z
end

---@param x number
---@return nil
function Effect:setX(x)
    BlzSetSpecialEffectX(self.effect_obj, x)
    self.x = x
end

---@param y number
---@return nil
function Effect:setY(y)
    BlzSetSpecialEffectY(self.effect_obj, y)
    self.y = y
end

---@param z number
---@return nil
function Effect:setZ(z)
    BlzSetSpecialEffectZ(self.effect_obj, z)
    self.z = z
end

---@param yaw number
---@param pitch number
---@param roll number
---return nil
function Effect:setAngles(yaw, pitch, roll)
    BlzSetSpecialEffectOrientation(self.effect_obj, yaw, pitch, roll)
    self.yaw = yaw
    self.pitch = pitch
    self.roll = roll
end

---@return number, number, number
function Effect:getAngles()
    return self.yaw, self.pitch, self.roll
end

---@param yaw number
---@return nil
function Effect:setYaw(yaw)
    BlzSetSpecialEffectYaw(self.effect_obj, yaw)
    self.yaw = yaw
end

---@param pitch number
---@return nil
function Effect:setPitch(pitch)
    BlzSetSpecialEffectPitch(self.effect_obj, pitch)
    self.pitch = pitch
end

---@param roll number
---@return nil
function Effect:setRoll(roll)
    BlzSetSpecialEffectRoll(self.effect_obj, roll)
    self.roll = roll
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

---@alias EffectSubAnimation userdata @Uses warcraft constants starting with SUBANIM_TYPE_

---@param sub_anim EffectSubAnimation
---@return nil
function Effect:addSubAnimation(sub_anim)
    BlzSpecialEffectAddSubAnimation(self.effect_obj, sub_anim)
end

---@param sub_anim EffectSubAnimation
---@return nil
function Effect:removeSubAnimation(sub_anim)
    BlzSpecialEffectRemoveSubAnimation(self.effect_obj, sub_anim)
end

---@return nil
function Effect:clearSubAnimations()
    BlzSpecialEffectClearSubAnimations(self.effect_obj)
end

---@alias EffectAnimationType userdata @Uses warcraft constants starting with ANIM_TYPE_

---@param anim_type EffectAnimationType
---@param time_scale number
---@return nil
function Effect:playAnimation(anim_type, time_scale)
    BlzPlaySpecialEffectWithTimeScale(self.effect_obj, anim_type, time_scale)
end

return Effect