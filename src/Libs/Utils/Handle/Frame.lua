--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type ActionClass
local Action = require(lib_modname..'.Action')
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type TimerClass
local Timer = require(lib_modname..'.Handle.Timer')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkTypeErr = Functions.checkTypeErr


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

---@param type_name string
---@param is_simpleframe boolean
---@param child_instance Frame | nil
---@return Frame
function override.new(type_name, is_simpleframe, child_instance)
    checkTypeErr(type_name, 'string', 'type_name')
    checkTypeErr(is_simpleframe, 'boolean', 'is_simpleframe')
    if child_instance then
        checkTypeErr(child_instance, Frame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Frame)
    local handle = is_simpleframe and BlzCreateFrame(type_name, nil, 0, 0) or BlzCreateSimpleFrame(type_name, nil, 0)
    instance = Handle.new(handle, BlzDestroyFrame, instance)
    private.newData(instance, is_simpleframe)

    return instance
end

--========
-- Public
--========

---@param point framepointtype
---@param relative Frame
---@param relativePoint framepointtype
---@param x number
---@param y number
function public:setPoint(point, relative, relativePoint, x, y)
    BlzFrameSetPoint(self:getHandleData(), point, relative:getHandleData(), relativePoint, x, y)
end

---@param relative Frame
function public:setAllPoints(relative)
    BlzFrameSetAllPoints(self:getHandleData(), relative:getHandleData())
end

---@param point framepointtype
---@param x number
---@param y number
function public:setAbsPoint(point, x, y)
    BlzFrameSetAbsPoint(self:getHandleData(), point, x, y)
end

function public:clearAllPoints()
    BlzFrameClearAllPoints(self:getHandleData())
end

---@param visible boolean
function public:setVisible(visible)
    BlzFrameSetVisible(self:getHandleData(), visible)
end

---@return boolean
function public:isVisible()
    return BlzFrameIsVisible(self:getHandleData())
end

---@return string
function public:getName()
    return BlzFrameGetName(self:getHandleData())
end

---@param alpha number
function public:setAlpha(alpha)
    BlzFrameSetAlpha(self:getHandleData(), alpha)
end

---@return number
function public:getAlpha()
    return BlzFrameGetAlpha(self:getHandleData())
end

---@param texFile string
---@param flag integer
---@param blend boolean
function public:setTexture(texFile, flag, blend)
    BlzFrameSetTexture(self:getHandleData(), texFile, flag, blend)
end

---@param tooltip Frame
function public:BlzFrameSetTooltip(tooltip)
    BlzFrameSetTooltip(self:getHandleData(), tooltip:getHandleData())
end

---@param value number
function public:BlzFrameSetValue(value)
    BlzFrameSetValue(self:getHandleData(), value)
end

---@return number
function public:BlzFrameGetValue()
    return BlzFrameGetValue(self:getHandleData())
end

---@param width number
---@param height number
function public:BlzFrameSetSize(width, height)
    BlzFrameSetSize(self:getHandleData(), width, height)
end

---@param color number
function public:BlzFrameSetVertexColor(color)
    BlzFrameSetVertexColor(self:getHandleData(), color)
end

---@param level number
function public:BlzFrameSetLevel(level)
    BlzFrameSetLevel(self:getHandleData(), level)
end

---@param parent Frame
function public:BlzFrameSetParent(parent)
    BlzFrameSetParent(self:getHandleData(), parent:getHandleData())
end

---@return Frame
function public:BlzFrameGetParent()
    return Handle.getLinked(BlzFrameGetParent(self:getHandleData()))
end

---@return number
function public:BlzFrameGetHeight()
    return BlzFrameGetHeight(self:getHandleData())
end

---@return number
function public:BlzFrameGetWidth()
    return BlzFrameGetWidth(self:getHandleData())
end

---@param fileName string
---@param height number
---@param flags integer
function public:BlzFrameSetFont(fileName, height, flags)
    BlzFrameSetFont(self:getHandleData(), fileName, height, flags)
end

---@param vert textaligntype
---@param horz textaligntype
function public:BlzFrameSetTextAlignment(vert, horz)
    BlzFrameSetTextAlignment(self:getHandleData(), vert, horz)
end

---@return boolean
function public:isSimpleframe()
    return private.data[self].is_simpleframe
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Frame
---@param is_simpleframe boolean
function private.newData(self, is_simpleframe)
    local priv = {
        is_simpleframe = is_simpleframe
    }
    private.data[self] = priv
end

return static