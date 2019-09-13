local Ability = require('baseClasses.Ability.AbilityData')

---@alias AbilityCastingTimeFunc fun(data:SpellCastingData):number

---@alias AbilityTargetingCallback fun(caster:Unit):nil
---@alias AbilityCastingCallback fun(data:SpellCastingData):boolean

---@alias AbilityTargetingEventName string
---| '"StartTargeting"'     #Callback is called when player starts targeting ability.
---| '"TargetingMouseMove"' #Callback is called when local player moves mouse while targeting.
---| '"FinishTargeting"'    #Callback is called when player cancel targeting ability.

---@alias AbilityCastingEventName string
---| '"Start"'              #Callback is called when unit starts casting.
---| '"Casting"'            #Callback is called every loop of timer while unit is casting an ability.
---| '"Cancel"'             #Callback is called when player cancels ability.
---| '"Interrupt"'          #Callback is called when unit interrupted casting.
---| '"Finish"'             #Callback is called if casting was not interrupted and cast time passed.

---@alias AbilityFlagName string
---| '"CanBeCanceled"'
---| '"CancelWithAnyOrder"'
---| '"CanMoveWhileCasting"'

---@param callback_type AbilityTargetingEventName
---@param callback AbilityTargetingCallback
function Ability:setTargetingCallback(callback_type, callback)
    if not self.__targeting_callbacks then
        self.__targeting_callbacks = {}
    end
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