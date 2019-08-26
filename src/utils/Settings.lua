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
    -- ================= --
    --  Unit parameters  --
    -- ================= --
    UnitParameters = {
        attack_dispersion = 0.15,
        value_to_get_half_cap_for_percent_value = 500
    },
    -- ======== --
    --  Events  --
    -- ======== --
    EnabledEvents = {
        Unit = true,
        Player = true
    }
}

return Settings