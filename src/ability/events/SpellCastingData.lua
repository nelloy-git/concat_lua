---@type DataBase
local DataBase = require('utils.DataBase')

---@class SpellCastingData
local SpellCastingData = {
    __type = 'SpellCastingDataClass',
    __db = DataBase.new('userdata', 'SpellCastingData')
}
local SpellCastingData_meta = {
    __type = 'SpellCastingData',
    __index = SpellCastingData,
    __gc = SpellCastingData.destroy
}

function SpellCastingData.init()
    SpellCastingData.__timer = glTimer
end

--- Predefined
local mainLoop
local destroy

---@param ability Ability
---@param caster unit
---@param target unit|item|destructable|nil
---@param target_pos Vec2
---@return SpellCastingData
function SpellCastingData.new(ability, caster, target, target_pos)
    ---@type SpellCastingData
    local data = {
        __ability = ability,
        __caster = caster,
        __target = target,
        __target_pos = target_pos
    }
    setmetatable(data, SpellCastingData_meta)

    local cur_data = SpellCastingData.__db:get(caster)
    if cur_data then cur_data:cancel() end
    SpellCastingData.__db:add(caster, data)

    local continue = ability:runCallback("StartCasting", data)
    if not continue then data:cancel() end

    data:setCastingTime(ability:getCastingTime(data))
    SpellCastingData.__timer:addAction(0, mainLoop, data)

    return data
end

---@param self SpellCastingData
function destroy(self)
    if SpellCastingData.__db:get(self.__caster) == self then
        SpellCastingData.__db:remove(self.__caster)
    end
end

---@param caster unit
---@return SpellCastingData
function SpellCastingData.get(caster)
    return SpellCastingData.__db:get(caster)
end

---@param self SpellCastingData
mainLoop = function(self)
    if self:isCanceled() then
        self.__ability:runCallback("CancelCasting", self)
        destroy(self)
    elseif self:isInterrupted() then
        self.__ability:runCallback("InterruptCasting", self)
        destroy(self)
    else
        self.__ability:runCallback("Casting", self)
        SpellCastingData.__timer:addAction(0, mainLoop, self)
    end
end

--- ============
---  Constants.
--- ============

---@return Ability
function SpellCastingData:getAbility()
    return self.__ability
end

---@return unit
function SpellCastingData:getCaster()
    return self.__caster
end

---@return unit|item|destructable|nil
function SpellCastingData:getTarget()
    return self.__target
end

---@return Vec2
function SpellCastingData:getTargetPos()
    return self.__target_pos
end

--- ===============
---  Elapsed time.
--- ===============

---@return number
function SpellCastingData:getElapsedTime()
    return self.__elapsed_time | 0
end

---@param time number
function SpellCastingData:setElapsedTime(time)
    self.__elapsed_time = time
end

---@param delta number
function SpellCastingData:addElapsedTime(delta)
    self.__elapsed_time = self.__elapsed_time + delta
end

---@return boolean
function SpellCastingData:isFinished()
    return (self.__elapsed_time >= self.__casting_time)
end

--- ===============
---  Casting time.
--- ===============

---@return number
function SpellCastingData:getCastingTime()
    return self.__casting_time | 0
end

---@param time number
function SpellCastingData:setCastingTime(time)
    self.__casting_time = time
end

---@param delta number
function SpellCastingData:addCastingTime(delta)
    self.__casting_time = self.__casting_time + delta
end

--- ==========
---  Userdata
--- ==========

---@return any
function SpellCastingData:getUserdata()
    return self.__userdata
end

---@param data any
function SpellCastingData:setUserdata(data)
    self.__userdata = data
end

function SpellCastingData:cancel()
    self.__cancel = true
end

---@return boolean
function SpellCastingData:isCanceled()
    return self.__cancel
end

function SpellCastingData:interrupt()
    self.__interrupt = true
end

---@return boolean
function SpellCastingData:isInterrupted()
    return self.__cancel
end

return SpellCastingData