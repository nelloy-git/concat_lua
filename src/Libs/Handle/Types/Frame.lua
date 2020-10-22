--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type TypesLib
local TypesLib = lib_dep.Types or error('')
local FrameEventType = TypesLib.FrameEventTypeEnum or error('')
local eventToStr = TypesLib.frameEventtoString or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')
---@type TriggerClass
local Trigger = require(lib_path..'Types.Trigger') or error('')

--=======
-- Class
--=======

local Frame = Class.new('Frame', Handle)
---@class Frame : Handle
local public = Frame.public
---@class FrameClass : HandleClass
local static = Frame.static
---@type FrameClass
local override = Frame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param is_simple boolean
---@param child Frame | nil
---@return Frame
function override.new(name, is_simple, child)
    isTypeErr(name, 'string', 'name')
    isTypeErr(is_simple, 'boolean', 'is_simple')
    if child then isTypeErr(child, Frame, 'child') end

    local handle = private.createFramehandle(name, is_simple)
    return static.link(handle, is_simple, child)
end

---@param handle framehandle
---@param is_simple boolean
---@param child Frame | nil
---@return Frame
function override.link(handle, is_simple, child)
    isTypeErr(handle, 'framehandle', 'handle')
    isTypeErr(is_simple, 'boolean', 'is_simple')
    if child then isTypeErr(child, Frame, 'child') end

    local instance = child or Class.allocate(Frame)
    instance = Handle.new(handle, BlzDestroyFrame, instance)
    private.newData(instance, is_simple)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    local priv = private.data[self]

    priv.x = x
    priv.y = y

    if priv.parent then
        BlzFrameSetPoint(self:getData(), FRAMEPOINT_TOPLEFT,
                         priv.parent:getData(), FRAMEPOINT_TOPLEFT,
                         x, -y)
    else
        BlzFrameSetAbsPoint(self:getData(), FRAMEPOINT_TOPLEFT,
                            x, 0.6 - y)
    end

    for child, _ in pairs(priv.children) do
        child:setPos(child:getX(), child:getY())
    end
end

--- Returns x offset from parent.
---@return number
function public:getX()
    return private.data[self].x
end

--- Returns y offset from parent.
function public:getY()
    return private.data[self].y
end

---@return number
function public:getAbsX()
    local priv = private.data[self]

    local parent_x = priv.parent and priv.parent:getAbsX() or 0
    local self_x = priv.x

    return self_x + parent_x
end

---@return number
function public:getAbsY()
    local priv = private.data[self]

    local parent_y = priv.parent and priv.parent:getAbsY() or 0
    local self_y = priv.y

    return self_y + parent_y
end

---@param width number
---@param height number
function public:setSize(width, height)
    local priv = private.data[self]

    priv.width = width
    priv.height = height
    BlzFrameSetSize(self:getData(), width, height)
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return boolean
function public:isSimple()
    return private.data[self].is_simple
end

---@return framehandle | nil
function public:getParent()
    return private.data[self].parent
end

--- User must check frame and parent are both simple or they are both normal.
---@param parent Frame | nil
function public:setParent(parent)
    local priv = private.data[self]

    -- Remove frame from previous parent.
    if priv.parent then
        local parent_priv = private.data[priv.parent]
        parent_priv.children[self] = nil
    end

    -- Setup new parent
    priv.parent = parent
    if parent then
        local parent_priv = private.data[parent]
        parent_priv.children[self] = true
    else
        BlzFrameSetParent(self:getData(), private.console_ui_backdrop)
    end

    -- Update position
    self:setPos(self:getX(), self:getY())
    self:setVisible(self:isVisible())
end

function public:getLevel()
    return private.data[self].level
end

---@param level number
function public:setLevel(level)
    local priv = private.data[self]

    priv.level = level
    BlzFrameSetLevel(self:getData(), level)
end

function public:getAlpha()
    return private.data[self].alpha
end

--- [0, 1]
---@param alpha number
function public:setAlpha(alpha)
    alpha = alpha > 1 and 1 or alpha < 0 and 0 or alpha
    private.data[self].alpha = alpha

    BlzFrameSetAlpha(self:getData(), math.floor(255 * alpha))
end

---@return boolean
function public:isVisible()
    local priv = private.data[self]
    return priv.visible
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]
    priv.visible = flag

    BlzFrameSetVisible(self:getData(), flag)
    for child, _ in pairs(priv.children) do
        child:setVisible(flag)
    end
    
    -- Adopted children
    --for child, _ in pairs(private.data[self].adopted) do
    --    child:setVisible(flag)
    --end
end

---@return Frame | nil
function public:getTooltip()
    return private.data[self].tooltip
end

---@param tooltip Frame | nil
function public:setTooltip(tooltip)
    local priv = private.data[self]

    if priv.is_simple then
        -- Simple frame
        if tooltip and not tooltip:isSimple() then
            Log:err('Normal frame can not be a tooltip for simple frame.', 2)
        end
    else
        -- Normal frame
        if tooltip and tooltip:isSimple() then
            Log:err('Simple frame can not be a parent of normal frame.', 2)
        end
    end
    local tooltip_handle = tooltip and tooltip:getData() or nil

    priv.tooltip = tooltip
    BlzFrameSetTooltip(self:getData(), tooltip_handle)
    --if priv.is_simple then
        tooltip:setVisible(false)
    --end
end

---@return boolean
function public:isEnabled()
    return BlzFrameGetEnable(self:getData())
end

---@param flag boolean
function public:setEnabled(flag)
    BlzFrameSetEnable(self:getData(), flag)
end

function public:click()
    BlzFrameClick(self:getData())
end

---@alias FrameCallback fun(frame:Frame, player:player, event:frameeventtype)

--- Not all events are available for all
---@param event frameeventtype
---@param callback FrameCallback
---@return Action
function public:addAction(event, callback)
    local priv = private.data[self]

    if not priv.actions[event] then
        priv.actions[event] = ActionList.new(self)
    end
    ---@type ActionList
    local list = priv.actions[event]
    return list:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for _, list in pairs(priv.actions) do
        if list and list:remove(action) then
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Frame
---@param is_simple boolean
function private.newData(self, is_simple)
    local handle = self:getData()
    local priv = {
        is_simple = is_simple,

        x = 0,
        y = 0,
        width = BlzFrameGetWidth(handle),
        height = BlzFrameGetHeight(handle),
        tooltip = nil,

        level = 0,
        alpha = 0,
        visible = true,

        children = {},
        --adopted = {},

        ---@type table<frameeventtype, ActionList>
        actions = {}
    }
    private.data[self] = priv

    for _, event in pairs(FrameEventType) do
        private.trigger:addFrameEvent(handle, event)
    end
end

---@param name string
---@param is_simple boolean
---@return framehandle
function private.createFramehandle(name, is_simple)
    local handle
    local test_handle
    if is_simple then
        handle = BlzCreateSimpleFrame(name, nil, 0)
        test_handle = BlzCreateSimpleFrame('', nil, 0)
    else
        handle = BlzCreateFrame(name, private.console_ui_backdrop, 0, 0)
        test_handle = BlzCreateFrame('', private.console_ui_backdrop, 0, 0)
    end

    if tostring(handle) == tostring(test_handle) then
        BlzDestroyFrame(handle)
        BlzDestroyFrame(test_handle)
        Log:err('Can not create framehandle', 3)
    end
    BlzDestroyFrame(test_handle)

    return handle
end

function private.runActions()
    ---@type Frame
    local frame = static.getLinked(BlzGetTriggerFrame())
    local player = GetTriggerPlayer()
    local event = BlzGetTriggerFrameEvent()

    local priv = private.data[frame]
    if not priv then return end
    ---@type ActionList
    local actions_list = priv.actions[event]
    if actions_list then actions_list:run(frame, player, event) end

    -- Drop focus
    if event == FrameEventType.MOUSE_CLICK and frame:isEnabled() then
        frame:setEnabled(false)
        frame:setEnabled(true)
    end
end

if not IsCompiletime() then
    private.console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    BlzFrameClearAllPoints(private.console_ui_backdrop)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, 0, 0.6)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_BOTTOMRIGHT, 0, 0.6)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_TOPLEFT, 0, 0.6)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_TOPLEFT, 0, 0.6)

    -- Protect ConsoleUIBackdrop
    local origBlzGetFrameByName = BlzGetFrameByName
    BlzGetFrameByName = function(name, createContext)
        if name == 'ConsoleUIBackdrop' then
            Log:err('Function disabled by FrameClass from HandleLib.', 2)
        end
        return origBlzGetFrameByName(name, createContext)
    end

    private.trigger = Trigger.new()
    private.trigger:addAction(private.runActions)
end

return static