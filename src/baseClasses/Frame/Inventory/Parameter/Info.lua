local Unit = require('baseClasses.Unit')

local ParametersInfo = {}

ParametersInfo.count = 20

ParametersInfo.Icons = {}
ParametersInfo.Icons[UNIT_PARAMETER_ATTACK_DAMAGE] = "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp"
ParametersInfo.Icons[UNIT_PARAMETER_ATTACK_SPEED] = "ReplaceableTextures\\CommandButtons\\BTNCommand.blp"
ParametersInfo.Icons[UNIT_PARAMETER_ARMOR] = "ReplaceableTextures\\CommandButtons\\BTNDefend.blp"
ParametersInfo.Icons[UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION] = "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpThree.blp"
ParametersInfo.Icons[UNIT_PARAMETER_SPELL_DAMAGE] = "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheMoon.blp"
ParametersInfo.Icons[UNIT_PARAMETER_CASTING_TIME_REDUCTION] = "ReplaceableTextures\\CommandButtons\\BTNBansheeMaster.blp"
ParametersInfo.Icons[UNIT_PARAMETER_RESISTANCE] = "ReplaceableTextures\\CommandButtons\\BTNResistantSkin.blp"
ParametersInfo.Icons[UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION] = "ReplaceableTextures\\CommandButtons\\BTNLightningShield.blp"
ParametersInfo.Icons[UNIT_PARAMETER_DODGE_CHANCE] = "ReplaceableTextures\\CommandButtons\\BTNEvasion.blp"
ParametersInfo.Icons[UNIT_PARAMETER_CRIT_CHANCE] = "ReplaceableTextures\\CommandButtons\\BTNCriticalStrike.blp"
ParametersInfo.Icons[UNIT_PARAMETER_CRIT_DAMAGE] = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp"
ParametersInfo.Icons[UNIT_PARAMETER_COOLDOWN_REDUCTION] = "ReplaceableTextures\\CommandButtons\\BTNDispelMagic.blp"
ParametersInfo.Icons[UNIT_PARAMETER_HEALTH] = "ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp"
ParametersInfo.Icons[UNIT_PARAMETER_REGENERATION] = "ReplaceableTextures\\CommandButtons\\BTNRegenerate.blp"
ParametersInfo.Icons[UNIT_PARAMETER_MANA] = "ReplaceableTextures\\CommandButtons\\BTNManaStone.blp"
ParametersInfo.Icons[UNIT_PARAMETER_RECOVERY] = "ReplaceableTextures\\CommandButtons\\BTNBrilliance.blp"
ParametersInfo.Icons[UNIT_PARAMETER_STRENGTH] = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-str.blp"
ParametersInfo.Icons[UNIT_PARAMETER_AGILITY] = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-agi.blp"
ParametersInfo.Icons[UNIT_PARAMETER_INTELLIGENCE] = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-int.blp"
ParametersInfo.Icons[UNIT_PARAMETER_MOVE_SPEED] = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp"

ParametersInfo.Title = {}
ParametersInfo.Title[UNIT_PARAMETER_ATTACK_DAMAGE] = "AttackDamage"
ParametersInfo.Title[UNIT_PARAMETER_ATTACK_SPEED] = "AttackSpeed"
ParametersInfo.Title[UNIT_PARAMETER_ARMOR] = "Armor"
ParametersInfo.Title[UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION] = "PhysicalDamageReduction"
ParametersInfo.Title[UNIT_PARAMETER_SPELL_DAMAGE] = "SpellDamage"
ParametersInfo.Title[UNIT_PARAMETER_CASTING_TIME_REDUCTION] = "CastingTimeReduction"
ParametersInfo.Title[UNIT_PARAMETER_RESISTANCE] = "Resistance"
ParametersInfo.Title[UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION] = "MagicalDamageReduction"
ParametersInfo.Title[UNIT_PARAMETER_DODGE_CHANCE] = "DodgeChance"
ParametersInfo.Title[UNIT_PARAMETER_CRIT_CHANCE] = "CritChance"
ParametersInfo.Title[UNIT_PARAMETER_CRIT_DAMAGE] = "CritDamage"
ParametersInfo.Title[UNIT_PARAMETER_COOLDOWN_REDUCTION] = "CooldownReduction"
ParametersInfo.Title[UNIT_PARAMETER_HEALTH] = "Health"
ParametersInfo.Title[UNIT_PARAMETER_REGENERATION] = "Regeneration"
ParametersInfo.Title[UNIT_PARAMETER_MANA] = "Mana"
ParametersInfo.Title[UNIT_PARAMETER_RECOVERY] = "Recovery"
ParametersInfo.Title[UNIT_PARAMETER_STRENGTH] = "Strength"
ParametersInfo.Title[UNIT_PARAMETER_AGILITY] = "Agility"
ParametersInfo.Title[UNIT_PARAMETER_INTELLIGENCE] = "Intelligence"
ParametersInfo.Title[UNIT_PARAMETER_MOVE_SPEED] = "MoveSpeed"

ParametersInfo.Text = {}
ParametersInfo.Text[UNIT_PARAMETER_ATTACK_DAMAGE] = "Physical damage."
ParametersInfo.Text[UNIT_PARAMETER_ATTACK_SPEED] = "Attacks cooldown."
ParametersInfo.Text[UNIT_PARAMETER_ARMOR] = "Incoming physical damage reduced by this value."
ParametersInfo.Text[UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION] = "Percent physical damage reduction."
ParametersInfo.Text[UNIT_PARAMETER_SPELL_DAMAGE] = "Magical damage."
ParametersInfo.Text[UNIT_PARAMETER_CASTING_TIME_REDUCTION] = "Spells casting time reduced by this value."
ParametersInfo.Text[UNIT_PARAMETER_RESISTANCE] = "Incoming magical damage reduced by this value."
ParametersInfo.Text[UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION] = "Percent magical damage reduction."
ParametersInfo.Text[UNIT_PARAMETER_DODGE_CHANCE] = "Chance to evade all incoming damage."
ParametersInfo.Text[UNIT_PARAMETER_CRIT_CHANCE] = "Chance to increase damage by crit damage value."
ParametersInfo.Text[UNIT_PARAMETER_CRIT_DAMAGE] = "Critical damage value."
ParametersInfo.Text[UNIT_PARAMETER_COOLDOWN_REDUCTION] = "Spells cooldown reduced by this value."
ParametersInfo.Text[UNIT_PARAMETER_HEALTH] = "Maximum health points."
ParametersInfo.Text[UNIT_PARAMETER_REGENERATION] = "Health point restored per sec."
ParametersInfo.Text[UNIT_PARAMETER_MANA] = "Maximum mana points."
ParametersInfo.Text[UNIT_PARAMETER_RECOVERY] = "Mana points restored per sec."
ParametersInfo.Text[UNIT_PARAMETER_STRENGTH] = "Strength"
ParametersInfo.Text[UNIT_PARAMETER_AGILITY] = "Agility"
ParametersInfo.Text[UNIT_PARAMETER_INTELLIGENCE] = "Intelligence"
ParametersInfo.Text[UNIT_PARAMETER_MOVE_SPEED] = "Movement speed"


return ParametersInfo