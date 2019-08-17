---@class AbilityField
local AbilityField = {
    Integer = {
        ABILITY_IF_BUTTON_POSITION_NORMAL_X = true,
        ABILITY_IF_BUTTON_POSITION_NORMAL_Y = true,
        ABILITY_IF_BUTTON_POSITION_ACTIVATED_X = true,
        ABILITY_IF_BUTTON_POSITION_ACTIVATED_Y = true,
        ABILITY_IF_BUTTON_POSITION_RESEARCH_X = true,
        ABILITY_IF_BUTTON_POSITION_RESEARCH_Y = true,
        ABILITY_IF_MISSILE_SPEED = true,
        ABILITY_IF_TARGET_ATTACHMENTS = true,
        ABILITY_IF_CASTER_ATTACHMENTS = true,
        ABILITY_IF_PRIORITY = true,
        ABILITY_IF_LEVELS = true,
        ABILITY_IF_REQUIRED_LEVEL = true,
        ABILITY_IF_LEVEL_SKIP_REQUIREMENT = true,
    },
    Real = {
        ABILITY_RF_ARF_MISSILE_ARC = true
    },
    Boolean = {
        ABILITY_BF_HERO_ABILITY = true,  --Get only.
        ABILITY_BF_ITEM_ABILITY = true,
        ABILITY_BF_CHECK_DEPENDENCIES = true,
    },
    String = {
        ABILITY_SF_NAME = true, -- Get only
        ABILITY_SF_ICON_ACTIVATED = true,
        ABILITY_SF_ICON_RESEARCH = true,
        ABILITY_SF_EFFECT_SOUND = true,
        ABILITY_SF_EFFECT_SOUND_LOOPING = true,
    },
    IntegerLevel = {
        ABILITY_ILF_MANA_COST = true,
        ABILITY_ILF_NUMBER_OF_WAVES = true,
        ABILITY_ILF_NUMBER_OF_SHARDS = true,
        ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED = true,
        ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2 = true,
        ABILITY_ILF_NUMBER_OF_IMAGES = true,
        ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1 = true,
        ABILITY_ILF_MORPHING_FLAGS = true,
        ABILITY_ILF_STRENGTH_BONUS_NRG5 = true,
        ABILITY_ILF_DEFENSE_BONUS_NRG6 = true,
        ABILITY_ILF_NUMBER_OF_TARGETS_HIT = true,
        ABILITY_ILF_DETECTION_TYPE_OFS1 = true,
        ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_OSF2 = true,
        ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_EFN1 = true,
        ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1 = true,
        ABILITY_ILF_STACK_FLAGS = true,
        ABILITY_ILF_MINIMUM_NUMBER_OF_UNITS = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_NDP3 = true,
        ABILITY_ILF_NUMBER_OF_UNITS_CREATED_NRC2 = true,
        ABILITY_ILF_SHIELD_LIFE = true,
        ABILITY_ILF_MANA_LOSS_AMS4 = true,
        ABILITY_ILF_GOLD_PER_INTERVAL_BGM1 = true,
        ABILITY_ILF_MAX_NUMBER_OF_MINERS = true,
        ABILITY_ILF_CARGO_CAPACITY = true,
        ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3 = true,
        ABILITY_ILF_MAX_CREEP_LEVEL_DEV1 = true,
        ABILITY_ILF_GOLD_PER_INTERVAL_EGM1 = true,
        ABILITY_ILF_DEFENSE_REDUCTION = true,
        ABILITY_ILF_DETECTION_TYPE_FLA1 = true,
        ABILITY_ILF_FLARE_COUNT = true,
        ABILITY_ILF_MAX_GOLD = true,
        ABILITY_ILF_MINING_CAPACITY = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_GYD1 = true,
        ABILITY_ILF_DAMAGE_TO_TREE = true,
        ABILITY_ILF_LUMBER_CAPACITY = true,
        ABILITY_ILF_GOLD_CAPACITY = true,
        ABILITY_ILF_DEFENSE_INCREASE_INF2 = true,
        ABILITY_ILF_INTERACTION_TYPE = true,
        ABILITY_ILF_GOLD_COST_NDT1 = true,
        ABILITY_ILF_LUMBER_COST_NDT2 = true,
        ABILITY_ILF_DETECTION_TYPE_NDT3 = true,
        ABILITY_ILF_STACKING_TYPE_POI4 = true,
        ABILITY_ILF_STACKING_TYPE_POA5 = true,
        ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1 = true,
        ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1 = true,
        ABILITY_ILF_MOVEMENT_UPDATE_FREQUENCY_PRG1 = true,
        ABILITY_ILF_ATTACK_UPDATE_FREQUENCY_PRG2 = true,
        ABILITY_ILF_MANA_LOSS_PRG6 = true,
        ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE = true,
        ABILITY_ILF_UNITS_SUMMONED_TYPE_TWO = true,
        ABILITY_ILF_MAX_UNITS_SUMMONED = true,
        ABILITY_ILF_ALLOW_WHEN_FULL_REJ3 = true,
        ABILITY_ILF_MAXIMUM_UNITS_CHARGED_TO_CASTER = true,
        ABILITY_ILF_MAXIMUM_UNITS_AFFECTED = true,
        ABILITY_ILF_DEFENSE_INCREASE_ROA2 = true,
        ABILITY_ILF_MAX_UNITS_ROA7 = true,
        ABILITY_ILF_ROOTED_WEAPONS = true,
        ABILITY_ILF_UPROOTED_WEAPONS = true,
        ABILITY_ILF_UPROOTED_DEFENSE_TYPE = true,
        ABILITY_ILF_ACCUMULATION_STEP = true,
        ABILITY_ILF_NUMBER_OF_OWLS = true,
        ABILITY_ILF_STACKING_TYPE_SPO4 = true,
        ABILITY_ILF_NUMBER_OF_UNITS = true,
        ABILITY_ILF_SPIDER_CAPACITY = true,
        ABILITY_ILF_INTERVALS_BEFORE_CHANGING_TREES = true,
        ABILITY_ILF_AGILITY_BONUS = true,
        ABILITY_ILF_INTELLIGENCE_BONUS = true,
        ABILITY_ILF_STRENGTH_BONUS_ISTR = true,
        ABILITY_ILF_ATTACK_BONUS = true,
        ABILITY_ILF_DEFENSE_BONUS_IDEF = true,
        ABILITY_ILF_SUMMON_1_AMOUNT = true,
        ABILITY_ILF_SUMMON_2_AMOUNT = true,
        ABILITY_ILF_EXPERIENCE_GAINED = true,
        ABILITY_ILF_HIT_POINTS_GAINED_IHPG = true,
        ABILITY_ILF_MANA_POINTS_GAINED_IMPG = true,
        ABILITY_ILF_HIT_POINTS_GAINED_IHP2 = true,
        ABILITY_ILF_MANA_POINTS_GAINED_IMP2 = true,
        ABILITY_ILF_DAMAGE_BONUS_DICE = true,
        ABILITY_ILF_ARMOR_PENALTY_IARP = true,
        ABILITY_ILF_ENABLED_ATTACK_INDEX_IOB5 = true,
        ABILITY_ILF_LEVELS_GAINED = true,
        ABILITY_ILF_MAX_LIFE_GAINED = true,
        ABILITY_ILF_MAX_MANA_GAINED = true,
        ABILITY_ILF_GOLD_GIVEN = true,
        ABILITY_ILF_LUMBER_GIVEN = true,
        ABILITY_ILF_DETECTION_TYPE_IFA1 = true,
        ABILITY_ILF_MAXIMUM_CREEP_LEVEL_ICRE = true,
        ABILITY_ILF_MOVEMENT_SPEED_BONUS = true,
        ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND = true,
        ABILITY_ILF_SIGHT_RANGE_BONUS = true,
        ABILITY_ILF_DAMAGE_PER_DURATION = true,
        ABILITY_ILF_MANA_USED_PER_SECOND = true,
        ABILITY_ILF_EXTRA_MANA_REQUIRED = true,
        ABILITY_ILF_DETECTION_RADIUS_IDET = true,
        ABILITY_ILF_MANA_LOSS_PER_UNIT_IDIM = true,
        ABILITY_ILF_DAMAGE_TO_SUMMONED_UNITS_IDID = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_IREC = true,
        ABILITY_ILF_DELAY_AFTER_DEATH_SECONDS = true,
        ABILITY_ILF_RESTORED_LIFE = true,
        ABILITY_ILF_RESTORED_MANA__1_FOR_CURRENT = true,
        ABILITY_ILF_HIT_POINTS_RESTORED = true,
        ABILITY_ILF_MANA_POINTS_RESTORED = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_ITPM = true,
        ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_CAD1 = true,
        ABILITY_ILF_TERRAIN_DEFORMATION_DURATION_MS = true,
        ABILITY_ILF_MAXIMUM_UNITS = true,
        ABILITY_ILF_DETECTION_TYPE_DET1 = true,
        ABILITY_ILF_GOLD_COST_PER_STRUCTURE = true,
        ABILITY_ILF_LUMBER_COST_PER_USE = true,
        ABILITY_ILF_DETECTION_TYPE_NSP3 = true,
        ABILITY_ILF_NUMBER_OF_SWARM_UNITS = true,
        ABILITY_ILF_MAX_SWARM_UNITS_PER_TARGET = true,
        ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2 = true,
        ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1 = true,
        ABILITY_ILF_ATTACKS_PREVENTED = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3 = true,
        ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_ESV1 = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1 = true,
        ABILITY_ILF_ITEM_CAPACITY = true,
        ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_SPL2 = true,
        ABILITY_ILF_ALLOW_WHEN_FULL_IRL3 = true,
        ABILITY_ILF_MAXIMUM_DISPELLED_UNITS = true,
        ABILITY_ILF_NUMBER_OF_LURES = true,
        ABILITY_ILF_NEW_TIME_OF_DAY_HOUR = true,
        ABILITY_ILF_NEW_TIME_OF_DAY_MINUTE = true,
        ABILITY_ILF_NUMBER_OF_UNITS_CREATED_MEC1 = true,
        ABILITY_ILF_MINIMUM_SPELLS = true,
        ABILITY_ILF_MAXIMUM_SPELLS = true,
        ABILITY_ILF_DISABLED_ATTACK_INDEX = true,
        ABILITY_ILF_ENABLED_ATTACK_INDEX_GRA4 = true,
        ABILITY_ILF_MAXIMUM_ATTACKS = true,
        ABILITY_ILF_BUILDING_TYPES_ALLOWED_NPR1 = true,
        ABILITY_ILF_BUILDING_TYPES_ALLOWED_NSA1 = true,
        ABILITY_ILF_ATTACK_MODIFICATION = true,
        ABILITY_ILF_SUMMONED_UNIT_COUNT_NPA5 = true,
        ABILITY_ILF_UPGRADE_LEVELS = true,
        ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2 = true,
        ABILITY_ILF_BEASTS_PER_SECOND = true,
        ABILITY_ILF_TARGET_TYPE = true,
        ABILITY_ILF_OPTIONS = true,
        ABILITY_ILF_ARMOR_PENALTY_NAB3 = true,
        ABILITY_ILF_WAVE_COUNT_NHS6 = true,
        ABILITY_ILF_MAX_CREEP_LEVEL_NTM3 = true,
        ABILITY_ILF_MISSILE_COUNT = true,
        ABILITY_ILF_SPLIT_ATTACK_COUNT = true,
        ABILITY_ILF_GENERATION_COUNT = true,
        ABILITY_ILF_ROCK_RING_COUNT = true,
        ABILITY_ILF_WAVE_COUNT_NVC2 = true,
        ABILITY_ILF_PREFER_HOSTILES_TAU1 = true,
        ABILITY_ILF_PREFER_FRIENDLIES_TAU2 = true,
        ABILITY_ILF_MAX_UNITS_TAU3 = true,
        ABILITY_ILF_NUMBER_OF_PULSES = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPE_HWE1 = true,
        ABILITY_ILF_SUMMONED_UNIT_UIN4 = true,
        ABILITY_ILF_SUMMONED_UNIT_OSF1 = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPE_EFNU = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPE_NBAU = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPE_NTOU = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPE_ESVU = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPES = true,
        ABILITY_ILF_SUMMONED_UNIT_TYPE_NDOU = true,
        ABILITY_ILF_ALTERNATE_FORM_UNIT_EMEU = true,
        ABILITY_ILF_PLAGUE_WARD_UNIT_TYPE = true,
        ABILITY_ILF_ALLOWED_UNIT_TYPE_BTL1 = true,
        ABILITY_ILF_NEW_UNIT_TYPE = true,
        ABILITY_ILF_RESULTING_UNIT_TYPE_ENT1 = true,
        ABILITY_ILF_CORPSE_UNIT_TYPE = true,
        ABILITY_ILF_ALLOWED_UNIT_TYPE_LOA1 = true,
        ABILITY_ILF_UNIT_TYPE_FOR_LIMIT_CHECK = true,
        ABILITY_ILF_WARD_UNIT_TYPE_STAU = true,
        ABILITY_ILF_EFFECT_ABILITY = true,
        ABILITY_ILF_CONVERSION_UNIT = true,
        ABILITY_ILF_UNIT_TO_PRESERVE = true,
        ABILITY_ILF_UNIT_TYPE_ALLOWED = true,
        ABILITY_ILF_SWARM_UNIT_TYPE = true,
        ABILITY_ILF_RESULTING_UNIT_TYPE_COAU = true,
        ABILITY_ILF_UNIT_TYPE_EXHU = true,
        ABILITY_ILF_WARD_UNIT_TYPE_HWDU = true,
        ABILITY_ILF_LURE_UNIT_TYPE = true,
        ABILITY_ILF_UNIT_TYPE_IPMU = true,
        ABILITY_ILF_FACTORY_UNIT_ID = true,
        ABILITY_ILF_SPAWN_UNIT_ID_NFYU = true,
        ABILITY_ILF_DESTRUCTIBLE_ID = true,
        ABILITY_ILF_UPGRADE_TYPE = true,
    },
    RealLevel = {
        ABILITY_RLF_CASTING_TIME = true,
        ABILITY_RLF_DURATION_NORMAL = true,
        ABILITY_RLF_DURATION_HERO = true,
        ABILITY_RLF_COOLDOWN = true,
        ABILITY_RLF_AREA_OF_EFFECT = true,
        ABILITY_RLF_CAST_RANGE = true,
        ABILITY_RLF_DAMAGE_HBZ2 = true,
        ABILITY_RLF_BUILDING_REDUCTION_HBZ4 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5 = true,
        ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE = true,
        ABILITY_RLF_MANA_REGENERATION_INCREASE = true,
        ABILITY_RLF_CASTING_DELAY = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_OWW1 = true,
        ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_OWW2 = true,
        ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE = true,
        ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2 = true,
        ABILITY_RLF_DAMAGE_BONUS_OCR3 = true,
        ABILITY_RLF_CHANCE_TO_EVADE_OCR4 = true,
        ABILITY_RLF_DAMAGE_DEALT_PERCENT_OMI2 = true,
        ABILITY_RLF_DAMAGE_TAKEN_PERCENT_OMI3 = true,
        ABILITY_RLF_ANIMATION_DELAY = true,
        ABILITY_RLF_TRANSITION_TIME = true,
        ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2 = true,
        ABILITY_RLF_BACKSTAB_DAMAGE = true,
        ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1 = true,
        ABILITY_RLF_LIFE_CONVERTED_TO_MANA = true,
        ABILITY_RLF_LIFE_CONVERTED_TO_LIFE = true,
        ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1 = true,
        ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT = true,
        ABILITY_RLF_CHANCE_TO_EVADE_EEV1 = true,
        ABILITY_RLF_DAMAGE_PER_INTERVAL = true,
        ABILITY_RLF_MANA_DRAINED_PER_SECOND_EIM2 = true,
        ABILITY_RLF_BUFFER_MANA_REQUIRED = true,
        ABILITY_RLF_MAX_MANA_DRAINED = true,
        ABILITY_RLF_BOLT_DELAY = true,
        ABILITY_RLF_BOLT_LIFETIME = true,
        ABILITY_RLF_ALTITUDE_ADJUSTMENT_DURATION = true,
        ABILITY_RLF_LANDING_DELAY_TIME = true,
        ABILITY_RLF_ALTERNATE_FORM_HIT_POINT_BONUS = true,
        ABILITY_RLF_MOVE_SPEED_BONUS_INFO_PANEL_ONLY = true,
        ABILITY_RLF_ATTACK_SPEED_BONUS_INFO_PANEL_ONLY = true,
        ABILITY_RLF_LIFE_REGENERATION_RATE_PER_SECOND = true,
        ABILITY_RLF_STUN_DURATION_USL1 = true,
        ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT = true,
        ABILITY_RLF_DAMAGE_UCS1 = true,
        ABILITY_RLF_MAX_DAMAGE_UCS2 = true,
        ABILITY_RLF_DISTANCE_UCS3 = true,
        ABILITY_RLF_FINAL_AREA_UCS4 = true,
        ABILITY_RLF_DAMAGE_UIN1 = true,
        ABILITY_RLF_DURATION = true,
        ABILITY_RLF_IMPACT_DELAY = true,
        ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 = true,
        ABILITY_RLF_DAMAGE_REDUCTION_PER_TARGET = true,
        ABILITY_RLF_EFFECT_DELAY_OEQ1 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS = true,
        ABILITY_RLF_UNITS_SLOWED_PERCENT = true,
        ABILITY_RLF_FINAL_AREA_OEQ4 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_EER1 = true,
        ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS = true,
        ABILITY_RLF_LIFE_HEALED = true,
        ABILITY_RLF_HEAL_INTERVAL = true,
        ABILITY_RLF_BUILDING_REDUCTION_ETQ3 = true,
        ABILITY_RLF_INITIAL_IMMUNITY_DURATION = true,
        ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT = true,
        ABILITY_RLF_BUILDING_REDUCTION_UDD2 = true,
        ABILITY_RLF_ARMOR_DURATION = true,
        ABILITY_RLF_ARMOR_BONUS_UFA2 = true,
        ABILITY_RLF_AREA_OF_EFFECT_DAMAGE = true,
        ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2 = true,
        ABILITY_RLF_DAMAGE_BONUS_HFA1 = true,
        ABILITY_RLF_DAMAGE_DEALT_ESF1 = true,
        ABILITY_RLF_DAMAGE_INTERVAL_ESF2 = true,
        ABILITY_RLF_BUILDING_REDUCTION_ESF3 = true,
        ABILITY_RLF_DAMAGE_BONUS_PERCENT = true,
        ABILITY_RLF_DEFENSE_BONUS_HAV1 = true,
        ABILITY_RLF_HIT_POINT_BONUS = true,
        ABILITY_RLF_DAMAGE_BONUS_HAV3 = true,
        ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_HAV4 = true,
        ABILITY_RLF_CHANCE_TO_BASH = true,
        ABILITY_RLF_DAMAGE_MULTIPLIER_HBH2 = true,
        ABILITY_RLF_DAMAGE_BONUS_HBH3 = true,
        ABILITY_RLF_CHANCE_TO_MISS_HBH4 = true,
        ABILITY_RLF_DAMAGE_HTB1 = true,
        ABILITY_RLF_AOE_DAMAGE = true,
        ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HTC4 = true,
        ABILITY_RLF_ARMOR_BONUS_HAD1 = true,
        ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1 = true,
        ABILITY_RLF_EXTRA_DAMAGE_HCA1 = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3 = true,
        ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1 = true,
        ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2 = true,
        ABILITY_RLF_REINCARNATION_DELAY = true,
        ABILITY_RLF_DAMAGE_OSH1 = true,
        ABILITY_RLF_MAXIMUM_DAMAGE_OSH2 = true,
        ABILITY_RLF_DISTANCE_OSH3 = true,
        ABILITY_RLF_FINAL_AREA_OSH4 = true,
        ABILITY_RLF_GRAPHIC_DELAY_NFD1 = true,
        ABILITY_RLF_GRAPHIC_DURATION_NFD2 = true,
        ABILITY_RLF_DAMAGE_NFD3 = true,
        ABILITY_RLF_SUMMONED_UNIT_DAMAGE_AMS1 = true,
        ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_AMS2 = true,
        ABILITY_RLF_AURA_DURATION = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_APL2 = true,
        ABILITY_RLF_DURATION_OF_PLAGUE_WARD = true,
        ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED = true,
        ABILITY_RLF_ATTACK_DAMAGE_INCREASE_AKB1 = true,
        ABILITY_RLF_MANA_LOSS_ADM1 = true,
        ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2 = true,
        ABILITY_RLF_EXPANSION_AMOUNT = true,
        ABILITY_RLF_INTERVAL_DURATION_BGM2 = true,
        ABILITY_RLF_RADIUS_OF_MINING_RING = true,
        ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1 = true,
        ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2 = true,
        ABILITY_RLF_SCALING_FACTOR = true,
        ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1 = true,
        ABILITY_RLF_MAX_HIT_POINTS = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_DEV2 = true,
        ABILITY_RLF_MOVEMENT_UPDATE_FREQUENCY_CHD1 = true,
        ABILITY_RLF_ATTACK_UPDATE_FREQUENCY_CHD2 = true,
        ABILITY_RLF_SUMMONED_UNIT_DAMAGE_CHD3 = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2 = true,
        ABILITY_RLF_DAMAGE_REDUCTION_CRI3 = true,
        ABILITY_RLF_CHANCE_TO_MISS_CRS = true,
        ABILITY_RLF_FULL_DAMAGE_RADIUS_DDA1 = true,
        ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2 = true,
        ABILITY_RLF_PARTIAL_DAMAGE_RADIUS = true,
        ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT = true,
        ABILITY_RLF_BUILDING_DAMAGE_FACTOR_SDS1 = true,
        ABILITY_RLF_MAX_DAMAGE_UCO5 = true,
        ABILITY_RLF_MOVE_SPEED_BONUS_UCO6 = true,
        ABILITY_RLF_DAMAGE_TAKEN_PERCENT_DEF1 = true,
        ABILITY_RLF_DAMAGE_DEALT_PERCENT_DEF2 = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_DEF3 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_DEF4 = true,
        ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_DEF5 = true,
        ABILITY_RLF_CHANCE_TO_DEFLECT = true,
        ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_PIERCING = true,
        ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_SPELLS = true,
        ABILITY_RLF_RIP_DELAY = true,
        ABILITY_RLF_EAT_DELAY = true,
        ABILITY_RLF_HIT_POINTS_GAINED_EAT3 = true,
        ABILITY_RLF_AIR_UNIT_LOWER_DURATION = true,
        ABILITY_RLF_AIR_UNIT_HEIGHT = true,
        ABILITY_RLF_MELEE_ATTACK_RANGE = true,
        ABILITY_RLF_INTERVAL_DURATION_EGM2 = true,
        ABILITY_RLF_EFFECT_DELAY_FLA2 = true,
        ABILITY_RLF_MINING_DURATION = true,
        ABILITY_RLF_RADIUS_OF_GRAVESTONES = true,
        ABILITY_RLF_RADIUS_OF_CORPSES = true,
        ABILITY_RLF_HIT_POINTS_GAINED_HEA1 = true,
        ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1 = true,
        ABILITY_RLF_AUTOCAST_RANGE = true,
        ABILITY_RLF_LIFE_REGEN_RATE = true,
        ABILITY_RLF_GRAPHIC_DELAY_LIT1 = true,
        ABILITY_RLF_GRAPHIC_DURATION_LIT2 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_LSH1 = true,
        ABILITY_RLF_MANA_GAINED = true,
        ABILITY_RLF_HIT_POINTS_GAINED_MBT2 = true,
        ABILITY_RLF_AUTOCAST_REQUIREMENT = true,
        ABILITY_RLF_WATER_HEIGHT = true,
        ABILITY_RLF_ACTIVATION_DELAY_MIN1 = true,
        ABILITY_RLF_INVISIBILITY_TRANSITION_TIME = true,
        ABILITY_RLF_ACTIVATION_RADIUS = true,
        ABILITY_RLF_AMOUNT_REGENERATED = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_POI1 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_POI2 = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POI3 = true,
        ABILITY_RLF_EXTRA_DAMAGE_POA1 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_POA2 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_POA3 = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POA4 = true,
        ABILITY_RLF_DAMAGE_AMPLIFICATION = true,
        ABILITY_RLF_CHANCE_TO_STOMP_PERCENT = true,
        ABILITY_RLF_DAMAGE_DEALT_WAR2 = true,
        ABILITY_RLF_FULL_DAMAGE_RADIUS_WAR3 = true,
        ABILITY_RLF_HALF_DAMAGE_RADIUS_WAR4 = true,
        ABILITY_RLF_SUMMONED_UNIT_DAMAGE_PRG3 = true,
        ABILITY_RLF_UNIT_PAUSE_DURATION = true,
        ABILITY_RLF_HERO_PAUSE_DURATION = true,
        ABILITY_RLF_HIT_POINTS_GAINED_REJ1 = true,
        ABILITY_RLF_MANA_POINTS_GAINED_REJ2 = true,
        ABILITY_RLF_MINIMUM_LIFE_REQUIRED = true,
        ABILITY_RLF_MINIMUM_MANA_REQUIRED = true,
        ABILITY_RLF_REPAIR_COST_RATIO = true,
        ABILITY_RLF_REPAIR_TIME_RATIO = true,
        ABILITY_RLF_POWERBUILD_COST = true,
        ABILITY_RLF_POWERBUILD_RATE = true,
        ABILITY_RLF_NAVAL_RANGE_BONUS = true,
        ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1 = true,
        ABILITY_RLF_LIFE_REGENERATION_RATE = true,
        ABILITY_RLF_MANA_REGEN = true,
        ABILITY_RLF_DAMAGE_INCREASE = true,
        ABILITY_RLF_SALVAGE_COST_RATIO = true,
        ABILITY_RLF_IN_FLIGHT_SIGHT_RADIUS = true,
        ABILITY_RLF_HOVERING_SIGHT_RADIUS = true,
        ABILITY_RLF_HOVERING_HEIGHT = true,
        ABILITY_RLF_DURATION_OF_OWLS = true,
        ABILITY_RLF_FADE_DURATION = true,
        ABILITY_RLF_DAY_NIGHT_DURATION = true,
        ABILITY_RLF_ACTION_DURATION = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_SPO1 = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SPO2 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_SPO3 = true,
        ABILITY_RLF_ACTIVATION_DELAY_STA1 = true,
        ABILITY_RLF_DETECTION_RADIUS_STA2 = true,
        ABILITY_RLF_DETONATION_RADIUS = true,
        ABILITY_RLF_STUN_DURATION_STA4 = true,
        ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_UHF2 = true,
        ABILITY_RLF_LUMBER_PER_INTERVAL = true,
        ABILITY_RLF_ART_ATTACHMENT_HEIGHT = true,
        ABILITY_RLF_TELEPORT_AREA_WIDTH = true,
        ABILITY_RLF_TELEPORT_AREA_HEIGHT = true,
        ABILITY_RLF_LIFE_STOLEN_PER_ATTACK = true,
        ABILITY_RLF_DAMAGE_BONUS_IDAM = true,
        ABILITY_RLF_CHANCE_TO_HIT_UNITS_PERCENT = true,
        ABILITY_RLF_CHANCE_TO_HIT_HEROS_PERCENT = true,
        ABILITY_RLF_CHANCE_TO_HIT_SUMMONS_PERCENT = true,
        ABILITY_RLF_DELAY_FOR_TARGET_EFFECT = true,
        ABILITY_RLF_DAMAGE_DEALT_PERCENT_OF_NORMAL = true,
        ABILITY_RLF_DAMAGE_RECEIVED_MULTIPLIER = true,
        ABILITY_RLF_MANA_REGENERATION_BONUS_AS_FRACTION_OF_NORMAL = true,
        ABILITY_RLF_MOVEMENT_SPEED_INCREASE_ISPI = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_IDPS = true,
        ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_COR1 = true,
        ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1 = true,
        ABILITY_RLF_DAMAGE_WRS1 = true,
        ABILITY_RLF_TERRAIN_DEFORMATION_AMPLITUDE = true,
        ABILITY_RLF_DAMAGE_CTC1 = true,
        ABILITY_RLF_EXTRA_DAMAGE_TO_TARGET = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4 = true,
        ABILITY_RLF_DAMAGE_CTB1 = true,
        ABILITY_RLF_CASTING_DELAY_SECONDS = true,
        ABILITY_RLF_MANA_LOSS_PER_UNIT_DTN1 = true,
        ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_DTN2 = true,
        ABILITY_RLF_TRANSITION_TIME_SECONDS = true,
        ABILITY_RLF_MANA_DRAINED_PER_SECOND_NMR1 = true,
        ABILITY_RLF_CHANCE_TO_REDUCE_DAMAGE_PERCENT = true,
        ABILITY_RLF_MINIMUM_DAMAGE = true,
        ABILITY_RLF_IGNORED_DAMAGE = true,
        ABILITY_RLF_FULL_DAMAGE_DEALT = true,
        ABILITY_RLF_FULL_DAMAGE_INTERVAL = true,
        ABILITY_RLF_HALF_DAMAGE_DEALT = true,
        ABILITY_RLF_HALF_DAMAGE_INTERVAL = true,
        ABILITY_RLF_BUILDING_REDUCTION_HFS5 = true,
        ABILITY_RLF_MAXIMUM_DAMAGE_HFS6 = true,
        ABILITY_RLF_MANA_PER_HIT_POINT = true,
        ABILITY_RLF_DAMAGE_ABSORBED_PERCENT = true,
        ABILITY_RLF_WAVE_DISTANCE = true,
        ABILITY_RLF_WAVE_TIME_SECONDS = true,
        ABILITY_RLF_DAMAGE_DEALT_UIM3 = true,
        ABILITY_RLF_AIR_TIME_SECONDS_UIM4 = true,
        ABILITY_RLF_UNIT_RELEASE_INTERVAL_SECONDS = true,
        ABILITY_RLF_DAMAGE_RETURN_FACTOR = true,
        ABILITY_RLF_DAMAGE_RETURN_THRESHOLD = true,
        ABILITY_RLF_RETURNED_DAMAGE_FACTOR = true,
        ABILITY_RLF_RECEIVED_DAMAGE_FACTOR = true,
        ABILITY_RLF_DEFENSE_BONUS_UTS3 = true,
        ABILITY_RLF_DAMAGE_BONUS_NBA1 = true,
        ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NBA3 = true,
        ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT = true,
        ABILITY_RLF_CHARGE_FOR_CURRENT_LIFE = true,
        ABILITY_RLF_HIT_POINTS_DRAINED = true,
        ABILITY_RLF_MANA_POINTS_DRAINED = true,
        ABILITY_RLF_DRAIN_INTERVAL_SECONDS = true,
        ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND = true,
        ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND = true,
        ABILITY_RLF_BONUS_LIFE_FACTOR = true,
        ABILITY_RLF_BONUS_LIFE_DECAY = true,
        ABILITY_RLF_BONUS_MANA_FACTOR = true,
        ABILITY_RLF_BONUS_MANA_DECAY = true,
        ABILITY_RLF_CHANCE_TO_MISS_PERCENT = true,
        ABILITY_RLF_MOVEMENT_SPEED_MODIFIER = true,
        ABILITY_RLF_ATTACK_SPEED_MODIFIER = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_TDG1 = true,
        ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_TDG2 = true,
        ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND = true,
        ABILITY_RLF_SMALL_DAMAGE_RADIUS_TDG4 = true,
        ABILITY_RLF_SMALL_DAMAGE_PER_SECOND = true,
        ABILITY_RLF_AIR_TIME_SECONDS_TSP1 = true,
        ABILITY_RLF_MINIMUM_HIT_INTERVAL_SECONDS = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_NBF5 = true,
        ABILITY_RLF_MAXIMUM_RANGE = true,
        ABILITY_RLF_MINIMUM_RANGE = true,
        ABILITY_RLF_DAMAGE_PER_TARGET_EFK1 = true,
        ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE = true,
        ABILITY_RLF_MAXIMUM_SPEED_ADJUSTMENT = true,
        ABILITY_RLF_DECAYING_DAMAGE = true,
        ABILITY_RLF_MOVEMENT_SPEED_FACTOR_ESH2 = true,
        ABILITY_RLF_ATTACK_SPEED_FACTOR_ESH3 = true,
        ABILITY_RLF_DECAY_POWER = true,
        ABILITY_RLF_INITIAL_DAMAGE_ESH5 = true,
        ABILITY_RLF_MAXIMUM_LIFE_ABSORBED = true,
        ABILITY_RLF_MAXIMUM_MANA_ABSORBED = true,
        ABILITY_RLF_MOVEMENT_SPEED_INCREASE_BSK1 = true,
        ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2 = true,
        ABILITY_RLF_DAMAGE_TAKEN_INCREASE = true,
        ABILITY_RLF_LIFE_PER_UNIT = true,
        ABILITY_RLF_MANA_PER_UNIT = true,
        ABILITY_RLF_LIFE_PER_BUFF = true,
        ABILITY_RLF_MANA_PER_BUFF = true,
        ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5 = true,
        ABILITY_RLF_DAMAGE_BONUS_FAK1 = true,
        ABILITY_RLF_MEDIUM_DAMAGE_FACTOR_FAK2 = true,
        ABILITY_RLF_SMALL_DAMAGE_FACTOR_FAK3 = true,
        ABILITY_RLF_FULL_DAMAGE_RADIUS_FAK4 = true,
        ABILITY_RLF_HALF_DAMAGE_RADIUS_FAK5 = true,
        ABILITY_RLF_EXTRA_DAMAGE_PER_SECOND = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_LIQ2 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_LIQ3 = true,
        ABILITY_RLF_MAGIC_DAMAGE_FACTOR = true,
        ABILITY_RLF_UNIT_DAMAGE_PER_MANA_POINT = true,
        ABILITY_RLF_HERO_DAMAGE_PER_MANA_POINT = true,
        ABILITY_RLF_UNIT_MAXIMUM_DAMAGE = true,
        ABILITY_RLF_HERO_MAXIMUM_DAMAGE = true,
        ABILITY_RLF_DAMAGE_COOLDOWN = true,
        ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_SPL1 = true,
        ABILITY_RLF_LIFE_REGENERATED = true,
        ABILITY_RLF_MANA_REGENERATED = true,
        ABILITY_RLF_MANA_LOSS_PER_UNIT_IDC1 = true,
        ABILITY_RLF_SUMMONED_UNIT_DAMAGE_IDC2 = true,
        ABILITY_RLF_ACTIVATION_DELAY_IMO2 = true,
        ABILITY_RLF_LURE_INTERVAL_SECONDS = true,
        ABILITY_RLF_DAMAGE_BONUS_ISR1 = true,
        ABILITY_RLF_DAMAGE_REDUCTION_ISR2 = true,
        ABILITY_RLF_DAMAGE_BONUS_IPV1 = true,
        ABILITY_RLF_LIFE_STEAL_AMOUNT = true,
        ABILITY_RLF_LIFE_RESTORED_FACTOR = true,
        ABILITY_RLF_MANA_RESTORED_FACTOR = true,
        ABILITY_RLF_ATTACH_DELAY = true,
        ABILITY_RLF_REMOVE_DELAY = true,
        ABILITY_RLF_HERO_REGENERATION_DELAY = true,
        ABILITY_RLF_UNIT_REGENERATION_DELAY = true,
        ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_NSA4 = true,
        ABILITY_RLF_HIT_POINTS_PER_SECOND_NSA5 = true,
        ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_IXS1 = true,
        ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_IXS2 = true,
        ABILITY_RLF_SUMMONED_UNIT_DURATION = true,
        ABILITY_RLF_SHIELD_COOLDOWN_TIME = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_NDO1 = true,
        ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NDO3 = true,
        ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_FLK1 = true,
        ABILITY_RLF_SMALL_DAMAGE_RADIUS_FLK2 = true,
        ABILITY_RLF_FULL_DAMAGE_AMOUNT_FLK3 = true,
        ABILITY_RLF_MEDIUM_DAMAGE_AMOUNT = true,
        ABILITY_RLF_SMALL_DAMAGE_AMOUNT = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HBN1 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HBN2 = true,
        ABILITY_RLF_MAX_MANA_DRAINED_UNITS = true,
        ABILITY_RLF_DAMAGE_RATIO_UNITS_PERCENT = true,
        ABILITY_RLF_MAX_MANA_DRAINED_HEROS = true,
        ABILITY_RLF_DAMAGE_RATIO_HEROS_PERCENT = true,
        ABILITY_RLF_SUMMONED_DAMAGE = true,
        ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1 = true,
        ABILITY_RLF_INITIAL_DAMAGE_PXF1 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_PXF2 = true,
        ABILITY_RLF_DAMAGE_PER_SECOND_MLS1 = true,
        ABILITY_RLF_BEAST_COLLISION_RADIUS = true,
        ABILITY_RLF_DAMAGE_AMOUNT_NST3 = true,
        ABILITY_RLF_DAMAGE_RADIUS = true,
        ABILITY_RLF_DAMAGE_DELAY = true,
        ABILITY_RLF_FOLLOW_THROUGH_TIME = true,
        ABILITY_RLF_ART_DURATION = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NAB1 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NAB2 = true,
        ABILITY_RLF_PRIMARY_DAMAGE = true,
        ABILITY_RLF_SECONDARY_DAMAGE = true,
        ABILITY_RLF_DAMAGE_INTERVAL_NAB6 = true,
        ABILITY_RLF_GOLD_COST_FACTOR = true,
        ABILITY_RLF_LUMBER_COST_FACTOR = true,
        ABILITY_RLF_MOVE_SPEED_BONUS_NEG1 = true,
        ABILITY_RLF_DAMAGE_BONUS_NEG2 = true,
        ABILITY_RLF_DAMAGE_AMOUNT_NCS1 = true,
        ABILITY_RLF_DAMAGE_INTERVAL_NCS2 = true,
        ABILITY_RLF_MAX_DAMAGE_NCS4 = true,
        ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NCS5 = true,
        ABILITY_RLF_EFFECT_DURATION = true,
        ABILITY_RLF_SPAWN_INTERVAL_NSY1 = true,
        ABILITY_RLF_SPAWN_UNIT_DURATION = true,
        ABILITY_RLF_SPAWN_UNIT_OFFSET = true,
        ABILITY_RLF_LEASH_RANGE_NSY5 = true,
        ABILITY_RLF_SPAWN_INTERVAL_NFY1 = true,
        ABILITY_RLF_LEASH_RANGE_NFY2 = true,
        ABILITY_RLF_CHANCE_TO_DEMOLISH = true,
        ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS = true,
        ABILITY_RLF_DAMAGE_MULTIPLIER_UNITS = true,
        ABILITY_RLF_DAMAGE_MULTIPLIER_HEROES = true,
        ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER = true,
        ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT = true,
        ABILITY_RLF_DEATH_DAMAGE_FULL_AREA = true,
        ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT = true,
        ABILITY_RLF_DEATH_DAMAGE_HALF_AREA = true,
        ABILITY_RLF_DEATH_DAMAGE_DELAY = true,
        ABILITY_RLF_DAMAGE_AMOUNT_NSO1 = true,
        ABILITY_RLF_DAMAGE_PERIOD = true,
        ABILITY_RLF_DAMAGE_PENALTY = true,
        ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NSO4 = true,
        ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NSO5 = true,
        ABILITY_RLF_SPLIT_DELAY = true,
        ABILITY_RLF_MAX_HITPOINT_FACTOR = true,
        ABILITY_RLF_LIFE_DURATION_SPLIT_BONUS = true,
        ABILITY_RLF_WAVE_INTERVAL = true,
        ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NVC4 = true,
        ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5 = true,
        ABILITY_RLF_HALF_DAMAGE_FACTOR = true,
        ABILITY_RLF_INTERVAL_BETWEEN_PULSES = true,
    },
    BooleanLevel = {
        ABILITY_BLF_PERCENT_BONUS_HAB2 = true,
        ABILITY_BLF_USE_TELEPORT_CLUSTERING_HMT3 = true,
        ABILITY_BLF_NEVER_MISS_OCR5 = true,
        ABILITY_BLF_EXCLUDE_ITEM_DAMAGE = true,
        ABILITY_BLF_BACKSTAB_DAMAGE = true,
        ABILITY_BLF_INHERIT_UPGRADES_UAN3 = true,
        ABILITY_BLF_MANA_CONVERSION_AS_PERCENT = true,
        ABILITY_BLF_LIFE_CONVERSION_AS_PERCENT = true,
        ABILITY_BLF_LEAVE_TARGET_ALIVE = true,
        ABILITY_BLF_PERCENT_BONUS_UAU3 = true,
        ABILITY_BLF_DAMAGE_IS_PERCENT_RECEIVED = true,
        ABILITY_BLF_MELEE_BONUS = true,
        ABILITY_BLF_RANGED_BONUS = true,
        ABILITY_BLF_FLAT_BONUS = true,
        ABILITY_BLF_NEVER_MISS_HBH5 = true,
        ABILITY_BLF_PERCENT_BONUS_HAD2 = true,
        ABILITY_BLF_CAN_DEACTIVATE = true,
        ABILITY_BLF_RAISED_UNITS_ARE_INVULNERABLE = true,
        ABILITY_BLF_PERCENTAGE_OAR2 = true,
        ABILITY_BLF_SUMMON_BUSY_UNITS = true,
        ABILITY_BLF_CREATES_BLIGHT = true,
        ABILITY_BLF_EXPLODES_ON_DEATH = true,
        ABILITY_BLF_ALWAYS_AUTOCAST_FAE2 = true,
        ABILITY_BLF_REGENERATE_ONLY_AT_NIGHT = true,
        ABILITY_BLF_SHOW_SELECT_UNIT_BUTTON = true,
        ABILITY_BLF_SHOW_UNIT_INDICATOR = true,
        ABILITY_BLF_CHARGE_OWNING_PLAYER = true,
        ABILITY_BLF_PERCENTAGE_ARM2 = true,
        ABILITY_BLF_TARGET_IS_INVULNERABLE = true,
        ABILITY_BLF_TARGET_IS_MAGIC_IMMUNE = true,
        ABILITY_BLF_KILL_ON_CASTER_DEATH = true,
        ABILITY_BLF_NO_TARGET_REQUIRED_REJ4 = true,
        ABILITY_BLF_ACCEPTS_GOLD = true,
        ABILITY_BLF_ACCEPTS_LUMBER = true,
        ABILITY_BLF_PREFER_HOSTILES_ROA5 = true,
        ABILITY_BLF_PREFER_FRIENDLIES_ROA6 = true,
        ABILITY_BLF_ROOTED_TURNING = true,
        ABILITY_BLF_ALWAYS_AUTOCAST_SLO3 = true,
        ABILITY_BLF_HIDE_BUTTON = true,
        ABILITY_BLF_USE_TELEPORT_CLUSTERING_ITP2 = true,
        ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS = true,
        ABILITY_BLF_DOES_NOT_BLOCK_BUILDINGS = true,
        ABILITY_BLF_AUTO_ACQUIRE_ATTACK_TARGETS = true,
        ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS_GHO2 = true,
        ABILITY_BLF_DO_NOT_BLOCK_BUILDINGS = true,
        ABILITY_BLF_INCLUDE_RANGED_DAMAGE = true,
        ABILITY_BLF_INCLUDE_MELEE_DAMAGE = true,
        ABILITY_BLF_MOVE_TO_PARTNER = true,
        ABILITY_BLF_CAN_BE_DISPELLED = true,
        ABILITY_BLF_IGNORE_FRIENDLY_BUFFS = true,
        ABILITY_BLF_DROP_ITEMS_ON_DEATH = true,
        ABILITY_BLF_CAN_USE_ITEMS = true,
        ABILITY_BLF_CAN_GET_ITEMS = true,
        ABILITY_BLF_CAN_DROP_ITEMS = true,
        ABILITY_BLF_REPAIRS_ALLOWED = true,
        ABILITY_BLF_CASTER_ONLY_SPLASH = true,
        ABILITY_BLF_NO_TARGET_REQUIRED_IRL4 = true,
        ABILITY_BLF_DISPEL_ON_ATTACK = true,
        ABILITY_BLF_AMOUNT_IS_RAW_VALUE = true,
        ABILITY_BLF_SHARED_SPELL_COOLDOWN = true,
        ABILITY_BLF_SLEEP_ONCE = true,
        ABILITY_BLF_ALLOW_ON_ANY_PLAYER_SLOT = true,
        ABILITY_BLF_DISABLE_OTHER_ABILITIES = true,
        ABILITY_BLF_ALLOW_BOUNTY = true,
    },
    StringLevel = {
        ABILITY_SLF_ICON_NORMAL = true,
        ABILITY_SLF_CASTER = true,
        ABILITY_SLF_TARGET = true,
        ABILITY_SLF_SPECIAL = true,
        ABILITY_SLF_EFFECT = true,
        ABILITY_SLF_AREA_EFFECT = true,
        ABILITY_SLF_LIGHTNING_EFFECTS = true,
        ABILITY_SLF_MISSILE_ART = true,
        ABILITY_SLF_TOOLTIP_LEARN = true,
        ABILITY_SLF_TOOLTIP_LEARN_EXTENDED = true,
        ABILITY_SLF_TOOLTIP_NORMAL = true,
        ABILITY_SLF_TOOLTIP_TURN_OFF = true,
        ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED = true,
        ABILITY_SLF_TOOLTIP_TURN_OFF_EXTENDED = true,
        ABILITY_SLF_NORMAL_FORM_UNIT_EME1 = true,
        ABILITY_SLF_SPAWNED_UNITS = true,
        ABILITY_SLF_ABILITY_FOR_UNIT_CREATION = true,
        ABILITY_SLF_NORMAL_FORM_UNIT_MIL1 = true,
        ABILITY_SLF_ALTERNATE_FORM_UNIT_MIL2 = true,
        ABILITY_SLF_BASE_ORDER_ID_ANS5 = true,
        ABILITY_SLF_MORPH_UNITS_GROUND = true,
        ABILITY_SLF_MORPH_UNITS_AIR = true,
        ABILITY_SLF_MORPH_UNITS_AMPHIBIOUS = true,
        ABILITY_SLF_MORPH_UNITS_WATER = true,
        ABILITY_SLF_UNIT_TYPE_ONE = true,
        ABILITY_SLF_UNIT_TYPE_TWO = true,
        ABILITY_SLF_UNIT_TYPE_SOD2 = true,
        ABILITY_SLF_SUMMON_1_UNIT_TYPE = true,
        ABILITY_SLF_SUMMON_2_UNIT_TYPE = true,
        ABILITY_SLF_RACE_TO_CONVERT = true,
        ABILITY_SLF_PARTNER_UNIT_TYPE = true,
        ABILITY_SLF_PARTNER_UNIT_TYPE_ONE = true,
        ABILITY_SLF_PARTNER_UNIT_TYPE_TWO = true,
        ABILITY_SLF_REQUIRED_UNIT_TYPE = true,
        ABILITY_SLF_CONVERTED_UNIT_TYPE = true,
        ABILITY_SLF_SPELL_LIST = true,
        ABILITY_SLF_BASE_ORDER_ID_SPB5 = true,
        ABILITY_SLF_BASE_ORDER_ID_NCL6 = true,
        ABILITY_SLF_ABILITY_UPGRADE_1 = true,
        ABILITY_SLF_ABILITY_UPGRADE_2 = true,
        ABILITY_SLF_ABILITY_UPGRADE_3 = true,
        ABILITY_SLF_ABILITY_UPGRADE_4 = true,
        ABILITY_SLF_SPAWN_UNIT_ID_NSY2 = true,
    }
}

---@param ability Ability
---@param unit Unit
---@param val any
---@param field userdata
---@param lvl integer|nil
---@return boolean
function AbilityField.set(ability, unit, val, field, lvl)
    if unit:getAbilityLevel(ability) <= 0 then
        Debug('Unit does not have the ability for field changing.')
        return false
    end

    local abil_instance = BlzGetUnitAbility(unit:getObj(), ability:getId())
    if lvl == nil then lvl = 1 end

    if AbilityField.Integer[field] then
        if type(val) == 'number' then val = math.floor(val) end
        if type(val) ~= 'integer' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityIntegerField(abil_instance, field, val)
        return true
    end

    if AbilityField.Real[field] then
        if type(val) ~= 'number' and type(val) ~= 'integer' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityRealField(abil_instance, field, val)
        return true
    end

    if AbilityField.Boolean[field] then
        if type(val) ~= 'boolean' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityBooleanField(abil_instance, field, val)
        return true
    end

    if AbilityField.String[field] then
        if type(val) ~= 'string' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityStringField(abil_instance, field, val)
        return true
    end

    if AbilityField.IntegerLevel[field] then
        if type(val) == 'number' then val = math.floor(val) end
        if type(val) ~= 'integer' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityIntegerLevelField(abil_instance, field, lvl - 1, val)
        return true
    end

    if AbilityField.RealLevel[field] then
        if type(val) ~= 'number' and type(val) ~= 'integer' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityRealLevelField(abil_instance, field, lvl - 1, val)
        return true
    end

    if AbilityField.BooleanLevel[field] then
        if type(val) ~= 'boolean' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityBooleanLevelField(abil_instance, field, lvl - 1, val)
        return true
    end

    if AbilityField.StringLevel[field] then
        if type(val) ~= 'string' then Debug('AbilityField got wrong type.') return false end
        BlzSetAbilityStringLevelField(abil_instance, field, lvl - 1, val)
        return true
    end

    Debug('Wrong ability field type.')
    return false
end

return AbilityField