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
---@param casting_type AbilityExtTypeCastingClass
---@param data_type AbilityExtTypeDataClass
---@return AbilityExtType
function override.new(targeting_type, casting_type, data_type)

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

function public:targetingStart(abil)
    return private.data[self].targeting_type.start(abil)
end

function public:targetingCancel(abil)
    return private.data[self].targeting_type.cancel(abil)
end

function public:targetingFinish(abil, targ)
    return private.data[self].targeting_type.finish(abil, targ)
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