--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')

---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local Image = FrameLib.Normal.Image or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local InterfaceUnitBuffs = Class.new('InterfaceUnitBuffs', Frame)
---@class InterfaceUnitBuffs : Frame
local public = InterfaceUnitBuffs.public
---@class InterfaceUnitBuffsClass : FrameClass
local static = InterfaceUnitBuffs.static
---@type InterfaceUnitBuffsClass
local override = InterfaceUnitBuffs.override
local private = {}

--=========
-- Static
--=========

---@return InterfaceUnitBuffs
function override.new()
    local instance = Class.allocate(InterfaceUnitBuffs)
    instance = Frame.new(private.fdf:getName(), private.fdf:isSimple(), instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    FramePublic.setPos(self, x, y)
    self:update()
end

--- Disabled
---@param width number
---@param height number
function public:setSize(width, height)
    Log:wrn(tostring(InterfaceUnitBuffs)..': it is autosized frame. Use setBuffIconSize instead.')
end

---@param width number
---@param height number
function public:setBuffIconSize(width, height)
    local priv = private.data[self]
    priv.buff_w = width
    priv.buff_h = height
    self:update()
end

---@param flag number
function public:setVisible(flag)
    FramePublic.setVisible(self, flag)
    local priv = private.data[self]

    for i = 1, #private.buffs do
        priv.buff_frames[i]:setVisible(flag)
    end
end

---@param unit_buffs BuffsContainer
function public:setUnitBuffs(unit_buffs)
    private.data[self].unit_buffs = unit_buffs
    self:update()
end

---@param self InterfaceUnitBuffs
function public:update()
    private.updateBuffFrames(self)
    local priv = private.data[self]

    local x0 = self:getAbsX() + 0.05 * self:getWidth()
    local y0 = self:getAbsY() + 0.95 * self:getHeight()

    local per_line = priv.per_line
    local count = #priv.buff_frames
    local w = priv.buff_w
    local h = priv.buff_h
    print(w, h)
    local lines, mod = math.modf(count / per_line)

    if mod ~= 0 then lines = lines + 1 end

    FramePublic.setSize(self,
                        1 / 0.9 * per_line * w,
                        1 / 0.9 * lines * h)

    local buffs = priv.unit_buffs and priv.unit_buffs:getAll() or {}
    local i = 0
    for l = 1, lines do
        for p = 1, per_line do
            i = i + 1
            ---@type FrameNormalImage
            local buff = priv.buff_frames[i]
            buff:setSize(w, h)
            buff:setPos(x0 + (p - 1) * w, y0 - l * h)
            buff:setTexture(buffs[i]:getType():getIcon(buffs[i]), 0, true)

            if i + 1 > #priv.buff_frames then
                return
            end
        end
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf = FrameLib.Fdf.Normal.Backdrop.new('InterfaceUnitBuffsBackground')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackgroundTileMode(true)
private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

---@param self InterfaceUnitBuffs
function private.newData(self)
    local priv = {
        unit_buffs = nil,
        buff_frames = {},

        per_line = 7,
        buff_w = 0.04,
        buff_h = 0.04
    }
    private.data[self] = priv
end

---@param self InterfaceUnitBuffs
function private.updateBuffFrames(self)
    local priv = private.data[self]
    local buffs = priv.unit_buffs and priv.unit_buffs:getAll() or {}

    if #buffs > #priv.buff_frames then
        for i = #priv.buff_frames + 1, #buffs do
            priv.buff_frames[i] = Image.new()
        end
    else
        for i = #buffs + 1, #priv.buff_frames do
            priv.buff_frames[i]:destroy()
        end
    end
end

return static