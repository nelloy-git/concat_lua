--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Unit = UtilsLib.Handle.Unit

---@type BuffClass
local Buff = require(lib_modname..'.Buff')
--endregion

--=======
-- Class
--=======

local BuffsContainer = Class.new('BuffsContainer')
---@class BuffsContainer
local public = BuffsContainer.public
---@class BuffsContainerClass
local static = BuffsContainer.static
---@type BuffsContainerClass
local override = BuffsContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance BuffsContainer | nil
---@return BuffsContainer
function static.new(owner, child_instance)
    checkType(owner, Unit, 'owner')
    if child_instance then
        checkType(child_instance, BuffsContainer, 'child_instance')
    end

    local instance = child_instance or Class.allocate(BuffsContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owners[owner]
end

--========
-- Public
--========

---@param buff_type Buff
---@param source Unit
---@return boolean
function public:addBuff(buff_type, source)
    local priv = private.data[self]

    local buff = Buff.new(source, priv.owner, buff_type)
    table.insert(priv.list, buff)
end

---@return table
function public:getAll()
    local priv = private.data[self]
    local copy = {}
    for i = 1, #priv.list do
        if priv.list[i]:getDurationLeft() > 0 then
            table.insert(copy, priv.list[i])
        end
    end
    return copy
end

---@param buff_type BuffType
---@return table
function public:getByType(buff_type)
    local priv = private.data[self]
    local copy = {}
    for i = 1, #priv.list do
        if priv.list[i]:getType() == buff_type then
            table.insert(copy, priv.list[i])
        end
    end
    return copy
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

---@param self BuffsContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        list = {}
    }
    private.data[self] = priv
    private.owners[owner] = self
end

return static