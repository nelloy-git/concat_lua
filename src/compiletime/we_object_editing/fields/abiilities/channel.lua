local WeChannelAbilityField = {}

WeChannelAbilityField['setArtDuration'] = {id = "Ncl4", lvl = -1, abil_data_id = 4, 'unreal'}
WeChannelAbilityField['setBaseOrderID'] = {id = "Ncl6", lvl = -1, abil_data_id = 6, 'string'}
WeChannelAbilityField['setDisableOtherAbilities'] = {id = "Ncl5", lvl = -1, abil_data_id = 5, 'int'}
WeChannelAbilityField['setFollowThroughTime'] = {id = "Ncl1", lvl = -1, abil_data_id = 1, 'unreal'}
WeChannelAbilityField['setTargetType'] = {id = "Ncl2", lvl = -1, abil_data_id = 2, 'int'}
WeChannelAbilityField['setOptions'] = {id = "Ncl3", lvl = -1, abil_data_id = 3, 'int'}

return WeChannelAbilityField

public class AbilityDefinitionIllidanChannel extends AbilityDefinition
	construct(int newAbilityId)
		super(newAbilityId, AbilityIds.channel)

	function setArtDuration(int level, real value)
		def.setLvlDataUnreal("Ncl4", level, 4, value)

	function setBaseOrderID(int level, string value)
		def.setLvlDataString("Ncl6", level, 6, value)

	function setDisableOtherAbilities(int level, bool value)
		def.setLvlDataBoolean("Ncl5", level, 5, value)

	function setFollowThroughTime(int level, real value)
		def.setLvlDataUnreal("Ncl1", level, 1, value)

	function setTargetType(int level, int value)
		def.setLvlDataInt("Ncl2", level, 2, value)

	function setOptions(int level, int value)
		def.setLvlDataInt("Ncl3", level, 3, value)



public enum Option
	VISIBLE
	TARGETIMAGE
	PHYSICALSPELL
	UNIVERSALSPELL
	UNIQUECAST

public enum Targettype
	NONE
	UNIT
	POINT
	POINTUNIT
	PASSIVE

public function Targettype.toString() returns string
	switch this
		case NONE
			return "Instant Cast"
		case Targettype.POINT
			return "Point Target"
		case Targettype.UNIT
			return "Unit Target"
		case Targettype.POINTUNIT
			return "Point & Unit Target"
		case PASSIVE
			return "Passive"

public class ChannelAbilityPreset extends AbilityDefinitionIllidanChannel
	private bitset optionSet = bitset(0)
	private string orderString

	function getOrderString() returns string
		return orderString

	construct(int newId, int lvls, boolean removeChannelProperties, TooltipGenerator tgen)
		super(newId)
		registerTooltipGenerator(tgen)
		setup(lvls, removeChannelProperties)

	construct(int newId, int lvls, boolean removeChannelProperties)
		super(newId)
		setup(lvls, removeChannelProperties)

	function setup(int lvls, boolean removeChannelProperties)
		this.lvls = lvls
		tooltipStartListen()
		setLevels(lvls)
		tooltipStopListen(false)
		orderString = odf.getOrderString(true)
		presetBaseOrderID(_lvl -> orderString)
		if removeChannelProperties
			removeChannelProperties(true)

	function makeUnitSpell(int mana, real cooldown)
		setHeroAbility(false)
		presetManaCost(lvl -> mana)
		presetCooldown(lvl -> cooldown)

	function removeChannelProperties(boolean removeVisuals)
		removeChannelProperties(removeVisuals, true)

	function removeChannelProperties(boolean removeVisuals, boolean makeVisible)
		presetDisableOtherAbilities(lvl -> false)
		presetFollowThroughTime(lvl -> 0.)
		presetArtDuration(lvl -> 0.)
		if makeVisible
			presetOption(Option.VISIBLE, true)
		if removeVisuals
			setArtCaster("")
			setArtEffect("")
			setArtSpecial("")
			setArtTarget("")

	function presetTargetTypes(Targettype ttype)
		presetTargetType(lvl -> ttype castTo int)

	function presetOption(Option opt, boolean flag)
		let pow = opt castTo int
		if optionSet.contains(pow)
			if not flag
				optionSet = optionSet.remove(pow)
		else if flag
			optionSet = optionSet.add(pow)

		presetOptions(lvl -> optionSet.val)

	function hasOption(Option option) returns boolean
		return optionSet.contains(option castTo int)