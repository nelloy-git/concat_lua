

local WarlordSettings = compiletime(function()
    local CTF = require('ability.warlord.compiletime') --CompiletimeFunctions

    local function buildAbilityTable(compiletimFunction, name, tooltip, castRange, targetingArea, castingTime, cooldown, hotkey)
        return {
            Id = compiletimFunction(name, tooltip, castRange, targetingArea, castingTime, cooldown, hotkey),
            Name = name,
            Tooltip = tooltip,
            CastRange = castRange,
            TargetingArea = targetingArea,
            CastingTime = castingTime,
            Cooldown = cooldown,
            HotKey = hotkey,
        }
    end

    -- ================= --
    --  Summon spearman  --
    -- ================= --
    local summonSpearmanSettings =
    buildAbilityTable  (CTF.generateSummonSpearmanAbility,          -- Ability generator
                        'Summon spearman',                          -- Name
                        'Summons invulnerale spirit warrior.',      -- Tooltip
                        500,                                        -- CastRange
                        150,                                        -- TargetingArea
                        0,                                          -- CastingTime
                        0,                                          -- Cooldown
                        'X')                                        -- HotKey

    -- ============= --
    --  Spirit rush  --
    -- ============= --

    local settings = {
        Ability1 = summonSpearmanSettings
    }
    return settings 
end)
return WarlordSettings