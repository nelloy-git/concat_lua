---@class SpellTargetingData
local SpellTargetingData = {
    is_active = false
}

--- Predefined
local mainLoop

local initialized = false
function SpellTargetingData.init()
    if initialized then return nil end

    glTimer:addAction(0, mainLoop)

    initialized = true
end

---@param ability Ability
---@param caster unit
---@return SpellCastingData
function SpellTargetingData.start(ability, caster)
    SpellTargetingData.finish()

    SpellTargetingData.__ability = ability
    SpellTargetingData.__caster = caster

    ability:showMainButton(caster)
    glTimer:addAction(0.05, function() ForceUIKeyBJ(GetOwningPlayer(caster), ability:getHotkey()) end)
    ability:runCallback("StartTargeting")

    SpellTargetingData.__is_active = true
end

---@return boolean
function SpellTargetingData.finish()
    if SpellTargetingData.__is_active then
        SpellTargetingData.__ability:showDummyButton(SpellTargetingData.__caster)
        SpellTargetingData.__ability:runCallback("FinishTargeting")
        SpellTargetingData.__is_active = false
        return true
    end
    return false
end

mainLoop = function()
    if SpellTargetingData.__is_active then
        SpellTargetingData.__ability:runCallback('Targeting')
        SpellTargetingData.__timer:addAction(0, mainLoop)
    end
end

--- ============
---  Constants.
--- ============

---@return Ability
function SpellTargetingData.getAbility()
    return SpellTargetingData.__ability
end

---@return unit
function SpellTargetingData.getCaster()
    return SpellTargetingData.__caster
end

return SpellTargetingData