--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')
---@type TriggerClass
local Trigger = require(lib_path..'Types.Trigger') or error('')
---@type UnitClass
local Unit = require(lib_path..'Types.Unit') or error('')

--=======
-- Class
--=======

local Ability = Class.new('Ability', Handle)
---@class Ability : Handle
local public = Ability.public
---@class AbilityClass : HandleClass
local static = Ability.static
---@type AbilityClass
local override = Ability.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param abil_id number
---@param child Ability | nil
---@return Ability
function override.new(owner, abil_id, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(abil_id, 'number', 'abil_id')
    if child then isTypeErr(child, Ability, 'child') end

    local handle = BlzGetUnitAbility(owner:getData(), abil_id)
    if handle ~= nil then
        Log:err('Can not add second ability with the same ID to Unit.', 2)
    end

    local instance = child or Class.allocate(Ability)
    UnitAddAbility(owner:getData(), abil_id)
    handle = BlzGetUnitAbility(owner:getData(), abil_id)
    if handle == nil then
        Log:err('Can not create handle for Ability.', 2)
    end

    instance = Handle.new(handle, private.destroyAbilityHandle, instance)

    private.newData(instance, owner, abil_id)

    return instance
end

--========
-- Public
--========

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@return number
function public:getId()
    return private.data[self].abil_id
end

---@param tooltip string
---@param lvl number
function public:setTooltipNormal(tooltip, lvl)
    BlzSetAbilityStringLevelField(self:getData(), ABILITY_SLF_TOOLTIP_NORMAL, lvl - 1, tooltip)
end

---@param tooltip string
---@param lvl number
function public:setTooltipNormalExtended(tooltip, lvl)
    BlzSetAbilityStringLevelField(self:getData(), ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, lvl - 1, tooltip)
end

---@param range number
function public:setRange(range)
    BlzSetAbilityRealLevelField(self:getData(), ABILITY_RLF_CAST_RANGE, 0, range)
end

---@alias AbilityCallback fun(abil:Ability, event:string)

---@param event string | "'CHANNEL'" | "'CAST'" | "'EFFECT'" | "'FINISH'" | "'ENDCAST'"
---@param callback AbilityCallback
---@return Action
function public:addAction(event, callback)
    local priv = private.data[self]

    local actions = priv.actions[event]
    if not actions then
        Log:Wnr(tostring(self)..': wrong event name. Got: '..event)
        return
    end

    return actions:add(callback)
end

---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for _, actions in pairs(priv.actions) do
        if actions:remove(action) then
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Ability
---@param owner Unit
---@param abil_id number
function private.newData(self, owner, abil_id)
    local priv = {
        owner = owner,
        abil_id = abil_id,

        actions = {
            CHANNEL = ActionList.new(),
            CAST = ActionList.new(),
            EFFECT = ActionList.new(),
            FINISH = ActionList.new(),
            ENDCAST = ActionList.new(),
        }
    }
    private.data[self] = priv
end

---@param handle ability
function private.destroyAbilityHandle(handle)
    local abil = static.getLinked(handle)
    local owner = abil:getOwner()
    local abil_id = abil:getId()
    UnitRemoveAbility(owner:getData(), abil_id)
end

function private.onChannel()
    ---@type Ability
    local self = static.getLinked(GetSpellAbility())

    if self then
        private.data[self].actions.CHANNEL:run(self, 'CHANNEL')
    end
end

function private.onCast()
    ---@type Ability
    local self = static.getLinked(GetSpellAbility())

    if self then
        private.data[self].actions.CAST:run(self, 'CAST')
    end
end

function private.onEffect()
    ---@type Ability
    local self = static.getLinked(GetSpellAbility())

    if self then
        private.data[self].actions.EFFECT:run(self, 'EFFECT')
    end
end

function private.onFinish()
    ---@type Ability
    local self = static.getLinked(GetSpellAbility())

    if self then
        private.data[self].actions.FINISH:run(self, 'FINISH')
    end
end

function private.onEnd()
    ---@type Ability
    local self = static.getLinked(GetSpellAbility())

    if self then
        private.data[self].actions.ENDCAST:run(self, 'ENDCAST')
    end
end

if not IsCompiletime() then
    private.channel_trigger = Trigger.new()
    private.cast_trigger = Trigger.new()
    private.effect_trigger = Trigger.new()
    private.finish_trigger = Trigger.new()
    private.end_trigger = Trigger.new()

    for i = 0, bj_MAX_PLAYER_SLOTS do
        private.channel_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_CHANNEL, Player(i))
        private.cast_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_CAST, Player(i))
        private.effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, Player(i))
        private.finish_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_FINISH, Player(i))
        private.end_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_ENDCAST, Player(i))
    end

    private.channel_trigger:addAction(private.onChannel)
    private.cast_trigger:addAction(private.onCast)
    private.effect_trigger:addAction(private.onEffect)
    private.finish_trigger:addAction(private.onFinish)
    private.end_trigger:addAction(private.onEnd)
end

return static