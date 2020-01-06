--=========
-- Include
--=========

local Class = require('utils.Class')
local WeObject = require('compiletime.ObjectEdit.WeObject')

local Log = require('utils.Log')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeItem = Class.newClass('WeItem', WeObject)
---@class WeItem
local public = WeItem.public
---@class WeItemClass
local static = WeItem.static
local override = WeItem.override
local private = {}

--========
-- Static
--========

---@param instance_data table | nil
---@return WeItem
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or Class.newInstanceData(WeItem)
    instance = WeObject.new(id, base_id, name, instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_src, private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
end

function static.save()
    if private.we_file then
        private.we_file:update()
    end
end

static.Abilities = WeField.new("iabi", "string", "Abilities")
static.ActivelyUsed = WeField.new("iusa", "bool", "ActivelyUsed")
static.ArmorType = WeField.new("iarm", "string", "ArmorType")
static.ButtonPositionX = WeField.new("ubpx", "int", "ButtonPositionX")
static.ButtonPositionY = WeField.new("ubpy", "int", "ButtonPositionY")
static.CanBeDropped = WeField.new("idro", "bool", "CanBeDropped")
static.CanBeSoldByMerchants = WeField.new("isel", "bool", "CanBeSoldByMerchants")
static.CanBeSoldToMerchants = WeField.new("ipaw", "bool", "CanBeSoldToMerchants")
static.Classification = WeField.new("icla", "string", "Classification")
static.CooldownGroup = WeField.new("icid", "string", "CooldownGroup")
static.Description = WeField.new("ides", "string", "Description")
static.DroppedWhenCarrierDies = WeField.new("idrp", "bool", "DroppedWhenCarrierDies")
static.GoldCost = WeField.new("igol", "int", "GoldCost")
static.HitPoints = WeField.new("ihtp", "int", "HitPoints")
static.Hotkey = WeField.new("uhot", "string", "Hotkey")
static.IgnoreCooldown = WeField.new("iicd", "bool", "IgnoreCooldown")
static.IncludeAsRandomChoice = WeField.new("iprn", "bool", "IncludeAsRandomChoice")
static.InterfaceIcon = WeField.new("iico", "string", "InterfaceIcon")
static.Level = WeField.new("ilev", "int", "Level")
static.LevelUnclassified = WeField.new("ilvo", "int", "LevelUnclassified")
static.LumberCost = WeField.new("ilum", "int", "LumberCost")
static.ModelUsed = WeField.new("ifil", "string", "ModelUsed")
static.Name = WeField.new("unam", 'string', "Name")
static.NumberofCharges = WeField.new("iuse", "int", "NumberofCharges")
static.Perishable = WeField.new("iper", "bool", "Perishable")
static.Priority = WeField.new("ipri", "int", "Priority")
static.Requirements = WeField.new("ureq", "string", "Requirements")
static.RequirementsLevels = WeField.new("urqa", "string", "RequirementsLevels")
static.ScalingValue = WeField.new("isca", "real", "ScalingValue")
static.StockMaximum = WeField.new("isto", "int", "StockMaximum")
static.StockReplenishInterval = WeField.new("istr", "int", "StockReplenishInterval")
static.StockStartDelay = WeField.new("isst", "int", "StockStartDelay")
static.TintingColor1Red = WeField.new("iclr", "int", "TintingColor1Red")
static.TintingColor2Green = WeField.new("iclg", "int", "TintingColor2Green")
static.TintingColor3Blue = WeField.new("iclb", "int", "TintingColor3Blue")
static.TooltipBasic = WeField.new("utip", "string", "TooltipBasic")
static.TooltipExtended = WeField.new("utub", "string", "TooltipExtended")
static.UseAutomaticallyWhenAcquired = WeField.new("ipow", "bool", "UseAutomaticallyWhenAcquired")
static.ValidTargetForTransformation = WeField.new("imor", "bool", "ValidTargetForTransformation")

--=========
-- Private
--=========

private.path_sep = package.config:sub(1,1)
private.file_src = _G._src_dir..private.path_sep..'war3map.w3t'
private.file_dst = _G._dst_dir..private.path_sep..'war3map.w3t'

return WeItem