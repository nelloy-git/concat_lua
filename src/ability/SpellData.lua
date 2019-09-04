---@type DataBase
local DataBase = require('utils.DataBase')

---@class SpellData
local SpellData = {
    __type = 'SpellDataClass',
    __db = DataBase.new('userdata', 'SpellData')
}
local SpellData_meta = {
    __type = 'SpellData',
    __index = SpellData,
    __gc = SpellData.destroy
}

---@param ability Ability
---@param caster unit
---@return SpellData
function SpellData.new(ability, caster)
    ---@type SpellData
    local data = {
        __ability = ability,
        __caster = caster,
    }
    setmetatable(data, SpellData_meta)
    SpellData.__db:add(caster, data)

    return data
end

function SpellData:destroy()
    if SpellData.__db:get(self.__caster) == self then
        SpellData.__db:remove(self.__caster)
    end
end

---@param caster unit
---@return SpellData
function SpellData.get(caster)
    return SpellData.__db:get(caster)
end

--- ============
---  Constants.
--- ============

---@return Ability
function SpellData:getAbility()
    return self.__ability
end

---@return unit
function SpellData:getCaster()
    return self.__caster
end

--- ===============
---  Elapsed time.
--- ===============

---@return number
function SpellData:getElapsedTime()
    return self.__elapsed_time | 0
end

---@param time number
function SpellData:setElapsedTime(time)
    self.__elapsed_time = time
end

---@param delta number
function SpellData:addElapsedTime(delta)
    self.__elapsed_time = self.__elapsed_time + delta
end

---@return boolean
function SpellData:isFinished()
    return (self.__elapsed_time >= self.__casting_time)
end

--- ===============
---  Casting time.
--- ===============

---@return number
function SpellData:getCastingTime()
    return self.__casting_time | 0
end

---@param time number
function SpellData:setCastingTime(time)
    self.__casting_time = time
end

---@param delta number
function SpellData:addCastingTime(delta)
    self.__casting_time = self.__casting_time + delta
end

--- =========
---  Target.
--- =========

---@return unit|item|destructable|nil
function SpellData:getTarget()
    return self.__target
end

---@param target unit|item|destructable|nil
function SpellData:setTarget(target)
    self.__target = target
end

---@return Vec2
function SpellData:getTargetPos()
    return self.__target_pos
end

---@param pos Vec2
function SpellData:setTargetPos(pos)
    self.__target_pos = pos
end

--- =================
---  Mouse position.
--- =================

---@return Vec2
function SpellData:getMousePos()
    return self.__mouse_pos
end

---@param pos Vec2
function SpellData:setMousePos(pos)
    self.__mouse_pos = pos
end

---@return TriggerAction
function SpellData:getMouseAction()
    return self.__mouse_action
end

---@param action TriggerAction
function SpellData:setMouseAction(action)
    self.__mouse_action = action
end

--- ==========
---  Userdata
--- ==========

---@return any
function SpellData:getUserdata()
    return self.__userdata
end

---@param data any
function SpellData:setUserdata(data)
    self.__userdata = data
end

function SpellData:cancel()
    self.__cancel = true
end

function SpellData:isCanceled()
    return self.__cancel
end

return SpellData