--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local NormalButton = FrameLib.Normal.Button or error('')
local NormalImage = FrameLib.Normal.Image or error('')
local SimpleText = FrameLib.Simple.Text or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type InterfaceSkillButtonFdf
local Fdf = require('Interface.Skill.ButtonFdf') or error('')

--=======
-- Class
--=======

local InterfaceSkillButton = Class.new('InterfaceSkillButton', Frame)
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
    instance = Frame.new(Fdf.background:getName(), Fdf.background:isSimple(), instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    FramePublic.setSize(self, width, height)
    local priv = private.data[self]

    priv.button:setSize(0.8 * width, 0.8 * height)
    priv.button:setPos(0.1 * width, 0.1 * height)

    priv.charges_back:setSize(width / 3, height / 4)
    priv.charges_back:setPos(0, priv.button:getHeight() - priv.charges_back:getHeight())

    priv.charges_text:setSize(width / 3, height / 4)
    priv.charges_text:setPos(0, priv.button:getHeight() - priv.charges_text:getHeight())
    priv.charges_text:setFont('fonts\\nim_____.ttf', 0.8 * height / 4)

    self:setCooldown(priv.cd_left, priv.cd_full)
end

---@param flag boolean
function public:setEnabled(flag)
    FramePublic.setEnabled(self, flag)
    local priv = private.data[self]

    priv.button:setEnabled(flag)
end

---@param count number
function public:setCharges(count, max_count)
    local priv = private.data[self]
--[[
    if max_count <= 1 then
        priv.charges_back:setVisible(false)
        priv.charges_text:setVisible(false)
    else
        priv.charges_back:setVisible(true)
        priv.charges_text:setVisible(true)

        local s_count = tostring(count - count % 1)
        priv.charges_text:setText(s_count)
    end
--]]
end

---@param left number
---@param full number
function public:setCooldown(left, full)
    local priv = private.data[self]
    priv.cd_left = left
    priv.cd_full = full

    priv.cd_mask:setSize(left / full * priv.button:getWidth(), priv.button:getHeight())

    priv.cd_line:setSize(0.1 * priv.button:getWidth(), 0)
    priv.cd_line:setPos(left / full * 0.95 * priv.button:getWidth(), 0)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setTexture(tex_file, dis_tex, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    local priv = private.data[self]

    priv.button:setNormalTexture(tex_file, flag, blend)
    priv.button:setPushedTexture(tex_file, flag, blend)
    priv.button:setDisabledTexture(dis_tex, flag, blend)
end

---@param event frameeventtype
---@param callback FrameNormalButtonCallback
---@return Action | nil
function public:addAction(event, callback)
    private.data[self].button:addAction(event, callback)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceSkillButton
function private.newData(self)
    local priv = {
        button = NormalButton.new(Fdf.button),

        cd_mask = NormalImage.new(),
        cd_line = NormalImage.new(),
        cd_text = SimpleText.new(),

        cd_left = 0,
        cd_full = 1,

        charges_back = NormalImage.new(),
        charges_text = SimpleText.new(),
    }
    private.data[self] = priv

    priv.button:setParent(self)

    priv.cd_mask:setParent(priv.button)
    priv.cd_mask:setPos(0, 0)
    priv.cd_mask:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
    priv.cd_mask:setAlpha(0.6)

    priv.cd_line:setParent(priv.button)
    priv.cd_line:setPos(0, 0)
    priv.cd_line:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor14.blp')

    priv.charges_back:setParent(priv.button)
    priv.charges_text:setParent(priv.button)

    self:setSize(self:getWidth(), self:getHeight())
end

return static