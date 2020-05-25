---@type UtilsLib
local UtilsLib = require(Lib.Utils)
---@type ParameterClass
local Parameter = require(__ParameterLib..'Parameter')

---@class ParameterDefines
local Defines = {}

Defines.PhysicalDamage = Parameter.new('PDmg', 'Physical damage',
                                       Compiletime(UtilsLib.Icon.BTNSteelMelee),
                                       0, 10^10, 0)

Defines.AttackSpeed = Parameter.new('ASpd', 'Attack speed',
                                    Compiletime(UtilsLib.Icon.BTNCommand),
                                    0, 10^10, 1)

Defines.Defence = Parameter.new('Def', 'Defence',
                                Compiletime(UtilsLib.Icon.BTNDefend),
                                0, 10^10, 0)

Defines.PhysicalDamageReduction = Parameter.new('PDmgReduc', 'Physical damage reduction',
                                                Compiletime(UtilsLib.Icon.BTNHumanArmorUpThree),
                                                -1, 1, 0)

Defines.MagicalDamage = Parameter.new('MDmg', 'Magical damage',
                                      Compiletime(UtilsLib.Icon.BTNAdvancedStrengthOfTheMoon),
                                      0, 10^10, 0)

Defines.CooldownReduction = Parameter.new('CdR', 'Cooldown reduction',
                                          Compiletime(UtilsLib.Icon.BTNDispelMagic),
                                          0, 0.75, 0)

Defines.Resistance = Parameter.new('Res', 'Resistance',
                                   Compiletime(UtilsLib.Icon.BTNResistantSkin),
                                   0, 10^10, 0)

Defines.MagicalDamageReduction = Parameter.new('MDmgReduc', 'Magical damage reduction',
                                               Compiletime(UtilsLib.Icon.BTNLightningShield),
                                               -1, 1, 0)

Defines.ControlReduction = Parameter.new('ConReduc', 'Control reduction',
                                    Compiletime(UtilsLib.Icon.BTNEvasion),
                                    0, 0.75, 0)

Defines.DodgeChance = Parameter.new('Dodge', 'Dodge chance',
                                    Compiletime(UtilsLib.Icon.BTNAncestralSpirit),
                                    0, 0.75, 0)

Defines.CriticalStrikeChance = Parameter.new('Crit', 'Critical strike chance',
                                             Compiletime(UtilsLib.Icon.BTNCriticalStrike),
                                             0, 0.75, 0)

Defines.Health = Parameter.new('HP', 'Health',
                               Compiletime(UtilsLib.Icon.BTNHealthStone),
                               0, 10^10, 10)

Defines.Regeneration = Parameter.new('Regen', 'Regeneration',
                                     Compiletime(UtilsLib.Icon.BTNRegenerate),
                                     0, 10^10, 0)

Defines.Mana = Parameter.new('MP', 'Mana',
                             Compiletime(UtilsLib.Icon.BTNManaStone),
                             0, 10^10, 0)

Defines.MoveSpeed = Parameter.new('MS', 'Move speed',
                                  Compiletime(UtilsLib.Icon.BTNBootsOfSpeed),
                                  0, 500, 250)

return Defines