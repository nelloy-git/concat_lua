--=========
-- Include
--=========

local Class = require('Utils.Class.API')

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
local SimpleStatusBarType = FrameAPI.SimpleStatusBarType
local SimpleStatusBar = FrameAPI.SimpleStatusBar
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceAbilityOldSlot = Class.new('InterfaceAbilityOldSlot', SimpleFrame)
---@class InterfaceAbilityOldSlot : SimpleFrame
local public = InterfaceAbilityOldSlot.public
---@class InterfaceAbilityOldSlotClass : SimpleFrameClass
local static = InterfaceAbilityOldSlot.static
---@type InterfaceAbilityOldSlotClass
local override = InterfaceAbilityOldSlot.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceAbilityOldSlot | nil
---@return InterfaceAbilityOldSlot
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceAbilityOldSlot)
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

---@param abil AbilityOldTypeOld
function public:setAbilityOld(abil)
    local priv = private.data[self]
    priv.abil = abil

    if abil then
        priv.icon:setTexture(abil:getIcon())
        priv.icon:setVisible(true)

        priv.hotkey_background:setVisible(true)
        priv.hotkey:setText('Q')
        priv.hotkey:setVisible(true)

        priv.charges_background:setVisible(true)
        priv.charges:setText(string.format("%d", abil:getCharges()))
        priv.charges:setVisible(true)

        priv.cooldown:setVisible(true)
    else
        priv.icon:setVisible(false)

        priv.hotkey_background:setVisible(false)
        priv.hotkey:setVisible(false)
        priv.charges_background:setVisible(false)
        priv.charges:setVisible(false)
    end
end

function public:updateCooldown()
    local priv = private.data[self]

    if not priv.abil then
        return
    end

    ---@type AbilityOld
    local abil = priv.abil
    ---@type AbilityOldTypeOld
    local abil_type = abil:getType()

    local cur_cd = abil:getCooldownTimeLeft()
    local full_cd = abil_type:getCooldown(abil:getOwner(), abil:getLevel())
    local ratio = cur_cd / full_cd

    if cur_cd > 0 then
        priv.cooldown:setVisible(true)
        priv.cooldown:setStatus(100 * ratio)
        priv.cooldown:setText(string.format('%.f', cur_cd))
    else
        priv.cooldown:setVisible(false)
    end

    priv.charges:setText(string.format("%d", abil:getCharges()))
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

private.background_type = SimpleFrameType.new('InterfaceAbilityOldSlotBackground', true)
private.background_type:setWidth(0.035)
private.background_type:setHeight(0.035)
private.background_type:setTexture(Import.Icon.Empty)

private.border_type = SimpleFrameType.new('InterfaceAbilityOldSlotBorder', true)
private.border_type:setWidth(0.040)
private.border_type:setHeight(0.040)
private.border_type:setTexture(Import.Icon.SlotBorder)

private.icon_type = SimpleButtonType.new('InterfaceAbilityOldSlotIcon', true)
private.icon_type:setWidth(0.035)
private.icon_type:setHeight(0.035)
private.icon_type:setTexture('')

private.text_background_type = SimpleFrameType.new('InterfaceaAbilityOldSlotHotkeyBackground', true)
private.text_background_type:setWidth(0.005)
private.text_background_type:setHeight(0.005)
private.text_background_type:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')

private.text_type = SimpleTextType.new('InterfaceAbilityOldSlotHotkey', true)
private.text_type:setWidth(0.005)
private.text_type:setHeight(0.005)

private.cooldown_type = SimpleStatusBarType.new('InterfaceAbilityOldSlotCooldown', true)
private.cooldown_type:setWidth(0.035)
private.cooldown_type:setHeight(0.035)
private.cooldown_type:setBackground(Import.HalfTransparentTexture)
private.cooldown_type:setBar(Import.HalfTransparentTexture)

---@param self InterfaceAbilityOldSlot
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

    priv.cooldown:setX(border_x)
    priv.cooldown:setY(border_y)
    priv.cooldown:setWidth(width - 2 * border_x)
    priv.cooldown:setHeight(height - 2 * border_y)

    priv.hotkey_background:setX((1 - private.hotkey_ratio) * width)
    priv.hotkey_background:setY((1 - private.hotkey_ratio) * height)
    priv.hotkey_background:setWidth(private.hotkey_ratio * width)
    priv.hotkey_background:setHeight(private.hotkey_ratio * height)

    priv.hotkey:setX((1 - private.hotkey_ratio) * width)
    priv.hotkey:setY((1 - private.hotkey_ratio) * height)
    priv.hotkey:setWidth(private.hotkey_ratio * width)
    priv.hotkey:setHeight(private.hotkey_ratio * height)

    priv.charges_background:setX((1 - private.hotkey_ratio) * width)
    priv.charges_background:setY((1 - private.hotkey_ratio) * height)
    priv.charges_background:setWidth(private.hotkey_ratio * width)
    priv.charges_background:setHeight(private.hotkey_ratio * height)

    priv.charges:setX(0)
    priv.charges:setY(0)
    priv.charges:setWidth(private.hotkey_ratio * width)
    priv.charges:setHeight(private.hotkey_ratio * height)
end

---@param self InterfaceAbilityOldSlot
function private.newData(self)
    local priv = {
        border = SimpleFrame.new(private.border_type),
        icon = SimpleButton.new(private.icon_type),
        cooldown = SimpleStatusBar.new(private.cooldown_type),
        hotkey_background = SimpleFrame.new(private.text_background_type),
        hotkey = SimpleText.new(private.text_type),
        charges_background = SimpleFrame.new(private.text_background_type),
        charges = SimpleText.new(private.text_type),
        abil = nil,
    }
    private.data[self] = priv

    priv.border:setParent(self)
    priv.border:setLevel(self:getLevel() + 1)

    priv.icon:setParent(self)
    priv.icon:setVisible(false)
    priv.icon:setLevel(self:getLevel() + 2)

    priv.cooldown:setParent(self)
    priv.cooldown:setVisible(false)
    priv.cooldown:setLevel(self:getLevel() + 3)

    priv.hotkey_background:setParent(self)
    priv.hotkey_background:setVisible(false)
    priv.hotkey_background:setLevel(self:getLevel() + 5)

    priv.hotkey:setParent(self)
    priv.hotkey:setVisible(false)
    priv.hotkey:setLevel(self:getLevel() + 7)
    priv.hotkey:setTextColor(255, 255, 255, 0)

    priv.charges_background:setParent(self)
    priv.charges_background:setVisible(false)
    priv.charges_background:setLevel(self:getLevel() + 5)

    priv.charges:setParent(self)
    priv.charges:setVisible(false)
    priv.charges:setLevel(self:getLevel() + 7)
    priv.charges:setTextColor(255, 255, 255, 0)
end


return static