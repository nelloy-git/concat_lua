---@type Trigger
local Trigger = require('utils.trigger.Trigger')

---@class PlayerEvent
local PlayerEvent = {
    __triggers = {}
}

---@alias PlayerEventName string
---| '"LocalPlayerMouseMove"'
---| '"LocalPlayerKeyPressed"'
---| '"LocalPlayerEscapeDown"'
---| '"LocalPlayerEscapeUp"'
---| '"LocalPlayerShiftDown"'
---| '"LocalPlayerShiftUp"'
---| '"LocalPlayerQDown"'
---| '"LocalPlayerQUp"'
---| '"LocalPlayerWDown"'
---| '"LocalPlayerWUp"'
---| '"LocalPlayerEDown"'
---| '"LocalPlayerEUp"'
---| '"LocalPlayerRDown"'
---| '"LocalPlayerRUp"'
---| '"LocalPlayerTDown"'
---| '"LocalPlayerTUp"'
---| '"LocalPlayerDDown"'
---| '"LocalPlayerDUp"'
---| '"LocalPlayerFDown"'
---| '"LocalPlayerFUp"'
---| '"LocalPlayerVDown"'
---| '"LocalPlayerVUp"'

--- Predefined
local createKeyboardTrigger
local updateMousePos

local initialized = false
function PlayerEvent.init()
    if initialized then return nil end

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerMouseMove"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerMouseMove"]:addEvent_Player("MouseMove", GetLocalPlayer())
    PlayerEvent.__triggers["LocalPlayerMouseMove"]:addAction(updateMousePos)

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerMouseDown"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerMouseDown"]:addEvent_Player("MouseDown", GetLocalPlayer())

    --- ==========
    ---  Keyboard
    --- ==========
    createKeyboardTrigger("Escape")
    createKeyboardTrigger("Shift")
    createKeyboardTrigger("Q")
    createKeyboardTrigger("W")
    createKeyboardTrigger("E")
    createKeyboardTrigger("R")
    createKeyboardTrigger("T")
    createKeyboardTrigger("D")
    createKeyboardTrigger("F")
    createKeyboardTrigger("V")


    initialized = true
end

local local_mouse_pos
updateMousePos = function()
    local_mouse_pos = Vec2(BlzGetTriggerPlayerMouseX(), BlzGetTriggerPlayerMouseY())
end

createKeyboardTrigger = function(key)
    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayer"..key.."Down"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayer"..key.."Down"]:addEvent_Keyboard("KeyDown", GetLocalPlayer(), _G["OSKEY_"..string.upper(key)])
    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayer"..key.."Up"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayer"..key.."Up"]:addEvent_Keyboard("KeyUp", GetLocalPlayer(), _G["OSKEY_"..string.upper(key)])
end

---@param event PlayerEventName
function PlayerEvent.getTrigger(event)
    if not initialized then PlayerEvent.init() end
    return PlayerEvent.__triggers[event]
end


---@return Vec2
function PlayerEvent.getLocalMousePos()
    return local_mouse_pos
end


return PlayerEvent