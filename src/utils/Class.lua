local Class = {}
local Instance = {}

local rawset = rawset
local rawget = rawget

local metadata = {}

---@type table(Instance, Class)
local instanceClass = {}

---@param orig any
---@param copies any
local function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local default_class_meta = {
    __newindex = function(self, key, value)
        if self.static[key] ~= nil then
            local t = self.static[key]
            t[key] = value
            return nil
        end
        Debug("Class error: can not add field or method directly to class. Use static or public field.\n",
              "Key:", key, "Value:", value)
        return nil
    end,

    __index = function(self, key)
        if self.static[key] ~= nil then
            return self.static[key]
        end
        return metadata[self][key]
    end
}

local default_instance_meta = {
    ---@param self Instance
    ---@param key any
    ---@param value any
    __newindex = function (self, key, value)
        Debug("Class error: can not add field or method directly to instance. Use class table public field.\n",
              "Key:", key, "Value:", value)
        return nil
    end
}

local function appendTable(dst, src)
    for i = 1, #src do
        table.insert(dst, #dst + 1, src[i])
    end
end

---@param class Class
---@return Instance
function Instance.allocate(class)
    ---@class Instance
    local instance = {}

    instanceClass[instance] = class
    local parents = {class}
    appendTable(parents, class.getParents())

    for i = #parents, 1 do
        instance = deepcopy(parents[i].public, instance)
    end

    return instance
end

function Instance:free()
    instanceClass[self] = nil
    setmetatable(self, nil)
end

local function getParents(class)
    local list = {}
    local data = metadata[class]

    local i = 1
    while i <= #data.parents do
        local parent_list = getParents(data.parents[i])
        appendTable(list, parent_list)
        i = i + 1
    end

    return list
end

local function isClass(class)
    return metadata[class] ~= nil
end

local function searchStaticPosition(self, class, key)
    local data = metadata[class]
    local parents = data.parents

end

local function searchStaticValue(self, class, key)
    local data = metadata[class]
    local parents = data.parents
    for i = 1, #parents do
        local cur = parents[i]
        print('Searching in', cur.name)
        local val = cur[key]
        print(key, val)

        if val ~= nil then
            return cur
        end
    end
end

---@param name string
---@return Class
function Class.new(name, ...)
    local vararg = {...}
    if (#vararg > 0) then
        for i = 1, #vararg do
            if not isClass(vararg[i]) then
                Debug("Class error: non class types can not be parent of class.")
                return nil
            end
        end
    end

    ---@class Class
    local class = {
        static = {},
        public = {},
    }

    local class_metadata = {
        name = name,
        parents = {},
    }
    metadata[class] = class_metadata

    setmetatable(class.static, {__index = function(self, key) return searchStaticValue(self, class, key) end})
    local i = #vararg
    while i > 0 do
        -- Copy all instance fields
        class.public = deepcopy(vararg[i].public, class.public)
        -- List all parents
        table.insert(class_metadata.parents, #class_metadata.parents + 1, vararg[i])
        appendTable(class_metadata.parents, getParents(vararg[i]))

        i = i - 1
    end
    setmetatable(class, default_class_meta)


    return class
end

print("Object")
---@class Object : Class
local ObjectClass = Class.new('Object')

ObjectClass.static.a = 5
ObjectClass.static.b = 10

print("  static")
for k,v in pairs(ObjectClass.static) do
    print('  ', k, ObjectClass[k])
end

print("  public")
for k,v in pairs(ObjectClass.public) do
    print('  ', k, v)
end

print("Object2")
local ObjectClass2 = Class.new('Object2', ObjectClass)
ObjectClass2.a = 10
ObjectClass2.static.b = 15
ObjectClass2.static.c = 20

print("  static")
for k,v in pairs(ObjectClass2.static) do
    print('  ', k, ObjectClass2[k])
end

print("  public")
for k,v in pairs(ObjectClass2.public) do
    print('  ', k, v)
end

print(ObjectClass.a)
print(ObjectClass2.a)

--for k,v in pairs(ObjectClass2) do
--    print(k, v)
--end
--
-----@class ObjectInstance : Object
--local ObjectInstance = ObjectClass2.allocate()
--
--for k,v in pairs(ObjectInstance) do
--    print(k, v)
--end


return Class