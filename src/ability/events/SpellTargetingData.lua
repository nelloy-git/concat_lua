---@type DataBase
local DataBase = require('utils.DataBase')
---@type PlayerEvent
local PlayerEvent = require('utils.trigger.events.PlayerEvents')

---@class SpellTargetingData
local SpellTargetingData = {
    __type = 'SpellTargetingDataClass',
    __db = DataBase.new('userdata', 'SpellTargetingData')
}
local SpellData_meta = {
    __type = 'SpellTargetingData',
    __index = SpellTargetingData,
}

function SpellTargetingData.init()
    SpellTargetingData.__timer = glTimer
end

--- Predefined
local mainLoop

---@param ability Ability
---@param caster unit
---@return SpellCastingData
function SpellTargetingData.new(ability, caster)
    ---@type SpellCastingData
    local data = {
        __ability = ability,
        __caster = caster,
        __action = PlayerEvent.getTrigger("LocalPlayerMouseMove", SpellTargetingData.saveMousePos, data)
    }
    setmetatable(data, SpellData_meta)

    local cur_data = SpellTargetingData.__db:get(caster)
    if cur_data then cur_data:cancel() end

    ability:showMainButton(caster)
    --ForceUIKeyBJ(GetOwningPlayer(caster), ability:getHotkey())
    SpellTargetingData.__timer:addAction(0.05, function() ForceUIKeyBJ(GetOwningPlayer(caster), ability:getHotkey()) end)
    ability:runCallback("StartTargeting", data)
    SpellTargetingData.__db:add(caster, data)
    SpellTargetingData.__timer:addAction(0, mainLoop, data)

    return data
end

---@param self SpellTargetingData
local function destroy(self)
    self.__ability:showUIButton(self.__caster)
    PlayerEvent.getTrigger("LocalPlayerMouseMove"):removeAction(self.__action)
    if SpellTargetingData.__db:get(self.__caster) == self then
        SpellTargetingData.__db:remove(self.__caster)
    end

    Debug("SpellTargetingData destroyed.")
end

---@param caster unit
---@return SpellCastingData
function SpellTargetingData.get(caster)
    return SpellTargetingData.__db:get(caster)
end

---@param self SpellTargetingData
mainLoop = function(self)
    if self:isCanceled() then
        self.__ability:runCallback('FinishTargeting', self)
        destroy(self)
    else
        self.__ability:runCallback('Targeting', self)
        SpellTargetingData.__timer:addAction(0, mainLoop, self)
    end
end

--- ============
---  Constants.
--- ============

---@return Ability
function SpellTargetingData:getAbility()
    return self.__ability
end

---@return unit
function SpellTargetingData:getCaster()
    return self.__caster
end

--- =================
---  Mouse position.
--- =================

---@return Vec2
function SpellTargetingData:getMousePos()
    return self.__mouse_pos
end

function SpellTargetingData:saveMousePos()
    self.__mouse_pos = BlzGetTriggerPlayerMousePosition()
end

--- ==========
---  Userdata
--- ==========

---@return any
function SpellTargetingData:getUserdata()
    return self.__userdata
end

---@param data any
function SpellTargetingData:setUserdata(data)
    self.__userdata = data
end

function SpellTargetingData:cancel()
    self.__cancel = true
end

function SpellTargetingData:isCanceled()
    return self.__cancel
end

return SpellTargetingData