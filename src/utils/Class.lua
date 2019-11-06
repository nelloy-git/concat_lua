local Metadata = require('utils.ClassMetadata')

---@class Class
local Class = {}

--[[
Example:

local C1 = Class.new('C1')
C1.public.a = 0

function C1.static.new(a, instance_table)
    local instance = instance_table or Class.newInstance(C1)
    instance.a = a
    return instance
end

local C2 = Class.new('C2', C1)
C2.public.a = 0
C2.public.b = 0

function C2.override.new(a, b, instance_table)
    local instance = instance_table or Class.newInstance(C2)
    instance = C1.new(a, instance)
    instance.b = b
    return instance
end

local A1 = Class.new('A1')
A1.public.a = 1
A1.public.c = 1

function A1.override.new(a, c, instance_table)
    local instance = instance_table or Class.newInstance(A1)
    instance.a = a
    instance.c = c
    return instance
end

local B1 = Class.new('B1', C2, A1)
function B1.override.new(a, b, c, instance_table)
    local instance = instance_table or Class.newInstance(B1)
    instance = C2.new(a, b, instance)
    instance = A1.new(a, c, instance)

    return instance
end

local c1 = C1.new(1)
print(Metadata.getName(Metadata.getClass(c1)))
for k,v in pairs(c1) do
    print(k,v)
end

local c2 = C2.new(2, 3)
print(Metadata.getName(Metadata.getClass(c2)))
for k,v in pairs(c2) do
    print(k,v)
end

local a1 = A1.new(4, 5)
print(Metadata.getName(Metadata.getClass(a1)))
for k,v in pairs(a1) do
    print(k,v)
end

local b1 = B1.new(3, 3, 3)
print(Metadata.getName(Metadata.getClass(b1)))
for k,v in pairs(b1) do
    print(k,v)
end

Output:
C1
a	1
C2
a	2
b	3
A1
a	4
c	5
B1
c	3
b	3
a	3

]]

local class_metatable = {
    __newindex = function(class, key, value)
	    Debug('You must use static or public subtable for new values.')
	end,

	__index = function(class, key)
        if (key == 'static') then
            return Metadata.getStaticTable(class)
        end

        if (key == 'public') then
            return Metadata.getPublicTable(class)
        end

        if (key == 'override') then
            return Metadata.getOverrideTable(class)
        end

        local static = Metadata.getStaticTable(class)
        local val = static[key]
        if val == nil then
            Debug(string.format('Class error: static variable with name \"%s\" is not found.', key))
            return nil
        end
        return val
	end
}

local instance_metatable = {
    __newindex = function(self, key, value)
        Debug("Class error: new fields can not be added to class instance after creation.")
    end
}

---Generates new class
---@param name string
---@return Class
function Class.new(name, ...)
    local class = {}
    setmetatable(class, class_metatable)
    Metadata.new(name, class, ...)
    
    return class
end


function Class.newInstance(class)
    local instance = Metadata.createInstance(class)
    setmetatable(instance, instance_metatable)

    return instance
end



return Class