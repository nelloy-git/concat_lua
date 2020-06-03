--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Import
local Import = require('Resources.Import')
---@type Item2ModelClass
local Item2Model = require('Item2.Model')
---@type ParameterAPI
local ParameterAPI = require('Parameter.API')
---@type Item2Obj
local Item2Obj = require('Object.Item2')

--=======
-- Class
--=======

local Item2 = Class.new('Item2', Item2Obj)
---@class Item22 : Item2Obj
local public = Item2.public
---@class Item2Class2 : Item2ObjClass
local static = Item2.static
---@type Item2Class
local override = Item2.override
local private = {}

--=========
-- Static
--=========

---@return Item2
function override.new()
    local instance = Class.allocate(Item2)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param name string
function public:setName(name)
    private.data[self].name = name
end

---@param icon string
function public:setIcon(icon)
    private.data[self].icon = icon
end

---@param description string
function public:setDescription(description)
    private.data[self].description = description
end

---@param model Item2Model | nil
function public:setModel(model)
    private.data[self].model = model
    if model then
        private.model2item2[model] = self
        model:setName(private.data[self].name)
    end
end

---@param owner unit
function public:setOwner(owner)
    private.data[self].owner = owner
end

---@return string
function public:getName()
    return private.data[self].name
end

---@return Item2TypeEnum
function public:getType()
    return private.data[self].item2_type
end

---@return string
function public:getIcon()
    return private.data[self].icon
end

---@return number
function public:getCount()
    return 1
end

---@return number
function public:getProgress()
    return nil
end

---@return string
function public:getDescription()
    return private.data[self].description
end

---@return Item2Model
function public:getModel()
    return private.data[self].model
end

---@return ParameterItem2
function public:getParameters()
    return private.data[self].param
end

---@return number
function public:getId()
    return private.data[self].id
end

---@return unit
function public:getOwner()
    return private.data[self].owner
end

---@return number
function public:getCount()
    return 1
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.model2item2 = setmetatable({},  {__mode = 'kv'})

private.cur_id = 1
private.id2item2 = setmetatable({},  {__mode = 'v'})
--[[
private.Equipable = {
    [static.Type.BAG] = true,
    [static.Type.BELT] = true,
    [static.Type.BOOTS] = true,
    [static.Type.CHEST] = true,
    [static.Type.EARRING] = true,
    [static.Type.HANDS] = true,
    [static.Type.HEAD] = true,
    [static.Type.LEGS] = true,
    [static.Type.WEAPON] = true,
    [static.Type.NECKLACE] = true,
    [static.Type.RING] = true,
    [static.Type.OFFHAND] = true,
    [static.Type.SHOULDERS] = true,
    [static.Type.USABLE] = false,
    [static.Type.MISCELLANEOUS] = false,
}

private.TypeIcon = {
    [static.Type.BAG] = Import.Icon.Bag,
    [static.Type.BELT] = Import.Icon.Belt,
    [static.Type.BOOTS] = Import.Icon.Boots,
    [static.Type.CHEST] = Import.Icon.Chest,
    [static.Type.EARRING] = Import.Icon.Earring,
    [static.Type.HANDS] = Import.Icon.Hands,
    [static.Type.HEAD] = Import.Icon.Head,
    [static.Type.LEGS] = Import.Icon.Legs,
    [static.Type.WEAPON] = Import.Icon.Weapon,
    [static.Type.NECKLACE] = Import.Icon.Necklace,
    [static.Type.RING] = Import.Icon.Ring,
    [static.Type.OFFHAND] = Import.Icon.Offhand,
    [static.Type.SHOULDERS] = Import.Icon.Shoulders,
    [static.Type.USABLE] = '',
    [static.Type.MISCELLANEOUS] = '',
}
]]
---@param item2 Item2
---@return number
function private.newId(item2)
    local id = private.cur_id
    private.cur_id = id + 1

    private.id2item2[id] = item2
    return id
end

---@param self Item2
function private.newData(self, item2_type)
    local priv = {
        name = 'Noname',
        description = 'Empty description',
        item2_type = item2_type,
        icon = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin',
        id = private.newId(self),

        model = nil,
        param = ParameterAPI.Item2.new(),

        owner = nil,
    }
    private.data[self] = priv
end

return static