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
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type BuffClass
local Buff = require(lib_path..'.Buff') or error('')

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
---@param child BuffsContainer | nil
---@return BuffsContainer
function static.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, BuffsContainer, 'child') end

    local instance = child or Class.allocate(BuffsContainer)
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

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owner2container = setmetatable({}, {__mode = 'k'})
private.buffs2container = setmetatable({}, {__mode = 'k'})

---@param self BuffsContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        list = {}
    }
    private.data[self] = priv
    private.owner2container[owner] = self
end

function private.removeBuff(buff)
    ---@type BuffsContainer
    local self = private.buffs2container[buff]
    local priv = private.data[self]

    for i = 1, #priv.list do
        if priv.list[i] == buff then
            table.remove(priv.list, i)
            return
        end
    end
    Log:err('Removing buff is not found')
end

return static