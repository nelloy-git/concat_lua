local Metadata = {}

local rawget = rawget
local rawset = rawset

-- Data
local Metadata_class2name = {}
local Metadata_name2class = {}
local Metadata_static = {}
local Metadata_static_override = {}
local Metadata_public = {}
local Metadata_subclass = {}
local Metadata_instance_class = {}

---@param class table
---@return string
function Metadata.getClassName(class)
    return Metadata_class2name[class]
end

---@param name string
---@return table
function Metadata.getClassByName(name)
    return Metadata_name2class[name]
end

---@param class table
---@return table
function Metadata.getStaticTable(class)
	return Metadata_static[class]
end

---@param class table
---@return table
function Metadata.getOverrideTable(class)
    return Metadata_static_override[class]
end

---@param class table
---@return table
function Metadata.getPublicTable(class)
    return Metadata_public[class]
end

---@param class table
---@return Class[]
function Metadata.getSubClasses(class)
    return Metadata_subclass[class]
end

---@param class table
---@return boolean
function Metadata.isClass(class)
    local res = Metadata_class2name[class] == nil
    return not res
end

function Metadata.getClass(instance)
    return Metadata_instance_class[instance]
end

function Metadata.isSubclass(class1, class2)
    local subs = Metadata.getSubClasses(class1)
    for i = 1, #subs do
        if class2 == subs[i] then
            return true
        end
    end
    return false
end

local function static_newindex(self, key, value, class)
    local subclasses = Metadata_subclass[class]
    for i = 1, #subclasses do
        local sub_static = Metadata_static[subclasses[i]]
        local sub_value = rawget(sub_static, key)
        if (sub_value ~= nil) then
            rawset(sub_static, key, value)
            return nil
        end
    end
    rawset(self, key, value)
end

local function static_index(self, key, class)
    local subclasses = Metadata_subclass[class]
    for i = 1, #subclasses do
        local sub_static = Metadata_static[subclasses[i]]
        local sub_value = rawget(sub_static, key)
        if (sub_value ~= nil) then
            return sub_value
        end
    end
    return nil
end

local function static_override_value(self, key, value, class)
    local static = Metadata.getStaticTable(class)
    rawset(static, key, value)
end

function Metadata.newClass(name, class, ...)
    Metadata_class2name[class] = name
    Metadata_name2class[name] = class

    local static = {}
    local static_meta = {
        __class = class,
        __newindex = function(self, key, value)
            static_newindex(self, key, value, class)
        end,
        __index = function(self, key)
            return static_index(self, key, class)
        end
    }
    Metadata_static[class] = static
    setmetatable(Metadata_static[class], static_meta)

    local static_override = {}
    local static_override_meta = {
        __newindex = function(self, key, value)
            static_override_value(self, key, value, class)
        end
    }
    Metadata_static_override[class] = static_override
    setmetatable(static_override, static_override_meta)

    Metadata_public[class] = {}

    local list = {class}
    local subclasses = {...}
    for i = 1, #subclasses do
        local s = Metadata.getSubClasses(subclasses[i])
        for j = 1, #s do
            if s[j] ~= nil then
                table.insert(list, #list + 1, s[j])
            end
        end
    end

    Metadata_subclass[class] = list
end

---@param class table
---@return any
function Metadata.allocate(class)
    local instance = {}
    local sub_classes = Metadata_subclass[class]
    local i = #sub_classes
    while i > 0 do
        local additive = deepcopy(sub_classes[i].public)
        for k,v in pairs(additive) do
            instance[k] = v
        end
        i = i - 1
    end
    Metadata_instance_class[instance] = class

    return instance
end

---@param instance table
---@return any
function Metadata.free(instance)
    Metadata_instance_class[instance] = nil
end

return Metadata