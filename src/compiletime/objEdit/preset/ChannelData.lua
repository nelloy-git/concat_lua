---@class ChannelCompiletimeData
local ChannelCompiletimeData = {}
local ChannelCompiletimeData_meta = {__index = ChannelCompiletimeData}

---@alias ChannelParameter string
---| '"Id"'
---| '"OrderId"'
---| '"Name"'
---| '"EditorSuffix"'
---| '"HeroAbility"'
---| '"ItemAbility"'
---| '"Race"'
---| '"ButtonPositionNormalX"'
---| '"ButtonPositionNormalY"'
---| '"ButtonPositionTurnOffX"'
---| '"ButtonPositionTurnOffY"'
---| '"ButtonPositionResearchX"'
---| '"ButtonPositionResearchY"'
---| '"IconNormal"'
---| '"IconTurnOff"'
---| '"IconResearch"'
---| '"ArtCaster"'
---| '"ArtTarget"'
---| '"ArtSpecial"'
---| '"ArtEffect"'
---| '"AreaEffect"'
---| '"LightningEffects"'
---| '"MissileArt"'
---| '"MissileSpeed"'
---| '"MissileArc"'
---| '"MissileHomingEnabled"'
---| '"TargetAttachments"'
---| '"TargetAttachmentPoint"'
---| '"TargetAttachmentPoint1"'
---| '"TargetAttachmentPoint2"'
---| '"TargetAttachmentPoint3"'
---| '"TargetAttachmentPoint4"'
---| '"TargetAttachmentPoint5"'
---| '"CasterAttachments"'
---| '"CasterAttachmentPoint"'
---| '"CasterAttachmentPoint1"'
---| '"SpecialAttachmentPoint"'
---| '"AnimationNames"'
---| '"TooltipNormal"'
---| '"TooltipTurnOff"'
---| '"TooltipNormalExtended"'
---| '"TooltipTurnOffExtended"'
---| '"TooltipLearn"'
---| '"TooltipLearnExtended"'
---| '"HotkeyLearn"'
---| '"HotkeyNormal"'
---| '"HotkeyTurnOff"'
---| '"Requirements"'
---| '"RequirementsLevels"'
---| '"CheckDependencies"'
---| '"PriorityForSpellSteal"'
---| '"OrderStringUseTurnOn"'
---| '"OrderStringTurnOff"'
---| '"OrderStringActivate"'
---| '"OrderStringDeactivate"'
---| '"EffectSound"'
---| '"EffectSoundLooping"'
---| '"Levels"'
---| '"RequiredLevel"'
---| '"LevelSkipRequirement"'
---| '"TargetsAllowed"'
---| '"CastingTime"'
---| '"DurationNormal"'
---| '"DurationHero"'
---| '"Cooldown"'
---| '"ManaCost"'
---| '"AreaofEffect"'
---| '"CastRange"'
---| '"Buffs"'
---| '"Effects"'
---| '"ArtDuration"'
---| '"BaseOrderID"'
---| '"DisableOtherAbilities"'
---| '"FollowThroughTime"'
---| '"TargetType"'
---| '"Options"'

ChannelCompiletimeData.option = {
    is_visible = 1,
    is_areaTarget = 2,
    is_matereal = 4,
    is_universal = 8,
    is_group = 16
}

---@return ChannelCompiletimeData
---@param src ChannelCompiletimeData | nil
function ChannelCompiletimeData.new(src)
    local data = {}
    if src ~= nil then
        for k, v in pairs(src) do
            data[k] = v
        end
    end
    setmetatable(data, ChannelCompiletimeData_meta)
    return data
end

---@param name ChannelParameter
---@param value any
---@return nil
function ChannelCompiletimeData:setField(name, value)
    self[name] = value
end

---@param name ChannelParameter
---@return any
function ChannelCompiletimeData:getField(name)
    return self[name]
end

---@return integer
function ChannelCompiletimeData:generate()
    local WeObjEdit = require('compiletime.objEdit.objEdit')

    self["Id"] = WeObjEdit.Utils.nextAbilityId()
    self["OrderId"] = WeObjEdit.Utils.nextOrderId()

    local ability = WeObjEdit.Ability.Channel.new(self["Id"])
    local max_lvl = 1
    if self["Levels"] then max_lvl = self["Levels"] end
    ability:setLevels(max_lvl)

    if self["Name"] then ability:setName(self["Name"]) end
    if self["EditorSuffix"] then ability:setEditorSuffix(self["EditorSuffix"]) end
    if self["HeroAbility"] then ability:setHeroAbility(self["HeroAbility"]) end
    if self["ItemAbility"] then ability:setItemAbility(self["ItemAbility"]) end
    if self["Race"] then ability:setRace(self["Race"]) end
    if self["ButtonPositionNormalX"] then ability:setButtonPositionNormalX(self["ButtonPositionNormalX"]) end
    if self["ButtonPositionNormalY"] then ability:setButtonPositionNormalY(self["ButtonPositionNormalY"]) end
    if self["ButtonPositionTurnOffX"] then ability:setButtonPositionTurnOffX(self["ButtonPositionTurnOffX"]) end
    if self["ButtonPositionTurnOffY"] then ability:setButtonPositionTurnOffY(self["ButtonPositionTurnOffY"]) end
    if self["ButtonPositionResearchX"] then ability:setButtonPositionResearchX(self["ButtonPositionResearchX"]) end
    if self["ButtonPositionResearchY"] then ability:setButtonPositionResearchY(self["ButtonPositionResearchY"]) end
    if self["IconNormal"] then ability:setIconNormal(self["IconNormal"]) end
    if self["IconTurnOff"] then ability:setIconTurnOff(self["IconTurnOff"]) end
    if self["IconResearch"] then ability:setIconResearch(self["IconResearch"]) end
    if self["ArtCaster"] then ability:setArtCaster(self["ArtCaster"]) end
    if self["ArtTarget"] then ability:setArtTarget(self["ArtTarget"]) end
    if self["ArtSpecial"] then ability:setArtSpecial(self["ArtSpecial"]) end
    if self["ArtEffect"] then ability:setArtEffect(self["ArtEffect"]) end
    if self["AreaEffect"] then ability:setAreaEffect(self["AreaEffect"]) end
    if self["LightningEffects"] then ability:setLightningEffects(self["LightningEffects"]) end
    if self["MissileArt"] then ability:setMissileArt(self["MissileArt"]) end
    if self["MissileSpeed"] then ability:setMissileSpeed(self["MissileSpeed"]) end
    if self["MissileArc"] then ability:setMissileArc(self["MissileArc"]) end
    if self["MissileHomingEnabled"] then ability:setMissileHomingEnabled(self["MissileHomingEnabled"]) end
    if self["TargetAttachments"] then ability:setTargetAttachments(self["TargetAttachments"]) end
    if self["TargetAttachmentPoint"] then ability:setTargetAttachmentPoint(self["TargetAttachmentPoint"]) end
    if self["TargetAttachmentPoint1"] then ability:setTargetAttachmentPoint1(self["TargetAttachmentPoint1"]) end
    if self["TargetAttachmentPoint2"] then ability:setTargetAttachmentPoint2(self["TargetAttachmentPoint2"]) end
    if self["TargetAttachmentPoint3"] then ability:setTargetAttachmentPoint3(self["TargetAttachmentPoint3"]) end
    if self["TargetAttachmentPoint4"] then ability:setTargetAttachmentPoint4(self["TargetAttachmentPoint4"]) end
    if self["TargetAttachmentPoint5"] then ability:setTargetAttachmentPoint5(self["TargetAttachmentPoint5"]) end
    if self["CasterAttachments"] then ability:setCasterAttachments(self["CasterAttachments"]) end
    if self["CasterAttachmentPoint"] then ability:setCasterAttachmentPoint(self["CasterAttachmentPoint"]) end
    if self["CasterAttachmentPoint1"] then ability:setCasterAttachmentPoint1(self["CasterAttachmentPoint1"]) end
    if self["SpecialAttachmentPoint"] then ability:setSpecialAttachmentPoint(self["SpecialAttachmentPoint"]) end
    if self["AnimationNames"] then ability:setAnimationNames(self["AnimationNames"]) end
    if self["TooltipLearn"] then ability:setTooltipLearn(self["TooltipLearn"]) end
    if self["TooltipLearnExtended"] then ability:setTooltipLearnExtended(self["TooltipLearnExtended"]) end
    if self["HotkeyLearn"] then ability:setHotkeyLearn(self["HotkeyLearn"]) end
    if self["HotkeyNormal"] then ability:setHotkeyNormal(self["HotkeyNormal"]) end
    if self["HotkeyTurnOff"] then ability:setHotkeyTurnOff(self["HotkeyTurnOff"]) end
    if self["Requirements"] then ability:setRequirements(self["Requirements"]) end
    if self["RequirementsLevels"] then ability:setRequirementsLevels(self["RequirementsLevels"]) end
    if self["CheckDependencies"] then ability:setCheckDependencies(self["CheckDependencies"]) end
    if self["PriorityForSpellSteal"] then ability:setPriorityForSpellSteal(self["PriorityForSpellSteal"]) end
    if self["OrderStringUseTurnOn"] then ability:setOrderStringUseTurnOn(self["OrderStringUseTurnOn"]) end
    if self["OrderStringTurnOff"] then ability:setOrderStringTurnOff(self["OrderStringTurnOff"]) end
    if self["OrderStringActivate"] then ability:setOrderStringActivate(self["OrderStringActivate"]) end
    if self["OrderStringDeactivate"] then ability:setOrderStringDeactivate(self["OrderStringDeactivate"]) end
    if self["EffectSound"] then ability:setEffectSound(self["EffectSound"]) end
    if self["EffectSoundLooping"] then ability:setEffectSoundLooping(self["EffectSoundLooping"]) end
    if self["Levels"] then ability:setLevels(self["Levels"]) end
    if self["RequiredLevel"] then ability:setRequiredLevel(self["RequiredLevel"]) end
    if self["LevelSkipRequirement"] then ability:setLevelSkipRequirement(self["LevelSkipRequirement"]) end

    for lvl = 1, max_lvl do
        ability:setBaseOrderID(self["OrderId"], lvl)

        if self["TooltipNormal"] then ability:setTooltipNormal(self["TooltipNormal"], lvl) end
        if self["TooltipTurnOff"] then ability:setTooltipTurnOff(self["TooltipTurnOff"], lvl) end
        if self["TooltipNormalExtended"] then ability:setTooltipNormalExtended(self["TooltipNormalExtended"], lvl) end
        if self["TooltipTurnOffExtended"] then ability:setTooltipTurnOffExtended(self["TooltipTurnOffExtended"], lvl) end
        if self["TargetsAllowed"] then ability:setTargetsAllowed(self["TargetsAllowed"], lvl) end
        if self["CastingTime"] then ability:setCastingTime(self["CastingTime"], lvl) end
        if self["DurationNormal"] then ability:setDurationNormal(self["DurationNormal"], lvl) end
        if self["DurationHero"] then ability:setDurationHero(self["DurationHero"], lvl) end
        if self["Cooldown"] then ability:setCooldown(self["Cooldown"], lvl) end
        if self["ManaCost"] then ability:setManaCost(self["ManaCost"], lvl) end
        if self["AreaofEffect"] then ability:setAreaofEffect(self["AreaofEffect"], lvl) end
        if self["CastRange"] then ability:setCastRange(self["CastRange"], lvl) end
        if self["Buffs"] then ability:setBuffs(self["Buffs"], lvl) end
        if self["Effects"] then ability:setEffects(self["Effects"], lvl) end
        if self["ArtDuration"] then ability:setArtDuration(self["ArtDuration"], lvl) end
        if self["BaseOrderID"] then ability:setBaseOrderID(self["BaseOrderID"], lvl) end
        if self["DisableOtherAbilities"] then ability:setDisableOtherAbilities(self["DisableOtherAbilities"], lvl) end
        if self["FollowThroughTime"] then ability:setFollowThroughTime(self["FollowThroughTime"], lvl) end
        if self["TargetType"] then ability:setTargetType(self["TargetType"], lvl) end
        if self["Options"] then ability:setOptions(self["Options"], lvl) end
    end

    return self["Id"]
end

return ChannelCompiletimeData