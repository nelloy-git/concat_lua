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
---@type InterfaceSkillChargesClass
local SkillCharges = require('Interface.Skill.Charges') or error('')

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

    --priv.cd_text:setSize(0.8 * width, 0.8 * height)
    --priv.cd_text:setFont('fonts\\nim_____.ttf', height / 4)

    priv.charges:setSize(width / 3, height / 4)
    priv.charges:setPos(0, 3 * height / 4)
end

---@param abil AbilityExt
function public:setAbility(abil)
    local priv = private.data[self]

    local prev = priv.abil


    priv.abil = abil
    if abil then
        priv.charges:setCharges(abil:getCharges())

        self:setVisible(true)
        self:setNormalTexture(abil:getType():getData():getIcon(abil))
    else
        self:setVisible(false)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameNormalButton
function private.newData(self)
    local priv = {
        abil = nil,

        --cd_mask = NormalImage.new(),
        --cd_line = NormalImage.new(),
        --cd_text = SimpleText.new(),

        cd_left = 0,
        cd_full = 1,

        charges = SkillCharges.new(),
    }
    private.data[self] = priv

    --priv.cd_mask:setParent(self)
    --priv.cd_mask:setPos(0, 0)
    --priv.cd_mask:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
    --priv.cd_mask:setAlpha(0.7)

    --priv.cd_line:setParent(self)
    --priv.cd_line:setPos(0, 0)
    --priv.cd_line:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor14.blp')

    --priv.cd_text:setParent(self)
    --priv.cd_text:setPos(0, 0)

    priv.charges:setParent(self)

    self:setSize(self:getWidth(), self:getHeight())
    self:addAction(FrameEvemt.MOUSE_CLICK, private.startTargeting)
end

---@type FrameNormalButtonCallback
private.startTargeting = function(self, pl)
    if pl ~= GetLocalPlayer() then
        return
    end

    ---@type AbilityExt
    local abil = private.data[self].abil
    if not abil then
        return
    end

    abil:targetingStart()
end

return static