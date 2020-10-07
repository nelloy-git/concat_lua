--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')

---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local BuffContainer = BuffLib.Container
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local Button = FrameLib.Normal.Button
local Image = FrameLib.Normal.Image or error('')
local ImagePublic = Class.getPublic(Image) or error('')
local Tooltip = FrameLib.Normal.Tooltip or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Timer = HandleLib.Timer or error('')
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
    instance = Image.new(nil, instance)

    private.newData(instance,
                    max_buffs or 20)

    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    ImagePublic.setSize(self, width, height)
    private.updatePos(self)
end

---@param container BuffContainer | nil
function public:setBuffContainer(container)
    if container then isTypeErr(container, BuffContainer, 'container') end

    local priv = private.data[self]

    local previous = priv.container
    if previous then
        private.container2interface[previous] = nil
        previous:removeAction(priv.changed_action)
    end

    priv.container = container
    if container then
        private.container2interface[container] = self
        local action = container:addChangedAction(private.containerChanged)
        priv.changed_action = action
    end

    private.updateBuffsList(self)
end

---@return number
function public:getMaxCount()
    return private.data[self].max_buffs
end

---@return number
function public:getPerLine()
    return private.data[self].per_line
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.container2interface = setmetatable({}, {__mode = 'kv'})
private.button2interface = setmetatable({}, {__mode = 'kv'})

---@param self InterfaceUnitBuffs
---@param max_buffs number
function private.newData(self, max_buffs)
    local priv = {
        container = nil,
        changed_action = nil,

        active_pos = -1,
        btn = {},
        tooltip = Tooltip.new(),

        max_buffs = max_buffs,
        per_line = 10,
    }
    private.data[self] = priv
    self:setAlpha(0)

    for i = 1, max_buffs do
        local btn = Button.new()
        btn:setParent(self)
        btn:setAlpha(1)
        btn:setVisible(false)
        btn:addAction(FrameEventType.MOUSE_ENTER, private.mouseEnter)
        btn:addAction(FrameEventType.MOUSE_LEAVE, private.mouseLeave)

        private.button2interface[btn] = self
        table.insert(priv.btn, i, btn)
    end

    priv.tooltip:setParent(self)
    priv.tooltip:setAlpha(1)
    priv.tooltip:setSize(0.2, 0.10)
    priv.tooltip:setIconsSize(0.015, 0.015)
    priv.tooltip:setRightIcon('ReplaceableTextures\\\\CommandButtons\\\\BTNPatrol.blp')
    priv.tooltip:setVisible(false)
end

---@param self InterfaceUnitBuffs
function private.updatePos(self)
    local priv = private.data[self]

    local count = #priv.btn
    local w = self:getWidth() / priv.per_line
    local h = private.getLineHeight(self:getHeight(),
                                    priv.max_buffs, priv.per_line)

    local p = 0
    local l = 1
    for i = 1, count do
        p = p + 1
        if p > priv.per_line then
            p = 1
            l = l + 1
        end

        priv.btn[i]:setPos((p - 1) * w, (l - 1) * h)
        priv.btn[i]:setSize(w, h)
    end
end

---@param height number
---@param max_frames number
---@param per_line number
---@return number
function private.getLineHeight(height, max_frames, per_line)
    local i, f = math.modf(max_frames / per_line)
    if f ~= 0 then i = i + 1 end
    return height / i
end

---@param self InterfaceUnitBuffs
function private.updateBuffsList(self)
    local priv = private.data[self]

    local buffs = priv.container and priv.container:getAll() or {}
    local p = 0
    local l = 1
    for i = 1, #priv.btn do
        p = p + 1
        if p > priv.per_line then
            p = 1
            l = l + 1
        end

        local btn = priv.btn[i]
        if not buffs[i] then
            btn:setVisible(false)
            return
        end

        btn:setVisible(true)
        btn:setNormalTexture(buffs[i]:getIcon())
        btn:setPushedTexture(buffs[i]:getIcon())
    end

    private.updateTooltip(self)
end

---@param self InterfaceUnitBuffs
function private.updateTooltip(self)
    local priv = private.data[self]

    local tooltip = priv.tooltip
    local pos = priv.active_pos

    if pos < 1 then return end

    local buff = priv.container:get(pos)

    if buff then
        tooltip:setName(buff:getName())
        tooltip:setText(buff:getTooltip())

        -- Time
        local time = buff:getTimeLeft()
        time = time - time % 0.1
        local s_time = tostring(time)
        s_time = s_time:sub(1, s_time:find('%.') + 1)
        tooltip:setRightText(s_time)

        -- Position
        local used_lines, f = math.modf(priv.container:count() / priv.per_line)
        if f ~= 0 then used_lines = used_lines + 1 end
        tooltip:setPos(0, used_lines * priv.btn[1]:getHeight())
    end
end

---@param container BuffContainer
function private.containerChanged(container)
    ---@type InterfaceUnitBuffs
    local self = private.container2interface[container]
    private.updateBuffsList(self)
end

---@param btn FrameNormalButton
function private.mouseEnter(btn)
    ---@type InterfaceUnitBuffs
    local self = private.button2interface[btn]
    local priv = private.data[self]

    local pos = -1
    for i = 1, #priv.btn do
        if btn == priv.btn[i] then
            pos = i
            break
        end
    end
    priv.active_pos = pos

    priv.tooltip:setVisible(true)
    private.updateTooltip(self)
end

---@param btn FrameNormalButton
function private.mouseLeave(btn)
    ---@type InterfaceUnitBuffs
    local self = private.button2interface[btn]
    local priv = private.data[self]

    priv.active_pos = -1
    priv.tooltip:setVisible(false)
end

if not IsCompiletime() then
    local timer = Timer.new()
    timer:start(0.05, true, function()
        for self, priv in pairs(private.data) do
            private.updateTooltip(self)
        end
    end)
end

return static