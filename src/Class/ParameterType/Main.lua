--==========
-- Includes
--==========

--=======
-- Class
--=======

---@class ParameterType
local ParameterType = newClass("ParameterType")
local ParameterType_meta = newMeta(ParameterType)

ParameterType.Id = {
    P_DMG = 1,
    ATKS_PER_SEC = 2,
    ARMOR = 3,
    P_DMG_REDUC = 4,
    M_DMG = 5,
    CAST_TIME_REDUC = 6,
    RESIST = 7,
    M_DMG_REDUC = 8,
    DODGE_CH = 9,
    CRIT_CH = 10,
    CRIT_DMG = 11,
    CD_REDUC = 12,
    HP = 13,
    REGEN = 14,
    MP = 15,
    RECOV = 16,
    STR = 17,
    AGI = 18,
    INT = 19,
    MS = 20,
}

---@param id number
---@return ParameterType
local function newParameter(id)
    local param_type = {
        __id = id
    }
    setmetatable(param_type, ParameterType_meta)

    return param_type
end

function ParameterType.init()
    ParameterType.P_DMG = newParameter(ParameterType.Id.P_DMG)
    ParameterType.ATKS_PER_SEC = newParameter(ParameterType.Id.ATKS_PER_SEC)
    ParameterType.ARMOR = newParameter(ParameterType.Id.ARMOR)
    ParameterType.P_DMG_REDUC = newParameter(ParameterType.Id.P_DMG_REDUC)
    ParameterType.M_DMG = newParameter(ParameterType.Id.M_DMG)
    ParameterType.CAST_TIME_REDUC = newParameter(ParameterType.Id.CAST_TIME_REDUC)
    ParameterType.RESIST = newParameter(ParameterType.Id.RESIST)
    ParameterType.M_DMG_REDUC = newParameter(ParameterType.Id.M_DMG_REDUC)
    ParameterType.DODGE_CH = newParameter(ParameterType.Id.DODGE_CH)
    ParameterType.CRIT_CH = newParameter(ParameterType.Id.CRIT_CH)
    ParameterType.CRIT_DMG = newParameter(ParameterType.Id.CRIT_DMG)
    ParameterType.CD_REDUC = newParameter(ParameterType.Id.CD_REDUC)
    ParameterType.HP = newParameter(ParameterType.Id.HP)
    ParameterType.REGEN = newParameter(ParameterType.Id.REGEN)
    ParameterType.MP = newParameter(ParameterType.Id.MP)
    ParameterType.RECOV = newParameter(ParameterType.Id.RECOV)
    ParameterType.STR = newParameter(ParameterType.Id.STR)
    ParameterType.AGI = newParameter(ParameterType.Id.AGI)
    ParameterType.INT = newParameter(ParameterType.Id.INT)
    ParameterType.MS = newParameter(ParameterType.Id.MS)
end

---@return number
function ParameterType:getId()
    return self.__id
end

return ParameterType