local Metadata = require('utils.ClassMetadata')

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
            Debug(string.format('Class error: static variable with name %s is not found.', key))
            return nil
        end
        return val
    end,
    
    __tostring = function(self)
        return Metadata.getClassName(self)..'Class'
    end
}

local instance_metatable = {
    __newindex = function(self, key, value)
        Debug("Class error: new fields can not be added to class instance after creation.")
    end,
    
    __tostring = function(self)  
        local temp = getmetatable(self)
        setmetatable(self, nil)
        local def = tostring(self)
        local res = Metadata.getClassName(Metadata.getClass(self)) .. string.sub(def, 7, #def)
        setmetatable(self, temp)
        return res
    end,

    __gc = freeInstanceData
}

function newClass(name, ...)
    local class = {}
    setmetatable(class, class_metatable)
    Metadata.newClass(name, class, ...)

    return class
end

---@param class table
---@return table
function newInstanceData(class)
    local instance = Metadata.allocate(class)
    setmetatable(instance, instance_metatable)

    return instance
end

---@param instance table
function freeInstanceData(instance)
    Metadata.free(instance)
end

function getInstanceClass(instance)
    return Metadata.getClass(instance)
end

function getClassName(class)
    if Metadata.isClass(class) then
        return Metadata.getClassName(class)
    end
    return nil
end

function isInstanceOfClass(instance, class)
    local inst_class = Metadata.getClass(instance)
    if inst_class == nil then
        return false
    end

    return Metadata.isSubclass(inst_class, class)
end

local original_type = _G.type

---Verify values types. For classes check is val2 class parent of val1 class.
---@param value any
---@param _type string
---@return boolean
function isType(value, _type)
    local class = Metadata.getClassByName(_type)
    if not Metadata.getClass(value) or not class then
        return type(value) == _type
    end

    return Metadata.isSubclass(Metadata.getClass(value), class)
end

function type(val)
    if Metadata.isClass(val) then
        return Metadata.getClassName(val)
    end
    return original_type(val)
end