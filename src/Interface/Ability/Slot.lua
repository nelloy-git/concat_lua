--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleText = FrameAPI.SimpleText
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceAbilitySlot = Class.new('InterfaceAbilitySlot', SimpleFrame)
---@class InterfaceAbilitySlot : SimpleFrame
local public = InterfaceAbilitySlot.public
---@class InterfaceAbilitySlotClass : SimpleFrameClass
local static = InterfaceAbilitySlot.static
---@type InterfaceAbilitySlotClass
local override = InterfaceAbilitySlot.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceAbilitySlot | nil
---@return InterfaceAbilitySlot
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceAbilitySlot)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    FramePublic.setWidth(self, width)
    private.update(self)
end

---@param height any number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

---@param abil AbilityType
function public:setAbility(abil)
    local priv = private.data[self]
    priv.abil = abil

    if abil then
        priv.icon:setTexture(abil:getIcon())
        priv.icon:setVisible(true)

        priv.hotkey:setText('Q')
        priv.hotkey:setVisible(true)
    else
        priv.icon:setVisible(false)
    end
end

---@param tooltip Frame
function public:setTooltip(tooltip)
    private.data[self].icon:setTooltip(tooltip)
end

---@return Item | nil
function public:getItem()
    return private.data[self].item
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio = 1 / 16
private.hotkey_ratio = 1 / 8

private.background_type = SimpleFrameType.new('InterfaceAbilitySlotBackground', true)
private.background_type:setWidth(0.035)
private.background_type:setHeight(0.035)
private.background_type:setTexture(Import.Icon.Empty)

private.border_type = SimpleFrameType.new('InterfaceEquipmentSlotBorder', true)
private.border_type:setWidth(0.040)
private.border_type:setHeight(0.040)
private.border_type:setTexture(Import.Icon.SlotBorder)

private.icon_type = SimpleButtonType.new('InterfaceAbilitySlotIcon', true)
private.icon_type:setWidth(0.035)
private.icon_type:setHeight(0.035)
private.icon_type:setTexture('')

private.hotkey_type = SimpleTextType.new('InterfaceAbilitySlotIcon', true)
private.hotkey_type:setWidth(0.005)
private.hotkey_type:setHeight(0.005)
private.hotkey_type:setTexture('')

---@param self InterfaceAbilitySlot
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = width * private.border_ratio
    local border_y = height * private.border_ratio

    priv.border:setWidth(width)
    priv.border:setHeight(height)

    priv.icon:setX(border_x)
    priv.icon:setY(border_y)
    priv.icon:setWidth(width - 2 * border_x)
    priv.icon:setHeight(height - 2 * border_y)

    priv.hotkey:setX((1 - private.hotkey_ratio) * width)
    priv.hotkey:setY((1 - private.hotkey_ratio) * height)
    priv.hotkey:setWidth(private.hotkey_ratio * width)
    priv.hotkey:setHeight(private.hotkey_ratio * height)
end

---@param self InterfaceAbilitySlot
function private.newData(self)
    local priv = {
        border = SimpleFrame.new(private.border_type),
        icon = SimpleButton.new(private.icon_type),
        hotkey = SimpleText.new(private.hotkey_type),
        abil = nil,
    }
    private.data[self] = priv

    priv.border:setParent(self)
    priv.border:setLevel(self:getLevel() + 2)

    priv.icon:setParent(self)
    priv.icon:setVisible(false)
    priv.icon:setLevel(self:getLevel() + 4)
    --priv.icon:addAction(SimpleButton.ActionType.MousePress, SyncEvent.startSync)

    priv.hotkey:setParent(self)
    priv.hotkey:setVisible(false)
end


return static