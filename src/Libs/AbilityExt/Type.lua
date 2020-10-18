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

---@param targeting_type AbilityExtTypeTargetingClass
---@param casting_type AbilityExtTypeCasting
---@param data_type AbilityExtTypeData
---@return AbilityExtType
function override.new(targeting_type, casting_type, data_type)
    isTypeErr(casting_type, AbilityExtCastingType, 'casting_type')
    isTypeErr(data_type, AbilityExtDataType, 'data_type')

    local instance = Class.allocate(AbilityExtType)
    private.newData(instance, targeting_type, casting_type, data_type)

    return instance
end

--========
-- Public
--========

-------------
-- Targeting
-------------

function public:targetingStart(abil, cancel_cb, finish_cb)
    return private.data[self].targeting_type.start(abil, cancel_cb, finish_cb)
end

function public:targetingCancel(abil)
    return private.data[self].targeting_type.cancel(abil)
end

function public:targetingFinish(abil, targ)
    return private.data[self].targeting_type.finish(abil, targ)
end

-----------
-- Casting
-----------

function public:castingStart(abil)
    return private.data[self].casting_type:start(abil)
end

--------
-- Data
--------

function public:checkConditions(abil)
    return private.data[self].data_type:checkConditions(abil)
end

function public:checkTarget(abil, target)
    return private.data[self].data_type:checkTarget(abil, target)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtType
---@param targeting_type AbilityExtTypeTargetingClass
---@param casting_type AbilityExtTypeCasting
---@param data_type AbilityExtTypeData
function private.newData(self, targeting_type, casting_type, data_type)
    local priv = {
        targeting_type = targeting_type,
        casting_type = casting_type,
        data_type = data_type
    }
    private.data[self] = priv
end



return static