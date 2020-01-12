--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeItem = Class.new('WeItem', WeObject)
---@class WeItem
local public = WeItem.public
---@class WeItemClass
local static = WeItem.static
---@type WeItemClass
local override = WeItem.override
local private = {}

--========
-- Static
--========

---@param id string | number
---@param base_id string | number
---@param name string
---@param child_instance WeItem | nil
---@return WeItem
function override.new(id, base_id, name, child_instance)
    local instance = child_instance or Class.allocate(WeItem)
    instance = WeObject.new(id, base_id, name, instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_src, private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
end

static.Field = {}
static.Field.Abilities = WeField.new("iabi", "string", "Abilities")
static.Field.ActivelyUsed = WeField.new("iusa", "bool", "ActivelyUsed")
static.Field.ArmorType = WeField.new("iarm", "string", "ArmorType")
static.Field.ButtonPositionX = WeField.new("ubpx", "int", "ButtonPositionX")
static.Field.ButtonPositionY = WeField.new("ubpy", "int", "ButtonPositionY")
static.Field.CanBeDropped = WeField.new("idro", "bool", "CanBeDropped")
static.Field.CanBeSoldByMerchants = WeField.new("isel", "bool", "CanBeSoldByMerchants")
static.Field.CanBeSoldToMerchants = WeField.new("ipaw", "bool", "CanBeSoldToMerchants")
static.Field.Classification = WeField.new("icla", "string", "Classification")
static.Field.CooldownGroup = WeField.new("icid", "string", "CooldownGroup")
static.Field.Description = WeField.new("ides", "string", "Description")
static.Field.DroppedWhenCarrierDies = WeField.new("idrp", "bool", "DroppedWhenCarrierDies")
static.Field.GoldCost = WeField.new("igol", "int", "GoldCost")
static.Field.HitPoints = WeField.new("ihtp", "int", "HitPoints")
static.Field.Hotkey = WeField.new("uhot", "string", "Hotkey")
static.Field.IgnoreCooldown = WeField.new("iicd", "bool", "IgnoreCooldown")
static.Field.IncludeAsRandomChoice = WeField.new("iprn", "bool", "IncludeAsRandomChoice")
static.Field.InterfaceIcon = WeField.new("iico", "string", "InterfaceIcon")
static.Field.Level = WeField.new("ilev", "int", "Level")
static.Field.LevelUnclassified = WeField.new("ilvo", "int", "LevelUnclassified")
static.Field.LumberCost = WeField.new("ilum", "int", "LumberCost")
static.Field.ModelUsed = WeField.new("ifil", "string", "ModelUsed")
static.Field.Name = WeField.new("unam", 'string', "Name")
static.Field.NumberofCharges = WeField.new("iuse", "int", "NumberofCharges")
static.Field.Perishable = WeField.new("iper", "bool", "Perishable")
static.Field.Priority = WeField.new("ipri", "int", "Priority")
static.Field.Requirements = WeField.new("ureq", "string", "Requirements")
static.Field.RequirementsLevels = WeField.new("urqa", "string", "RequirementsLevels")
static.Field.ScalingValue = WeField.new("isca", "real", "ScalingValue")
static.Field.StockMaximum = WeField.new("isto", "int", "StockMaximum")
static.Field.StockReplenishInterval = WeField.new("istr", "int", "StockReplenishInterval")
static.Field.StockStartDelay = WeField.new("isst", "int", "StockStartDelay")
static.Field.TintingColor1Red = WeField.new("iclr", "int", "TintingColor1Red")
static.Field.TintingColor2Green = WeField.new("iclg", "int", "TintingColor2Green")
static.Field.TintingColor3Blue = WeField.new("iclb", "int", "TintingColor3Blue")
static.Field.TooltipBasic = WeField.new("utip", "string", "TooltipBasic")
static.Field.TooltipExtended = WeField.new("utub", "string", "TooltipExtended")
static.Field.UseAutomaticallyWhenAcquired = WeField.new("ipow", "bool", "UseAutomaticallyWhenAcquired")
static.Field.ValidTargetForTransformation = WeField.new("imor", "bool", "ValidTargetForTransformation")

--=========
-- Private
--=========

private.path_sep = package.config:sub(1,1)
private.file_src = GetSrcDir()..private.path_sep..'war3map.w3t'
private.file_dst = GetDstDir()..private.path_sep..'war3map.w3t'

return WeItem