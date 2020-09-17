--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local getEnum = UtilsLib.getEnum
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

---@class FrameEventType
local FrameEventType = {}

FrameEventType.Enum = {
    ---@type frameeventtype
    CONTROL_CLICK = FRAMEEVENT_CONTROL_CLICK or getEnum(),
    ---@type frameeventtype
    MOUSE_ENTER = FRAMEEVENT_MOUSE_ENTER or getEnum(),
    ---@type frameeventtype
    MOUSE_LEAVE = FRAMEEVENT_MOUSE_LEAVE or getEnum(),
    ---@type frameeventtype
    MOUSE_UP = FRAMEEVENT_MOUSE_UP or getEnum(),
    ---@type frameeventtype
    MOUSE_DOWN = FRAMEEVENT_MOUSE_DOWN or getEnum(),
    ---@type frameeventtype
    MOUSE_WHEEL = FRAMEEVENT_MOUSE_WHEEL or getEnum(),
    ---@type frameeventtype
    CHECKBOX_CHECKED = FRAMEEVENT_CHECKBOX_CHECKED or getEnum(),
    ---@type frameeventtype
    CHECKBOX_UNCHECKED = FRAMEEVENT_CHECKBOX_UNCHECKED or getEnum(),
    ---@type frameeventtype
    EDITBOX_TEXT_CHANGED = FRAMEEVENT_EDITBOX_TEXT_CHANGED or getEnum(),
    ---@type frameeventtype
    POPUPMENU_ITEM_CHANGED = FRAMEEVENT_POPUPMENU_ITEM_CHANGED or getEnum(),
    ---@type frameeventtype
    MOUSE_DOUBLECLICK = FRAMEEVENT_MOUSE_DOUBLECLICK or getEnum(),
    ---@type frameeventtype
    SPRITE_ANIM_UPDATE = FRAMEEVENT_SPRITE_ANIM_UPDATE or getEnum(),
    ---@type frameeventtype
    SLIDER_VALUE_CHANGED = FRAMEEVENT_SLIDER_VALUE_CHANGED or getEnum(),
    ---@type frameeventtype
    DIALOG_CANCEL = FRAMEEVENT_DIALOG_CANCEL or getEnum(),
    ---@type frameeventtype
    DIALOG_ACCEPT = FRAMEEVENT_DIALOG_ACCEPT or getEnum(),
    ---@type frameeventtype
    EDITBOX_ENTER = FRAMEEVENT_EDITBOX_ENTER or getEnum(),
}

local frameevent_type2str = {
    [FrameEventType.Enum.CONTROL_CLICK] = 'CONTROL_CLICK',
    [FrameEventType.Enum.MOUSE_ENTER] = 'MOUSE_ENTER',
    [FrameEventType.Enum.MOUSE_LEAVE] = 'MOUSE_LEAVE',
    [FrameEventType.Enum.MOUSE_UP] = 'MOUSE_UP',
    [FrameEventType.Enum.MOUSE_DOWN] = 'MOUSE_DOWN',
    [FrameEventType.Enum.MOUSE_WHEEL] = 'MOUSE_WHEEL',
    [FrameEventType.Enum.CHECKBOX_CHECKED] = 'CHECKBOX_CHECKED',
    [FrameEventType.Enum.CHECKBOX_UNCHECKED] = 'CHECKBOX_UNCHECKED',
    [FrameEventType.Enum.EDITBOX_TEXT_CHANGED] = 'EDITBOX_TEXT_CHANGED',
    [FrameEventType.Enum.POPUPMENU_ITEM_CHANGED] = 'POPUPMENU_ITEM_CHANGED',
    [FrameEventType.Enum.MOUSE_DOUBLECLICK] = 'MOUSE_DOUBLECLICK',
    [FrameEventType.Enum.SPRITE_ANIM_UPDATE] = 'SPRITE_ANIM_UPDATE',
    [FrameEventType.Enum.SLIDER_VALUE_CHANGED] = 'SLIDER_VALUE_CHANGED',
    [FrameEventType.Enum.DIALOG_CANCEL] = 'DIALOG_CANCEL',
    [FrameEventType.Enum.DIALOG_ACCEPT] = 'DIALOG_ACCEPT',
    [FrameEventType.Enum.EDITBOX_ENTER] = 'EDITBOX_ENTER',
}

---@param val any
---@return boolean
function FrameEventType.isFrameEventType(val)
    if not frameevent_type2str[val] then
        return false
    end
    return true
end

---@param frameevent_type frameeventtype
---@return string
function FrameEventType.toStr(frameevent_type)
    local res = frameevent_type2str[frameevent_type]
    if res == nil then
        Log:err('variable \'frameevent_type\' is not of type frameevent', 3)
    end
    return res
end

return FrameEventType