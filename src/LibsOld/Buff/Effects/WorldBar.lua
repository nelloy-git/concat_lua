-- https://www.hiveworkshop.com/threads/genericbar.277605/#resource-37792
-- https://www.hiveworkshop.com/threads/hero-glow.326680/#resource-91186

--=========
-- Include
--=========

local Class = require(LibManager.getDepency('LuaClass')) or error('')
---@type Wc3Utils
local Wc3Utils = require(LibManager.getDepency('Wc3Utils')) or error('')
---@type BinaryLib
local BinaryLib = lib_dep.Binary or error('')
local BinaryUnit = BinaryLib.Unit or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local id2int = UtilsLib.id2int or error('')
local ImportFile = UtilsLib.ImportFile or error('')

---@type HandleSettings
local Settings = require(lib_path..'Settings') or error('')
---@type Unit
local Unit = require(lib_path..'Types.Unit') or error('')
---@type Timer
local Timer = require(lib_path..'Types.Timer') or error('')

--=======
-- Class
--=======

local WorldBar = Class.new('WorldBar')
---@class WorldBar
local public = WorldBar.public
---@class WorldBarClass
local static = WorldBar.static
---@type WorldBarClass
local override = WorldBar.override
local private = {}

--=========
-- Static
--=========

---@param target Unit
---@return WorldBar
function override.new(target)
    local instance = Class.allocate(WorldBar)

    private.newData(instance, target)

    return instance
end

--========
-- Public
--========

---@return Unit
function public:getTarget()
    return private.data[self].target
end

---@param val number
---@param max number
function public:setValue(val, max)
    local perc = 100 * val / max
    private.data[self].bar:setAnimation(math.floor(perc))
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height
end

---@param scale number
function public:setScale(scale)
    private.data[self].bar:setScale(scale)
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    private.data[self].bar:setColor(r, g, b, a)
end

function public:updatePos()
    local priv = private.data[self]

    priv.bar:setX(priv.target:getX())
    priv.bar:setY(priv.target:getY())
    priv.bar:setZ(priv.target:getZ() + priv.height)
end

function public:destroy()
    private.data[self].bar:destroy()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.base_id = id2int('Hpal')
private.id = BinaryLib.getUnitId()

private.unit_type = BinaryUnit.new(private.id, private.base_id, 'Shield Bar')
private.unit_type:setNormalAbilities({'Aloc', 'Abun'})
private.unit_type:setMoveSpeed(1)

local sep = Compiletime(package.config:sub(1,1))
ImportFile.load(lib_path:gsub('%.', sep)..'Preset'..sep..'WorldBar'..sep..'generic_bar.mdx',
                'war3mapImported'..sep..'WorldBar'..sep..'generic_bar.mdx')
private.unit_type:setModelFile('war3mapImported\\WorldBar\\generic_bar.mdx')
-- Disable hero glow. In reforged glow makes bar be transparent.
ImportFile.load(lib_path:gsub('%.', sep)..'Preset'..sep..'WorldBar'..sep..'heroglow_bw.dds',
                'textures'..sep..'fx'..sep..'flare'..sep..'heroglow_bw.dds')

---@param self WorldBar
---@param target Unit
function private.newData(self, target)
    local priv = {
        target = target,
        bar = Unit.new(private.unit_type:getId(),
                       target:getX(), target:getY(),
                       target:getOwner()),

        height = 0
    }
    private.data[self] = priv
end

if not IsCompiletime() then
    local timer = Timer.new()
    timer:start(Settings.WorldBarPeriod, true, function()
        for self, _ in pairs(private.data) do
            self:updatePos()
        end
    end)
end

return static