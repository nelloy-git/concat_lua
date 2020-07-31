---@class BinaryAbilityDB
local AbilityValuesDB = {}

AbilityValuesDB.AnimationNames = {value_id = "aani", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.AreaEffect = {value_id = "aaea", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.AreaOfEffect = {value_id = "aare", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.ArtCaster = {value_id = "acat", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.ArtEffect = {value_id = "aeat", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.ArtSpecial = {value_id = "asat", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.ArtTarget = {value_id = "atat", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.Buffs = {value_id = "abuf", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.ButtonPositionNormalX = {value_id = "abpx", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.ButtonPositionNormalY = {value_id = "abpy", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.ButtonPositionResearchX = {value_id = "arpx", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.ButtonPositionResearchY = {value_id = "arpy", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.ButtonPositionTurnOffX = {value_id = "aubx", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.ButtonPositionTurnOffY = {value_id = "auby", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.CastRange = {value_id = "aran", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.CasterAttachmentPoint = {value_id = "acap", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.CasterAttachmentPoint1 = {value_id = "aca1", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.CasterAttachments = {value_id = "acac", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.CastingTime = {value_id = "acas", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.CheckDependencies = {value_id = "achd", value_type = 'bool', need_lvl = false, extra_id = 0}
AbilityValuesDB.Cooldown = {value_id = "acdn", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.DurationHero = {value_id = "ahdu", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.DurationNormal = {value_id = "adur", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.EditorSuffix = {value_id = "ansf", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.EffectSound = {value_id = "aefs", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.EffectSoundLooping = {value_id = "aefl", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.Effects = {value_id = "aeff", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.HeroAbility = {value_id = "aher", value_type = 'bool', need_lvl = false, extra_id = 0}
AbilityValuesDB.HotkeyLearn = {value_id = "arhk", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.HotkeyNormal = {value_id = "ahky", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.HotkeyTurnOff = {value_id = "auhk", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.IconNormal = {value_id = "aart", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.IconResearch = {value_id = "arar", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.IconTurnOff = {value_id = "auar", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.ItemAbility = {value_id = "aite", value_type = 'bool', need_lvl = false, extra_id = 0}
AbilityValuesDB.LevelSkipRequirement = {value_id = "alsk", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.Levels = {value_id = "alev", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.LightningEffects = {value_id = "alig", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.ManaCost = {value_id = "amcs", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.MissileArc = {value_id = "amac", value_type = 'unreal', need_lvl = false, extra_id = 0}
AbilityValuesDB.MissileArt = {value_id = "amat", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.MissileHomingEnabled = {value_id = "amho", value_type = 'bool', need_lvl = false, extra_id = 0}
AbilityValuesDB.MissileSpeed = {value_id = "amsp", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.Name = {value_id = "anam", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.OrderStringActivate = {value_id = "aoro", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.OrderStringDeactivate = {value_id = "aorf", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.OrderStringTurnOff = {value_id = "aoru", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.OrderStringUseTurnOn = {value_id = "aord", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.PriorityForSpellSteal = {value_id = "apri", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.Race = {value_id = "arac", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.RequiredLevel = {value_id = "arlv", value_type = 'int', need_lvl = false, extra_id = 0}
AbilityValuesDB.Requirements = {value_id = "areq", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.RequirementsLevels = {value_id = "arqa", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.SpecialAttachmentPoint = {value_id = "aspt", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.TargetAttachmentPoint = {value_id = "ata0", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.TargetAttachmentPoint1 = {value_id = "ata1", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.TargetAttachmentPoint2 = {value_id = "ata2", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.TargetAttachmentPoint3 = {value_id = "ata3", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.TargetAttachmentPoint4 = {value_id = "ata4", value_type = 'string', need_lvl = false, extra_id = 0}
AbilityValuesDB.TargetAttachmentPoint5 = {value_id = "ata5", value_type = 'string', need_lvl = false, extra_id = 0}

AbilityValuesDB.TargetAttachments = {value_id = "atac", value_type = 'int', need_lvl = true, extra_id = 0}
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
AbilityValuesDB.TargetsAllowed = {value_id = "atar", value_type = 'string', need_lvl = true, extra_id = 0}
AbilityValuesDB.TooltipLearn = {value_id = "aret", value_type = 'string', need_lvl = true, extra_id = 0}
AbilityValuesDB.TooltipLearnExtended = {value_id = "arut", value_type = 'string', need_lvl = true, extra_id = 0}
AbilityValuesDB.TooltipNormal = {value_id = "atp1", value_type = 'string', need_lvl = true, extra_id = 0}
AbilityValuesDB.TooltipNormalExtended = {value_id = "aub1", value_type = 'string', need_lvl = true, extra_id = 0}
AbilityValuesDB.TooltipTurnOff = {value_id = "aut1", value_type = 'string', need_lvl = true, extra_id = 0}
AbilityValuesDB.TooltipTurnOffExtended = {value_id = "auu1", value_type = 'string', need_lvl = true, extra_id = 0}

AbilityValuesDB.ANcl = {}
AbilityValuesDB.ANcl.ArtDuration = {value_id = "Ncl4", value_type = 'unreal', need_lvl = true, extra_id = 4}
AbilityValuesDB.ANcl.BaseOrderID = {value_id = "Ncl6", value_type = 'string', need_lvl = true, extra_id = 6}
AbilityValuesDB.ANcl.DisableOtherAbilities = {value_id = "Ncl5", value_type = 'bool', need_lvl = true, extra_id = 5}
AbilityValuesDB.ANcl.FollowThroughTime = {value_id = "Ncl1", value_type = 'unreal', need_lvl = true, extra_id = 1}
--- 0 - none; 1 - unit; 2 - point; 3 - point or unit
AbilityValuesDB.ANcl.TargetType = {value_id = "Ncl2", value_type = 'int', need_lvl = true, extra_id = 2}
--- Summ of flags: visible - 1, area target - 2, material - 4, universal - 8, group - 16
AbilityValuesDB.ANcl.Options = {value_id = "Ncl3", value_type = 'int', need_lvl = true, extra_id = 3}


return AbilityValuesDB