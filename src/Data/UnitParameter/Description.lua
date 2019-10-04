local Settings = require('utils.Settings')

local UnitParameterDescription = {}

local min_attack_dmg = tostring(100*(1 - Settings.Unit.attack_dispersion))
local max_attack_dmg = tostring(100*(1 + Settings.Unit.attack_dispersion))
UnitParameterDescription.P_DMG = 'Physical damage of unit with attacks and some physical damage spells. Attacks randomly deals'..min_attack_dmg..'-'..max_attack_dmg..'% of this value.'
UnitParameterDescription.ATKS_PER_SEC = 'Number of attacks dealing by unit per second.'
UnitParameterDescription.ARMOR = 'Physical damage is reduced by this value. Works after physical damage reduction.'
UnitParameterDescription.P_DMG_REDUC = 'Physical damage is reduced by this value. Works before armor. Maximum: '..tostring(100 * Settings.Unit.maximum_physical_damage_reduction)..'%.'
UnitParameterDescription.M_DMG = 'Magic power of unit. Icreases damage dealt by magic abilities.'
UnitParameterDescription.CAST_TIME_REDUC = 'Casting time of abilities is reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_casting_time_reduction)..'%.'
UnitParameterDescription.RESIST = 'Magical damage is reduced by this value. Works after magical damage reduction.'
UnitParameterDescription.M_DMG_REDUC = 'Magical damage is reduced by this value. Works before resistance. Maximum: '..tostring(100 * Settings.Unit.maximum_magical_damage_reduction)..'%.'
UnitParameterDescription.DODGE_CH = 'Chance to avoid incoming damage. Maximum: '..tostring(100 * Settings.Unit.maximum_dodge_chance)..'%.'
UnitParameterDescription.CRIT_CH = 'Chance to increase damage by critical damage value. Maximum: '..tostring(100 * Settings.Unit.maximum_crit_chance)..'%.'
UnitParameterDescription.CRIT_DMG = 'Critical attack or spell deals this value damage.'
UnitParameterDescription.CD_REDUC = 'Abilities cooldown reduced by this value. Maximum: '..tostring(100 * Settings.Unit.maximum_cooldown_reduction)..'%.'
UnitParameterDescription.HP = 'Maximum health.'
UnitParameterDescription.REGEN = 'Health restoration per second.'
UnitParameterDescription.MP = 'Maximum mana.'
UnitParameterDescription.RECOV = 'Mana restoration per second'
local atk_per_str = tostring(Settings.Unit.p_dmg_per_str)
local armor_per_str = tostring(Settings.Unit.armor_per_str)
local hp_per_str = tostring(Settings.Unit.health_per_str)
UnitParameterDescription.STR = 'Some spell effects depends on this value. Every point of strength increases attack damage by '..atk_per_str..', armor by '..armor_per_str..' and health by '..hp_per_str..'.'
local aspd_per_agi = tostring(Settings.Unit.attack_speed_per_agi)
local ctr_per_agi = tostring(Settings.Unit.casting_time_reduction_per_agi)
local dodge_per_agi = tostring(Settings.Unit.dodge_chance_per_agi)
UnitParameterDescription.AGI = 'Some spell effects depends on this value. Every point of strength increases attack speed by '..aspd_per_agi..', casting time reduction by '..ctr_per_agi..' and dodge chance by '..dodge_per_agi..'.'
local mdmg_per_int = tostring(Settings.Unit.m_dmg_per_int)
local cdr_per_int = tostring(Settings.Unit.cooldown_reduction_per_int)
local mp_per_int = tostring(Settings.Unit.mana_per_int)
UnitParameterDescription.INT = 'Some spell effects depends on this value. Every point of strength increases spell damage by '..mdmg_per_int..', cooldown reduction by '..cdr_per_int..' and mana by '..mp_per_int..'.'
UnitParameterDescription.MS = 'Move speed'

return UnitParameterDescription