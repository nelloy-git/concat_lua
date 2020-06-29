--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType
---@type UnitClass
local Unit = require(lib_modname..'.Handle.Unit')

--=======
-- Class
--=======

local TextTag = Class.new('TextTag', Handle)
---@class TextTag : Handle
local public = TextTag.public
---@class TextTagClass : HandleClass
local static = TextTag.static
---@type TextTagClass
local override = TextTag.override
local private = {}

--=========
-- Static
--=========

---@param child_instance TextTag | nil
---@return TextTag
function override.new(child_instance)
    if child_instance then
        checkType(child_instance, TextTag, 'child_instance')
    end

    local instance = child_instance or Class.allocate(TextTag)
    instance = Handle.new(CreateTextTag(), DestroyTextTag, instance)

    return instance
end

---@param text string
---@param size number
---@param red number
---@param green number
---@param blue number
---@param alpha number
---@param x number
---@param y number
---@param z number
---@param x_vel number
---@param y_vel number
---@param time number
function override.newTimed(text, size,
                           red, green, blue, alpha,
                           x, y, z,
                           x_vel, y_vel,
                           time)
    local text_tag = CreateTextTag()
    SetTextTagText(text_tag, text, size)
    SetTextTagColor(text_tag, red, green, blue, alpha)
    SetTextTagPos(text_tag, x, y, z)
    SetTextTagVelocity(text_tag, x_vel, y_vel)
    SetTextTagPermanent(text_tag, false)
    SetTextTagLifespan(text_tag, time)
    SetTextTagFadepoint(text_tag, 0)
end

---@param text string
---@param size number
---@param red number
---@param green number
---@param blue number
---@param alpha number
---@param target Unit
---@param z number
---@param x_vel number
---@param y_vel number
---@param time number
function override.newTimedForUnit(text, size,
                                   red, green, blue, alpha,
                                   target, z,
                                   x_vel, y_vel,
                                   time)

    local text_tag = CreateTextTag()
    SetTextTagText(text_tag, text, size)
    SetTextTagColor(text_tag, red, green, blue, alpha)
    SetTextTagPosUnit(text_tag, target:getHandleData(), z)
    SetTextTagVelocity(text_tag, x_vel, y_vel)
    SetTextTagPermanent(text_tag, false)
    SetTextTagLifespan(text_tag, time)
    SetTextTagFadepoint(text_tag, 0)
end

--========
-- Public
--========

---@param text string
---@param size number
function public:setText(text, size)
    SetTextTagText(self:getHandleData(), text, size)
end

---@param red number
---@param green number
---@param blue number
---@param alpha number
function public:setColor(red, green, blue, alpha)
    SetTextTagColor(self:getHandleData(), red, green, blue, alpha)
end

---@param x number
---@param y number
---@param z number
---@overload fun(self:TextTag, target:Unit, z:number)
function public:setPos(x, y, z)
    if type(x) == 'number' and type(y) == 'number' and type(z) == 'number' then
        SetTextTagPos(self:getHandleData(), x, y, z)
        return
    end

    -- Overload
    local target = x
    z = y
    SetTextTagPosUnit(self:getHandleData(), target:getHandleData(), z)
end

---@param x_vel number
---@param y_vel number
function public:setVelocity(x_vel, y_vel)
    SetTextTagVelocity(self:getHandleData(), x_vel, y_vel)
end

---@param flag boolean
function public:setVisible(flag)
    SetTextTagVisibility(self:getHandleData(), flag)
end

---@param flag boolean
function public:setSuspended(flag)
    SetTextTagSuspended(self:getHandleData(), flag)
end

---@param flag boolean
function public:setPermanent(flag)
    SetTextTagPermanent(self:getHandleData(), flag)
end

---@param age number
function public:setAge(age)
    SetTextTagAge(self:getHandleData(), age)
end

---@param lifespan number
function public:setLifespan(lifespan)
    SetTextTagLifespan(self:getHandleData(), lifespan)
end

---@param fadepoint number
function public:setFadepoint(fadepoint)
    SetTextTagFadepoint(self:getHandleData(), fadepoint)
end

--=========
-- Private
--=========


return static