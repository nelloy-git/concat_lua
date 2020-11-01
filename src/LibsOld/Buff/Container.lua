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
local Log = UtilsLib.Log or error('')

---@type BuffClass
local Buff = require(lib_path..'.Buff') or error('')

--=======
-- Class
--=======

local BuffContainer = Class.new('BuffContainer')
---@class BuffContainer
local public = BuffContainer.public
---@class BuffContainerClass
local static = BuffContainer.static
---@type BuffContainerClass
local override = BuffContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child BuffContainer | nil
---@return BuffContainer
function static.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, BuffContainer, 'child') end

    local instance = child or Class.allocate(BuffContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owner2container[owner]
end

--========
-- Public
--========

---@param buff_type Buff
---@param source Unit
---@param time number
---@param user_data any
---@return boolean
function public:add(buff_type, source, time, user_data)
    local priv = private.data[self]

    local buff = Buff.new(source, priv.owner, buff_type, user_data)

    buff:addCancelAction(private.removeBuff)
    buff:addFinishAction(private.removeBuff)
    buff:start(time)
    table.insert(priv.list, #priv.list + 1, buff)
    private.buffs2container[buff] = self

    priv.changed_actions:run(self)
end

---@return number
function public:count()
    return #private.data[self].list
end

---@param i number
---@return Buff | nil
function public:get(i)
    return private.data[self].list[i]
end

---@return table
function public:getAll()
    local priv = private.data[self]

    local copy = {}
    for i = 1, #priv.list do
        table.insert(copy, i, priv.list[i])
    end
    return copy
end

---@alias BuffContainerCallback fun(container:BuffContainer)

---@param callback BuffContainerCallback
---@return Action
function public:addChangedAction(callback)
    return private.data[self].changed_actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    return private.data[self].changed_actions:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owner2container = setmetatable({}, {__mode = 'k'})
private.buffs2container = setmetatable({}, {__mode = 'k'})

---@param self BuffContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        list = {},

        changed_actions = ActionList.new(self)
    }
    private.data[self] = priv
    private.owner2container[owner] = self
end

function private.removeBuff(buff)
    ---@type BuffContainer
    local self = private.buffs2container[buff]
    local priv = private.data[self]

    for i = 1, #priv.list do
        if priv.list[i] == buff then
            table.remove(priv.list, i)
            priv.changed_actions:run(self)
            return
        end
    end
    Log:err('Removing buff is not found')
end

return static