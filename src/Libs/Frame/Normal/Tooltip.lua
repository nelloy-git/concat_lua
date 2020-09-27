--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = require(LibList.ClassLib) or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type FdfBackdropClass
local FdfBackdrop = require(lib_path..'Fdf.Normal.Backdrop') or error('')
---@type FdfTextClass
local FdfText = require(lib_path..'Fdf.Normal.Text') or error('')

---@type FrameNormalImageClass
local Image = require(lib_path..'Normal.Image')
---@type FrameNormalTextClass
local Text = require(lib_path..'Normal.Text')

--=======
-- Class
--=======

local FrameNormalTooltip = Class.new('FrameNormalTooltip', Frame)
---@class FrameNormalTooltip : Frame
local public = FrameNormalTooltip.public
---@class FrameNormalTooltipClass : FrameClass
local static = FrameNormalTooltip.static
---@type FrameNormalTooltipClass
local override = FrameNormalTooltip.override
local private = {}

--=========
-- Static
--=========

---@return FrameNormalTooltip
function override.new(child)
    if child then isTypeErr(child, FrameNormalTooltip, 'child') end

    local fdf = private.fdf
    local instance = child or Class.allocate(FrameNormalTooltip)
    instance = Frame.new(fdf:getName(), fdf:isSimple(), instance)

    private.newData(instance)

    return instance
end

---@param handle framehandle
---@param child FrameNormalText
---@return FrameNormalTooltip
function override.link(handle, child)
    Log:err(tostring(FrameNormalTooltip)..': function \'link\' is not available.', 2)
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    FramePublic.setSize(self, width, height)
    private.update(self)
end

---@param width number
---@param height number
function public:setIconsSize(width, height)
    local priv = private.data[self]
    priv.left_icon:setSize(width, height)
    priv.center_icon:setSize(width, height)
    priv.right_icon:setSize(width, height)
    private.update(self)
end

---@param flag boolean
function public:setVisible(flag)
    FramePublic.setVisible(self, flag)
    local priv = private.data[self]

    priv.name:setVisible(flag)
    priv.text:setVisible(flag)
    priv.left_icon:setVisible(flag)
    priv.left_text:setVisible(flag)
    priv.center_icon:setVisible(flag)
    priv.center_text:setVisible(flag)
    priv.right_icon:setVisible(flag)
    priv.right_text:setVisible(flag)
end

---@param name string
function public:setName(name)
    isTypeErr(name, 'string', 'name')
    local frame = private.data[self].name
    BlzFrameSetText(frame:getData(), name)
end

---@param text string
function public:setText(text)
    isTypeErr(text, 'string', 'text')
    local frame = private.data[self].text
    BlzFrameSetText(frame:getData(), text)
end

---@param icon string
---@param flag number | nil
---@param blend boolean | nil
function public:setLeftIcon(icon, flag, blend)
    isTypeErr(icon, 'string', 'icon')
    if flag then isTypeErr(flag, 'number', 'flag') end
    if blend then isTypeErr(blend, 'boolean', 'blend') end
    local frame = private.data[self].left_icon
    BlzFrameSetTexture(frame:getData(), icon, flag or 0, blend or true)
end

---@param text string
function public:setLeftText(text)
    isTypeErr(text, 'string', 'text')
    local frame = private.data[self].left_text
    BlzFrameSetText(frame:getData(), text)
end

---@param icon string
---@param flag number | nil
---@param blend boolean | nil
function public:setCenterIcon(icon, flag, blend)
    isTypeErr(icon, 'string', 'icon')
    if flag then isTypeErr(flag, 'number', 'flag') end
    if blend then isTypeErr(blend, 'boolean', 'blend') end
    local frame = private.data[self].center_icon
    BlzFrameSetTexture(frame:getData(), icon, flag or 0, blend or true)
end

---@param text string
function public:setCenterText(text)
    isTypeErr(text, 'string', 'text')
    local frame = private.data[self].center_text
    BlzFrameSetText(frame:getData(), text)
end

---@param icon string
---@param flag number | nil
---@param blend boolean | nil
function public:setRightIcon(icon, flag, blend)
    isTypeErr(icon, 'string', 'icon')
    if flag then isTypeErr(flag, 'number', 'flag') end
    if blend then isTypeErr(blend, 'boolean', 'blend') end
    local frame = private.data[self].right_icon
    BlzFrameSetTexture(frame:getData(), icon, flag or 0, blend or true)
end

---@param text string
function public:setRightText(text)
    isTypeErr(text, 'string', 'text')
    local frame = private.data[self].right_text
    BlzFrameSetText(frame:getData(), text)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameNormalTooltip
function private.newData(self)
    local fdf_icon = private.fdf_icon
    local fdf_name = private.fdf_name
    local fdf_text = private.fdf_text

    local priv = {
        name = Frame.new(fdf_name:getName(), fdf_name:isSimple()),
        text = Frame.new(fdf_text:getName(), fdf_text:isSimple()),

        left_icon = Frame.new(fdf_icon:getName(), fdf_icon:isSimple()),
        left_text = Frame.new(fdf_text:getName(), fdf_text:isSimple()),

        center_icon = Frame.new(fdf_icon:getName(), fdf_icon:isSimple()),
        center_text = Frame.new(fdf_text:getName(), fdf_text:isSimple()),

        right_icon = Frame.new(fdf_icon:getName(), fdf_icon:isSimple()),
        right_text = Frame.new(fdf_text:getName(), fdf_text:isSimple())
    }
    private.data[self] = priv

    priv.name:setParent(self)
    priv.text:setParent(self)
    priv.left_icon:setParent(self)
    priv.left_text:setParent(priv.left_icon)
    priv.center_icon:setParent(self)
    priv.center_text:setParent(priv.center_icon)
    priv.right_icon:setParent(self)
    priv.right_text:setParent(priv.right_icon)
end

---@param self FrameNormalTooltip
function private.update(self)
    local priv = private.data[self]

    local w = self:getWidth()
    local h = self:getHeight()
    local x0 = 0.05 * w
    local y0 = 0.05 * h
    local icon_text_width = (0.9 * w - (priv.left_icon:getWidth() + priv.center_icon:getWidth() + priv.right_icon:getWidth())) / 3

    priv.name:setPos(x0, y0)
    priv.name:setSize(0.9 * w, 0.012)    -- Font size

    -- Left
    local l_x0 = x0
    priv.left_icon:setPos(l_x0, y0 + 0.9 * h - priv.left_icon:getHeight())
    priv.left_text:setPos(priv.left_icon:getWidth(), 0)
    priv.left_text:setSize(icon_text_width, priv.left_icon:getHeight())

    -- Center
    local c_x0 = x0 + priv.left_icon:getWidth() + priv.left_text:getWidth()
    priv.center_icon:setPos(c_x0, y0 + 0.9 * h - priv.center_icon:getHeight())
    priv.center_text:setPos(priv.center_icon:getWidth(), 0)
    priv.center_text:setSize(icon_text_width, priv.center_icon:getHeight())

    -- Right
    local r_x0 = x0 + priv.left_icon:getWidth() + priv.left_text:getWidth()
                    + priv.center_icon:getWidth() + priv.center_text:getWidth()
    priv.right_icon:setPos(r_x0, y0 + 0.9 * h - priv.right_icon:getHeight())
    priv.right_text:setPos(priv.right_icon:getWidth(), 0)
    priv.right_text:setSize(icon_text_width, priv.right_icon:getHeight())

    -- Text
    local max_icon_height = math.max(priv.left_icon:getHeight(),
                                     priv.center_icon:getHeight(),
                                     priv.right_icon:getHeight())
    priv.text:setPos(x0, y0 + priv.name:getHeight())
    priv.text:setSize(0.9 * w,
                      0.9 * h - priv.name:getHeight() - max_icon_height)
end

private.fdf = FdfBackdrop.new('FrameNormalTooltip')
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

private.fdf_icon = FdfBackdrop.new('FrameNormalTooltipIcon')
private.fdf_icon:setWidth(0.04)
private.fdf_icon:setHeight(0.04)
private.fdf_icon:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')

private.fdf_name = FdfText.new('FrameNormalTooltipName')
private.fdf_name:setWidth(0.04)
private.fdf_name:setHeight(0.04)
private.fdf_name:setFont('fonts\\nim_____.ttf', 0.012)
private.fdf_name:setJustification('JUSTIFYLEFT', 'JUSTIFYMIDDLE')

private.fdf_text = FdfText.new('FrameNormalTooltipText')
private.fdf_text:setWidth(0.04)
private.fdf_text:setHeight(0.04)
private.fdf_text:setFont('fonts\\nim_____.ttf', 0.010)
private.fdf_text:setJustification('JUSTIFYCENTER', 'JUSTIFYMIDDLE')

return static