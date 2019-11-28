--=========
-- Include
--=========

local Log = require('utils.Log')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeObjectFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeObjectFile')
---@type WeUtils
local WeUtils = require('compiletime.ObjectEdit.WeUtils')

--=======
-- Class
--=======

---@type WeItemClass
local WeItem = newClass('WeItem', WeObject)

---@class WeItem : WeObject
local public = WeItem.public
---@class WeItemClass : WeObjectClass
local static = WeItem.static
---@type table
local override = WeItem.override
---@type table(WeItem, table)
local private = {}

private.path_sep = package.config:sub(1,1)
private.file_src = _G._src_dir..private.path_sep..'war3map.w3t'
private.file_dst = _G._dst_dir..private.path_sep..'war3map.w3t'

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return WeItem
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeItem)
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

function public:free()
    WeObject.free(self)
end

local fmt = string.format

function private.checkType(field, data)
    local data_type = field:getDataType()
    local res = false
    if data_type == 'string' and type(data) == 'string' then
        res = true
    end
    if data_type == 'int' and type(data) == 'number' and data % 1 == 0 then
        res = true
    end
    if data_type == 'bool' and type(data) == 'boolean' then
        res = true
    end
    if (data_type == 'real' or data_type == 'unreal') and type(data) == 'number' then
        res = true
    end

    if not res then
        local msg = fmt('wrong data type. Got %s. Need %s.',
                         type(data), data_type)
        Log(Log.Warn, field:getName(), msg)
    end
    return res
end

--=============
-- Item fields
--=============
static.Abilities = WeField.new("iabi", "string", "Abilities", private.checkType)
static.ActivelyUsed = WeField.new("iusa", "bool", "ActivelyUsed", private.checkType)
static.ArmorType = WeField.new("iarm", "string", "ArmorType", private.checkType)
static.ButtonPositionX = WeField.new("ubpx", "int", "ButtonPositionX", private.checkType)
static.ButtonPositionY = WeField.new("ubpy", "int", "ButtonPositionY", private.checkType)
static.CanBeDropped = WeField.new("idro", "bool", "CanBeDropped", private.checkType)
static.CanBeSoldByMerchants = WeField.new("isel", "bool", "CanBeSoldByMerchants", private.checkType)
static.CanBeSoldToMerchants = WeField.new("ipaw", "bool", "CanBeSoldToMerchants", private.checkType)
static.Classification = WeField.new("icla", "string", "Classification", private.checkType)
static.CooldownGroup = WeField.new("icid", "string", "CooldownGroup", private.checkType)
static.Description = WeField.new("ides", "string", "Description", private.checkType)
static.DroppedWhenCarrierDies = WeField.new("idrp", "bool", "DroppedWhenCarrierDies", private.checkType)
static.GoldCost = WeField.new("igol", "int", "GoldCost", private.checkType)
static.HitPoints = WeField.new("ihtp", "int", "HitPoints", private.checkType)
static.Hotkey = WeField.new("uhot", "string", "Hotkey", private.checkType)
static.IgnoreCooldown = WeField.new("iicd", "bool", "IgnoreCooldown", private.checkType)
static.IncludeAsRandomChoice = WeField.new("iprn", "bool", "IncludeAsRandomChoice", private.checkType)
static.InterfaceIcon = WeField.new("iico", "string", "InterfaceIcon", private.checkType)
static.Level = WeField.new("ilev", "int", "Level", private.checkType)
static.LevelUnclassified = WeField.new("ilvo", "int", "LevelUnclassified", private.checkType)
static.LumberCost = WeField.new("ilum", "int", "LumberCost", private.checkType)
static.ModelUsed = WeField.new("ifil", "string", "ModelUsed", private.checkType)
static.Name = WeField.new("unam", 'string', "Name", private.checkType)
static.NumberofCharges = WeField.new("iuse", "int", "NumberofCharges", private.checkType)
static.Perishable = WeField.new("iper", "bool", "Perishable", private.checkType)
static.Priority = WeField.new("ipri", "int", "Priority", private.checkType)
static.Requirements = WeField.new("ureq", "string", "Requirements", private.checkType)
static.RequirementsLevels = WeField.new("urqa", "string", "RequirementsLevels", private.checkType)
static.ScalingValue = WeField.new("isca", "real", "ScalingValue", private.checkType)
static.StockMaximum = WeField.new("isto", "int", "StockMaximum", private.checkType)
static.StockReplenishInterval = WeField.new("istr", "int", "StockReplenishInterval", private.checkType)
static.StockStartDelay = WeField.new("isst", "int", "StockStartDelay", private.checkType)
static.TintingColor1Red = WeField.new("iclr", "int", "TintingColor1Red", private.checkType)
static.TintingColor2Green = WeField.new("iclg", "int", "TintingColor2Green", private.checkType)
static.TintingColor3Blue = WeField.new("iclb", "int", "TintingColor3Blue", private.checkType)
static.TooltipBasic = WeField.new("utip", "string", "TooltipBasic", private.checkType)
static.TooltipExtended = WeField.new("utub", "string", "TooltipExtended", private.checkType)
static.UseAutomaticallyWhenAcquired = WeField.new("ipow", "bool", "UseAutomaticallyWhenAcquired", private.checkType)
static.ValidTargetForTransformation = WeField.new("imor", "bool", "ValidTargetForTransformation", private.checkType)

return WeItem