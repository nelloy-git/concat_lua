local Ability = require('ability.AbilityData')

---@alias AbilityCastingTimeFunc fun(data:SpellCastingData):number

---@alias AbilityCallback fun(data:SpellCastingData):boolean

---@alias AbilityEventName string
---| '"StartTargeting"'     #Callback is called when player starts targeting ability.
---| '"Targeting"'          #Callback is called every timer period while player is targeting.
---| '"FinishTargeting"'    #Callback is called when player cancel targeting ability.
---| '"Start"'              #Callback is called when unit starts casting.
---| '"Casting"'            #Callback is called every loop of timer while unit is casting an ability.
---| '"Cancel"'             #Callback is called when player cancels ability.
---| '"Interrupt"'          #Callback is called when unit interrupted casting.
---| '"Finish"'             #Callback is called if casting was not interrupted and cast time passed.

---@alias AbilityFlagName string
---| '"CanBeCanceled"'
---| '"CancelWithAnyOrder"'
---| '"CanMoveWhileCasting"'

---@param callback_type AbilityEventName
---@param callback AbilityCallback
function Ability:setCallback(callback_type, callback)
    self.__callbacks[callback_type] = callback
end

---@param callback_type AbilityEventName
---@return AbilityCallback
function Ability:getCallback(callback_type)
    return self.__callbacks[callback_type]
end

---@param callback_type AbilityEventName
---@param cast_data SpellCastingData
---@return boolean
function Ability:runCallback(callback_type, cast_data)
    if type(self.__callbacks[callback_type]) == 'function' then
        return self.__callbacks[callback_type](cast_data)
    else
        return true
    end
end

---Set ability casting time.
---@param func AbilityCastingTimeFunc
function Ability:setCastingTimeFunction(func)
    self.__casting_time_func = func
end

---@param data SpellCastingData
---@return number
function Ability:getCastingTime(data)
    if type(self.__casting_time_func) == 'function' then
        return self.__casting_time_func(data)
    end
    return 0
end

---@param flag boolean
---@param flag_name AbilityFlagName
function Ability:setFlag(flag, flag_name)
    if not self.__flag then self.__flag = {} end
    self.__flag[flag_name] = flag
end

---@param flag_name AbilityFlagName
---@return boolean
function Ability:getFlag(flag_name)
    if not self.__flag then self.__flag = {} end
    return self.__flag[flag_name]
end