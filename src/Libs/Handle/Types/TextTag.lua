--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

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

---@param child TextTag | nil
---@return TextTag
function override.new(child)
    if child then
        isTypeErr(child, TextTag, 'child')
    end

    local instance = child or Class.allocate(TextTag)
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
    SetTextTagText(text_tag, text, 0.0023 * size)
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
    SetTextTagText(text_tag, text, 0.0023 * size)
    SetTextTagColor(text_tag, red, green, blue, alpha)
    SetTextTagPosUnit(text_tag, target:getData(), z)
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
    SetTextTagText(self:getData(), text, 0.0023 * size)
end

---@param red number
---@param green number
---@param blue number
---@param alpha number
function public:setColor(red, green, blue, alpha)
    SetTextTagColor(self:getData(), red, green, blue, alpha)
end

---@param x number
---@param y number
---@param z number
---@overload fun(self:TextTag, target:Unit, z:number)
function public:setPos(x, y, z)
    if type(x) == 'number' and type(y) == 'number' and type(z) == 'number' then
        SetTextTagPos(self:getData(), x, y, z)
        return
    end

    -- Overload
    local target = x
    z = y
    SetTextTagPosUnit(self:getData(), target:getData(), z)
end

---@param x_vel number
---@param y_vel number
function public:setVelocity(x_vel, y_vel)
    SetTextTagVelocity(self:getData(), x_vel, y_vel)
end

---@param flag boolean
function public:setVisible(flag)
    SetTextTagVisibility(self:getData(), flag)
end

---@param flag boolean
function public:setSuspended(flag)
    SetTextTagSuspended(self:getData(), flag)
end

---@param flag boolean
function public:setPermanent(flag)
    SetTextTagPermanent(self:getData(), flag)
end

---@param age number
function public:setAge(age)
    SetTextTagAge(self:getData(), age)
end

---@param lifespan number
function public:setLifespan(lifespan)
    SetTextTagLifespan(self:getData(), lifespan)
end

---@param fadepoint number
function public:setFadepoint(fadepoint)
    SetTextTagFadepoint(self:getData(), fadepoint)
end

--=========
-- Private
--=========


return static