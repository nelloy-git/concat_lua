--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
---@type ObjectLib
local ObjectLib = depencies.Object
local SimpleTimer = ObjectLib.SimpleTimer

---@type AbilityTypeClass
local AbilityType = require(lib_modname..'.Type')

--=======
-- Class
--=======

local Ability = Class.new('Ability')
---@class Ability
local public = Ability.public
---@class AbilityClass
local static = Ability.static
---@type AbilityClass
local override = Ability.override
local private = {}

---@class AbilityCastingFlags
---@field already_casting boolean
---@field no_charges boolean
---@field no_mana boolean
---@field out_of_range boolean
---@field started boolean

--=========
-- Static
--=========

---@param owner unit
---@param ability_type AbilityType
---@param lvl number
---@param child_instance Ability | nil
---@return Ability
function override.new(owner, ability_type, lvl, child_instance)
    checkType(owner, 'unit', 'owner')
    checkType(ability_type, AbilityType, 'ability_type')
    checkType(lvl, 'number', 'lvl')
    if child_instance then
        checkType(child_instance, Ability, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type, lvl)

    return instance
end

--========
-- Public
--========

---@param lvl number
function public:setLevel(lvl)
    private.data[self].lvl = lvl
end

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@return unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityType
function public:getType()
    return private.data[self].ability_type
end

---@param target AbilityTarget
---@return AbilityCastingFlags
function public:use(target)
    local priv = private.data[self]

    ---@type unit
    local caster = priv.owner
    ---@type AbilityType
    local abil_type = priv.ability_type
    ---@type number
    local lvl = priv.lvl

    local charges_cost = abil_type:getChargesCost(caster, lvl)
    local mana_cost = abil_type:getManaCost(caster, lvl)
    ---@type AbilityCastingFlags
    local flags = {
        already_casting = private.casting_list[self] ~= nil,
        no_charges = charges_cost > priv.charges,
        no_mana = mana_cost > GetUnitState(caster, UNIT_STATE_MANA),
        out_of_range = abil_type:getRange(caster, lvl) < target:getDistance(caster),
        started = false,
    }

    if not flags.already_casting and
       not flags.no_charges and
       not flags.no_mana and
       not flags.out_of_range then
        flags.started = abil_type:start(caster, target, lvl)
        if flags.started then
            private.casting_list[self] = priv

            priv.charges = priv.charges - charges_cost
            SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - mana_cost)
        end
    end

    return flags
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.casting_list = setmetatable({}, {__mode = 'kv'})
private.cooldown_list = setmetatable({}, {__mode = 'kv'})

---@param self Ability
---@param owner unit
---@param lvl number
---@param ability_type AbilityType
function private.newData(self, owner, ability_type, lvl)
    local priv = {
        owner = owner,
        ability_type = ability_type,
        lvl = lvl,

        cur_target = nil,
        casting_end_time = 0,

        charges = 0,
    }
    private.data[self] = priv
end

private.casting_current_time = 0
function private.castingLoop()
    local cur_time = private.casting_current_time + 0.05
    private.casting_current_time = cur_time

    for abil, priv in pairs(private.casting_list) do
        ---@type AbilityType
        local abil_type = priv.ability_type
        if priv.casting_end_time <= cur_time then
            abil_type:finish(priv.owner, priv.cur_target, priv.lvl)
            private.casting_list[abil] = nil
        else
            abil_type:casting(priv.owner, priv.cur_target, priv.lvl)
        end
    end
end

private.cooldown_current_time = 0
function private.cooldownLoop()
    for abil, priv in pairs(private.casting_list) do
    end
end

if not IsCompiletime() then
    private.cooldown_timer = SimpleTimer.new()
    private.cooldown_timer:start(0.05, true, private.cooldownLoop)

    private.casting_timer = SimpleTimer.new()
    private.casting_timer:start(0.05, true, private.castingLoop)
end

return static