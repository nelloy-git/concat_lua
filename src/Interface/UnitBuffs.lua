--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')

---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local Button = FrameLib.Normal.Button
local Image = FrameLib.Normal.Image or error('')
local ImagePublic = Class.getPublic(Image) or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local InterfaceUnitBuffs = Class.new('InterfaceUnitBuffs', Image)
---@class InterfaceUnitBuffs : FrameNormalImage
local public = InterfaceUnitBuffs.public
---@class InterfaceUnitBuffsClass : FrameNormalImageClass
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
    instance = Image.new(instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    ImagePublic.setPos(self, x, y)
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
    ImagePublic.setVisible(self, flag)
    local priv = private.data[self]

    for i = 1, #priv.buff_frames do
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

    local x0 = self:getAbsX()
    local y0 = self:getAbsY()

    local per_line = priv.per_line
    local count = #priv.buff_frames
    local w = priv.buff_w
    local h = priv.buff_h
    local lines, mod = math.modf(count / per_line)

    if mod ~= 0 then lines = lines + 1 end

    local buffs = priv.unit_buffs and priv.unit_buffs:getAll() or {}
    local i = 0
    for l = 1, lines do
        for p = 1, per_line do
            i = i + 1
            if i > #priv.buff_frames or i > #buffs then
                return
            end

            ---@type FrameNormalImage
            local buff = priv.buff_frames[i]
            buff:setSize(w, h)
            buff:setPos(x0 + (p - 1) * w, y0 + (l - 1) * h)
            buff:setNormalTexture(buffs[i]:getType():getIcon(buffs[i]))
            buff:setPushedTexture(buffs[i]:getType():getIcon(buffs[i]))
        end
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf_tooltip = Fdf

---@param self InterfaceUnitBuffs
function private.newData(self)
    local priv = {
        unit_buffs = nil,
        buff_frames = {},
        tooltip = nil,

        per_line = 10,
        buff_w = 0.04,
        buff_h = 0.04
    }
    private.data[self] = priv
    self:setAlpha(0)
end

---@param self InterfaceUnitBuffs
function private.updateBuffFrames(self)
    local priv = private.data[self]
    local buffs = priv.unit_buffs and priv.unit_buffs:getAll() or {}

    if #buffs > #priv.buff_frames then
        for i = #priv.buff_frames + 1, #buffs do
            priv.buff_frames[i] = Button.new()
        end
    else
        for i = #buffs + 1, #priv.buff_frames do
            priv.buff_frames[i]:destroy()
            priv.buff_frames[i] = nil
        end
    end
end

return static