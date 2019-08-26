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
---| '"PriorityforSpellSteal"'
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
function ChannelCompiletimeData.new()
    local data = {}
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
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end

    self["Id"] = WeObjEdit.Utils.nextAbilId()
    self["OrderId"] = WeObjEdit.Utils.nextOrderId()

    local abil = WeObjEdit.Ability.Channel.new(self["Id"])
    local max_lvl = 1
    if self["Levels"] then max_lvl = self["Levels"] end
    abil:setLevels(max_lvl)

    if self["Name"] then abil:setName(self["Name"]) end
    if self["EditorSuffix"] then abil:setEditorSuffix(self["EditorSuffix"]) end
    if self["HeroAbility"] then abil:setHeroAbility(self["HeroAbility"]) end
    if self["ItemAbility"] then abil:setItemAbility(self["ItemAbility"]) end
    if self["Race"] then abil:setRace(self["Race"]) end
    if self["ButtonPositionNormalX"] then abil:setButtonPositionNormalX(self["ButtonPositionNormalX"]) end
    if self["ButtonPositionNormalY"] then abil:setButtonPositionNormalY(self["ButtonPositionNormalY"]) end
    if self["ButtonPositionTurnOffX"] then abil:setButtonPositionTurnOffX(self["ButtonPositionTurnOffX"]) end
    if self["ButtonPositionTurnOffY"] then abil:setButtonPositionTurnOffY(self["ButtonPositionTurnOffY"]) end
    if self["ButtonPositionResearchX"] then abil:setButtonPositionResearchX(self["ButtonPositionResearchX"]) end
    if self["ButtonPositionResearchY"] then abil:setButtonPositionResearchY(self["ButtonPositionResearchY"]) end
    if self["IconNormal"] then abil:setIconNormal(self["IconNormal"]) end
    if self["IconTurnOff"] then abil:setIconTurnOff(self["IconTurnOff"]) end
    if self["IconResearch"] then abil:setIconResearch(self["IconResearch"]) end
    if self["ArtCaster"] then abil:setArtCaster(self["ArtCaster"]) end
    if self["ArtTarget"] then abil:setArtTarget(self["ArtTarget"]) end
    if self["ArtSpecial"] then abil:setArtSpecial(self["ArtSpecial"]) end
    if self["ArtEffect"] then abil:setArtEffect(self["ArtEffect"]) end
    if self["AreaEffect"] then abil:setAreaEffect(self["AreaEffect"]) end
    if self["LightningEffects"] then abil:setLightningEffects(self["LightningEffects"]) end
    if self["MissileArt"] then abil:setMissileArt(self["MissileArt"]) end
    if self["MissileSpeed"] then abil:setMissileSpeed(self["MissileSpeed"]) end
    if self["MissileArc"] then abil:setMissileArc(self["MissileArc"]) end
    if self["MissileHomingEnabled"] then abil:setMissileHomingEnabled(self["MissileHomingEnabled"]) end
    if self["TargetAttachments"] then abil:setTargetAttachments(self["TargetAttachments"]) end
    if self["TargetAttachmentPoint"] then abil:setTargetAttachmentPoint(self["TargetAttachmentPoint"]) end
    if self["TargetAttachmentPoint1"] then abil:setTargetAttachmentPoint1(self["TargetAttachmentPoint1"]) end
    if self["TargetAttachmentPoint2"] then abil:setTargetAttachmentPoint2(self["TargetAttachmentPoint2"]) end
    if self["TargetAttachmentPoint3"] then abil:setTargetAttachmentPoint3(self["TargetAttachmentPoint3"]) end
    if self["TargetAttachmentPoint4"] then abil:setTargetAttachmentPoint4(self["TargetAttachmentPoint4"]) end
    if self["TargetAttachmentPoint5"] then abil:setTargetAttachmentPoint5(self["TargetAttachmentPoint5"]) end
    if self["CasterAttachments"] then abil:setCasterAttachments(self["CasterAttachments"]) end
    if self["CasterAttachmentPoint"] then abil:setCasterAttachmentPoint(self["CasterAttachmentPoint"]) end
    if self["CasterAttachmentPoint1"] then abil:setCasterAttachmentPoint1(self["CasterAttachmentPoint1"]) end
    if self["SpecialAttachmentPoint"] then abil:setSpecialAttachmentPoint(self["SpecialAttachmentPoint"]) end
    if self["AnimationNames"] then abil:setAnimationNames(self["AnimationNames"]) end
    if self["TooltipLearn"] then abil:setTooltipLearn(self["TooltipLearn"]) end
    if self["TooltipLearnExtended"] then abil:setTooltipLearnExtended(self["TooltipLearnExtended"]) end
    if self["HotkeyLearn"] then abil:setHotkeyLearn(self["HotkeyLearn"]) end
    if self["HotkeyNormal"] then abil:setHotkeyNormal(self["HotkeyNormal"]) end
    if self["HotkeyTurnOff"] then abil:setHotkeyTurnOff(self["HotkeyTurnOff"]) end
    if self["Requirements"] then abil:setRequirements(self["Requirements"]) end
    if self["RequirementsLevels"] then abil:setRequirementsLevels(self["RequirementsLevels"]) end
    if self["CheckDependencies"] then abil:setCheckDependencies(self["CheckDependencies"]) end
    if self["PriorityforSpellSteal"] then abil:setPriorityforSpellSteal(self["PriorityforSpellSteal"]) end
    if self["OrderStringUseTurnOn"] then abil:setOrderStringUseTurnOn(self["OrderStringUseTurnOn"]) end
    if self["OrderStringTurnOff"] then abil:setOrderStringTurnOff(self["OrderStringTurnOff"]) end
    if self["OrderStringActivate"] then abil:setOrderStringActivate(self["OrderStringActivate"]) end
    if self["OrderStringDeactivate"] then abil:setOrderStringDeactivate(self["OrderStringDeactivate"]) end
    if self["EffectSound"] then abil:setEffectSound(self["EffectSound"]) end
    if self["EffectSoundLooping"] then abil:setEffectSoundLooping(self["EffectSoundLooping"]) end
    if self["Levels"] then abil:setLevels(self["Levels"]) end
    if self["RequiredLevel"] then abil:setRequiredLevel(self["RequiredLevel"]) end
    if self["LevelSkipRequirement"] then abil:setLevelSkipRequirement(self["LevelSkipRequirement"]) end

    for lvl = 1, max_lvl do
        abil:setBaseOrderID(self["OrderId"], lvl)

        if self["TooltipNormal"] then abil:setTooltipNormal(self["TooltipNormal"], lvl) end
        if self["TooltipTurnOff"] then abil:setTooltipTurnOff(self["TooltipTurnOff"], lvl) end
        if self["TooltipNormalExtended"] then abil:setTooltipNormalExtended(self["TooltipNormalExtended"], lvl) end
        if self["TooltipTurnOffExtended"] then abil:setTooltipTurnOffExtended(self["TooltipTurnOffExtended"], lvl) end
        if self["TargetsAllowed"] then abil:setTargetsAllowed(self["TargetsAllowed"], lvl) end
        if self["CastingTime"] then abil:setCastingTime(self["CastingTime"], lvl) end
        if self["DurationNormal"] then abil:setDurationNormal(self["DurationNormal"], lvl) end
        if self["DurationHero"] then abil:setDurationHero(self["DurationHero"], lvl) end
        if self["Cooldown"] then abil:setCooldown(self["Cooldown"], lvl) end
        if self["ManaCost"] then abil:setManaCost(self["ManaCost"], lvl) end
        if self["AreaofEffect"] then abil:setAreaofEffect(self["AreaofEffect"], lvl) end
        if self["CastRange"] then abil:setCastRange(self["CastRange"], lvl) end
        if self["Buffs"] then abil:setBuffs(self["Buffs"], lvl) end
        if self["Effects"] then abil:setEffects(self["Effects"], lvl) end
        if self["ArtDuration"] then abil:setArtDuration(self["ArtDuration"], lvl) end
        if self["BaseOrderID"] then abil:setBaseOrderID(self["BaseOrderID"], lvl) end
        if self["DisableOtherAbilities"] then abil:setDisableOtherAbilities(self["DisableOtherAbilities"], lvl) end
        if self["FollowThroughTime"] then abil:setFollowThroughTime(self["FollowThroughTime"], lvl) end
        if self["TargetType"] then abil:setTargetType(self["TargetType"], lvl) end
        if self["Options"] then abil:setOptions(self["Options"], lvl) end
    end

    return self["Id"]
end

return ChannelCompiletimeData