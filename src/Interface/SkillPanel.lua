--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type AbilityLib
local AbilLib = require(LibList.AbilityExtLib) or error('')
local AbilContainer = AbilLib.Container or error('')
local AbilEvent = AbilLib.Event or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local Image = FrameLib.Normal.Image or error('')
local ImagePublic = Class.getPublic(Image) or error('')
local OriginTooltip = FrameLib.Origin.Tooltip or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceSkillButtonClass
local SkillButton = require('Interface.SkillButton') or error('')

--=======
-- Class
--=======

local InterfaceSkillPanel = Class.new('InterfaceSkillPanel', Image)
---@class InterfaceSkillPanel : FrameNormalImage
local public = InterfaceSkillPanel.public
---@class InterfaceSkillPanelClass : FrameNormalImageClass
local static = InterfaceSkillPanel.static
---@type InterfaceSkillPanelClass
local override = InterfaceSkillPanel.override
local private = {}

--=========
-- Static
--=========

local static_instance = nil

---@return InterfaceSkillPanel
function override.new()
    if static_instance then
        Log:wrn(tostring(InterfaceSkillPanel)..': can not get new instance. It is static class.')
        return static_instance
    end

    local instance = Class.allocate(InterfaceSkillPanel)
    instance = Image.new(instance)

    private.newData(instance)

    static_instance = instance
    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    ImagePublic.setPos(self, x, y)
    local priv = private.data[self]

    for i = 1, 7 do
        priv.buttons[i]:setPos(x + (i - 1) * priv.buttons[i]:getWidth(), y)
    end
end

---@param width number
---@param height number
function public:setSize(width, height)
    Log:wrn(tostring(InterfaceSkillPanel)..': it is autosized frame.')
end

---@return number
function public:getWidth()
    return 7 * private.data[self].buttons[1]:getWidth()
end

---@return number
function public:getHeight()
    return private.data[self].buttons[1]:getHeight()
end

---@param container AbilityExtContainer
function public:setAbilContainer(container)
    if container then isTypeErr(container, AbilContainer, 'container') end

    local priv = private.data[self]

    local previous = priv.container
    if previous then
        private.container2interface[previous] = nil
        previous:removeAction(priv.changed_action)
    end

    priv.container = container
    if container then
        private.container2interface[container] = self
        local action = container:addAction(AbilEvent.CHARGES_CHANGED, private.chargedChanged)
        priv.changed_action = action
    end

    for i = 1, #private.hotkeys do
        local abil = container:get(private.hotkeys[i])
        priv.buttons[i]:setCharges(abil:getCharges(), abil:getMaxCharges())
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.container2interface = setmetatable({}, {__mode = 'kv'})

---@param self InterfaceSkillPanel
function private.newData(self)
    local priv = {
        container = nil,
        changed_action = nil,

        buttons = {},
        tooltip = OriginTooltip,
    }
    private.data[self] = priv
    ImagePublic.setVisible(self, false)

    for i = 1, 7 do
        priv.buttons[i] = SkillButton.new(i + 5)
        priv.buttons[i]:setPos((i - 1) * priv.buttons[i]:getWidth(), 0)
        priv.buttons[i]:setVisible(true)
    end

    priv.tooltip:setParent(self)
    -- Native bind with bottom center point
    BlzFrameSetPoint(priv.tooltip:getData(), FRAMEPOINT_BOTTOM,
                     self:getData(), FRAMEPOINT_TOP, 0, 0)
    priv.tooltip:setVisible(true)
end

private.hotkeys = {
    'Q', 'W', 'E', 'R', 'T', 'D', 'F'
}

---@param container AbilityExtContainer
---@param abil AbilityExt
---@param event AbilityExtEvent
function private.chargedChanged(container, abil, event)
    ---@type InterfaceSkillPanel
    local self = private.container2interface[container]

    for i = 1, #private.hotkeys do
        if container:get(private.hotkeys[i]) == abil then
            private.data[self].buttons[i]:setCharges(abil:getCharges(), abil:getMaxCharges())
            break
        end
    end
end

return static