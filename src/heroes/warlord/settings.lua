---@class WarlordAbilitiesSettings
local WarlordSettings = compiletime(function()
    local WeObjEdit = require('compiletime.objEdit.objEdit')
    local Channel = WeObjEdit.Preset.Channel
    local Hero = WeObjEdit.Preset.Hero
    -- ================= --
    --  Summon spearman  --
    -- ================= --
    ---@type ChannelCompiletimeData
    local SummonSpearmanData = Channel.new()
    SummonSpearmanData:setField("Name", "SummonSpearman")
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
    SummonSpearmanData:setField("AnimationNames", "")
    SummonSpearmanData:setField("Levels", 1)
    SummonSpearmanData:setField("Options", Channel.option.is_visible + Channel.option.is_areaTarget)
    SummonSpearmanData:setField("TargetType", "point")
    SummonSpearmanData:setField("DisableOtherAbilities", false)
    SummonSpearmanData:setField("FollowThroughTime", 0)
    SummonSpearmanData:generate()

    ---@type HeroCompiletimeData
    local SwordmanData = Hero.new()
    SwordmanData:setField("Name", "Spearman")
    SwordmanData:setField("ModelFile", "war3mapImported\\units\\SwordNya.mdx")
    SwordmanData:setField("NormalAbilities", "Avul,Aloc")
    SwordmanData:setField("SpeedBase", 1)
    SwordmanData:setField("CollisionSize", 0)
    SwordmanData:setField("HideHeroDeathMsg", true)
    SwordmanData:setField("HideHeroInterfaceIcon", true)
    SwordmanData:setField("HideHeroMinimapDisplay", true)
    SwordmanData:generate("Hpal")

    -- ============= --
    --  Spirit rush  --
    -- ============= --
    local SpiritRushData = Channel.new()
    SpiritRushData:setField("Name", "Spirit rush")
    SpiritRushData:setField("TooltipNormal", "Spirit rush")
    SpiritRushData:setField("TooltipNormalExtended", "All summoned spirits attack target area.")
    SpiritRushData:setField("TargetType", "point")
    SpiritRushData:setField("CastRange", 500)


    -- Save settings --
    local settings = {
        SummonSpearman = SummonSpearmanData,
        SwordmanUnit = SwordmanData
    }
    return settings
end)

return WarlordSettings