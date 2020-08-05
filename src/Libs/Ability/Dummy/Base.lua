--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Ability = UtilsLib.Handle.Ability
local AbilityPublic = Class.getPublic(Ability)
local Action = UtilsLib.Action
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit
local Timer = UtilsLib.Handle.Timer
local Trigger = UtilsLib.Handle.Trigger

---@type AbilityDummyPool
local AbilityDummyPool = require(lib_modname..'.Dummy.Pool')
--endregion

--=======
-- Class
--=======

local AbilityDummy = Class.new('AbilityDummy', Ability)
---@class AbilityDummy : Ability
local public = AbilityDummy.public
---@class AbilityDummyClass : AbilityClass
local static = AbilityDummy.static
---@type AbilityDummyClass
local override = AbilityDummy.override
local private = {}

--=========
-- Static
--=========

---@alias AbilityDummyCallback fun(abil_dummy:AbilityDummy)

---@param owner Unit
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param child_instance AbilityDummy | nil
---@return AbilityDummy
function override.new(owner, hotkey, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(hotkey, 'string', 'hotkey')
    if child_instance then checkTypeErr(child_instance, AbilityDummy, 'child_instance') end

    local abil_dummy_type = AbilityDummyPool.pop(hotkey)
    local instance = child_instance or Class.allocate(AbilityDummy)
    instance = Ability.new(owner:getHandleData(), abil_dummy_type:getId(), instance)
    private.newData(instance, owner, abil_dummy_type, hotkey)

    return instance
end

--========
-- Public
--========

--- Override
---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
function public:setTargetingType(target_type)
    local value = nil
    value = target_type == 'None' and 0 or value
    value = target_type == 'Unit' and 1 or value
    value = target_type == 'Point' and 2 or value
    value = target_type == 'PointOrUnit' and 3 or value
    if value == nil then
        Log:err('Unavailable target type.', 2)
    end
    BlzSetAbilityIntegerLevelField(self:getHandleData(), ABILITY_ILF_TARGET_TYPE, 0, value)
end

---@param area number
function public:setArea(area)
    BlzSetAbilityRealLevelField(self:getHandleData(), ABILITY_RLF_AREA_OF_EFFECT, 0, area)
end

---@param range number
function public:setRange(range)
    -- TODO
end

---@param targets string
function public:setTargetsAllowed(targets)
    -- TODO
end

function public:setOptions(options)
    -- TODO
end

---@param name string
function public:setName(name)
    BlzSetAbilityTooltip(private.data[self].abil_dummy_type:getId(), name, 0)
end

---@param tooltip string
function public:setTooltip(tooltip)
    BlzSetAbilityExtendedTooltip(private.data[self].abil_dummy_type:getId(), tooltip, 0)
end

---@param icon string
function public:setIcon(icon)
    BlzSetAbilityIcon(private.data[self].abil_dummy_type:getId(), icon)
end

---@param mana_cost number
function public:setManaCost(mana_cost)
    BlzSetUnitAbilityManaCost(self:getOwner():getHandleData(), self:getId(), 0, mana_cost)
end

---@param cooldown number
function public:setCooldownRemaining(cooldown)
    -- Can not be charged after some events, so Timer is used.
    local timer = Timer.new()
    timer:start(0, false, function()
        if cooldown > 0 then
            BlzStartUnitAbilityCooldown(self:getOwner():getHandleData(), self:getId(), cooldown)
        else
            BlzEndUnitAbilityCooldown(self:getOwner():getHandleData(), self:getId())
        end
    end)
end

---@return number
function public:getCooldownRemaining()
    return BlzGetUnitAbilityCooldownRemaining(self:getOwner():getHandleData(), self:getId())
end

---@param cooldown number
function public:setCooldown(cooldown)
    --BlzSetAbilityRealLevelField(self:getHandleData(), ABILITY_RLF_COOLDOWN, 0, cooldown)
    BlzSetUnitAbilityCooldown(self:getOwner():getHandleData(), self:getId(), 0, cooldown)
end

function public:destroy()
    local priv = private.data[self]
    AbilityDummyPool.push(priv.hotkey, priv.abil_dummy_type)
    AbilityPublic.destroy()
end

--===========
-- Callbacks
--===========

---@param callback AbilityDummyCallback | Action
function public:setEffectAction(callback)
    if type(callback) == 'function' then
        private.data[self].effect_action = Action.new(callback, self)
    elseif Class.type(callback, Action) then
        local action = callback
        private.data[self].effect_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityDummyCallback | Action', 2)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityDummy
---@param owner Unit
function private.newData(self, owner, abil_dummy_type, hotkey)
    local priv = {
        owner = owner,
        abil_dummy_type = abil_dummy_type,
        hotkey = hotkey,

        effect_action = nil
    }

    private.data[self] = priv
end

function private.onEffect()
    ---@type AbilityDummy
    local self = static.getLinked(GetSpellAbility())
    local priv = private.data[self]
    if priv.effect_action then priv.effect_action:run(self) end
end

if not IsCompiletime() then
    local trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, Player(i))
    end
    trigger:addAction(private.onEffect)
end

return static