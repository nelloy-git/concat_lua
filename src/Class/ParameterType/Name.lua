local ParameterType = require('Class.ParameterType.Main')

local Name = {}
Name[ParameterType.Id.P_DMG] = 'Attack damage'
Name[ParameterType.Id.ATKS_PER_SEC] = 'Attacks per second'
Name[ParameterType.Id.ARMOR] = 'Armor'
Name[ParameterType.Id.P_DMG_REDUC] = 'Physical damage reduction'
Name[ParameterType.Id.M_DMG] = 'Spell damage'
Name[ParameterType.Id.CAST_TIME_REDUC] = 'Casting time reduction'
Name[ParameterType.Id.RESIST] = 'Reisistance'
Name[ParameterType.Id.M_DMG_REDUC] = 'Magical damage reduction'
Name[ParameterType.Id.DODGE] = 'Dodge chance'
Name[ParameterType.Id.CRIT_CH] = 'Critical strike chance'
Name[ParameterType.Id.CRIT_DMG] = 'Critical strike damage'
Name[ParameterType.Id.CD_REDUC] = 'Cooldown reduction'
Name[ParameterType.Id.HP] = 'Health'
Name[ParameterType.Id.REGEN] = 'Regeneration'
Name[ParameterType.Id.MP] = 'Mana'
Name[ParameterType.Id.RECOV] = 'Recovery'
Name[ParameterType.Id.STR] = 'Strength'
Name[ParameterType.Id.AGI] = 'Agility'
Name[ParameterType.Id.INT] = 'Intelligence'
Name[ParameterType.Id.MS] = 'Move speed'

---@return string
function ParameterType:getName()
    return Name[self.__id]
end