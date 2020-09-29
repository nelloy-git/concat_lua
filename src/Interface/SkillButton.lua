--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local OriginSkillBtn = FrameLib.Origin.SkillButton or error('')
local SimpleImage = FrameLib.Simple.Image or error('')
local SimpleText = FrameLib.Simple.Text or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
local Tooltip = FrameLib.Normal.Tooltip
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEventType = TypesLib.FrameEventTypeEnum or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local Log = UtilsLib.Log or error('')

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

local static_instances = {}

---@return InterfaceSkillButton
function override.new(origin_id)
    if static_instances[origin_id] then
        Log:wrn(tostring(InterfaceSkillButton)..': instance with selected origin_id already exist.')
        return static_instances[origin_id]
    end

    local instance = Class.allocate(InterfaceSkillButton)
    instance = Frame.new(private.fdf:getName(), private.fdf:isSimple(), instance)

    private.newData(instance, origin_id)

    static_instances[origin_id] = instance
    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    FramePublic.setPos(self, x, y)
    local priv = private.data[self]

    local x0 = 0.1 * priv.origin:getWidth()
    local y0 = 0.1 * priv.origin:getHeight()

    priv.charges_back:setPos(x0, y0)
    priv.charges_text:setPos(x0, y0)
end

---@param width number
---@param height number
function public:setSize(width, height)
    Log:wrn(tostring(InterfaceSkillButton)..': size can not be changed.')
end

---@param count number
function public:setCharges(count, max_count)
    local priv = private.data[self]

    if max_count > 1 then
        priv.charges_back:setVisible(false)
        priv.charges_text:setVisible(false)
    else
        priv.charges_back:setVisible(true)
        priv.charges_text:setVisible(true)

        local s_count = tostring(count - count % 1)
        priv.charges_text:setText(s_count)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceSkillButton
---@param origin_id number
function private.newData(self, origin_id)
    local priv = {
        origin = OriginSkillBtn[origin_id],
        charges_back = SimpleImage.new(),
        charges_text = SimpleText.new(),
    }
    private.data[self] = priv

    local w = 1.2 * priv.origin:getWidth()
    local h = 1.2 * priv.origin:getHeight()
    local x0 = 0.1 * priv.origin:getWidth()
    local y0 = 0.1 * priv.origin:getHeight()

    FramePublic.setSize(self, w, h)

    priv.origin:setParent(self)
    priv.origin:setPos(x0, y0)

    priv.charges_back:setPos(x0, y0)
    priv.charges_back:setSize(priv.origin:getWidth() / 3, priv.origin:getHeight() / 6)
    priv.charges_back:setVisible(false)
    priv.charges_back:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')

    priv.charges_text:setPos(x0, y0)
    priv.charges_text:setSize(priv.origin:getWidth() / 3, priv.origin:getHeight() / 6)
    priv.charges_text:setVisible(false)
    priv.charges_text:setFont('fonts\\nim_____.ttf', 0.9 * priv.charges_text:getHeight(), 0)
end

private.fdf = FrameLib.Fdf.Normal.Backdrop.new('InterfaceSkillButtonBorder')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackgroundTileMode(true)
private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setBlendAll(true)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static