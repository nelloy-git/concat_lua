--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local SimpleImage = FrameLib.Simple.Image or error('')
local SimpleImagePublic = Class.getPublic(SimpleImage) or error('')
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

        charges = nil,
        changed_action = nil,
        loop_action = nil,
    }
    private.data[self] = priv

    self:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
end

---@type AbilityExtChargesCallback
private.changedCallback = function(charges)
    ---@type InterfaceSkillCooldown
    local self = private.charges2frame[charges]

    if charges:get() < 1 then
        self:setAlpha(0.25)
    else
        self:setAlpha(0.75)
    end
end

private.cooldownLoop = function(charges)
    ---@type InterfaceSkillCooldown
    local self = private.charges2frame[charges]
    local priv = private.data[self]

    local cur = charges:getTimeLeft()
    local full = charges:getCooldown()
    local perc = cur / full

    print(perc)
    SimpleImagePublic.setSize(self, perc * priv.width, priv.height)
end

return static