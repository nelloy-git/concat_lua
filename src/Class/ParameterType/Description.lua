local ParameterType = require('Class.ParameterType.Main')
local Settings = require('utils.Settings')

local min_attack_dmg = tostring(100*(1 - Settings.Unit.attack_dispersion))
local max_attack_dmg = tostring(100*(1 + Settings.Unit.attack_dispersion))

local atk_per_str = tostring(Settings.Unit.p_dmg_per_str)
local armor_per_str = tostring(Settings.Unit.armor_per_str)
local hp_per_str = tostring(Settings.Unit.health_per_str)

local aspd_per_agi = tostring(Settings.Unit.attack_speed_per_agi)
local ctr_per_agi = tostring(Settings.Unit.casting_time_reduction_per_agi)
local dodge_per_agi = tostring(Settings.Unit.dodge_chance_per_agi)

local mdmg_per_int = tostring(Settings.Unit.m_dmg_per_int)
local cdr_per_int = tostring(Settings.Unit.cooldown_reduction_per_int)
local mp_per_int = tostring(Settings.Unit.mana_per_int)

local Description = {}
Description[ParameterType.Id.P_DMG] = 'Physical damage of unit with attacks and some physical damage spells. Attacks randomly deals'..min_attack_dmg..'-'..max_attack_dmg..'% of this value.'
Description[ParameterType.Id.ATKS_PER_SEC] = 'Number of attacks dealing by unit per second.'
Description[ParameterType.Id.ARMOR] = 'Physical damage is reduced by this value. Works after physical damage reduction.'
Description[ParameterType.Id.P_DMG_REDUC] = 'Physical damage is reduced by this value. Works before armor. Maximum: '..tostring(100 * Settings.Unit.maximum_physical_damage_reduction)..'%.'
Description[ParameterType.Id.M_DMG] = 'Magic power of unit. Icreases damage dealt by magic abilities.'
Description[ParameterType.Id.CAST_TIME_REDUC] = 'Casting time of abilities is reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_casting_time_reduction)..'%.'
Description[ParameterType.Id.RESIST] = 'Magical damage is reduced by this value. Works after magical damage reduction.'
Description[ParameterType.Id.M_DMG_REDUC] = 'Magical damage is reduced by this value. Works before resistance. Maximum: '..tostring(100 * Settings.Unit.maximum_magical_damage_reduction)..'%.'
Description[ParameterType.Id.DODGE_CH] = 'Chance to avoid incoming damage. Maximum: '..tostring(100 * Settings.Unit.maximum_dodge_chance)..'%.'
Description[ParameterType.Id.CRIT_CH] = 'Chance to increase damage by critical damage value. Maximum: '..tostring(100 * Settings.Unit.maximum_crit_chance)..'%.'
Description[ParameterType.Id.CRIT_DMG] = 'Critical attack or spell deals this value damage.'
Description[ParameterType.Id.CD_REDUC] = 'Abilities cooldown reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_cooldown_reduction)..'%.'
Description[ParameterType.Id.HP] = 'Maximum health.'
Description[ParameterType.Id.REGEN] = 'Health restoration per second.'
Description[ParameterType.Id.MP] = 'Maximum mana.'
Description[ParameterType.Id.RECOV] = 'Mana restoration per second'
Description[ParameterType.Id.STR] = 'Some spell effects depends on this value. Every point of strength increases attack damage by '..atk_per_str..', armor by '..armor_per_str..' and health by '..hp_per_str..'.'
Description[ParameterType.Id.AGI] = 'Some spell effects depends on this value. Every point of agility increases attack speed by '..aspd_per_agi..', casting time reduction by '..ctr_per_agi..' and dodge chance by '..dodge_per_agi..'.'
Description[ParameterType.Id.INT] = 'Some spell effects depends on this value. Every point of intelligence increases spell damage by '..mdmg_per_int..', cooldown reduction by '..cdr_per_int..' and mana by '..mp_per_int..'.'
Description[ParameterType.Id.MS] = 'Move speed'

---@return string
function ParameterType:getDescription()
    return Description[self.__id]
end