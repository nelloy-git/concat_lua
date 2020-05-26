local lib_modname = Lib.current().modname
---@type UtilsLib
local UtilsLib = Lib.current().depencies.UtilsLib

---@class ParameterDefines
local Defines = {}
---@type ParameterClass
local Parameter = require(lib_modname..'.Parameter')

Defines.AllParameters = {}

Defines.PhysicalDamage = Parameter.new('PDmg', 'Physical damage',
                                       Compiletime(UtilsLib.Icon.BTNSteelMelee),
                                       0, 10^10, 0)
table.insert(Defines.AllParameters, Defines.PhysicalDamage)

Defines.AttackSpeed = Parameter.new('ASpd', 'Attack speed',
                                    Compiletime(UtilsLib.Icon.BTNCommand),
                                    0, 10^10, 1)
table.insert(Defines.AllParameters, Defines.AttackSpeed)

Defines.Defence = Parameter.new('Def', 'Defence',
                                Compiletime(UtilsLib.Icon.BTNDefend),
                                0, 10^10, 0)
table.insert(Defines.AllParameters, Defines.Defence)

Defines.PhysicalDamageReduction = Parameter.new('PDmgReduc', 'Physical damage reduction',
                                                Compiletime(UtilsLib.Icon.BTNHumanArmorUpThree),
                                                -1, 1, 0)
table.insert(Defines.AllParameters, Defines.PhysicalDamageReduction)

Defines.MagicalDamage = Parameter.new('MDmg', 'Magical damage',
                                      Compiletime(UtilsLib.Icon.BTNAdvancedStrengthOfTheMoon),
                                      0, 10^10, 0)
table.insert(Defines.AllParameters, Defines.MagicalDamage)

Defines.CooldownReduction = Parameter.new('CdR', 'Cooldown reduction',
                                          Compiletime(UtilsLib.Icon.BTNDispelMagic),
                                          0, 0.75, 0)
table.insert(Defines.AllParameters, Defines.CooldownReduction)

Defines.Resistance = Parameter.new('Res', 'Resistance',
                                   Compiletime(UtilsLib.Icon.BTNResistantSkin),
                                   0, 10^10, 0)
table.insert(Defines.AllParameters, Defines.Resistance)

Defines.MagicalDamageReduction = Parameter.new('MDmgReduc', 'Magical damage reduction',
                                               Compiletime(UtilsLib.Icon.BTNLightningShield),
                                               -1, 1, 0)
table.insert(Defines.AllParameters, Defines.MagicalDamageReduction)

Defines.ControlReduction = Parameter.new('ConReduc', 'Control reduction',
                                    Compiletime(UtilsLib.Icon.BTNEvasion),
                                    0, 0.75, 0)
table.insert(Defines.AllParameters, Defines.ControlReduction)

Defines.DodgeChance = Parameter.new('Dodge', 'Dodge chance',
                                    Compiletime(UtilsLib.Icon.BTNAncestralSpirit),
                                    0, 0.75, 0)
table.insert(Defines.AllParameters, Defines.DodgeChance)

Defines.CriticalStrikeChance = Parameter.new('Crit', 'Critical strike chance',
                                             Compiletime(UtilsLib.Icon.BTNCriticalStrike),
                                             0, 0.75, 0)
table.insert(Defines.AllParameters, Defines.CriticalStrikeChance)

Defines.Health = Parameter.new('HP', 'Health',
                               Compiletime(UtilsLib.Icon.BTNHealthStone),
                               0, 10^10, 10)
table.insert(Defines.AllParameters, Defines.Health)

Defines.Regeneration = Parameter.new('Regen', 'Regeneration',
                                     Compiletime(UtilsLib.Icon.BTNRegenerate),
                                     0, 10^10, 0)
table.insert(Defines.AllParameters, Defines.Regeneration)

Defines.Mana = Parameter.new('MP', 'Mana',
                             Compiletime(UtilsLib.Icon.BTNManaStone),
                             0, 10^10, 0)
table.insert(Defines.AllParameters, Defines.Mana)

Defines.MoveSpeed = Parameter.new('MS', 'Move speed',
                                  Compiletime(UtilsLib.Icon.BTNBootsOfSpeed),
                                  0, 500, 250)
table.insert(Defines.AllParameters, Defines.MoveSpeed)

return Defines