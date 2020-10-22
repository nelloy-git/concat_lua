--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local FdfNormalImage = FrameLib.Fdf.Normal.Backdrop or error('')
local NormalImage = FrameLib.Normal.Image or error('')
local NormalImagePublic = Class.getPublic(NormalImage) or error('')
local SimpleText = FrameLib.Simple.Text or error('')
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEvemt = TypesLib.FrameEventTypeEnum
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

--=======
-- Class
--=======

local InterfaceSkillCharges = Class.new('InterfaceSkillCharges', NormalImage)
---@class InterfaceSkillCharges : FrameNormalImage
local public = InterfaceSkillCharges.public
---@class InterfaceSkillChargesClass : FrameNormalImageClass
local static = InterfaceSkillCharges.static
---@type InterfaceSkillChargesClass
local override = InterfaceSkillCharges.override
local private = {}

--=========
-- Static
--=========

---@param child InterfaceSkillCharges | nil
---@return InterfaceSkillCharges
function override.new(child)
    if child then isTypeErr(child, InterfaceSkillCharges, 'child') end

    local instance = child or Class.allocate(InterfaceSkillCharges)
    instance = NormalImage.new(private.fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    NormalImagePublic.setSize(self, width, height)
    local priv = private.data[self]

    priv.text:setSize(width, height)
    priv.text:setFont('fonts\\nim_____.ttf', 0.8 * height)
end

---@param charges AbilityExtCharges
function public:setCharges(charges)
    local priv = private.data[self]

    local prev = priv.charges
    if prev then
        private.charges2frame[prev] = nil
        prev:removeAction(priv.changed_action)
    end

    priv.charges = charges
    if charges then
        private.charges2frame[charges] = self
        priv.changed_action = charges:addChargesChangedAction(private.changedCallback)
        private.changedCallback(charges)
    else
        self:setVisible(false)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.charges2frame = setmetatable({}, {__mode = 'kv'})

---@param self FrameNormalButton
function private.newData(self)
    local priv = {
        charges = nil,
        changed_action = nil,

        text = SimpleText.new(),
    }
    private.data[self] = priv

    priv.text:setParent(self)

    self:setSize(self:getWidth(), self:getHeight())
end

---@type AbilityExtChargesCallback
private.changedCallback = function(charges)
    local self = private.charges2frame[charges]
    local max = charges:getMax()

    if max <= 1 then
        self:setVisible(false)
    else
        self:setVisible(true)

        local left = charges:get()
        local s_left = tostring(left - left % 1)
        private.data[self].charges_text:setText(s_left)
    end
end

private.fdf = FdfNormalImage.new('InterfaceSkillCharges')
private.fdf:setWidth(0.01)
private.fdf:setHeight(0.01)
--private.fdf:setBackgroundTileMode(true)
--private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
private.fdf:setBlendAll(true)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static