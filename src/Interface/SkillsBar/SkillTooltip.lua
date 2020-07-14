--=========
-- Include
--=========

--region Include
local Class = require(LibList.ClassLib)

---@type FrameLib
local FrameLib = require(LibList.FrameLib)
local FdfLayer = FrameLib.FdfLayer
local FdfFrame = FrameLib.FdfFrame
local FdfString = FrameLib.FdfString
local FdfTexture = FrameLib.FdfTexture
local SimpleBase = FrameLib.SimpleBase
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
--endregion

--=======
-- Class
--=======

local InterfaceSkillTooltip = Class.new('InterfaceSkillTooltip', SimpleBase)
--region Class
---@class InterfaceSkillTooltip : SimpleBaseFrame
local public = InterfaceSkillTooltip.public
---@class InterfaceSkillTooltipClass : SimpleBaseFrameClass
local static = InterfaceSkillTooltip.static
---@type InterfaceSkillTooltipClass
local override = InterfaceSkillTooltip.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param child_instance InterfaceSkillTooltip | nil
---@return InterfaceSkillTooltip
function override.new(child_instance)
    if child_instance then
        checkTypeErr(child_instance, InterfaceSkillTooltip, 'child_instance')
    end

    local instance = child_instance or Class.allocate(InterfaceSkillTooltip)
    instance = SimpleBase.new(private.default_fdf, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param name string
---@param description string
---@param resouces string
function public:set(name, description, resouces)
    local priv = private.data[self]

    priv.name:setText(name)
    priv.description:setText(description)
    priv.resources:setText(resouces)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.default_fdf = FdfFrame.new('InterfaceSkillTooltip', 'SIMPLEFRAME')

private.stringName_name = 'InterfaceSkillTooltipArtworkName'
private.stringDescription_name = 'InterfaceSkillTooltipArtworkDescription'
private.stringResources_name = 'InterfaceSkillTooltipArtworkResources'

do
    local w = 0.12
    local h = 0.08
    local bord = 0.005

    local name_height = 0.012
    local description_height = 0.010
    local resourses_height = 0.010

    local fdf = private.default_fdf
    fdf:setParameter('Width', tostring(w))
    fdf:setParameter('Height', tostring(h))

        local layer_background = FdfLayer.new('BACKGROUND')
            local texture = FdfTexture.new('InterfaceSkillTooltipBackgroundTexture')
            texture:setParameter('File', '\"Replaceabletextures\\Teamcolor\\Teamcolor27.blp\"')
            layer_background:addTexture(texture)
        fdf:addLayer(layer_background)

        local layer_artwork = FdfLayer.new('ARTWORK')
            local name = FdfString.new(private.stringName_name)
            name:setParameter('Anchor', 'TOPLEFT, '..tostring(bord)..', '..tostring(-bord))
            name:setParameter('Text', '\"Name\"')
            name:setParameter('Font', '\"fonts\\nim_____.ttf\", '..tostring(name_height))
            layer_artwork:addString(name)

            local description = FdfString.new(private.stringDescription_name)
            description:setParameter('Anchor', 'LEFT, '..tostring(bord)..', 0')
            description:setParameter('Text', '\"Description\"')
            description:setParameter('Font', '\"fonts\\nim_____.ttf\", '..tostring(description_height))
            layer_artwork:addString(description)

            local resources = FdfString.new(private.stringResources_name)
            resources:setParameter('Anchor', 'BOTTOMRIGHT, '..tostring(-bord)..', '..tostring(bord))
            resources:setParameter('Text', '\"Mana/Health\"')
            resources:setParameter('Font', '\"fonts\\nim_____.ttf\", '..tostring(resourses_height))
            layer_artwork:addString(resources)

        fdf:addLayer(layer_artwork)
end

---@param self InterfaceSkillTooltip
function private.newData(self)
    local priv = {}
    private.data[self] = priv

    priv.background = self:getLayer('BACKGROUND'):getTexture(1)
    for i = 1, 3 do
        local str = self:getLayer('ARTWORK'):getString(i)
        local str_name = str:getFdf():getName()
        if str_name == private.stringName_name then
            priv.name = str
        elseif str_name == private.stringDescription_name then
            priv.description = str
        elseif str_name == private.stringResources_name then
            priv.resources = str
        else
            Log:err('Error in fdf file')
        end
    end


end

return static