--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtClass
local AbilityExt = require(lib_path..'Ability')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local Event = AbilityExtEventModule.Enum or error('')
---@type AbilityExtTypeClass
local AbilityExtType = require(lib_path..'Type')

--=======
-- Class
--=======

local AbilityExtContainer = Class.new('AbilityExtContainer')
---@class AbilityExtContainer
local public = AbilityExtContainer.public
---@class AbilityExtContainerClass
local static = AbilityExtContainer.static
---@type AbilityExtContainerClass
local override = AbilityExtContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child AbilityExtContainer | nil
---@return AbilityExtContainer
function override.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, AbilityExtContainer, 'child') end

    local instance = child or Class.allocate(AbilityExtContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owners[owner]
end

--========
-- Public
--========

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param abil_type AbilityExtType | nil
function public:set(hotkey, abil_type)
    isTypeErr(hotkey, 'string', 'hotkey')
    if abil_type then isTypeErr(abil_type, AbilityExtType, 'abil_type') end

    local priv = private.data[self]

    local prev = priv.abil_data_list[hotkey]
    if prev then
        private.abil2container[prev] = nil
        prev:destroy()
    end

    local abil = nil
    if abil_type then
        abil = AbilityExt.new(priv.owner, abil_type, hotkey)
        for _, event in pairs(Event) do
            abil:addAction(event, private.runAbilityAction)
        end
        private.abil2container[abil] = self
    end
    priv.abil_data_list[hotkey] = abil
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return AbilityExt | nil
function public:get(hotkey)
    return private.data[self].abil_data_list[hotkey]
end

---@alias AbilityExtContainerCallback fun(container:AbilityExtContainer, abil:AbilityExt, event:AbilityExtEvent)

---@param event AbilityExtEvent
---@param callback AbilityExtContainerCallback
---@return Action
function public:addAction(event, callback)
    local priv = private.data[self]
    return priv.actions[event]:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for _, event in pairs(priv.actions) do
        if priv.actions[event]:remove(action) then
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})
private.abil2container = setmetatable({}, {__mode = 'kv'})

---@param self AbilityExtContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        abil_data_list = {},

        actions = {}
    }
    private.data[self] = priv
    private.owners[owner] = self

    for _, event in pairs(Event) do
        priv.actions[event] = ActionList.new(self)
    end
end

---@param abil AbilityExt
---@param event AbilityExtEvent
function private.runAbilityAction(abil, event)
    ---@type AbilityExtContainer
    local self = private.abil2container[abil]
    private.data[self].actions[event]:run(self, abil, event)
end

return static