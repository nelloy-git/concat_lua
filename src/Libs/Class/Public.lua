local modname = Lib.current().modname

local ClassStatic = require(modname..'.Static')
local ClassUtils = require(modname..'.Utils')
local ClassParent = require(modname..'.Parent')

---@class ClassPublic
local ClassPublic = {}

local rawset = rawset
local deepcopy = ClassUtils.deepcopy

local class2public = {}
local public2class = {}

local NIL = '__RESERVED__'

local public_meta = {
    __newindex = function(self, key, value)
        if value == nil then
            value = NIL
        end
        rawset(self, key, value)
    end,

    __tostring = function(self)
        return tostring(public2class[self])
    end,

    __pairs = function(self)
        local class = public2class[self]
        local parents = ClassParent.getList(class)

        local k, v
        local cur_pos = 0
        local cur_table = self
        local list = {}
        local function getKeyValue()
            k, v = next(cur_table, k)
            if k ~= nil then
                if list[k] ~= nil then
                    getKeyValue()
                end

                if k ~= nil then
                    list[k] = v
                end

                return k, v
            else
                cur_pos = cur_pos + 1
                if cur_pos > #parents then
                    return
                end

                cur_table = class2public[parents[cur_pos]]
                return getKeyValue()
            end
        end

        return getKeyValue
    end
}

---@param class table
---@return table
function ClassPublic.register(class)
    local public = {}
    setmetatable(public, public_meta)

    class2public[class] = public
    public2class[public] = class
    return public
end

---@param class table
---@return table
function ClassPublic.get(class)
    class = ClassStatic.getClass(class) or class
    return class2public[class]
end

return ClassPublic