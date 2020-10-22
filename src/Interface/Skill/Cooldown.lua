--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local SimpleImage = FrameLib.Simple.Image or error('')
local SimpleImagePublic = Class.getPublic(SimpleImage) or error('')
local SimpleText = FrameLib.Simple.Text or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

--=======
-- Class
--=======

local InterfaceSkillCooldown = Class.new('InterfaceSkillCooldown', SimpleImage)
---@class InterfaceSkillCooldown : Frame
local public = InterfaceSkillCooldown.public
---@class InterfaceSkillCooldownClass : FrameClass
local static = InterfaceSkillCooldown.static
---@type InterfaceSkillCooldownClass
local override = InterfaceSkillCooldown.override
local private = {}

--=========
-- Static
--=========

---@param child InterfaceSkillCooldown | nil
---@return InterfaceSkillCooldown
function override.new(child)
    if child then isTypeErr(child, InterfaceSkillCooldown, 'child') end

    local instance = child or Class.allocate(InterfaceSkillCooldown)
    instance = SimpleImage.new(instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    local priv = private.data[self]

    priv.width = width
    priv.height = height

    priv.text:setSize(width, height)
    priv.text:setFont('fonts\\nim_____.ttf', 0.35 * height)
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@param charges AbilityExtCharges
function public:setCharges(charges)
    local priv = private.data[self]

    local prev = priv.charges
    if prev then
        private.charges2frame[prev] = nil
        prev:removeAction(priv.changed_action)
        prev:removeAction(priv.loop_action)
    end

    priv.charges = charges
    if not charges then
        self:setVisible(false)
        return
    end
    self:setVisible(true)

    private.charges2frame[charges] = self
    priv.changed_action = charges:addChargesChangedAction(private.changedCallback)
    priv.loop_action = charges:addCooldownAction(private.cooldownLoop)

    private.changedCallback(charges)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.charges2frame = setmetatable({}, {__mode = 'kv'})

---@param self InterfaceSkillCooldown
function private.newData(self)
    local priv = {
        width = SimpleImagePublic.getWidth(self),
        height = SimpleImagePublic.getHeight(self),

        text = SimpleText.new(),

        charges = nil,
        changed_action = nil,
        loop_action = nil,
    }
    private.data[self] = priv

    priv.text:setParent(self)
    priv.text:setPos(0, 0)
    priv.text:setFont('fonts\\nim_____.ttf', 0.5 * self:getHeight())

    self:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
end

---@type AbilityExtChargesCallback
private.changedCallback = function(charges)
    ---@type InterfaceSkillCooldown
    local self = private.charges2frame[charges]
    local priv = private.data[self]

    if charges:get() < 1 then
        self:setAlpha(0.85)
        priv.text:setAlpha(0.85)
    else
        self:setAlpha(0.25)
        priv.text:setAlpha(0.25)
    end
end

private.cooldownLoop = function(charges)
    ---@type InterfaceSkillCooldown
    local self = private.charges2frame[charges]
    local priv = private.data[self]

    local cur = charges:getTimeLeft()
    local full = charges:getCooldown()
    local perc = cur / full

    SimpleImagePublic.setSize(self, perc * priv.width, priv.height)

    cur = math.floor(cur/0.1)
    local s_cur = tostring(cur)
    local len = s_cur:len()
    if len == 1 then
        s_cur = '0'..s_cur
        len = len + 1
    end
    priv.text:setText(s_cur:sub(1, len - 1)..'.'..s_cur:sub(len))
end

return static