local ParameterType = require('Class.ParameterType.Main')

local Icon = {}

Icon[ParameterType.Id.P_DMG] = "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp"
Icon[ParameterType.Id.ATKS_PER_SEC] = "ReplaceableTextures\\CommandButtons\\BTNCommand.blp"
Icon[ParameterType.Id.ARMOR] = "ReplaceableTextures\\CommandButtons\\BTNDefend.blp"
Icon[ParameterType.Id.P_DMG_REDUC] = "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpThree.blp"
Icon[ParameterType.Id.M_DMG] = "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheMoon.blp"
Icon[ParameterType.Id.CAST_TIME_REDUC] = "ReplaceableTextures\\CommandButtons\\BTNBansheeMaster.blp"
Icon[ParameterType.Id.RESIST] = "ReplaceableTextures\\CommandButtons\\BTNResistantSkin.blp"
Icon[ParameterType.Id.M_DMG_REDUC] = "ReplaceableTextures\\CommandButtons\\BTNLightningShield.blp"
Icon[ParameterType.Id.DODGE_CH] = "ReplaceableTextures\\CommandButtons\\BTNEvasion.blp"
Icon[ParameterType.Id.CRIT_CH] = "ReplaceableTextures\\CommandButtons\\BTNCriticalStrike.blp"
Icon[ParameterType.Id.CRIT_DMG] = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp"
Icon[ParameterType.Id.CD_REDUC] = "ReplaceableTextures\\CommandButtons\\BTNDispelMagic.blp"
Icon[ParameterType.Id.HP] = "ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp"
Icon[ParameterType.Id.REGEN] = "ReplaceableTextures\\CommandButtons\\BTNRegenerate.blp"
Icon[ParameterType.Id.MP] = "ReplaceableTextures\\CommandButtons\\BTNManaStone.blp"
Icon[ParameterType.Id.RECOV] = "ReplaceableTextures\\CommandButtons\\BTNBrilliance.blp"
Icon[ParameterType.Id.STR] = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-str.blp"
Icon[ParameterType.Id.AGI] = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-agi.blp"
Icon[ParameterType.Id.INT] = "UI\\Widgets\\Console\\Human\\infocard-heroattributes-int.blp"
Icon[ParameterType.Id.MS] = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp"

---@return string
function ParameterType:getIcon()
    return Icon[self.__id]
end