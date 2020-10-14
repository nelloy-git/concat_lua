--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local NormalButton = FrameLib.Normal.Button or error('')
local NormalButtonPublic = Class.getPublic(NormalButton) or error('')
local NormalImage = FrameLib.Normal.Image or error('')
local SimpleText = FrameLib.Simple.Text or error('')
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEvemt = TypesLib.FrameEventTypeEnum
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type InterfaceSkillButtonFdf
local Fdf = require('Interface.Skill.ButtonFdf') or error('')

--=======
-- Class
--=======

local InterfaceSkillButton = Class.new('InterfaceSkillButton', NormalButton)
---@class InterfaceSkillButton : Frame
local public = InterfaceSkillButton.public
---@class InterfaceSkillButtonClass : FrameClass
local static = InterfaceSkillButton.static
---@type InterfaceSkillButtonClass
local override = InterfaceSkillButton.override
local private = {}

--=========
-- Static
--=========

---@return InterfaceSkillButton
function override.new(child)
    if child then isTypeErr(child, InterfaceSkillButton, 'child') end

    local instance = child or Class.allocate(InterfaceSkillButton)
    instance = NormalButton.new(Fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    NormalButtonPublic.setSize(self, width, height)
    local priv = private.data[self]

    priv.cd_text:setSize(0.8 * width, 0.8 * height)
    priv.cd_text:setFont('fonts\\nim_____.ttf', height / 4)

    priv.charges_back:setSize(width / 3, height / 4)
    priv.charges_back:setPos(0, height - priv.charges_back:getHeight())

    priv.charges_text:setSize(width / 3, height / 4)
    priv.charges_text:setPos(0, height - priv.charges_text:getHeight())
    priv.charges_text:setFont('fonts\\nim_____.ttf', 0.8 * height / 4)

    self:setCooldown(priv.cd_left, priv.cd_full)
end

---@param count number
function public:setCharges(count, max_count)
    local priv = private.data[self]

    if max_count <= 1 then
        priv.charges_back:setVisible(false)
        priv.charges_text:setVisible(false)
    else
        priv.charges_back:setVisible(true)
        priv.charges_text:setVisible(true)

        local s_count = tostring(count - count % 1)
        priv.charges_text:setText(s_count)
    end
end

---@param left number
---@param full number
function public:setCooldown(left, full)
    local priv = private.data[self]
    priv.cd_left = left
    priv.cd_full = full

    if priv.charges_left < priv.charges_full - 1 then
        priv.cd_mask:setSize(left / full * self:getWidth(), self:getHeight())

        local cd_time = 10 * left
        cd_time = cd_time - cd_time % 1
        priv.cd_text:setVisible(true)
        priv.cd_text:setText(tostring(cd_time / 10))
    else
        priv.cd_mask:setSize(0, self:getHeight())
        priv.cd_text:setVisible(false)
    end

    priv.cd_line:setSize(0.05 * self:getWidth(), self:getHeight())

    if left > 0 then
        priv.cd_line:setVisible(true)
        priv.cd_line:setPos(left / full * 0.95 * self:getWidth(), 0)
    else
        priv.cd_line:setVisible(false)
    end
end

---@param abil AbilityExt
function public:setAbility(abil)
    local priv = private.data[self]

    if abil then
        self:setAlpha(1)
        self:setNormalTexture(abil:getIcon())
        self:setCharges(abil:getCurrentChargesLeft(),
                        abil:getCurrentChargesMax())
        self:setCooldown(abil:getCurrentCooldownLeft(),
                         abil:getCurrentCooldownFull())
    else
        self:setAlpha(0)
        self:setCharges(0, 0)
        self:setCooldown(0, 0)
    end

    local prev = priv.abil

    priv.abil = abil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameNormalButton
function private.newData(self)
    local priv = {
        abil = nil,

        cd_mask = NormalImage.new(),
        cd_line = NormalImage.new(),
        cd_text = SimpleText.new(),

        cd_left = 0,
        cd_full = 1,

        charges_back = NormalImage.new(),
        charges_text = SimpleText.new(),

        charges_left = 1,
        charges_full = 1,
    }
    private.data[self] = priv

    priv.cd_mask:setParent(self)
    priv.cd_mask:setPos(0, 0)
    priv.cd_mask:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
    priv.cd_mask:setAlpha(0.7)

    priv.cd_line:setParent(self)
    priv.cd_line:setPos(0, 0)
    priv.cd_line:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor14.blp')

    priv.cd_text:setParent(self)
    priv.cd_text:setPos(0, 0)

    priv.charges_back:setParent(self)
    priv.charges_text:setParent(self)

    self:setSize(self:getWidth(), self:getHeight())
    self:addAction(FrameEvemt.MOUSE_CLICK, private.startTargeting)
end

---@type FrameNormalButtonCallback
private.startTargeting = function(self)
    ---@type AbilityExt
    local abil = private.data[self].abil
    if not abil then
        return
    end

    abil:targetingStart()
end

return static