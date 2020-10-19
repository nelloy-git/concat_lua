--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type AbilityExtTypeTargetingClass
local AbilityExtTargetingType = require(lib_path..'Type.Targeting') or error('')
---@type AbilityExtTypeCastingClass
local AbilityExtCastingType = require(lib_path..'Type.Casting') or error('')
---@type AbilityExtTypeDataClass
local AbilityExtDataType = require(lib_path..'Type.Data') or error('')

--=======
-- Class
--=======

local AbilityExtType = Class.new('AbilityExtType')
---@class AbilityExtType
local public = AbilityExtType.public
---@class AbilityExtTypeClass
local static = AbilityExtType.static
---@type AbilityExtTypeClass
local override = AbilityExtType.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@param targ_type AbilityExtTypeTargetingClass
---@param cast_type AbilityExtTypeCasting
---@param data_type AbilityExtTypeData
---@return AbilityExtType
function override.new(targ_type, cast_type, data_type)
    isTypeErr(cast_type, AbilityExtCastingType, 'cast_type')
    isTypeErr(data_type, AbilityExtDataType, 'data_type')

    local instance = Class.allocate(AbilityExtType)
    private.newData(instance, targ_type, cast_type, data_type)

    return instance
end

--========
-- Public
--========

---@return AbilityExtTypeTargetingClass
function public:getTargeting()
    return private.data[self].targ_type
end

---@return AbilityExtTypeCasting
function public:getCasting()
    return private.data[self].cast_type
end

---@return AbilityExtTypeData
function public:getData()
    return private.data[self].data_type
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtType
---@param targ_type AbilityExtTypeTargetingClass
---@param cast_type AbilityExtTypeCasting
---@param data_type AbilityExtTypeData
function private.newData(self, targ_type, cast_type, data_type)
    local priv = {
        targ_type = targ_type,
        cast_type = cast_type,
        data_type = data_type
    }
    private.data[self] = priv
end



return static