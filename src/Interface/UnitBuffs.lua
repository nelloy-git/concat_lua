--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')

---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local Button = FrameLib.Normal.Button
local Image = FrameLib.Normal.Image or error('')
local ImagePublic = Class.getPublic(Image) or error('')
local Tooltip = FrameLib.Normal.Tooltip or error('')
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEventType = TypesLib.FrameEventTypeEnum or error('')
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

---@param max_buffs number | nil
---@return InterfaceUnitBuffs
function override.new(max_buffs)
    local instance = Class.allocate(InterfaceUnitBuffs)
    instance = Image.new(instance)

    private.newData(instance, max_buffs or 20)

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
    for i = 1, #priv.buff_frames do
        local l, p = math.modf(i / per_line)
        p = p * 10

        if buffs[i]
    end
    for l = 1, lines do
        for p = 1, per_line do
            i = p + (l - 1)
            if i > #priv.buff_frames or i > #buffs then
                if i < #priv.buff_frames
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

    priv.tooltip:setPos(x0, y0 - (lines - 1) * h)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.buff_frame2unit_buffs = setmetatable({}, {__mode = 'kv'})

---@param self InterfaceUnitBuffs
---@param max_buffs number
function private.newData(self, max_buffs)
    local priv = {
        unit_buffs = nil,
        buff_frames = {},
        tooltip = Tooltip.new(),

        per_line = 10,
        buff_w = 0.04,
        buff_h = 0.04
    }
    private.data[self] = priv
    self:setAlpha(0)

    for i = 1, max_buffs do
        local btn = Button.new()
        btn:addAction(FrameEventType.MOUSE_ENTER, private.updateTooltipFull)
        btn:setVisible(false)
        btn:setTooltip(priv.tooltip)

        private.buff_frame2unit_buffs[btn] = self
        table.insert(priv.buff_frames, btn)
    end

    priv.tooltip:setSize(0.2, 0.15)
    priv.tooltip:setIconsSize(0.02, 0.02)
    priv.tooltip:setRightIcon('ReplaceableTextures\\\\CommandButtons\\\\BTNPatrol.blp')
    priv.tooltip:setVisible(false)
end

---@param frame FrameNormalButton
---@param player player
function private.updateTooltipFull(frame, player)
    ---@type FrameNormalTooltip
    local tooltip = frame:getTooltip()
    ---@type Buff
    local buff = private.buff_frame2unit_buffs[frame]

    tooltip:setName(buff:getType():getName(buff))
    tooltip:setText(buff:getType():getTooltip(buff))
    tooltip:setRightText(tostring(buff:getTimeLeft()))
end

return static