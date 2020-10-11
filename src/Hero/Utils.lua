--=========
-- Include
--=========

---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
local AbilEvent = AbilityLib.Event
local AbilType = AbilityLib.Type
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamType = ParamLib.ParamType or error('')

--========
-- Module
--========

---@class HeroUtils
local HeroUtils = {}

local scale_colors = {
    [ParamType.PATK] = 'FFFFA0A0',
    [ParamType.MATK] = 'FFA0A0FF'
}
---@param text string
---@param param ParameterType
---@return string
function HeroUtils.colorScale(text, param)
    local color = scale_colors[param] or 'FFFFFFFF'
    return '|c'..color..text..'|r'
end

local function errorNoCharges(abil)
    print('No charges')
end

local function errorAlreadyCasting(abil)
    print('Already casting')
end

---@param name string
---@return AbilityExtType
function HeroUtils.newAbilPoint(name)
    local abil = HeroUtils.newAbilErr(name)

    function abil:getTargetingType(owner)
        return 'Point'
    end

    ---@param abil AbilityExt
    function abil:isStarted(abil)
        return true
    end

    return abil
end

---@param name string
---@return AbilityExtType
function HeroUtils.newAbilAlly(name)
    local abil = HeroUtils.newAbilErr(name)

    function abil:getTargetingType(owner)
        return 'Unit'
    end

    ---@param abil AbilityExt
    function abil:isStarted(abil)
        local owner = abil:getOwner()
        local target = abil:getTargetUnit()

        if not target then
            print('No target unit.')
            return false
        end

        local is_ally = owner:isAlly(target)
        if not is_ally then
            print('Can not target enemy unit.')
            return false
        end
        return true
    end

    return abil
end

---@param name string
---@return AbilityExtType
function HeroUtils.newAbilEnemy(name)
    local abil = HeroUtils.newAbilErr(name)

    function abil:getTargetingType(owner)
        return 'Unit'
    end

    ---@param abil AbilityExt
    function abil:isStarted(abil)
        local owner = abil:getOwner()
        local target = abil:getTargetUnit()

        print(target)
        if not target then
            print('No target unit.')
            return false
        end

        local is_ally = owner:isAlly(target)
        if is_ally then
            print('Can not target ally unit.')
            return false
        end
        return true
    end

    return abil
end

---@param name string
---@return AbilityExtType
function HeroUtils.newAbilErr(name)
    local abil = AbilType.new()

    function abil:getName(owner) return name end

    function abil:getChargesForUse(owner) return 1 end
    function abil:getMaxCharges(owner) return 1 end

    function abil:getCallback(event)
        if event == AbilEvent.ERROR_NO_CHARGES then
            return errorNoCharges
        elseif event == AbilEvent.ERROR_ALREADY_CASTING then
            return errorAlreadyCasting
        end
    end

    return abil
end

return HeroUtils