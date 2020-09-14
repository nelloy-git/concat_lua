--=========
-- Include
--=========

--region Include
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local isTypeErr = UtilsLib.isTypeErr
--endregion

--=======
-- Class
--=======

local Parameter = Class.new('Parameter')
--region Class
---@class Parameter
local public = Parameter.public
---@class ParameterClass
local static = Parameter.static
---@type ParameterClass
local override = Parameter.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param short_name string
---@param full_name string
---@param icon string
---@param min_value number
---@param max_value number
---@param default_value number
---@param apply_func function
---@return Parameter
function override.new(short_name, full_name, icon,
                      min_value, max_value, default_value,
                      apply_func)
    isTypeErr(short_name, 'string', 'short_name')
    isTypeErr(full_name, 'string', 'full_name')
    isTypeErr(icon, 'string', 'icon')
    isTypeErr(min_value, 'number', 'min_value')
    isTypeErr(max_value, 'number', 'max_value')
    isTypeErr(default_value, 'number', 'default_value')
    isTypeErr(apply_func, 'function', 'apply_func')

    local instance = Class.allocate(Parameter)
    private.newData(instance,
                    short_name, full_name, icon,
                    min_value, max_value, default_value,
                    apply_func)

    return instance
end

--========
-- Public
--========

---@return string
function public:getShortName()
    return private.data[self].short_name
end

---@return string
function public:getName()
    return private.data[self].full_name
end

---@return string
function public:getIcon()
    return private.data[self].icon
end

---@return number
function public:getDefault()
    return private.data[self].default_value
end

---@return number
function public:getMin()
    return private.data[self].min_value
end

---@return number
function public:getMax()
    return private.data[self].max_value
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Parameter
---@param short_name string
---@param full_name string
---@param icon string
---@param min_value number
---@param max_value number
---@param default_value number
---@param apply_func function
function private.newData(self,
                         short_name, full_name, icon,
                         min_value, max_value, default_value,
                         apply_func)
    local priv = {
        short_name = short_name,
        full_name = full_name,
        icon = icon,
        min_value = min_value,
        max_value = max_value,
        default_value = default_value,
        apply_func = apply_func,
    }
    private.data[self] = priv
end

return static