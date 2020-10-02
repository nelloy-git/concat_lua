--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local TimedObj = HandleLib.TimedObj or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type BuffTypeClass
local BuffType = require(lib_path..'Type') or error('')

--=======
-- Class
--=======

local Buff = Class.new('Buff', TimedObj)
---@class Buff : TimedObj
local public = Buff.public
---@class BuffClass : TimedObjClass
local static = Buff.static
---@type BuffClass
local override = Buff.override
local private = {}

--=========
-- Static
--=========

---@param source Unit
---@param target Unit
---@param buff_type BuffType
---@param user_data any
---@param child Buff | nil
---@return Buff
function override.new(source, target, buff_type, user_data, child)
    isTypeErr(source, Unit, 'source')
    isTypeErr(target, Unit, 'target')
    isTypeErr(buff_type, BuffType, 'buff_type')
    if child then isTypeErr(child, Buff, 'child') end

    local instance = child or Class.allocate(Buff)
    instance = TimedObj.new(instance)

    private.newData(instance, source, target, buff_type, user_data)

    return instance
end

--========
-- Public
--========

---@return Unit
function public:getSource()
    return private.data[self].source
end

---@return Unit
function public:getTarget()
    return private.data[self].target
end

---@return BuffType
function public:getType()
    return private.data[self].buff_type
end

---@return any
function public:getUserData()
    return private.data[self].user_data
end

---@return string
function public:getName()
    return private.data[self].buff_type:getName(self)
end

---@return string
function public:getIcon()
    return private.data[self].buff_type:getIcon(self)
end

---@return string
function public:getTooltip()
    return private.data[self].buff_type:getTooltip(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Buff
---@param source Unit
---@param target Unit
---@param buff_type BuffType
---@param user_data any
function private.newData(self, source, target, buff_type, user_data)
    local priv = {
        source = source,
        target = target,
        buff_type = buff_type,
        user_data = user_data,
    }
    private.data[self] = priv

    self:addStartAction(private.start)
    self:addLoopAction(private.loop)
    self:addCancelAction(private.cancel)
    self:addFinishAction(private.finish)
end

---@self Buff
function private.start(self)
    private.data[self].buff_type:onStart(self)
end

---@self Buff
function private.loop(self)
    private.data[self].buff_type:onLoop(self)
end

---@self Buff
function private.cancel(self)
    private.data[self].buff_type:onCancel(self)
end

---@self Buff
function private.finish(self)
    private.data[self].buff_type:onFinish(self)
end

return static