--=========
-- Include
--=========


local Class = require('Utils.Class.API')

--=======
-- Class
--=======

local UnitAnimation = Class.new('UnitAnimation')
---@class UnitAnimation
local public = UnitAnimation.public
---@class UnitAnimationClass
local static = UnitAnimation.static
---@type UnitAnimationClass
local override = UnitAnimation.override
local private = {}

--=========
-- Static
--=========

---@alias AnimationTypeEnum number

---@type table<string, AnimationTypeEnum>
static.AnimationType = {}
---@type AnimationTypeEnum
static.AnimationType.STAND = 1
---@type AnimationTypeEnum
static.AnimationType.WALK = 2
---@type AnimationTypeEnum
static.AnimationType.ATTACK = 3
---@type AnimationTypeEnum
static.AnimationType.CAST = 4

---@param unit unit
---@return UnitAnimation
function override.new(unit)
    local instance = Class.allocate(UnitAnimation)
    private.newData(instance, unit)

    return instance
end

--========
-- Public
--========

---@param anim_type AnimationTypeEnum
---@param id number
function public:add(anim_type, id)
    if not private.isAnimType(anim_type) then
        Log.error(self, 'unknow AnimationTypeEnum.', 2)
    end

    local priv = private.data[self]
    table.insert(priv.animation[anim_type], id)
end

---@param anim_type AnimationTypeEnum
function public:play(anim_type)
    if not private.isAnimType(anim_type) then
        Log.error(self, 'unknow AnimationTypeEnum.', 2)
    end

    local priv = private.data[self]
    if #priv.animation[anim_type] == 0 then
        return
    end

    if anim_type ~= priv.cur then
        local pos = math.random(1, #priv.animation[anim_type])
        SetUnitAnimationByIndex(priv.unit, priv.animation[anim_type][pos])
        priv.cur = anim_type
    end
end

---@param factor number
function public:setSpeedFactor(factor)
    SetUnitTimeScale(private.data[self].unit, factor)
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param val any
---@return boolean
function private.isAnimType(val)
    for _, anim_type in pairs(static.AnimationType) do
        if val == anim_type then
            return true
        end
    end
    return false
end

---@param self UnitAnimation
function private.newData(self, unit)
    local priv = {
        unit = unit,

        cur = static.AnimationType.STAND,
        animation = {}
    }
    private.data[self] = priv

    for _, anim_type in pairs(static.AnimationType) do
        priv.animation[anim_type] = {}
    end
end

return static