--=========
-- Include
--=========

--region Include
local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Log = UtilsLib.DefaultLogger
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Handle = UtilsLib.Handle.Base
local Unit = UtilsLib.Handle.Unit
local Trigger = UtilsLib.Handle.Trigger

---@type AbilityDataClass
local AbilityData = require(lib_modename..'.Ability')
---@type AbilityDataTypeClass
local AbilityDataType = require(lib_modename..'.Type')
---@type AbilitiesContainerClass
local Container = require(lib_modename..'.Container')
local ContainerPublic = Class.getPublic(Container)
---@type DummyAbility
local DummyAbility = require(lib_modename..'.Dummy.Ability')

---@type AbilityTargetNoneClass
local TargetNone = require(lib_modename..'.Target.None')
---@type AbilityTargetPointClass
local TargetPoint = require(lib_modename..'.Target.Point')
---@type AbilityTargetUnitClass
local TargetUnit = require(lib_modename..'.Target.Unit')

--endregion

--=======
-- Class
--=======

local DummyAbilitiesContainer = Class.new('DummyAbilitiesContainer', Container)
---@class DummyAbilitiesContainer
local public = DummyAbilitiesContainer.public
---@class DummyAbilitiesContainerClass
local static = DummyAbilitiesContainer.static
---@type DummyAbilitiesContainerClass
local override = DummyAbilitiesContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance DummyAbilitiesContainer | nil
---@return DummyAbilitiesContainer
function override.new(owner, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    if child_instance then checkTypeErr(child_instance, DummyAbilitiesContainer, 'child_instance') end

    local instance = child_instance or Class.allocate(DummyAbilitiesContainer)
    instance = Container.new(owner, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param abil_type AbilityDataType | nil
---@return AbilityData | nil
function public:set(hotkey, abil_type)
    checkTypeErr(hotkey, 'string', 'hotkey')
    if abil_type then checkTypeErr(abil_type, AbilityDataType, 'abil_type') end
    local pos = private.poses[hotkey]
    if pos == nil then Log:err('Wrong hotkey.', 2) end

    local prev_abil_data = ContainerPublic.set(self, pos, abil_type)
    local abil_data = ContainerPublic.get(self, pos)

    local priv = private.data[self]
    local prev_abil_dummy = priv.abil_dummy[hotkey]
    if prev_abil_dummy then prev_abil_dummy:destroy() end
    priv.abil_dummy[hotkey] = DummyAbility.new(self:getOwner(), hotkey)
    private.id_links[priv.abil_dummy[hotkey]:getId()] = abil_data

    self:updateDummy(hotkey)

    return prev_abil_data
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return AbilityData | nil
function public:getDummy(hotkey)
    return private.data[self].abil_dummy[hotkey]
end

function public:updateDummy(hotkey)
    local priv = private.data[self]
    ---@type DummyAbility
    local abil_dummy = priv.abil_dummy[hotkey]
    ---@type AbilityData
    local abil_data = ContainerPublic.get(self, private.poses[hotkey])
    local abil_type = abil_data:getType()

    abil_dummy:setName(abil_type:getName(abil_data))
    abil_dummy:setTooltip(abil_type:getTooltip(abil_data))
    abil_dummy:setIcon(abil_type:getIcon(abil_data))
    abil_dummy:setManaCost(abil_type:getManaCost(abil_data))
    abil_dummy:setTargetType(abil_type:getTargetType())
    -- Set range, available targets
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.id_links = setmetatable({}, {__mode = 'v'})

private.hotkeys = {
    'Q', 'W', 'E', 'R', 'T', 'D', 'F'
}

private.poses = {}
for pos, hotkey in pairs(private.hotkeys) do
    private.poses[hotkey] = pos
end

---@param self DummyAbilitiesContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        abil_dummy = {}
    }

    private.data[self] = priv
end

function private.onDummyUse()
    local id = GetSpellAbilityId()
    ---@type AbilityData
    local abil_data = private.id_links[id]
    if not abil_data then return end

    local abil_type = abil_data:getType()
    local target_type = abil_type:getTargetType()

    local target
    if target_type == 'None' then
        target = TargetNone.new()
    elseif target_type == 'Unit' then
        target = TargetUnit.new(Handle.getLinked(GetSpellTargetUnit()))
    elseif target_type == 'PointOrUnit' then
        target = TargetUnit.new(Handle.getLinked(GetSpellTargetUnit()))
        if not target then target = TargetPoint.new(GetSpellTargetX(), GetSpellTargetY()) end
    elseif target_type == 'Point' then
        target = TargetPoint.new(GetSpellTargetX(), GetSpellTargetY())
    end

    abil_data:use(target)
end

if not IsCompiletime() then
    local trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYERS do
        trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, Player(i))
    end
    trigger:addAction(private.onDummyUse)
end

return static