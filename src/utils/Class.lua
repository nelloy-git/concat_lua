local Log = require('utils.Log')
local Metadata = require('utils.ClassMetadata')

local Class = {}

local class_metatable = {
    __newindex = function(class, key, value)
        local msg = "have to use static or public subtable for new values."
        Log(Log.Warn, Class.getClassName(class), msg)
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
            local msg = string.format('static field with name \"%s\" is not found.', key)
            Log(Log.Warn, Class.getClassName(class), msg)
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
        Log(Log.Warn, self, "new fields can not be added to class instance after creation.")
    end,
    
    __tostring = function(self)  
        local temp = getmetatable(self)
        setmetatable(self, nil)
        local def = tostring(self)
        local res = Metadata.getClassName(Metadata.getClass(self)) .. string.sub(def, 7, #def)
        setmetatable(self, temp)
        return res
    end,

    __gc = Class.freeInstanceData
}

---@return any
function Class.Class.newClass(name, ...)
    local class = {}
    setmetatable(class, class_metatable)
    Metadata.Class.newClass(name, class, ...)

    return class
end

function Class.newInstanceData(class)
    local instance = Metadata.allocate(class)
    setmetatable(instance, instance_metatable)

    return instance
end

---@param instance table
function Class.freeInstanceData(instance)
    Metadata.free(instance)
end

function Class.getInstanceClass(instance)
    return Metadata.getClass(instance)
end

function Class.getClassName(class)
    if Metadata.isClass(class) then
        return Metadata.getClassName(class)
    end
    return nil
end

function Class.isInstanceOfClass(instance, class)
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
    local class
    if not Metadata.isClass(_type) then
        class = Metadata.getClassByName(_type)
    else
        class = _type
    end

    if not Metadata.getClass(value) or not class then
        return type(value) == _type
    end

    return Metadata.isSubclass(Metadata.getClass(value), class)
end

function type(val)
    local class = Class.getInstanceClass(val)
    if class then
        val = class
    end

    if Metadata.isClass(val) then
        return Metadata.getClassName(val)
    end
    return original_type(val)
end

return Class