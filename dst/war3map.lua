  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["unit.HeroCompiletimeData"] = function()
    local HeroCompiletimeData = {}
    local HeroCompiletimeData_meta = {__index = HeroCompiletimeData}
    function HeroCompiletimeData.new()
      local data = {}
      setmetatable(data, HeroCompiletimeData_meta)
      return data
    end
    function HeroCompiletimeData:setField(name, value)
      self[name] = value
    end
    function HeroCompiletimeData:getField(name)
      return self[name]
    end
    function HeroCompiletimeData:generate(base_id)
      if (not WeObjEdit) then
        print("WeObjEdit module is not loaded.")
        return nil
      end
      self.Id = WeObjEdit.Utils.nextHeroId()
      local hero = WeObjEdit.Unit.Hero.new(self.Id, ID2str(ID(base_id)))
      if (self.Name) then
        hero:setName(self.Name)
      end
      if (self.TooltipExtended) then
        hero:setTooltipExtended(self.TooltipExtended)
      end
      if (self.TooltipBasic) then
        hero:setTooltipBasic(self.TooltipBasic)
      end
      if (self.RequirementsLevels) then
        hero:setRequirementsLevels(self.RequirementsLevels)
      end
      if (self.Requirements) then
        hero:setRequirements(self.Requirements)
      end
      if (self.Hotkey) then
        hero:setHotkey(self.Hotkey)
      end
      if (self.Description) then
        hero:setDescription(self.Description)
      end
      if (self.ButtonPositionY) then
        hero:setButtonPositionY(self.ButtonPositionY)
      end
      if (self.ButtonPositionX) then
        hero:setButtonPositionX(self.ButtonPositionX)
      end
      if (self.ItemsSold) then
        hero:setItemsSold(self.ItemsSold)
      end
      if (self.UnitsSold) then
        hero:setUnitsSold(self.UnitsSold)
      end
      if (self.HideMinimapDisplay) then
        hero:setHideMinimapDisplay(self.HideMinimapDisplay)
      end
      if (self.UseExtendedLineofSight) then
        hero:setUseExtendedLineofSight(self.UseExtendedLineofSight)
      end
      if (self.UseClickHelper) then
        hero:setUseClickHelper(self.UseClickHelper)
      end
      if (self.UpgradesUsed) then
        hero:setUpgradesUsed(self.UpgradesUsed)
      end
      if (self.UnitSoundSet) then
        hero:setUnitSoundSet(self.UnitSoundSet)
      end
      if (self.UnitClassification) then
        hero:setUnitClassification(self.UnitClassification)
      end
      if (self.MovementType) then
        hero:setMovementType(self.MovementType)
      end
      if (self.TurnRate) then
        hero:setTurnRate(self.TurnRate)
      end
      if (self.TintingColorBlue) then
        hero:setTintingColorBlue(self.TintingColorBlue)
      end
      if (self.TintingColorGreen) then
        hero:setTintingColorGreen(self.TintingColorGreen)
      end
      if (self.TintingColorRed) then
        hero:setTintingColorRed(self.TintingColorRed)
      end
      if (self.Tilesets) then
        hero:setTilesets(self.Tilesets)
      end
      if (self.TeamColor) then
        hero:setTeamColor(self.TeamColor)
      end
      if (self.TargetedAs) then
        hero:setTargetedAs(self.TargetedAs)
      end
      if (self.ArtTarget) then
        hero:setArtTarget(self.ArtTarget)
      end
      if (self.StockStartDelay) then
        hero:setStockStartDelay(self.StockStartDelay)
      end
      if (self.StockReplenishInterval) then
        hero:setStockReplenishInterval(self.StockReplenishInterval)
      end
      if (self.StockMaximum) then
        hero:setStockMaximum(self.StockMaximum)
      end
      if (self.SpeedMinimum) then
        hero:setSpeedMinimum(self.SpeedMinimum)
      end
      if (self.SpeedMaximum) then
        hero:setSpeedMaximum(self.SpeedMaximum)
      end
      if (self.SpeedBase) then
        hero:setSpeedBase(self.SpeedBase)
      end
      if (self.ArtSpecial) then
        hero:setArtSpecial(self.ArtSpecial)
      end
      if (self.Sleeps) then
        hero:setSleeps(self.Sleeps)
      end
      if (self.SightRadiusNight) then
        hero:setSightRadiusNight(self.SightRadiusNight)
      end
      if (self.SightRadiusDay) then
        hero:setSightRadiusDay(self.SightRadiusDay)
      end
      if (self.ShadowTextureBuilding) then
        hero:setShadowTextureBuilding(self.ShadowTextureBuilding)
      end
      if (self.ShadowImageWidth) then
        hero:setShadowImageWidth(self.ShadowImageWidth)
      end
      if (self.ShadowImageUnit) then
        hero:setShadowImageUnit(self.ShadowImageUnit)
      end
      if (self.ShadowImageHeight) then
        hero:setShadowImageHeight(self.ShadowImageHeight)
      end
      if (self.ShadowImageCenterY) then
        hero:setShadowImageCenterY(self.ShadowImageCenterY)
      end
      if (self.ShadowImageCenterX) then
        hero:setShadowImageCenterX(self.ShadowImageCenterX)
      end
      if (self.SelectionScale) then
        hero:setSelectionScale(self.SelectionScale)
      end
      if (self.SelectionCircleOnWater) then
        hero:setSelectionCircleOnWater(self.SelectionCircleOnWater)
      end
      if (self.SelectionCircleHeight) then
        hero:setSelectionCircleHeight(self.SelectionCircleHeight)
      end
      if (self.ScalingValue) then
        hero:setScalingValue(self.ScalingValue)
      end
      if (self.ScaleProjectiles) then
        hero:setScaleProjectiles(self.ScaleProjectiles)
      end
      if (self.RequiredBoneNames) then
        hero:setRequiredBoneNames(self.RequiredBoneNames)
      end
      if (self.RequiredAttachmentLinkNames) then
        hero:setRequiredAttachmentLinkNames(self.RequiredAttachmentLinkNames)
      end
      if (self.RequiredAnimationNamesAttachments) then
        hero:setRequiredAnimationNamesAttachments(self.RequiredAnimationNamesAttachments)
      end
      if (self.RequiredAnimationNames) then
        hero:setRequiredAnimationNames(self.RequiredAnimationNames)
      end
      if (self.RepairTime) then
        hero:setRepairTime(self.RepairTime)
      end
      if (self.RepairLumberCost) then
        hero:setRepairLumberCost(self.RepairLumberCost)
      end
      if (self.RepairGoldCost) then
        hero:setRepairGoldCost(self.RepairGoldCost)
      end
      if (self.RandomSound) then
        hero:setRandomSound(self.RandomSound)
      end
      if (self.Race) then
        hero:setRace(self.Race)
      end
      if (self.PropulsionWindowdegrees) then
        hero:setPropulsionWindowdegrees(self.PropulsionWindowdegrees)
      end
      if (self.ProjectileLaunchZSwimming) then
        hero:setProjectileLaunchZSwimming(self.ProjectileLaunchZSwimming)
      end
      if (self.ProjectileLaunchZ) then
        hero:setProjectileLaunchZ(self.ProjectileLaunchZ)
      end
      if (self.ProjectileLaunchY) then
        hero:setProjectileLaunchY(self.ProjectileLaunchY)
      end
      if (self.ProjectileLaunchX) then
        hero:setProjectileLaunchX(self.ProjectileLaunchX)
      end
      if (self.ProjectileImpactZSwimming) then
        hero:setProjectileImpactZSwimming(self.ProjectileImpactZSwimming)
      end
      if (self.ProjectileImpactZ) then
        hero:setProjectileImpactZ(self.ProjectileImpactZ)
      end
      if (self.Priority) then
        hero:setPriority(self.Priority)
      end
      if (self.PointValue) then
        hero:setPointValue(self.PointValue)
      end
      if (self.PlaceableInEditor) then
        hero:setPlaceableInEditor(self.PlaceableInEditor)
      end
      if (self.OrientationInterpolation) then
        hero:setOrientationInterpolation(self.OrientationInterpolation)
      end
      if (self.OccluderHeight) then
        hero:setOccluderHeight(self.OccluderHeight)
      end
      if (self.NormalAbilities) then
        hero:setNormalAbilities(self.NormalAbilities)
      end
      if (self.NameEditorSuffix) then
        hero:setNameEditorSuffix(self.NameEditorSuffix)
      end
      if (self.MovementSound) then
        hero:setMovementSound(self.MovementSound)
      end
      if (self.ModelFileExtraVersions) then
        hero:setModelFileExtraVersions(self.ModelFileExtraVersions)
      end
      if (self.ModelFile) then
        hero:setModelFile(self.ModelFile)
      end
      if (self.MinimumAttackRange) then
        hero:setMinimumAttackRange(self.MinimumAttackRange)
      end
      if (self.MaximumRollAngledegrees) then
        hero:setMaximumRollAngledegrees(self.MaximumRollAngledegrees)
      end
      if (self.MaximumPitchAngledegrees) then
        hero:setMaximumPitchAngledegrees(self.MaximumPitchAngledegrees)
      end
      if (self.ManaRegeneration) then
        hero:setManaRegeneration(self.ManaRegeneration)
      end
      if (self.ManaMaximum) then
        hero:setManaMaximum(self.ManaMaximum)
      end
      if (self.ManaInitialAmount) then
        hero:setManaInitialAmount(self.ManaInitialAmount)
      end
      if (self.LumberCost) then
        hero:setLumberCost(self.LumberCost)
      end
      if (self.SoundLoopingFadeOutRate) then
        hero:setSoundLoopingFadeOutRate(self.SoundLoopingFadeOutRate)
      end
      if (self.SoundLoopingFadeInRate) then
        hero:setSoundLoopingFadeInRate(self.SoundLoopingFadeInRate)
      end
      if (self.IsaBuilding) then
        hero:setIsaBuilding(self.IsaBuilding)
      end
      if (self.IconScoreScreen) then
        hero:setIconScoreScreen(self.IconScoreScreen)
      end
      if (self.IconGameInterface) then
        hero:setIconGameInterface(self.IconGameInterface)
      end
      if (self.HitPointsRegenerationType) then
        hero:setHitPointsRegenerationType(self.HitPointsRegenerationType)
      end
      if (self.HitPointsRegenerationRate) then
        hero:setHitPointsRegenerationRate(self.HitPointsRegenerationRate)
      end
      if (self.HitPointsMaximumBase) then
        hero:setHitPointsMaximumBase(self.HitPointsMaximumBase)
      end
      if (self.MovementHeightMinimum) then
        hero:setMovementHeightMinimum(self.MovementHeightMinimum)
      end
      if (self.MovementHeight) then
        hero:setMovementHeight(self.MovementHeight)
      end
      if (self.HasWaterShadow) then
        hero:setHasWaterShadow(self.HasWaterShadow)
      end
      if (self.HasTilesetSpecificData) then
        hero:setHasTilesetSpecificData(self.HasTilesetSpecificData)
      end
      if (self.GoldCost) then
        hero:setGoldCost(self.GoldCost)
      end
      if (self.GoldBountyAwardedSidesperDie) then
        hero:setGoldBountyAwardedSidesperDie(self.GoldBountyAwardedSidesperDie)
      end
      if (self.GoldBountyAwardedbooleanofDice) then
        hero:setGoldBountyAwardedbooleanofDice(self.GoldBountyAwardedbooleanofDice)
      end
      if (self.GoldBountyAwardedBase) then
        hero:setGoldBountyAwardedBase(self.GoldBountyAwardedBase)
      end
      if (self.LumberBountyAwardedSidesperDie) then
        hero:setLumberBountyAwardedSidesperDie(self.LumberBountyAwardedSidesperDie)
      end
      if (self.LumberBountyAwardedbooleanofDice) then
        hero:setLumberBountyAwardedbooleanofDice(self.LumberBountyAwardedbooleanofDice)
      end
      if (self.LumberBountyAwardedBase) then
        hero:setLumberBountyAwardedBase(self.LumberBountyAwardedBase)
      end
      if (self.FoodProduced) then
        hero:setFoodProduced(self.FoodProduced)
      end
      if (self.FoodCost) then
        hero:setFoodCost(self.FoodCost)
      end
      if (self.FogOfWarSampleRadius) then
        hero:setFogOfWarSampleRadius(self.FogOfWarSampleRadius)
      end
      if (self.ElevationSampleRadius) then
        hero:setElevationSampleRadius(self.ElevationSampleRadius)
      end
      if (self.ElevationSamplePoints) then
        hero:setElevationSamplePoints(self.ElevationSamplePoints)
      end
      if (self.DisplayasNeutralHostile) then
        hero:setDisplayasNeutralHostile(self.DisplayasNeutralHostile)
      end
      if (self.DependencyEquivalents) then
        hero:setDependencyEquivalents(self.DependencyEquivalents)
      end
      if (self.DefenseUpgradeBonus) then
        hero:setDefenseUpgradeBonus(self.DefenseUpgradeBonus)
      end
      if (self.ArmorType) then
        hero:setArmorType(self.ArmorType)
      end
      if (self.DefenseBase) then
        hero:setDefenseBase(self.DefenseBase)
      end
      if (self.DefaultActiveAbility) then
        hero:setDefaultActiveAbility(self.DefaultActiveAbility)
      end
      if (self.DeathType) then
        hero:setDeathType(self.DeathType)
      end
      if (self.DeathTimeseconds) then
        hero:setDeathTimeseconds(self.DeathTimeseconds)
      end
      if (self.CollisionSize) then
        hero:setCollisionSize(self.CollisionSize)
      end
      if (self.CategorizationSpecial) then
        hero:setCategorizationSpecial(self.CategorizationSpecial)
      end
      if (self.CategorizationCampaign) then
        hero:setCategorizationCampaign(self.CategorizationCampaign)
      end
      if (self.CanFlee) then
        hero:setCanFlee(self.CanFlee)
      end
      if (self.CanDropItemsOnDeath) then
        hero:setCanDropItemsOnDeath(self.CanDropItemsOnDeath)
      end
      if (self.BuildTime) then
        hero:setBuildTime(self.BuildTime)
      end
      if (self.AttacksEnabled) then
        hero:setAttacksEnabled(self.AttacksEnabled)
      end
      if (self.Attack2WeaponType) then
        hero:setAttack2WeaponType(self.Attack2WeaponType)
      end
      if (self.Attack2WeaponSound) then
        hero:setAttack2WeaponSound(self.Attack2WeaponSound)
      end
      if (self.Attack2TargetsAllowed) then
        hero:setAttack2TargetsAllowed(self.Attack2TargetsAllowed)
      end
      if (self.Attack2ShowUI) then
        hero:setAttack2ShowUI(self.Attack2ShowUI)
      end
      if (self.Attack2RangeMotionBuffer) then
        hero:setAttack2RangeMotionBuffer(self.Attack2RangeMotionBuffer)
      end
      if (self.Attack2Range) then
        hero:setAttack2Range(self.Attack2Range)
      end
      if (self.Attack2ProjectileSpeed) then
        hero:setAttack2ProjectileSpeed(self.Attack2ProjectileSpeed)
      end
      if (self.Attack2ProjectileHomingEnabled) then
        hero:setAttack2ProjectileHomingEnabled(self.Attack2ProjectileHomingEnabled)
      end
      if (self.Attack2ProjectileArt) then
        hero:setAttack2ProjectileArt(self.Attack2ProjectileArt)
      end
      if (self.Attack2ProjectileArc) then
        hero:setAttack2ProjectileArc(self.Attack2ProjectileArc)
      end
      if (self.Attack2MaximumbooleanofTargets) then
        hero:setAttack2MaximumbooleanofTargets(self.Attack2MaximumbooleanofTargets)
      end
      if (self.Attack2DamageUpgradeAmount) then
        hero:setAttack2DamageUpgradeAmount(self.Attack2DamageUpgradeAmount)
      end
      if (self.Attack2DamageSpillRadius) then
        hero:setAttack2DamageSpillRadius(self.Attack2DamageSpillRadius)
      end
      if (self.Attack2DamageSpillDistance) then
        hero:setAttack2DamageSpillDistance(self.Attack2DamageSpillDistance)
      end
      if (self.Attack2DamageSidesperDie) then
        hero:setAttack2DamageSidesperDie(self.Attack2DamageSidesperDie)
      end
      if (self.Attack2DamagebooleanofDice) then
        hero:setAttack2DamagebooleanofDice(self.Attack2DamagebooleanofDice)
      end
      if (self.Attack2DamageLossFactor) then
        hero:setAttack2DamageLossFactor(self.Attack2DamageLossFactor)
      end
      if (self.Attack2DamageFactorSmall) then
        hero:setAttack2DamageFactorSmall(self.Attack2DamageFactorSmall)
      end
      if (self.Attack2DamageFactorMedium) then
        hero:setAttack2DamageFactorMedium(self.Attack2DamageFactorMedium)
      end
      if (self.Attack2DamageBase) then
        hero:setAttack2DamageBase(self.Attack2DamageBase)
      end
      if (self.Attack2CooldownTime) then
        hero:setAttack2CooldownTime(self.Attack2CooldownTime)
      end
      if (self.Attack2AttackType) then
        hero:setAttack2AttackType(self.Attack2AttackType)
      end
      if (self.Attack2AreaofEffectTargets) then
        hero:setAttack2AreaofEffectTargets(self.Attack2AreaofEffectTargets)
      end
      if (self.Attack2AreaofEffectSmallDamage) then
        hero:setAttack2AreaofEffectSmallDamage(self.Attack2AreaofEffectSmallDamage)
      end
      if (self.Attack2AreaofEffectMediumDamage) then
        hero:setAttack2AreaofEffectMediumDamage(self.Attack2AreaofEffectMediumDamage)
      end
      if (self.Attack2AreaofEffectFullDamage) then
        hero:setAttack2AreaofEffectFullDamage(self.Attack2AreaofEffectFullDamage)
      end
      if (self.Attack2AnimationDamagePoint) then
        hero:setAttack2AnimationDamagePoint(self.Attack2AnimationDamagePoint)
      end
      if (self.Attack2AnimationBackswingPoint) then
        hero:setAttack2AnimationBackswingPoint(self.Attack2AnimationBackswingPoint)
      end
      if (self.Attack1WeaponType) then
        hero:setAttack1WeaponType(self.Attack1WeaponType)
      end
      if (self.Attack1WeaponSound) then
        hero:setAttack1WeaponSound(self.Attack1WeaponSound)
      end
      if (self.Attack1TargetsAllowed) then
        hero:setAttack1TargetsAllowed(self.Attack1TargetsAllowed)
      end
      if (self.Attack1ShowUI) then
        hero:setAttack1ShowUI(self.Attack1ShowUI)
      end
      if (self.Attack1RangeMotionBuffer) then
        hero:setAttack1RangeMotionBuffer(self.Attack1RangeMotionBuffer)
      end
      if (self.Attack1Range) then
        hero:setAttack1Range(self.Attack1Range)
      end
      if (self.Attack1ProjectileSpeed) then
        hero:setAttack1ProjectileSpeed(self.Attack1ProjectileSpeed)
      end
      if (self.Attack1ProjectileHomingEnabled) then
        hero:setAttack1ProjectileHomingEnabled(self.Attack1ProjectileHomingEnabled)
      end
      if (self.Attack1ProjectileArt) then
        hero:setAttack1ProjectileArt(self.Attack1ProjectileArt)
      end
      if (self.Attack1ProjectileArc) then
        hero:setAttack1ProjectileArc(self.Attack1ProjectileArc)
      end
      if (self.Attack1MaximumbooleanofTargets) then
        hero:setAttack1MaximumbooleanofTargets(self.Attack1MaximumbooleanofTargets)
      end
      if (self.Attack1DamageUpgradeAmount) then
        hero:setAttack1DamageUpgradeAmount(self.Attack1DamageUpgradeAmount)
      end
      if (self.Attack1DamageSpillRadius) then
        hero:setAttack1DamageSpillRadius(self.Attack1DamageSpillRadius)
      end
      if (self.Attack1DamageSpillDistance) then
        hero:setAttack1DamageSpillDistance(self.Attack1DamageSpillDistance)
      end
      if (self.Attack1DamageSidesperDie) then
        hero:setAttack1DamageSidesperDie(self.Attack1DamageSidesperDie)
      end
      if (self.Attack1DamagebooleanofDice) then
        hero:setAttack1DamagebooleanofDice(self.Attack1DamagebooleanofDice)
      end
      if (self.Attack1DamageLossFactor) then
        hero:setAttack1DamageLossFactor(self.Attack1DamageLossFactor)
      end
      if (self.Attack1DamageFactorSmall) then
        hero:setAttack1DamageFactorSmall(self.Attack1DamageFactorSmall)
      end
      if (self.Attack1DamageFactorMedium) then
        hero:setAttack1DamageFactorMedium(self.Attack1DamageFactorMedium)
      end
      if (self.Attack1DamageBase) then
        hero:setAttack1DamageBase(self.Attack1DamageBase)
      end
      if (self.Attack1CooldownTime) then
        hero:setAttack1CooldownTime(self.Attack1CooldownTime)
      end
      if (self.Attack1AttackType) then
        hero:setAttack1AttackType(self.Attack1AttackType)
      end
      if (self.Attack1AreaofEffectTargets) then
        hero:setAttack1AreaofEffectTargets(self.Attack1AreaofEffectTargets)
      end
      if (self.Attack1AreaofEffectSmallDamage) then
        hero:setAttack1AreaofEffectSmallDamage(self.Attack1AreaofEffectSmallDamage)
      end
      if (self.Attack1AreaofEffectMediumDamage) then
        hero:setAttack1AreaofEffectMediumDamage(self.Attack1AreaofEffectMediumDamage)
      end
      if (self.Attack1AreaofEffectFullDamage) then
        hero:setAttack1AreaofEffectFullDamage(self.Attack1AreaofEffectFullDamage)
      end
      if (self.Attack1AnimationDamagePoint) then
        hero:setAttack1AnimationDamagePoint(self.Attack1AnimationDamagePoint)
      end
      if (self.Attack1AnimationBackswingPoint) then
        hero:setAttack1AnimationBackswingPoint(self.Attack1AnimationBackswingPoint)
      end
      if (self.ArmorSoundType) then
        hero:setArmorSoundType(self.ArmorSoundType)
      end
      if (self.AnimationWalkSpeed) then
        hero:setAnimationWalkSpeed(self.AnimationWalkSpeed)
      end
      if (self.AnimationRunSpeed) then
        hero:setAnimationRunSpeed(self.AnimationRunSpeed)
      end
      if (self.AnimationCastPoint) then
        hero:setAnimationCastPoint(self.AnimationCastPoint)
      end
      if (self.AnimationCastBackswing) then
        hero:setAnimationCastBackswing(self.AnimationCastBackswing)
      end
      if (self.AnimationBlendTimeseconds) then
        hero:setAnimationBlendTimeseconds(self.AnimationBlendTimeseconds)
      end
      if (self.AllowCustomTeamColor) then
        hero:setAllowCustomTeamColor(self.AllowCustomTeamColor)
      end
      if (self.AIPlacementType) then
        hero:setAIPlacementType(self.AIPlacementType)
      end
      if (self.AIPlacementRadius) then
        hero:setAIPlacementRadius(self.AIPlacementRadius)
      end
      if (self.TransportedSize) then
        hero:setTransportedSize(self.TransportedSize)
      end
      if (self.Level) then
        hero:setLevel(self.Level)
      end
      if (self.GroupSeparationPriority) then
        hero:setGroupSeparationPriority(self.GroupSeparationPriority)
      end
      if (self.GroupSeparationParameter) then
        hero:setGroupSeparationParameter(self.GroupSeparationParameter)
      end
      if (self.GroupSeparationGroupNumber) then
        hero:setGroupSeparationGroupNumber(self.GroupSeparationGroupNumber)
      end
      if (self.GroupSeparationEnabled) then
        hero:setGroupSeparationEnabled(self.GroupSeparationEnabled)
      end
      if (self.FormationRank) then
        hero:setFormationRank(self.FormationRank)
      end
      if (self.StructuresBuilt) then
        hero:setStructuresBuilt(self.StructuresBuilt)
      end
      if (self.HideHeroDeathMsg) then
        hero:setHideHeroDeathMsg(self.HideHeroDeathMsg)
      end
      if (self.HideHeroInterfaceIcon) then
        hero:setHideHeroInterfaceIcon(self.HideHeroInterfaceIcon)
      end
      if (self.HideHeroMinimapDisplay) then
        hero:setHideHeroMinimapDisplay(self.HideHeroMinimapDisplay)
      end
      if (self.TooltipRevive) then
        hero:setTooltipRevive(self.TooltipRevive)
      end
      if (self.TooltipAwaken) then
        hero:setTooltipAwaken(self.TooltipAwaken)
      end
      if (self.StrengthPerLevel) then
        hero:setStrengthPerLevel(self.StrengthPerLevel)
      end
      if (self.StartingStrength) then
        hero:setStartingStrength(self.StartingStrength)
      end
      if (self.StartingIntelligence) then
        hero:setStartingIntelligence(self.StartingIntelligence)
      end
      if (self.StartingAgility) then
        hero:setStartingAgility(self.StartingAgility)
      end
      if (self.ProperNamesUsed) then
        hero:setProperNamesUsed(self.ProperNamesUsed)
      end
      if (self.ProperNames) then
        hero:setProperNames(self.ProperNames)
      end
      if (self.PrimaryAttribute) then
        hero:setPrimaryAttribute(self.PrimaryAttribute)
      end
      if (self.IntelligencePerLevel) then
        hero:setIntelligencePerLevel(self.IntelligencePerLevel)
      end
      if (self.HeroRevivalLocations) then
        hero:setHeroRevivalLocations(self.HeroRevivalLocations)
      end
      if (self.HeroAbilities) then
        hero:setHeroAbilities(self.HeroAbilities)
      end
      if (self.AgilityPerLevel) then
        hero:setAgilityPerLevel(self.AgilityPerLevel)
      end
      if (self.RequierementsForTier1) then
        hero:setRequierementsForTier1(self.RequierementsForTier1)
      end
      if (self.RequierementsForTier2) then
        hero:setRequierementsForTier2(self.RequierementsForTier2)
      end
      if (self.RequierementsForTier3) then
        hero:setRequierementsForTier3(self.RequierementsForTier3)
      end
      if (self.RequierementsForTier4) then
        hero:setRequierementsForTier4(self.RequierementsForTier4)
      end
      if (self.RequierementsForTier5) then
        hero:setRequierementsForTier5(self.RequierementsForTier5)
      end
      if (self.RequierementsForTier6) then
        hero:setRequierementsForTier6(self.RequierementsForTier6)
      end
      if (self.RequierementsForTier7) then
        hero:setRequierementsForTier7(self.RequierementsForTier7)
      end
      if (self.RequierementsForTier8) then
        hero:setRequierementsForTier8(self.RequierementsForTier8)
      end
      if (self.RequierementsForTier9) then
        hero:setRequierementsForTier9(self.RequierementsForTier9)
      end
      if (self.UpgradesTo) then
        hero:setUpgradesTo(self.UpgradesTo)
      end
      if (self.UnitsTrained) then
        hero:setUnitsTrained(self.UnitsTrained)
      end
      if (self.RevivesDeadHeros) then
        hero:setRevivesDeadHeros(self.RevivesDeadHeros)
      end
      if (self.ResearchesAvailable) then
        hero:setResearchesAvailable(self.ResearchesAvailable)
      end
      if (self.PlacementRequiresWaterRadius) then
        hero:setPlacementRequiresWaterRadius(self.PlacementRequiresWaterRadius)
      end
      if (self.PlacementRequires) then
        hero:setPlacementRequires(self.PlacementRequires)
      end
      if (self.PlacementPreventedBy) then
        hero:setPlacementPreventedBy(self.PlacementPreventedBy)
      end
      if (self.PathingMap) then
        hero:setPathingMap(self.PathingMap)
      end
      if (self.NeutralBuildingValidAsRandomBuilding) then
        hero:setNeutralBuildingValidAsRandomBuilding(self.NeutralBuildingValidAsRandomBuilding)
      end
      if (self.NeutralBuildingShowsMinimapIcon) then
        hero:setNeutralBuildingShowsMinimapIcon(self.NeutralBuildingShowsMinimapIcon)
      end
      if (self.ItemsMade) then
        hero:setItemsMade(self.ItemsMade)
      end
      if (self.GroundTexture) then
        hero:setGroundTexture(self.GroundTexture)
      end
      if (self.ConstructionSound) then
        hero:setConstructionSound(self.ConstructionSound)
      end
      if (self.TooltipRevive) then
        hero:setTooltipRevive(self.TooltipRevive)
      end
      if (self.TooltipAwaken) then
        hero:setTooltipAwaken(self.TooltipAwaken)
      end
      if (self.StrengthPerLevel) then
        hero:setStrengthPerLevel(self.StrengthPerLevel)
      end
      if (self.StartingStrength) then
        hero:setStartingStrength(self.StartingStrength)
      end
      if (self.StartingIntelligence) then
        hero:setStartingIntelligence(self.StartingIntelligence)
      end
      if (self.StartingAgility) then
        hero:setStartingAgility(self.StartingAgility)
      end
      if (self.ProperNamesUsed) then
        hero:setProperNamesUsed(self.ProperNamesUsed)
      end
      if (self.ProperNames) then
        hero:setProperNames(self.ProperNames)
      end
      if (self.PrimaryAttribute) then
        hero:setPrimaryAttribute(self.PrimaryAttribute)
      end
      if (self.IntelligencePerLevel) then
        hero:setIntelligencePerLevel(self.IntelligencePerLevel)
      end
      if (self.HeroRevivalLocations) then
        hero:setHeroRevivalLocations(self.HeroRevivalLocations)
      end
      if (self.HeroAbilities) then
        hero:setHeroAbilities(self.HeroAbilities)
      end
      if (self.AgilityPerLevel) then
        hero:setAgilityPerLevel(self.AgilityPerLevel)
      end
    end
    return HeroCompiletimeData
end
__require_data.module["ability.ChannelCompiletimeData"] = function()
    local ChannelCompiletimeData = {}
    local ChannelCompiletimeData_meta = {__index = ChannelCompiletimeData}
    ChannelCompiletimeData.option = {is_visible = 1, is_areaTarget = 2, is_matereal = 4, is_universal = 8, is_group = 16}
    function ChannelCompiletimeData.new()
      local data = {}
      setmetatable(data, ChannelCompiletimeData_meta)
      return data
    end
    function ChannelCompiletimeData:setField(name, value)
      self[name] = value
    end
    function ChannelCompiletimeData:getField(name)
      return self[name]
    end
    function ChannelCompiletimeData:generate()
      if (not WeObjEdit) then
        print("WeObjEdit module is not loaded.")
        return nil
      end
      self.Id = WeObjEdit.Utils.nextAbilId()
      self.OrderId = WeObjEdit.Utils.nextOrderId()
      local abil = WeObjEdit.Ability.Channel.new(self.Id)
      local max_lvl = 1
      if (self.Levels) then
        max_lvl = self.Levels
      end
      abil:setLevels(max_lvl)
      if (self.Name) then
        abil:setName(self.Name)
      end
      if (self.EditorSuffix) then
        abil:setEditorSuffix(self.EditorSuffix)
      end
      if (self.HeroAbility) then
        abil:setHeroAbility(self.HeroAbility)
      end
      if (self.ItemAbility) then
        abil:setItemAbility(self.ItemAbility)
      end
      if (self.Race) then
        abil:setRace(self.Race)
      end
      if (self.ButtonPositionNormalX) then
        abil:setButtonPositionNormalX(self.ButtonPositionNormalX)
      end
      if (self.ButtonPositionNormalY) then
        abil:setButtonPositionNormalY(self.ButtonPositionNormalY)
      end
      if (self.ButtonPositionTurnOffX) then
        abil:setButtonPositionTurnOffX(self.ButtonPositionTurnOffX)
      end
      if (self.ButtonPositionTurnOffY) then
        abil:setButtonPositionTurnOffY(self.ButtonPositionTurnOffY)
      end
      if (self.ButtonPositionResearchX) then
        abil:setButtonPositionResearchX(self.ButtonPositionResearchX)
      end
      if (self.ButtonPositionResearchY) then
        abil:setButtonPositionResearchY(self.ButtonPositionResearchY)
      end
      if (self.IconNormal) then
        abil:setIconNormal(self.IconNormal)
      end
      if (self.IconTurnOff) then
        abil:setIconTurnOff(self.IconTurnOff)
      end
      if (self.IconResearch) then
        abil:setIconResearch(self.IconResearch)
      end
      if (self.ArtCaster) then
        abil:setArtCaster(self.ArtCaster)
      end
      if (self.ArtTarget) then
        abil:setArtTarget(self.ArtTarget)
      end
      if (self.ArtSpecial) then
        abil:setArtSpecial(self.ArtSpecial)
      end
      if (self.ArtEffect) then
        abil:setArtEffect(self.ArtEffect)
      end
      if (self.AreaEffect) then
        abil:setAreaEffect(self.AreaEffect)
      end
      if (self.LightningEffects) then
        abil:setLightningEffects(self.LightningEffects)
      end
      if (self.MissileArt) then
        abil:setMissileArt(self.MissileArt)
      end
      if (self.MissileSpeed) then
        abil:setMissileSpeed(self.MissileSpeed)
      end
      if (self.MissileArc) then
        abil:setMissileArc(self.MissileArc)
      end
      if (self.MissileHomingEnabled) then
        abil:setMissileHomingEnabled(self.MissileHomingEnabled)
      end
      if (self.TargetAttachments) then
        abil:setTargetAttachments(self.TargetAttachments)
      end
      if (self.TargetAttachmentPoint) then
        abil:setTargetAttachmentPoint(self.TargetAttachmentPoint)
      end
      if (self.TargetAttachmentPoint1) then
        abil:setTargetAttachmentPoint1(self.TargetAttachmentPoint1)
      end
      if (self.TargetAttachmentPoint2) then
        abil:setTargetAttachmentPoint2(self.TargetAttachmentPoint2)
      end
      if (self.TargetAttachmentPoint3) then
        abil:setTargetAttachmentPoint3(self.TargetAttachmentPoint3)
      end
      if (self.TargetAttachmentPoint4) then
        abil:setTargetAttachmentPoint4(self.TargetAttachmentPoint4)
      end
      if (self.TargetAttachmentPoint5) then
        abil:setTargetAttachmentPoint5(self.TargetAttachmentPoint5)
      end
      if (self.CasterAttachments) then
        abil:setCasterAttachments(self.CasterAttachments)
      end
      if (self.CasterAttachmentPoint) then
        abil:setCasterAttachmentPoint(self.CasterAttachmentPoint)
      end
      if (self.CasterAttachmentPoint1) then
        abil:setCasterAttachmentPoint1(self.CasterAttachmentPoint1)
      end
      if (self.SpecialAttachmentPoint) then
        abil:setSpecialAttachmentPoint(self.SpecialAttachmentPoint)
      end
      if (self.AnimationNames) then
        abil:setAnimationNames(self.AnimationNames)
      end
      if (self.TooltipLearn) then
        abil:setTooltipLearn(self.TooltipLearn)
      end
      if (self.TooltipLearnExtended) then
        abil:setTooltipLearnExtended(self.TooltipLearnExtended)
      end
      if (self.HotkeyLearn) then
        abil:setHotkeyLearn(self.HotkeyLearn)
      end
      if (self.HotkeyNormal) then
        abil:setHotkeyNormal(self.HotkeyNormal)
      end
      if (self.HotkeyTurnOff) then
        abil:setHotkeyTurnOff(self.HotkeyTurnOff)
      end
      if (self.Requirements) then
        abil:setRequirements(self.Requirements)
      end
      if (self.RequirementsLevels) then
        abil:setRequirementsLevels(self.RequirementsLevels)
      end
      if (self.CheckDependencies) then
        abil:setCheckDependencies(self.CheckDependencies)
      end
      if (self.PriorityforSpellSteal) then
        abil:setPriorityforSpellSteal(self.PriorityforSpellSteal)
      end
      if (self.OrderStringUseTurnOn) then
        abil:setOrderStringUseTurnOn(self.OrderStringUseTurnOn)
      end
      if (self.OrderStringTurnOff) then
        abil:setOrderStringTurnOff(self.OrderStringTurnOff)
      end
      if (self.OrderStringActivate) then
        abil:setOrderStringActivate(self.OrderStringActivate)
      end
      if (self.OrderStringDeactivate) then
        abil:setOrderStringDeactivate(self.OrderStringDeactivate)
      end
      if (self.EffectSound) then
        abil:setEffectSound(self.EffectSound)
      end
      if (self.EffectSoundLooping) then
        abil:setEffectSoundLooping(self.EffectSoundLooping)
      end
      if (self.Levels) then
        abil:setLevels(self.Levels)
      end
      if (self.RequiredLevel) then
        abil:setRequiredLevel(self.RequiredLevel)
      end
      if (self.LevelSkipRequirement) then
        abil:setLevelSkipRequirement(self.LevelSkipRequirement)
      end
      for lvl = 1, max_lvl do
        abil:setBaseOrderID(self.OrderId, lvl)
        if (self.TooltipNormal) then
          abil:setTooltipNormal(self.TooltipNormal, lvl)
        end
        if (self.TooltipTurnOff) then
          abil:setTooltipTurnOff(self.TooltipTurnOff, lvl)
        end
        if (self.TooltipNormalExtended) then
          abil:setTooltipNormalExtended(self.TooltipNormalExtended, lvl)
        end
        if (self.TooltipTurnOffExtended) then
          abil:setTooltipTurnOffExtended(self.TooltipTurnOffExtended, lvl)
        end
        if (self.TargetsAllowed) then
          abil:setTargetsAllowed(self.TargetsAllowed, lvl)
        end
        if (self.CastingTime) then
          abil:setCastingTime(self.CastingTime, lvl)
        end
        if (self.DurationNormal) then
          abil:setDurationNormal(self.DurationNormal, lvl)
        end
        if (self.DurationHero) then
          abil:setDurationHero(self.DurationHero, lvl)
        end
        if (self.Cooldown) then
          abil:setCooldown(self.Cooldown, lvl)
        end
        if (self.ManaCost) then
          abil:setManaCost(self.ManaCost, lvl)
        end
        if (self.AreaofEffect) then
          abil:setAreaofEffect(self.AreaofEffect, lvl)
        end
        if (self.CastRange) then
          abil:setCastRange(self.CastRange, lvl)
        end
        if (self.Buffs) then
          abil:setBuffs(self.Buffs, lvl)
        end
        if (self.Effects) then
          abil:setEffects(self.Effects, lvl)
        end
        if (self.ArtDuration) then
          abil:setArtDuration(self.ArtDuration, lvl)
        end
        if (self.BaseOrderID) then
          abil:setBaseOrderID(self.BaseOrderID, lvl)
        end
        if (self.DisableOtherAbilities) then
          abil:setDisableOtherAbilities(self.DisableOtherAbilities, lvl)
        end
        if (self.FollowThroughTime) then
          abil:setFollowThroughTime(self.FollowThroughTime, lvl)
        end
        if (self.TargetType) then
          abil:setTargetType(self.TargetType, lvl)
        end
        if (self.Options) then
          abil:setOptions(self.Options, lvl)
        end
      end
      return self.Id
    end
    return ChannelCompiletimeData
end
__require_data.module["ability.warlord.settings"] = function()
    local WarlordSettings = {SpearmanUnit = {NormalAbilities = "Avul,Aloc", SpeedBase = 1, HideHeroInterfaceIcon = true, Name = "Spearman", Id = "HM#$", HideHeroMinimapDisplay = true, CollisionSize = 0, ModelFile = "war3mapImported\\units\\SwordNya.mdx", HideHeroDeathMsg = true}, SummonSpearman = {ArtEffect = "", CastingTime = 0, ArtTarget = "", Options = 3, Name = "Summon spearman", OrderId = "acidbomb", TooltipNormal = "Summon spearman", FollowThroughTime = 0, Id = "AM#'", CustomCastingTime = 1, DisableOtherAbilities = false, CastRange = 500, TooltipNormalExtended = "Summons invulnerale spirit warrior.", Cooldown = 0, Levels = 1, ArtSpecial = "", AreaofEffect = 150, ArtCaster = "", HotkeyNormal = "X", TargetType = "point"}}
    return WarlordSettings
end
__require_data.module["ability.SummonsDB"] = function()
    local SummonDB = {}
    local MastersDB = {}
    local SlavesDB = {}
    function SummonDB.addSlave(slave, master)
      SlavesDB[slave] = master
      if (not MastersDB[master]) then
        MastersDB[master] = {}
      end
      table.insert(MastersDB[master], 1, slave)
    end
    function SummonDB.rmSlave(slave)
      local master = SlavesDB[slave]
      if (not master) then
        Debug("SummonDB: error trying to remove non summon unit.")
        return false
      end
      SlavesDB[slave] = nil
      local slaves = MastersDB[master]
      if (#slaves == 1) then
        MastersDB[master] = nil
        return true
      end
      local pos = -1
      for i = 0, #slaves do
        if (slaves[i] == slave) then
          pos = i
          break
        end
      end
      if (pos > 0) then
        table.remove(slaves, pos)
        return true
      end
      return false
    end
    function SummonDB.getMaster(slave)
      return SlavesDB[slave]
    end
    function SummonDB.getSlaves(master)
      return MastersDB[master]
    end
    return SummonDB
end
__require_data.module["ability.SpellData"] = function()
    local SpellData = {}
    local SpellData_meta = {__index = SpellData}
    function SpellData.new(ability, caster, target, x, y)
      local data = {__ability = ability, __caster = caster, __target = target, __x = x, __y = y, __cur_time = 0, __cast_time = 0}
      setmetatable(data, SpellData_meta)
      return data
    end
    function SpellData:getAll()
      return self.__ability, self.__caster, self.__target, self.__x, self.__y, self.__cur_time, self.__full_time
    end
    function SpellData:addTime(delta)
      self.__cur_time = (self.__cur_time+delta)
    end
    function SpellData:isFinished()
      return self.__cur_time >= self.__cast_time
    end
    function SpellData:setCastTime(time)
      self.__cast_time = time
    end
    function SpellData:getTime()
      return self.__cur_time
    end
    function SpellData:getCastTime()
      return self.__cast_time
    end
    function SpellData:getAbility()
      return self.__ability
    end
    function SpellData:getCaster()
      return self.__caster
    end
    function SpellData:getTarget()
      return self.__target
    end
    function SpellData:getX()
      return self.__x
    end
    function SpellData:getY()
      return self.__y
    end
    return SpellData
end
__require_data.module["ability.CasterDB"] = function()
    local CasterDB = {}
    function CasterDB.add(caster, data)
      CasterDB[caster] = data
    end
    function CasterDB.rm(caster)
      CasterDB[caster] = nil
    end
    function CasterDB.get(caster)
      return CasterDB[caster]
    end
    return CasterDB
end
__require_data.module["ability.AbilityDB"] = function()
    local AbilityDB = {}
    function AbilityDB.add(ability_id, ability)
      AbilityDB[ability_id] = ability
    end
    function AbilityDB.rm(ability_id)
      AbilityDB[ability_id] = nil
    end
    function AbilityDB.get(ability_id)
      return AbilityDB[ability_id]
    end
    return AbilityDB
end
__require_data.module["ability.AbilityEvent"] = function()
    local AbilityDB = require("ability.AbilityDB")
    local UnitEvent = require("trigger.events.unitEvent")
    local CasterDB = require("ability.CasterDB")
    local SpellData = require("ability.SpellData")
    local CastTimer = glTimer
    local AbilityEvent = {}
    function AbilityEvent.init()
      UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.startCast)
      UnitEvent.getTrigger("AnyUnitIssuedAnyOrder"):addAction(AbilityEvent.issuedOrder)
    end
    function AbilityEvent.getSpellTarget()
      local target = GetSpellTargetUnit()
      if (not target) then
        target = GetSpellTargetItem()
      end
      if (not target) then
        target = GetSpellTargetDestructable()
      end
      return target
    end
    function AbilityEvent.startCast()
      local ability = AbilityDB.get(GetSpellAbilityId())
      if (ability == nil) then
        return nil
      end
      local target = AbilityEvent.getSpellTarget()
      local caster = GetSpellAbilityUnit()
      local x = GetSpellTargetX()
      local y = GetSpellTargetY()
      local spell_data = SpellData.new(ability, caster, target, x, y)
      local cast_time = ability:getCastingTime(spell_data)
      spell_data:setCastTime(cast_time)
      local continue = ability:runCallback("start", spell_data)
      if (not continue) then
        caster:orderStop()
        return nil
      end
      CastTimer:addAction(0, AbilityEvent.timerPeriod, spell_data)
      CasterDB.add(caster, spell_data)
    end
    function AbilityEvent.timerPeriod(spell_data)
      if (spell_data ~= CasterDB.get(spell_data:getCaster())) then
        local abil = spell_data:getAbility()
        abil:runCallback("interrupt", spell_data)
        return nil
      end
      local delta = CastTimer:getPeriod()
      spell_data:addTime(delta)
      if (spell_data:isFinished()) then
        local abil = spell_data:getAbility()
        abil:runCallback("finish", spell_data)
        CasterDB.rm(spell_data:getCaster())
        return nil
      end
      local abil = spell_data:getAbility()
      local continue = abil:runCallback("casting", spell_data)
      if (continue) then
        CastTimer:addAction(0, AbilityEvent.timerPeriod, spell_data)
      else
        abil:runCallback("interrupt", spell_data)
        CasterDB.rm(spell_data:getCaster())
      end
    end
    function AbilityEvent.issuedOrder()
      local spell_data = CasterDB.get(GetSpellAbilityUnit())
      if (not spell_data) then
        return nil
      end
      local ability = spell_data:getAbility()
      if (ability:getFlag("OrderInterrupt")) then
        CasterDB.rm(GetSpellAbilityUnit())
      end
    end
    function AbilityEvent.unitPause(unit)

    end
    return AbilityEvent
end
__require_data.module["ability.Ability"] = function()
    require("ability.AbilityEvent")
    local AbilityDB = require("ability.AbilityDB")
    local Ability = {}
    local Ability_meta = {__index = Ability}
    function Ability_meta.__tostring(self)
      local str = string.format("Ability %s (%s) with callbacks: ", self:getName(), ID2str(self:getId()))
      local callbacks = ""
      if (self:getCallback("start")) then
        callbacks = callbacks..",start"
      end
      if (self:getCallback("casting")) then
        callbacks = callbacks..",casting"
      end
      if (self:getCallback("interrupt")) then
        callbacks = callbacks..",interrupt"
      end
      if (self:getCallback("finish")) then
        callbacks = callbacks..",finish"
      end
      callbacks = callbacks:sub(2)
      return str..callbacks
    end
    function Ability.new(id)
      id = ID(id)
      local ability = {__id = id, __callback = {}, __casting_time_func = nil}
      setmetatable(ability, Ability_meta)
      AbilityDB.add(id, ability)
      return ability
    end
    function Ability:getId()
      return self.__id
    end
    function Ability:setCallback(callback, callback_type)
      self.__callback[callback_type] = callback
    end
    function Ability:getCallback(callback_type)
      return self.__callback[callback_type]
    end
    function Ability:runCallback(callback_type, cast_data)
      if (type(self.__callback[callback_type]) == "function") then
        return self.__callback[callback_type](cast_data)
      else
        return true
      end
    end
    function Ability:setFlag(flag, flag_name)
      self.__flag[flag_name] = flag
    end
    function Ability:getFlag(flag_name)
      return self.__flag[flag_name]
    end
    function Ability:setCastingTimeFunction(func)
      self.__casting_time_func = func
    end
    function Ability:getCastingTime(data)
      if (type(self.__casting_time_func) == "function") then
        return self.__casting_time_func(data)
      end
      return 0
    end
    function Ability:setName(name)
      self.__name = name
    end
    function Ability:getName()
      return self.__name
    end
    function Ability:setTooltip(tooltip, lvl, wc3_player)
      if (wc3_player == nil) then
        BlzSetAbilityTooltip(self.__id, tooltip, lvl)
      elseif (wc3_player == GetLocalPlayer()) then
        BlzSetAbilityTooltip(self.__id, tooltip, lvl)
      end

    end
    function Ability:setExtendedTooltip(ext_tooltip, lvl, wc3_player)
      if (wc3_player == nil) then
        BlzSetAbilityExtendedTooltip(self.__id, ext_tooltip, lvl)
      elseif (wc3_player == GetLocalPlayer()) then
        BlzSetAbilityExtendedTooltip(self.__id, ext_tooltip, lvl)
      end

    end
    function Ability:setIcon(icon_path, wc3_player)
      if (wc3_player == nil) then
        BlzSetAbilityIcon(self.__id, icon_path)
      elseif (wc3_player == GetLocalPlayer()) then
        BlzSetAbilityIcon(self.__id, icon_path)
      end

    end
    function Ability:setPosition(x, y, wc3_player)
      if (wc3_player == nil) then
        BlzSetAbilityPosX(self.__id, x)
        BlzSetAbilityPosY(self.__id, y)
      elseif (wc3_player == GetLocalPlayer()) then
        BlzSetAbilityPosX(self.__id, x)
        BlzSetAbilityPosY(self.__id, y)
      end

    end
    return Ability
end
__require_data.module["unit.UnitDB"] = function()
    local UnitDB = {}
    function UnitDB.add(unit_obj, unit)
      UnitDB[unit_obj] = unit
    end
    function UnitDB.rm(unit_obj)
      UnitDB[unit_obj] = nil
    end
    function UnitDB.get(unit_obj)
      return UnitDB[unit_obj]
    end
    return UnitDB
end
__require_data.module["unitParameter.mathFunc"] = function()
    local Settings = require("utils.Settings")
    local UnitMathParameter = {}
    local half_cap = Settings.UnitParameters.value_to_get_half_cap_for_percent_value
    function UnitMathParameter.linear(base, mult, bonus)
      return ((base*mult)+bonus)
    end
    function UnitMathParameter.inverseLinear(base, mult, bonus)
      return ((base/mult)-bonus)
    end
    function UnitMathParameter.percent(base, mult, bonus, param_cap)
      local val = ((base*mult)+bonus)
      local k = (val/(val+half_cap))
      return (k*param_cap)
    end
    function UnitMathParameter.inversePercent(base, mult, bonus, param_cap)
      local val = ((base*mult)+bonus)
      local k = (val/(val+half_cap))
      return (100-(k*(100-param_cap)))
    end
    return UnitMathParameter
end
__require_data.module["unitParameter.applyFunc"] = function()
    local Settings = require("utils.Settings")
    local UnitApplyParameter = {}
    local attack_dispertion = Settings.UnitParameters.attack_dispersion
    local crit_and_dodge_id = 1095574308
    local resist_id = 1095574309
    local book_id = 1095574310
    function UnitApplyParameter.attack(wc3_unit, val)
      local k = (1-attack_dispertion)
      local dmg = (k*val)
      local dice_sides = ((2*attack_dispertion)*val)
      BlzSetUnitBaseDamage(wc3_unit, math.floor(dmg), 0)
      BlzSetUnitDiceNumber(wc3_unit, 1, 0)
      BlzSetUnitDiceSides(wc3_unit, math.floor((dice_sides+1)), 0)
    end
    function UnitApplyParameter.attackSpeed(wc3_unit, val)
      BlzSetUnitAttackCooldown(wc3_unit, val, 0)
      BlzSetUnitAttackCooldown(wc3_unit, val, 1)
    end
    function UnitApplyParameter.armor(wc3_unit, val)
      BlzSetUnitArmor(wc3_unit, math.floor(val))
    end
    function UnitApplyParameter.spellPower(wc3_unit, val)

    end
    function UnitApplyParameter.castSpeed(wc3_unit, val)

    end
    function UnitApplyParameter.resistance(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, resist_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1, val)
    end
    function UnitApplyParameter.cooldown(wc3_unit, val)

    end
    function UnitApplyParameter.health(wc3_unit, val)
      BlzSetUnitMaxHP(wc3_unit, math.floor(val))
    end
    function UnitApplyParameter.regeneration(wc3_unit, val)
      BlzSetUnitRealField(wc3_unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
    end
    function UnitApplyParameter.mana(wc3_unit, val)
      BlzSetUnitMaxMana(wc3_unit, math.floor(val))
    end
    function UnitApplyParameter.recovery(wc3_unit, val)
      BlzSetUnitRealField(wc3_unit, UNIT_RF_MANA_REGENERATION, val)
    end
    function UnitApplyParameter.critChance(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1, val)
    end
    function UnitApplyParameter.critPower(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1, val)
    end
    function UnitApplyParameter.dodgeChance(wc3_unit, val)
      val = (val/100)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1, val)
    end
    function UnitApplyParameter.strength(wc3_unit, val)
      SetHeroStr(wc3_unit, math.floor(val), true)
    end
    function UnitApplyParameter.agility(wc3_unit, val)
      SetHeroAgi(wc3_unit, math.floor(val), true)
    end
    function UnitApplyParameter.intelligence(wc3_unit, val)
      SetHeroInt(wc3_unit, math.floor(val), true)
    end
    return UnitApplyParameter
end
__require_data.module["unitParameter.UnitParameterContainerDB"] = function()
    local UnitParameterContainerDB = {}
    function UnitParameterContainerDB.add(wc3_unit, container)
      UnitParameterContainerDB[wc3_unit] = container
    end
    function UnitParameterContainerDB.rm(wc3_unit)
      UnitParameterContainerDB[wc3_unit] = nil
    end
    function UnitParameterContainerDB.get(wc3_unit)
      return UnitParameterContainerDB[wc3_unit]
    end
    return UnitParameterContainerDB
end
__require_data.module["unitParameter.UnitParameter"] = function()
    local UnitParameter = {}
    local UnitParameter_meta = {__index = UnitParameter}
    function UnitParameter.new(wc3_unit, base, apply_param_func, math_func, max_val)
      local parameter = {__wc3_unit = wc3_unit, __base = base, __bonus = 0, __mult = 1, __cap = max_val, __apply_param_func = apply_param_func, __math_func = math_func}
      setmetatable(parameter, UnitParameter_meta)
      parameter:update()
      return parameter
    end
    function UnitParameter:set(base, mult, bonus)
      self.__base = base
      self.__mult = mult
      self.__bonus = bonus
      self:update()
    end
    function UnitParameter:addAll(base, mult, bonus)
      self.__base = (self.__base+base)
      self.__mult = (self.__mult+mult)
      self.__bonus = (self.__bonus+bonus)
      self:update()
    end
    function UnitParameter:addBase(val)
      self.__base = (self.__base+val)
      self:update()
    end
    function UnitParameter:addBonus(val)
      self.__bonus = (self.__bonus+val)
      self:update()
    end
    function UnitParameter:addMult(val)
      self.__mult = (self.__mult+val)
      self:update()
    end
    function UnitParameter:getAll()
      return self.__base, self.__mult, self.__bonus, self.__math_func(self.__base, self.__mult, self.__bonus, self.__cap)
    end
    function UnitParameter:getBase()
      return self.__base
    end
    function UnitParameter:getBonus()
      return self.__bonus
    end
    function UnitParameter:getMult()
      return self.__mult
    end
    function UnitParameter:getResult()
      return self.__res
    end
    function UnitParameter:update()
      self.__res = self.__math_func(self.__base, self.__mult, self.__bonus, self.__cap)
      self.__apply_param_func(self.__wc3_unit, self.__res)
    end
    return UnitParameter
end
__require_data.module["unitParameter.UnitParameterContainer"] = function()
    local UnitParameter = require("unitParameter.UnitParameter")
    local UnitParameterContainerDB = require("unitParameter.UnitParameterContainerDB")
    local ApplyParam = require("unitParameter.applyFunc")
    local MathParam = require("unitParameter.mathFunc")
    local ParameterContainer = {}
    local ParameterContainer_meta = {__index = ParameterContainer}
    function ParameterContainer.new(wc3_unit)
      local container = {}
      setmetatable(container, ParameterContainer_meta)
      UnitParameterContainerDB.add(wc3_unit)
      local string_id = ID2str(GetUnitTypeId(wc3_unit))
      local first = string_id:sub(1, 1)
      if (first == string.upper(first)) then
        container.__strength = UnitParameter.new(wc3_unit, 1, ApplyParam.strength, MathParam.linear)
        container.__agility = UnitParameter.new(wc3_unit, 1, ApplyParam.agility, MathParam.linear)
        container.__intelligence = UnitParameter.new(wc3_unit, 1, ApplyParam.intelligence, MathParam.linear)
      end
      container.__attack = UnitParameter.new(wc3_unit, 1, ApplyParam.attack, MathParam.linear)
      container.__attackSpeed = UnitParameter.new(wc3_unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear)
      container.__armor = UnitParameter.new(wc3_unit, 0, ApplyParam.armor, MathParam.linear)
      container.__spellPower = UnitParameter.new(wc3_unit, 0, ApplyParam.spellPower, MathParam.linear)
      container.__castSpeed = UnitParameter.new(wc3_unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25)
      container.__resistance = UnitParameter.new(wc3_unit, 0, ApplyParam.resistance, MathParam.percent, 90)
      container.__health = UnitParameter.new(wc3_unit, 100, ApplyParam.health, MathParam.linear)
      container.__regeneration = UnitParameter.new(wc3_unit, 0, ApplyParam.regeneration, MathParam.linear)
      container.__mana = UnitParameter.new(wc3_unit, 100, ApplyParam.mana, MathParam.linear)
      container.__recovery = UnitParameter.new(wc3_unit, 0, ApplyParam.recovery, MathParam.linear)
      container.__critChance = UnitParameter.new(wc3_unit, 0, ApplyParam.critChance, MathParam.percent, 100)
      container.__critPower = UnitParameter.new(wc3_unit, 1, ApplyParam.critPower, MathParam.linear)
      container.__dodge = UnitParameter.new(wc3_unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75)
      container.__cooldown = UnitParameter.new(wc3_unit, 0, ApplyParam.cooldown, MathParam.percent, 75)
      return container
    end
    function ParameterContainer.get(wc3_unit)
      return UnitParameterContainerDB.get(wc3_unit)
    end
    function ParameterContainer:addAttack(base, mult, bonus)
      self.__attack:add(base, mult, bonus)
    end
    function ParameterContainer:getAttack()
      return self.__attack:get()
    end
    function ParameterContainer:setAttacksPerSec(base)
      _, mult, bonus, _ = self.__attackSpeed:get()
      self.__attackSpeed:set(base, mult, bonus)
    end
    function ParameterContainer:addAttackSpeed(mult)
      self.__attackSpeed:add(0, mult, 0)
    end
    function ParameterContainer:getAttackSpeed()
      base, mult, _, res = self.__attackSpeed:get()
      return base, mult, res
    end
    function ParameterContainer:addArmor(base, mult, bonus)
      self.__armor:add(base, mult, bonus)
    end
    function ParameterContainer:getArmor()
      return self.__armor:get()
    end
    function ParameterContainer:addSpellPower(base, mult, bonus)
      self.__spellPower:add(base, mult, bonus)
    end
    function ParameterContainer:getSpellPower()
      return self.__spellPower:get()
    end
    function ParameterContainer:addCastSpeed(base, mult, bonus)
      self.__castSpeed:add(base, mult, bonus)
    end
    function ParameterContainer:getCastSpeed()
      return self.__castSpeed:get()
    end
    function ParameterContainer:addResistance(base, mult, bonus)
      self.__resistance:add(base, mult, bonus)
    end
    function ParameterContainer:getResistance()
      return self.__resistance:get()
    end
    function ParameterContainer:addHealth(base, mult, bonus)
      self.__health:add(base, mult, bonus)
    end
    function ParameterContainer:getHealth()
      return self.__health:get()
    end
    function ParameterContainer:addRegeneration(base, mult, bonus)
      self.__regeneration:add(base, mult, bonus)
    end
    function ParameterContainer:getRegeneration()
      return self.__regeneration:get()
    end
    function ParameterContainer:addMana(base, mult, bonus)
      self.__mana:add(base, mult, bonus)
    end
    function ParameterContainer:getMana()
      return self.__mana:get()
    end
    function ParameterContainer:addRecovery(base, mult, bonus)
      self.__recovery:add(base, mult, bonus)
    end
    function ParameterContainer:getRecovery()
      return self.__recovery:get()
    end
    function ParameterContainer:addCritChance(base, mult, bonus)
      self.__critChance:add(base, mult, bonus)
    end
    function ParameterContainer:getCritChance()
      return self.__critChance:get()
    end
    function ParameterContainer:addCritPower(base, mult, bonus)
      self.__critPower:add(base, mult, bonus)
    end
    function ParameterContainer:getCritPower()
      return self.__critPower:get()
    end
    function ParameterContainer:addDodgeChance(base, mult, bonus)
      self.__dodge:add(base, mult, bonus)
    end
    function ParameterContainer:getDodgeChance()
      return self.__dodge:get()
    end
    function ParameterContainer:addCooldown(base, mult, bonus)
      self.__cooldown:add(base, mult, bonus)
    end
    function ParameterContainer:getCooldown()
      return self.__cooldown:get()
    end
    function ParameterContainer:addStrength(base, mult, bonus)
      if (self.strength ~= nil) then
        self.strength:add(base, mult, bonus)
      end
    end
    function ParameterContainer:getStrength()
      if (self.strength ~= nil) then
        return self.strength:get()
      else
        return 0, 0, 0, 0
      end
    end
    function ParameterContainer:addAgility(base, mult, bonus)
      if (self.agility ~= nil) then
        self.agility:add(base, mult, bonus)
      end
    end
    function ParameterContainer:getAgility()
      if (self.agility ~= nil) then
        return self.agility:get()
      else
        return 0, 0, 0, 0
      end
    end
    function ParameterContainer:addIntelligence(base, mult, bonus)
      if (self.intelligence ~= nil) then
        self.intelligence:add(base, mult, bonus)
      end
    end
    function ParameterContainer:getIntelligence()
      if (self.intelligence ~= nil) then
        return self.intelligence:get()
      else
        return 0, 0, 0, 0
      end
    end
    return ParameterContainer
end
__require_data.module["unit.Unit"] = function()
    local ParameterContainer = require("unitParameter.UnitParameterContainer")
    local UnitDB = require("unit.UnitDB")
    require("trigger.events.unitEvent")
    local Unit = {}
    local Unit_meta = {__index = Unit, __gc = Unit.destroy}
    function Unit_meta.__tostring(self)
      return string.format("Unit %s (%s) at [%.2f, %.2f, %.2f]", self:getName(), ID2str(self:getId()), self:getX(), self:getY(), self:getZ())
    end
    function Unit.new(wc3_player, id, x, y, face, is_dead)
      id = ID(id)
      local wc3_unit = nil
      if (is_dead) then
        wc3_unit = CreateCorpse(wc3_player, id, x, y, face)
      else
        wc3_unit = CreateUnit(wc3_player, id, x, y, face)
      end
      local unit = {__id = id, __wc3_unit = wc3_unit}
      setmetatable(unit, Unit_meta)
      UnitDB.add(unit.__wc3_unit, unit)
      unit:initCustomData()
      return unit
    end
    function Unit:destroy()
      self:destroyCustomData()
      UnitDB.rm(self.__wc3_unit)
      RemoveUnit(self.__wc3_unit)
      self.__wc3_unit = nil
    end
    function Unit:getObj()
      return self.__wc3_unit
    end
    function Unit:initCustomData()
      self.parameter = runFuncInDebug(ParameterContainer.new, self.__wc3_unit)
    end
    function Unit:destroyCustomData()

    end
    function Unit:getId()
      return self.__id
    end
    function Unit:getName()
      return GetUnitName(self.__wc3_unit)
    end
    function Unit:setVertexColor(red, green, blue, alpha)
      red = math.floor((255*torange(red, 0, 1)))
      green = math.floor((255*torange(green, 0, 1)))
      blue = math.floor((255*torange(blue, 0, 1)))
      alpha = math.floor((255*torange(alpha, 0, 1)))
      SetUnitVertexColor(self.__wc3_unit, red, green, blue, alpha)
    end
    function Unit:getOwningPlayer()
      return GetOwningPlayer(self.__wc3_unit)
    end
    function Unit:setPos2(pos)
      self:setX(pos.x)
      self:setY(pos.y)
    end
    function Unit:setPos3(pos)
      self:setX(pos.x)
      self:setY(pos.y)
      self:setZ(pos.z)
    end
    function Unit:setX(x)
      SetUnitX(self.__wc3_unit, x)
    end
    function Unit:setY(y)
      SetUnitY(self.__wc3_unit, y)
    end
    function Unit:setZ(z)
      self:setFlyHeight((z-GetTerrainZ(self:getX(), self:getY())))
    end
    function Unit:getPos2()
      return Vec2.new(self:getX(), self:getY())
    end
    function Unit:getPos3()
      return Vec3.new(self:getX(), self:getY(), self:getZ())
    end
    function Unit:getX()
      return GetUnitX(self.__wc3_unit)
    end
    function Unit:getY()
      return GetUnitY(self.__wc3_unit)
    end
    function Unit:getZ()
      return (GetTerrainZ(self:getX(), self:getY())+self:getFlyHeight())
    end
    function Unit:getFlyHeight()
      return GetUnitFlyHeight(self.__wc3_unit)
    end
    function Unit:setFlyHeigth(height)
      return SetUnitFlyHeight(self.__wc3_unit, height)
    end
    function Unit:getDefaultsFlyHeight()
      return GetUnitDefaultFlyHeight(self.__wc3_unit)
    end
    function Unit:setFacing(angle, time)
      if (time == nil or time <= 0) then
        SetUnitFacing(self.__wc3_unit, angle)
      else
        SetUnitFacingTimed(self.__wc3_unit, angle, time)
      end
    end
    function Unit:setFacingTo(target, time)
      local x, y = self:getPos()
      local angle = (180+((180/math.pi)*math.atan((y-target.y), (x-target.x))))
      self:setFacing(angle, time)
    end
    function Unit:getFacing()
      return GetUnitFacing(self.__wc3_unit)
    end
    function Unit:getMoveSpeed()
      return GetUnitMoveSpeed(self.__wc3_unit)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.__wc3_unit, speed)
    end
    function Unit:getTurnSpeed()
      return GetUnitTurnSpeed(self.__wc3_unit)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.__wc3_unit, speed)
    end
    function Unit:getDefaultTurnSpeed()
      return GetUnitDefaultTurnSpeed(self.__wc3_unit)
    end
    function Unit:addAbility(ability_id)
      UnitAddAbility(self.__wc3_unit, ability_id)
    end
    function Unit:removeAbility(ability_id)
      UnitRemoveAbility(self.__wc3_unit, ability_id)
    end
    function Unit:getAbilityLevel(ability_id)
      return GetUnitAbilityLevel(self.__wc3_unit, ability_id)
    end
    function Unit:setAbilityLevel(ability_id)
      SetUnitAbilityLevel(self.__wc3_unit, ability_id)
    end
    function Unit:setInvulnerable(flag)
      SetUnitInvulnerable(self.__wc3_unit, flag)
    end
    function Unit:applyTimedLife(time)
      UnitApplyTimedLife(self.__wc3_unit, 0, time)
    end
    function Unit:issueImmediateOrderById(order_id)
      IssueImmediateOrderById(self.__wc3_unit, order_id)
    end
    function Unit:orderStop()
      self:issueImmediateOrderById(851972)
    end
    function Unit:issuePointOrderById(order_id, x, y)
      IssuePointOrderById(self.__wc3_unit, order_id, x, y)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.__wc3_unit, speed)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.__wc3_unit, speed)
    end
    function Unit:playAnimation(animation)
      SetUnitAnimation(self.__wc3_unit, animation)
    end
    function Unit:setAnimationSpeed(scale)
      SetUnitTimeScale(self.__wc3_unit, scale)
    end
    function Unit:pause()
      PauseUnit(self.__wc3_unit, true)
    end
    function Unit:unpause()
      PauseUnit(self.__wc3_unit, false)
    end
    function Unit.get(wc3_unit)
      return UnitDB.get(wc3_unit)
    end
    function Unit.GetLevelingUnit()
      return UnitDB.get(GetLevelingUnit())
    end
    function Unit.GetLearningUnit()
      return UnitDB.get(GetLearningUnit())
    end
    function Unit.GetRevivableUnit()
      return UnitDB.get(GetRevivableUnit())
    end
    function Unit.GetRevivingUnit()
      return UnitDB.get(GetRevivingUnit())
    end
    function Unit.GetAttacker()
      return UnitDB.get(GetAttacker())
    end
    function Unit.GetRescuer()
      return UnitDB.get(GetRescuer())
    end
    function Unit.GetDyingUnit()
      return UnitDB.get(GetDyingUnit())
    end
    function Unit.GetKillingUnit()
      return UnitDB.get(GetKillingUnit())
    end
    function Unit.GetDecayingUnit()
      return UnitDB.get(GetDecayingUnit())
    end
    function Unit.GetConstructingStructure()
      return UnitDB.get(GetConstructingStructure())
    end
    function Unit.GetCancelledStructure()
      return UnitDB.get(GetCancelledStructure())
    end
    function Unit.GetConstructedStructure()
      return UnitDB.get(GetConstructedStructure())
    end
    function Unit.GetResearchingUnit()
      return UnitDB.get(GetResearchingUnit())
    end
    function Unit.GetTrainedUnit()
      return UnitDB.get(GetTrainedUnit())
    end
    function Unit.GetDetectedUnit()
      return UnitDB.get(GetDetectedUnit())
    end
    function Unit.GetSummoningUnit()
      return UnitDB.get(GetSummoningUnit())
    end
    function Unit.GetSummonedUnit()
      return UnitDB.get(GetSummonedUnit())
    end
    function Unit.GetTransportUnit()
      return UnitDB.get(GetTransportUnit())
    end
    function Unit.GetLoadedUnit()
      return UnitDB.get(GetLoadedUnit())
    end
    function Unit.GetSellingUnit()
      return UnitDB.get(GetSellingUnit())
    end
    function Unit.GetSoldUnit()
      return UnitDB.get(GetSoldUnit())
    end
    function Unit.GetBuyingUnit()
      return UnitDB.get(GetBuyingUnit())
    end
    function Unit.GetChangingUnit()
      return UnitDB.get(GetChangingUnit())
    end
    function Unit.GetManipulatingUnit()
      return UnitDB.get(GetManipulatingUnit())
    end
    function Unit.GetOrderedUnit()
      return UnitDB.get(GetOrderedUnit())
    end
    function Unit.GetOrderTargetUnit()
      return UnitDB.get(GetOrderTargetUnit())
    end
    function Unit.GetSpellAbilityUnit()
      return UnitDB.get(GetSpellAbilityUnit())
    end
    function Unit.GetSpellTargetUnit()
      return UnitDB.get(GetSpellTargetUnit())
    end
    function Unit.GetTriggerUnit()
      return UnitDB.get(GetTriggerUnit())
    end
    function Unit.GetEventDamage()
      return UnitDB.get(GetEventDamage())
    end
    function Unit.GetEventDamageSource()
      return UnitDB.get(GetEventDamageSource())
    end
    function Unit.GetEventTargetUnit()
      return UnitDB.get(GetEventTargetUnit())
    end
    return Unit
end
__require_data.module["ability.warlord.summon"] = function()
    local Unit = require("unit.Unit")
    local UnitEvent = require("trigger.events.unitEvent")
    local Ability = require("ability.Ability")
    local SummonDB = require("ability.SummonsDB")
    local FullData = require("ability.warlord.settings")
    local AbilityData = FullData.SummonSpearman
    local SummonData = FullData.SpearmanUnit
    local SummonCrystalSwordmanAbility = Ability.new(AbilityData.Id)
    function SummonCrystalSwordmanAbility.init()
      UnitEvent.getTrigger("AnyUnitDie"):addAction(function()
          local unit = Unit.GetDyingUnit()
          local dying_id = unit:getId()
          if (dying_id == ID(SummonData.Id)) then
            SummonDB.rmSlave(unit:getObj())
          end
      end)
    end
    local function finishCastingCallback(spell_data)
      local caster = spell_data:getCaster()
      local owner = GetOwningPlayer(caster)
      local unit = Unit.new(owner, SummonData.Id, spell_data:getX(), spell_data:getY(), GetUnitFacing(caster))
      unit:setVertexColor(1, 1, 1, 0.35)
      unit:applyTimedLife(10)
      SummonDB.addSlave(unit:getObj(), caster)
      unit.parameter:setAttacksPerSec(1)
    end
    SummonCrystalSwordmanAbility:setName(AbilityData.TooltipNormal)
    SummonCrystalSwordmanAbility:setCastingTimeFunction(function()
        return AbilityData.CustomCastingTime
    end)
    SummonCrystalSwordmanAbility:setCallback(finishCastingCallback, "finish")
    return SummonCrystalSwordmanAbility
end
__require_data.module["utils.timer.TimerDB"] = function()
    local TimerDB = {}
    function TimerDB.add(timer_obj, timer)
      TimerDB[timer_obj] = timer
    end
    function TimerDB.rm(timer_obj)
      TimerDB[timer_obj] = nil
    end
    function TimerDB.get(timer_obj)
      return TimerDB[timer_obj]
    end
    return TimerDB
end
__require_data.module["utils.timer.TimerAction"] = function()
    local TimerAction = {}
    local TimerAction_meta = {__index = TimerAction}
    function TimerAction.new(time, callback, data)
      local action = {__time = time, __callback = callback, __data = data}
      setmetatable(action, TimerAction_meta)
      return action
    end
    function TimerAction:destroy()

    end
    function TimerAction:getTime()
      return self.__time
    end
    function TimerAction:run()
      self.__callback(self.__data)
    end
    return TimerAction
end
__require_data.module["utils.timer.Timer"] = function()
    local TimerAction = require("utils.timer.TimerAction")
    local TimerDB = require("utils.timer.TimerDB")
    local Timer = {}
    local Timer_meta = {__index = Timer, __gc = Timer.destroy}
    function Timer.new(period)
      local timer = {__timer_obj = CreateTimer(), __cur_time = 0.0, __period = period, __actions = {}}
      setmetatable(timer, Timer_meta)
      TimerDB.add(timer.__timer_obj, timer)
      TimerStart(timer.__timer_obj, timer.__period, true, Timer.timeout)
      return timer
    end
    function Timer:destroy()
      while(#self.__actions > 0) do
        local action = table.remove(self.__actions, 1)
        action:destroy()
      end
      TimerDB.rm(self.__timer_obj)
      DestroyTimer(self.__timer_obj)
    end
    function Timer:getPeriod()
      return self.__period
    end
    function Timer.timeout()
      local self = TimerDB.get(GetExpiredTimer())
      local cur_time = (self.__cur_time+self.__period)
      while(#self.__actions > 0) do
        local action = table.remove(self.__actions, 1)
        if (action:getTime() <= cur_time) then
          action:run()
        else
          table.insert(self.__actions, 1, action)
          break
        end
      end
      self.__cur_time = cur_time
    end
    function Timer:findPos(time, first, len)
      if (len == 0) then
        return first
      end
      local half_len, d = math.modf((len/2))
      local pos = (first+half_len)
      if (self.__actions[pos]:getTime() > time) then
        return self:findPos(time, first, half_len)
      else
        return self:findPos(time, ((first+half_len)+(2*d)), half_len)
      end
    end
    function Timer:findPosSimple(time)
      local count = #self.__actions
      if (count == 0) then
        return 1
      end
      for i = 1, count do
        if (self.__actions[i]:getTime() > time) then
          return i
        end
      end
      return (count+1)
    end
    function Timer:addAction(delay, callback, data)
      if (delay <= 0) then
        delay = 0.01
      end
      local time = (self.__cur_time+delay)
      local action = TimerAction.new(time, callback, data)
      local pos = 1
      pos = self:findPos(time, 1, #self.__actions)
      table.insert(self.__actions, pos, action)
      return action
    end
    function Timer:removeAction(action)
      local count = #self.__actions
      for i = 1, count do
        if (self.__actions[i] == action) then
          table.remove(self.__actions, i)
          return true
        end
      end
      return false
    end
    local count = 10
    local test_result = {}
    local test_timer = nil
    local function test(num)
      table.insert(test_result, (#test_result+1), num)
    end
    local function check_test()
      DestroyTimer(GetExpiredTimer())
      for i = 1, count do
        if (test_result[i] ~= (i//2)) then
          Debug("Timer test failed")
          return nil
        end
      end
      test_timer:destroy()
      Debug("Timer test passed.")
    end
    function Timer.test()
      test_timer = Timer.new(0.03125)
      local t = 0.05
      for i = 1, count do
        test_timer:addAction((i*t), test, i)
        test_timer:addAction(((count-i)*t), test, (count-i))
      end
      local timer = CreateTimer()
      TimerStart(timer, ((1.1*t)*count), false, check_test)
    end
    return Timer
end
__require_data.module["utils.math.Vec3"] = function()
    local Vec3 = {}
    local Vec3_meta = {__index = Vec3}
    function Vec3_meta.__tostring(self)
      return string.format("[%.2f, %.2f, %.2f]", self.x, self.y, self.z)
    end
    local loc = nil
    function Vec3.init()
      loc = Location(0, 0)
    end
    function GetTerrainZ(x, y)
      MoveLocation(loc, x, y)
      return GetLocationZ(loc)
    end
    function Vec3.new(x, y, z)
      local v = {x = x, y = y, z = z}
      setmetatable(v, Vec3_meta)
      return v
    end
    return Vec3
end
__require_data.module["utils.math.Vec2"] = function()
    local Vec2 = {}
    local Vec2_meta = {__index = Vec2}
    function Vec2_meta.__tostring(self)
      return string.format("[%.2f, %.2f]", self.x, self.y)
    end
    function Vec2.new(x, y)
      local v = {x = x, y = y}
      setmetatable(v, Vec2_meta)
      return v
    end
    return Vec2
end
__require_data.module["trigger.events.playerEvent"] = function()
    local Trigger = require("trigger.Trigger")
    local PlayerEvent = {__triggers = {}}
    local initialized = false
    function PlayerEvent.init()
      if (initialized) then
        return nil
      end
      PlayerEvent.__triggers.LocalPlayerMouseMove = Trigger.new()
      PlayerEvent.__triggers.LocalPlayerMouseMove:addEvent_Player("MouseMove", GetLocalPlayer())
      initialized = true
    end
    function PlayerEvent.getTrigger(event)
      if (not initialized) then
        PlayerEvent.init()
      end
      return PlayerEvent.__triggers[event]
    end
    return PlayerEvent
end
__require_data.module["trigger.Event"] = function()
    local Event = {Game = {}, Player = {}, PlayerUnit = {}, AnyUnit = {}, Unit = {}}
    Event.Game.Victory = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VICTORY)
    end
    Event.Game.End = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_END_LEVEL)
    end
    Event.Game.VariableLimit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VARIABLE_LIMIT)
    end
    Event.Game.StateLimit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_STATE_LIMIT)
    end
    Event.Game.TimerExpired = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TIMER_EXPIRED)
    end
    Event.Game.EnterRegion = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_ENTER_REGION)
    end
    Event.Game.LeaveRegion = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LEAVE_REGION)
    end
    Event.Game.TrackableHit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_HIT)
    end
    Event.Game.TrackableTrack = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_TRACK)
    end
    Event.Game.ShowSkill = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SHOW_SKILL)
    end
    Event.Game.BuildSubmenu = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_BUILD_SUBMENU)
    end
    Event.Game.Loaded = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LOADED)
    end
    Event.Game.TournamentFinishSoon = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_SOON)
    end
    Event.Game.TournamentFinishNow = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_NOW)
    end
    Event.Game.Save = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SAVE)
    end
    Event.Game.CustomUIFrame = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_CUSTOM_UI_FRAME)
    end
    Event.Player.StateLimit = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_STATE_LIMIT)
    end
    Event.Player.AllianceChanged = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ALLIANCE_CHANGED)
    end
    Event.Player.Defeat = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_DEFEAT)
    end
    Event.Player.Victory = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_VICTORY)
    end
    Event.Player.Leave = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_LEAVE)
    end
    Event.Player.Chat = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_CHAT)
    end
    Event.Player.EndCinematic = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_END_CINEMATIC)
    end
    Event.Player.ArrowLeft_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_DOWN)
    end
    Event.Player.ArrowLeft_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_UP)
    end
    Event.Player.ArrowRight_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_DOWN)
    end
    Event.Player.ArrowRight_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_UP)
    end
    Event.Player.ArrowDown_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_DOWN)
    end
    Event.Player.ArrowDown_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_UP)
    end
    Event.Player.ArrowUp_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_DOWN)
    end
    Event.Player.ArrowUp_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_UP)
    end
    Event.Player.MouseDown = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_DOWN)
    end
    Event.Player.MouseUp = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_UP)
    end
    Event.Player.MouseMove = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_MOVE)
    end
    Event.Player.SyncData = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_SYNC_DATA)
    end
    Event.Player.Key = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY)
    end
    Event.Player.KeyDown = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_DOWN)
    end
    Event.Player.KeyUp = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_UP)
    end
    Event.PlayerUnit.Attacked = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ATTACKED)
    end
    Event.PlayerUnit.Resqued = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESCUED)
    end
    Event.PlayerUnit.Death = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DEATH)
    end
    Event.PlayerUnit.Decay = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DECAY)
    end
    Event.PlayerUnit.Death = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DETECTED)
    end
    Event.PlayerUnit.Hidden = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_HIDDEN)
    end
    Event.PlayerUnit.Selected = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELECTED)
    end
    Event.PlayerUnit.Deselected = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DESELECTED)
    end
    Event.PlayerUnit.ConstructStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    end
    Event.PlayerUnit.ConstructCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    end
    Event.PlayerUnit.ConstructFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    end
    Event.PlayerUnit.UpgradeStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_START)
    end
    Event.PlayerUnit.Cancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    end
    Event.PlayerUnit.Finish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    end
    Event.PlayerUnit.TrainStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_START)
    end
    Event.PlayerUnit.TrainCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    end
    Event.PlayerUnit.TrainFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    end
    Event.PlayerUnit.ResearchStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_START)
    end
    Event.PlayerUnit.ResearchCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    end
    Event.PlayerUnit.ResearchFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    end
    Event.PlayerUnit.IssuedOrder = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    end
    Event.PlayerUnit.IssuedOrderPointTartet = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    end
    Event.PlayerUnit.IssuedOrderTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    end
    Event.PlayerUnit.IssuedOrderUnitTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    end
    Event.PlayerUnit.Level = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_LEVEL)
    end
    Event.PlayerUnit.Skill = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_SKILL)
    end
    Event.PlayerUnit.Revivable = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVABLE)
    end
    Event.PlayerUnit.ReviveStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_START)
    end
    Event.PlayerUnit.ReviveCance = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    end
    Event.PlayerUnit.ReviveFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_FINISH)
    end
    Event.PlayerUnit.Summon = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SUMMON)
    end
    Event.PlayerUnit.DropItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DROP_ITEM)
    end
    Event.PlayerUnit.PickUpItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    end
    Event.PlayerUnit.UseItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_USE_ITEM)
    end
    Event.PlayerUnit.Loaded = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_LOADED)
    end
    Event.PlayerUnit.Damaged = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGED)
    end
    Event.PlayerUnit.Damaging = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGING)
    end
    Event.PlayerUnit.Sell = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL)
    end
    Event.PlayerUnit.ChangeOwner = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    end
    Event.PlayerUnit.SellItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL_ITEM)
    end
    Event.PlayerUnit.SpellChannel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    end
    Event.PlayerUnit.SpellCast = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CAST)
    end
    Event.PlayerUnit.SpellEffect = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    end
    Event.PlayerUnit.SpellFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_FINISH)
    end
    Event.PlayerUnit.SpellEndCast = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    end
    Event.PlayerUnit.PawnItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PAWN_ITEM)
    end
    Event.AnyUnit.Attacked = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED)
        end
    end
    Event.AnyUnit.Resqued = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESCUED)
        end
    end
    Event.AnyUnit.Death = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH)
        end
    end
    Event.AnyUnit.Decay = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DECAY)
        end
    end
    Event.AnyUnit.Detect = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DETECTED)
        end
    end
    Event.AnyUnit.Hidden = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_HIDDEN)
        end
    end
    Event.AnyUnit.Selected = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELECTED)
        end
    end
    Event.AnyUnit.Deselected = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DESELECTED)
        end
    end
    Event.AnyUnit.ConstructStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START)
        end
    end
    Event.AnyUnit.ConstructCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
        end
    end
    Event.AnyUnit.ConstructFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
        end
    end
    Event.AnyUnit.UpgradeStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START)
        end
    end
    Event.AnyUnit.Cancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
        end
    end
    Event.AnyUnit.Finish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH)
        end
    end
    Event.AnyUnit.TrainStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_START)
        end
    end
    Event.AnyUnit.TrainCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL)
        end
    end
    Event.AnyUnit.TrainFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH)
        end
    end
    Event.AnyUnit.ResearchStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START)
        end
    end
    Event.AnyUnit.ResearchCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
        end
    end
    Event.AnyUnit.ResearchFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
        end
    end
    Event.AnyUnit.IssuedOrder = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER)
        end
    end
    Event.AnyUnit.IssuedOrderPointTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
        end
    end
    Event.AnyUnit.IssuedOrderTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
        end
    end
    Event.AnyUnit.IssuedOrderUnitTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
        end
    end
    Event.AnyUnit.Level = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_LEVEL)
        end
    end
    Event.AnyUnit.Skill = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_SKILL)
        end
    end
    Event.AnyUnit.Revivable = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVABLE)
        end
    end
    Event.AnyUnit.ReviveStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_START)
        end
    end
    Event.AnyUnit.ReviveCance = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL)
        end
    end
    Event.AnyUnit.ReviveFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH)
        end
    end
    Event.AnyUnit.Summon = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SUMMON)
        end
    end
    Event.AnyUnit.DropItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM)
        end
    end
    Event.AnyUnit.PickUpItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM)
        end
    end
    Event.AnyUnit.UseItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_USE_ITEM)
        end
    end
    Event.AnyUnit.Loaded = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_LOADED)
        end
    end
    Event.AnyUnit.Damaged = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED)
        end
    end
    Event.AnyUnit.Damaging = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING)
        end
    end
    Event.AnyUnit.Sell = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL)
        end
    end
    Event.AnyUnit.ChangeOwner = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER)
        end
    end
    Event.AnyUnit.SellItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM)
        end
    end
    Event.AnyUnit.SpellChannel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
        end
    end
    Event.AnyUnit.SpellCast = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST)
        end
    end
    Event.AnyUnit.SpellEffect = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT)
        end
    end
    Event.AnyUnit.SpellFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH)
        end
    end
    Event.AnyUnit.SpellEndCast = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
        end
    end
    Event.AnyUnit.PawnItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM)
        end
    end
    Event.Unit.Damaged = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGED)
    end
    Event.Unit.Damaging = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGING)
    end
    Event.Unit.Death = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DEATH)
    end
    Event.Unit.Decay = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DECAY)
    end
    Event.Unit.Detected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DETECTED)
    end
    Event.Unit.Hiden = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HIDDEN)
    end
    Event.Unit.Selected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELECTED)
    end
    Event.Unit.Deselected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DESELECTED)
    end
    Event.Unit.StateLimit = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_STATE_LIMIT)
    end
    Event.Unit.AcquiredTarget = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ACQUIRED_TARGET)
    end
    Event.Unit.TargetInRange = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TARGET_IN_RANGE)
    end
    Event.Unit.Attacked = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ATTACKED)
    end
    Event.Unit.Resqued = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESCUED)
    end
    Event.Unit.ConstructCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_CANCEL)
    end
    Event.Unit.ConstructFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_FINISH)
    end
    Event.Unit.UpgradeStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_START)
    end
    Event.Unit.UpgradeCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_CANCEL)
    end
    Event.Unit.UpgradeFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_FINISH)
    end
    Event.Unit.TrainStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_START)
    end
    Event.Unit.TrainCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_CANCEL)
    end
    Event.Unit.TrainFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_FINISH)
    end
    Event.Unit.ResearchStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_START)
    end
    Event.Unit.ResearchCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_CANCEL)
    end
    Event.Unit.ResearchFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_FINISH)
    end
    Event.Unit.IssuedOrder = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_ORDER)
    end
    Event.Unit.IssuedOrderPoint = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_POINT_ORDER)
    end
    Event.Unit.IssuedOrderTarget = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_TARGET_ORDER)
    end
    Event.Unit.Level = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_LEVEL)
    end
    Event.Unit.Skill = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_SKILL)
    end
    Event.Unit.Revivable = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVABLE)
    end
    Event.Unit.ReviveStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_START)
    end
    Event.Unit.ReviveCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_CANCEL)
    end
    Event.Unit.ReviveFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_FINISH)
    end
    Event.Unit.Summon = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SUMMON)
    end
    Event.Unit.DropItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DROP_ITEM)
    end
    Event.Unit.PickUpItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PICKUP_ITEM)
    end
    Event.Unit.UseItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_USE_ITEM)
    end
    Event.Unit.Loaded = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_LOADED)
    end
    Event.Unit.Sell = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL)
    end
    Event.Unit.ChangeOwner = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CHANGE_OWNER)
    end
    Event.Unit.SellItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL_ITEM)
    end
    Event.Unit.SpellChannel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CHANNEL)
    end
    Event.Unit.SpellCast = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CAST)
    end
    Event.Unit.SpellEffect = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_EFFECT)
    end
    Event.Unit.SpellFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_FINISH)
    end
    Event.Unit.SpellEndCast = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_ENDCAST)
    end
    Event.Unit.PawnItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PAWN_ITEM)
    end
    return Event
end
__require_data.module["trigger.TriggerAction"] = function()
    local TriggerAction = {}
    local TriggerAction_meta = {__index = TriggerAction, __gc = TriggerAction.destroy}
    function TriggerAction.new(callback, data)
      local action = {__callback = callback, __data = data}
      setmetatable(action, TriggerAction_meta)
      return action
    end
    function TriggerAction:destroy()
      self.__callback = nil
      self.__data = nil
    end
    function TriggerAction:run()
      self.__callback(self.__data)
    end
    function TriggerAction:getCallback()
      return self.__callback
    end
    function TriggerAction:getData()
      return self.__data
    end
    return TriggerAction
end
__require_data.module["utils.DataBase"] = function()
    local DataBase = {}
    local DataBase_meta = {__index = DataBase}
    function DataBase.new(key_type, value_type)
      local db = {__key_type = key_type, __value_type = value_type}
      setmetatable(db, DataBase_meta)
      return db
    end
    function DataBase:add(key, value)
      if (type(key) ~= self.__key_type) then
        error("DataBase: wrong key type.")
      end
      if (type(value) ~= self.__value_type) then
        error("DataBase: wrong value type.")
      end
      self[key] = value
    end
    function DataBase:remove(key)
      if (type(key) ~= self.__key_type) then
        error("DataBase: wrong key type.")
      end
      self[key] = nil
    end
    function DataBase:get(key)
      if (type(key) ~= self.__key_type) then
        error("DataBase: wrong key type.")
      end
      return self[key]
    end
    return DataBase
end
__require_data.module["trigger.Trigger"] = function()
    local Settings = require("utils.Settings")
    local DataBase = require("utils.DataBase")
    local TriggerAction = require("trigger.TriggerAction")
    local Event = require("trigger.Event")
    local Trigger = {}
    local Trigger_meta = {__index = Trigger, __gc = Trigger.destroy}
    local TriggerDB = DataBase.new("userdata", "table")
    function Trigger_meta.__tostring(self)
      return string.format("Trigger with %d action(s).", #self.__actions)
    end
    local function runTriggerActions()
      local self = TriggerDB:get(GetTriggeringTrigger())
      for i = 1, #self.__actions do
        local action = self.__actions[i]
        if (Settings.debug) then
          local succes, result = pcall(action.run, action)
          if (not succes) then
            Debug("Error in trigger")
            Debug(result)
          end
        else
          action:run()
        end
      end
      return true
    end
    function Trigger.new()
      local wc3_trigger = CreateTrigger()
      local trigger = {__wc3_trigger = wc3_trigger, __wc3_action = TriggerAddAction(wc3_trigger, runTriggerActions), __actions = {}}
      setmetatable(trigger, Trigger_meta)
      TriggerDB:add(trigger.__wc3_trigger, trigger)
      return trigger
    end
    function Trigger:destroy()
      self:clearActions()
      DestroyTrigger(self.__wc3_trigger)
      self.__wc3_trigger = nil
    end
    function Trigger:getObj()
      return self.__wc3_trigger
    end
    function Trigger:getActionObj()
      return self.__wc3_action
    end
    function Trigger:addAction(callback, data)
      local action = TriggerAction.new(callback, data)
      table.insert(self.__actions, (#self.__actions+1), action)
      return action
    end
    function Trigger:removeAction(action)
      local pos = -1
      for i = 1, #self.__actions do
        if (self.__actions[i] == action) then
          pos = i
          break
        end
      end
      if (pos > 0) then
        table.remove(self.__actions, pos)
        return true
      end
      return false
    end
    function Trigger:clearActions()
      while(#self.__actions > 0) do
        table.remove(self.__actions, 1)
      end
    end
    function Trigger:execute()
      TriggerExecute(self.__wc3_trigger)
    end
    function Trigger:addEvent_Game(event)
      Event.Game[event](self.__wc3_trigger)
    end
    function Trigger:addEvent_Player(event, wc3_player)
      Event.Player[event](self.__wc3_trigger, wc3_player)
    end
    function Trigger:addEvent_Unit(event, wc3_unit)
      Event.Unit[event](self.__wc3_trigger, wc3_unit)
    end
    function Trigger:addEvent_PlayerUnit(event, wc3_player)
      Event.PlayerUnit[event](self.__wc3_trigger, wc3_player)
    end
    function Trigger:addEvent_AnyUnit(event)
      Event.AnyUnit[event](self.__wc3_trigger)
    end
    return Trigger
end
__require_data.module["trigger.events.unitEvent"] = function()
    local Trigger = require("trigger.Trigger")
    local UnitEvent = {__triggers = {}}
    local initialized = false
    function UnitEvent.init()
      if (initialized) then
        return nil
      end
      UnitEvent.__triggers.AnyUnitDie = Trigger.new()
      UnitEvent.__triggers.AnyUnitDie:addEvent_AnyUnit("Death")
      UnitEvent.__triggers.AnyUnitStartChannelAbility = Trigger.new()
      UnitEvent.__triggers.AnyUnitStartChannelAbility:addEvent_AnyUnit("SpellChannel")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder = Trigger.new()
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrder")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrderTarget")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrderUnitTarget")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrderPointTarget")
      UnitEvent.__triggers.AnyUnitSelected = Trigger.new()
      UnitEvent.__triggers.AnyUnitSelected:addEvent_AnyUnit("Selected")
      UnitEvent.__triggers.AnyUnitDeselected = Trigger.new()
      UnitEvent.__triggers.AnyUnitDeselected:addEvent_AnyUnit("Deselected")
      UnitEvent.__triggers.AnyUnitAttacked = Trigger.new()
      UnitEvent.__triggers.AnyUnitAttacked:addEvent_AnyUnit("Attacked")
      initialized = true
    end
    function UnitEvent.getTrigger(name)
      if (not initialized) then
        UnitEvent.init()
      end
      return UnitEvent.__triggers[name]
    end
    return UnitEvent
end
__require_data.module["utils.Settings"] = function()
    local Settings = {debug = true, Timer = {glTimer_period = 0.03125, run_test = false}, UnitParameters = {attack_dispersion = 0.15, value_to_get_half_cap_for_percent_value = 500}, EnabledEvents = {Unit = true, Player = true}}
    return Settings
end
__require_data.module["utils.Globals"] = function()
    local Settings = require("utils.Settings")
    local Globals = {}
    local initialized = false
    
    function Globals.init()
      if (initialized) then
        return nil
      end
      Vec2 = require("utils.math.Vec2")
      Vec3 = require("utils.math.Vec3")
      local Timer = require("utils.timer.Timer")
      glTimer = Timer.new(Settings.Timer.glTimer_period)
      initialized = true
    end
    function runFuncInDebug(func, ...)
      if (Settings.debug) then
        local success, result = pcall(func, ...)
        if (success) then
          return result
        else
          Debug(result)
          return nil
        end
      else
        return func(...)
      end
    end
    local compiletime_print = print
    function Debug(...)
      if (is_compiletime) then
        compiletime_print(...)
      elseif (Settings.debug) then
        local s = ""
        for i = 1, select("#", ...) do
          local v = select(i, ...)
          local t = type(v)
          if (t == "nil") then
            v = "nil"
          elseif (t == "userdata") then
            v = "userdata"
          elseif (t == "string") then
            v = v
          elseif (t == "integer" or t == "number") then
            v = tostring(v)
          elseif (t == "table" or t == "function") then
            v = tostring(v)
          else
            v = ""
          end




          s = s.." "..v
        end
        DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "[Debug]: "..s)
      end

    end
    function ID(id)
      if (type(id) == "string") then
        return string.unpack(">I4", id)
      elseif (type(id) == "number" and math.fmod(id, 1) == 0) then
        return id
      end

      print("Wrong id fromat")
      return nil
    end
    function ID2str(id)
      if (type(id) == "number" or type(id) == "integer") then
        return string.pack(">I4", id)
      end
      return id
    end
    function torange(val, min, max)
      if (val < min) then
        return min
      end
      if (val > max) then
        return max
      end
      return val
    end
    return Globals
end
__require_data.module["utils.Init"] = function()
    local Init = {}
    local Globals = require("utils.Globals")
    if (not is_compiletime) then
      Globals.init()
    end
    function Init.start()
      for name, _ in pairs(__require_data.module) do
        if (not __require_data.loaded[name]) then
          local success, result = pcall(__require_data.module[name])
          if (success) then
            __require_data.result[name] = result
            __require_data.loaded[name] = true
          else
            Debug(string.format("Error in loading %s\n%s", name, result))
          end
        end
        if (__require_data.result[name] ~= nil) then
          if (__require_data.result[name].init ~= nil) then
            local success, result = pcall(__require_data.result[name].init)
            if (not success) then
              Debug(string.format("Error in %s initialization\n%s", name, result))
            end
          end
        end
      end
      Debug("Initialisation finished")
      local Settings = require("utils.Settings")
      if (Settings.Timer.run_test) then
        local Timer = require("utils.timer.Timer")
        Debug("Timer test.")
        Timer.test()
      end
    end
    return Init
end
  
  GG_trg_Melee_Initialization = nil
  function InitGlobals()

  end
  function Trig_Melee_Initialization_Actions()

  end
  function InitTrig_Melee_Initialization()
    GG_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(GG_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitialization()
    DestroyTimer(GetExpiredTimer())
    local Init = require("utils.Init")
    Init.start()
    require("ability.warlord.summon")
    local Unit = require("unit.Unit")
    local u = Unit.new(Player(0), "hfoo", 0, 0, 0)
    local summon_abil = require("ability.warlord.summon")
    Debug(type(summon_abil))
    u:addAbility(summon_abil:getId())
  end
  function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
  end
  function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
  end
  function main()
    SetCameraBounds((-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT)), (-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM)), (3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT)), (3072.0-GetCameraMargin(CAMERA_MARGIN_TOP)), (-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT)), (3072.0-GetCameraMargin(CAMERA_MARGIN_TOP)), (3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT)), (-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM)))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    TimerStart(CreateTimer(), 0.1, false, RunInitialization)
  end
  function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 0, 0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
  end