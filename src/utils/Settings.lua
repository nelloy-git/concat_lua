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
        maximum_physical_damage_reduction = 0.75,
        maximum_magical_damage_reduction = 0.75,
        maximum_casting_speed = 0.75,
        maximum_dodge_chance = 0.75,
        maximum_crit_chance = 0.75,
        maximum_cooldown_reduction = 0.75,

        attack_damage_per_str = 1,
        health_per_str = 5,
        armor_per_str = 0.25,

        attack_speed_per_agi = 0.25,
        casting_time_reduction_per_agi = 0.25,
        dodge_chance_per_agi = 0.25,

        spell_damage_per_int = 1,
        cooldown_reduction_per_int = 0.25,
        mana_per_int = 5
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
        Unit = true,
        Player = true,
        Ability = true,
        VerboseAbility = true
    }
}

return Settings