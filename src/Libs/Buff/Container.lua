--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_depss
---@type UtilsLib
local UtilsLib = lib_deplsLib
local isTypeErr = UtilsLib.isTypeErr
local Unit = UtilsLib.Handle.Unit

---@type BuffClass
local Buff = require(lib_path..'.Buff')

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
    if child then
        isTypeErr(child, BuffsContainer, 'child')
    end

    local instance = child or Class.allocate(BuffsContainer)
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
    local new_list = {}
    for i = 1, #priv.list do
        if priv.list[i]:getDurationLeft() > 0 then
            table.insert(copy, priv.list[i])
            table.insert(new_list, priv.list[i])
        end
    end
    priv.list = new_list
    return copy
end

---@param buff_type BuffType
---@return table
function public:getByType(buff_type)
    local priv = private.data[self]
    local copy = {}
    local new_list = {}
    for i = 1, #priv.list do
        if priv.list[i]:getDurationLeft() > 0 then
            table.insert(new_list, priv.list[i])
            if priv.list[i]:getType() == buff_type then
                table.insert(copy, priv.list[i])
            end
        end
    end
    priv.list = new_list
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