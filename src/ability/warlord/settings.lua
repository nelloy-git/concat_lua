---@class WarlordAbilitiesSettings
local WarlordSettings = compiletime(function()
    ---@type ChannelCompiletimeData
    local AbilityData = require('ability.ChannelCompiletimeData')
    ---@type HeroCompiletimeData
    local HeroData = require('unit.HeroCompiletimeData')
    -- ================= --
    --  Summon spearman  --
    -- ================= --
    local SummonSpearmanData = AbilityData.new()
    SummonSpearmanData:setField("Name", "Summon spearman")
    SummonSpearmanData:setField("TooltipNormal", "Summon spearman")
    SummonSpearmanData:setField("TooltipNormalExtended", "Summons invulnerale spirit warrior.")
    SummonSpearmanData:setField("CastRange", 500)
    SummonSpearmanData:setField("AreaofEffect", 150)
    SummonSpearmanData:setField("Cooldown", 0)
    SummonSpearmanData:setField("CastingTime", 0)
    SummonSpearmanData:setField("CustomCastingTime", 3)
    SummonSpearmanData:setField("HotkeyNormal", "X")
    SummonSpearmanData:setField("ArtCaster", "")
    SummonSpearmanData:setField("ArtEffect", "")
    SummonSpearmanData:setField("ArtSpecial", "")
    SummonSpearmanData:setField("ArtTarget", "")
    SummonSpearmanData:setField("Levels", 1)
    SummonSpearmanData:setField("Options", AbilityData.option.is_visible + AbilityData.option.is_areaTarget)
    SummonSpearmanData:setField("TargetType", "point")
    SummonSpearmanData:setField("DisableOtherAbilities", false)
    SummonSpearmanData:setField("FollowThroughTime", 0)
    SummonSpearmanData:generate()

    local SpearmanData = HeroData.new()
    SpearmanData:setField("Name", "Spearman")
    SpearmanData:setField("ModelFile", "war3mapImported\\\\units\\\\SwordNya.mdx")
    SpearmanData:setField("NormalAbilities", "Avul,Aloc")
    SpearmanData:setField("SpeedBase", 1)
    SpearmanData:setField("CollisionSize", 0)
    SpearmanData:setField("HideHeroDeathMsg", true)
    SpearmanData:setField("HideHeroInterfaceIcon", true)
    SpearmanData:setField("HideHeroMinimapDisplay", true)
    SpearmanData:generate("Hpal")

    -- ============= --
    --  Spirit rush  --
    -- ============= --
    local SpiritRushData = AbilityData.new()
    SpiritRushData:setField("Name", "Spirit rush")
    SpiritRushData:setField("TooltipNormal", "Spirit rush")
    SpiritRushData:setField("TooltipNormalExtended", "All summoned spirits attack target area.")
    SpiritRushData:setField("CastRange", 500)
    SpiritRushData:setField("AreaofEffect", 150)


    -- Save settings --
    local settings = {
        SummonSpearman = SummonSpearmanData,
        SpearmanUnit = SpearmanData
    }
    return settings
end)

return WarlordSettings