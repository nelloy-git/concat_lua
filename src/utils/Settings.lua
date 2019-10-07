---@class Settings
local Settings = {
    debug = true,
    -- ======= --
    --  Timer  --
    -- ======= --
    Timer = {
        glTimer_period = 0.03125,
        run_test = false,
    },
    -- ====== --
    --  Unit  --
    -- ====== --
    Unit = {
        DebugCreationFunctions = true,
        DebugRemovalFunctions = true,

        attack_dispersion = 0.15,

        StartingParameter = {
            P_DMG = 1,
            ATKS_PER_SEC = 2,
            ARMOR = 0,
            P_DMG_REDUC = 0,
            M_DMG = 0,
            CAST_TIME_REDUC = 0,
            RESIST = 0,
            M_DMG_REDUC = 0,
            DODGE_CH = 0,
            CRIT_CH = 0,
            CRIT_DMG = 1.5,
            CD_REDUC = 0,
            HP = 100,
            REGEN = 0,
            MP = 50,
            RECOV = 0,
            STR = 0,
            AGI = 0,
            INT = 0,
            MS = 250,
        },

        base_attacks_per_sec = 2,
        base_crit_damage = 1.5,
        base_health = 100,
        maximum_attack_speed = 10,
        maximum_physical_damage_reduction = 0.75,
        maximum_magical_damage_reduction = 0.75,
        maximum_casting_time_reduction = 0.75,
        maximum_dodge_chance = 0.75,
        maximum_crit_chance = 0.75,
        maximum_cooldown_reduction = 0.75,

        p_dmg_per_str = 1,
        health_per_str = 5,
        armor_per_str = 0.25,

        attack_speed_per_agi = 0.01,
        casting_time_reduction_per_agi = 0.25,
        dodge_chance_per_agi = 0.25,

        m_dmg_per_int = 1,
        mana_per_int = 5,
        cooldown_reduction_per_int = 0.25,
    },
    -- =============
    --  DamageTypes
    -- =============
    DamageType = {
        Physic = DAMAGE_TYPE_NORMAL,
        Magic = DAMAGE_TYPE_MAGIC,
        Chaos = DAMAGE_TYPE_UNKNOWN
    },
    -- ======== --
    --  Events  --
    -- ======== --
    Events = {
        VerboseAbilityTargeting = true,
        VerboseAbilityCasting = true
    }
}

return Settings