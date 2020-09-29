-- https://www.hiveworkshop.com/threads/genericbar.277605/#resource-37792
-- https://www.hiveworkshop.com/threads/hero-glow.326680/#resource-91186

--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type BinaryLib
local BinaryLib = lib_dep.Binary or error('')
local BinaryUnit = BinaryLib.Unit or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
local Timer = HandleLib.Timer or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local id2int = UtilsLib.id2int or error('')
local ImportFile = UtilsLib.ImportFile or error('')

--=======
-- Class
--=======

local ShieldBar = Class.new('ShieldBar', Unit)
---@class ShieldBar : TextTag
local public = ShieldBar.public
---@class ShieldBarClass : TextTagClass
local static = ShieldBar.static
---@type ShieldBarClass
local override = ShieldBar.override
local private = {}

--=========
-- Static
--=========

---@param target Unit
---@return ShieldBar
function override.new(target)
    local instance = Class.allocate(ShieldBar)
    instance = Unit.new(private.unit_type:getId(),
                        target:getX(), target:getY(),
                        target:getOwner(), instance)

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
function public:updateValue(val, max)
    local perc = 100 * val / max
    self:setAnimation(math.floor(perc))
end

function public:updatePos()
    local priv = private.data[self]
    self:setX(priv.target:getX())
    self:setY(priv.target:getY())
    self:setZ(priv.target:getZ() + 170)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.base_id = id2int('Hpal')
private.id = BinaryLib.getUnitId()

private.unit_type = BinaryUnit.new(private.id, private.base_id, 'Shield Bar')
private.unit_type:setModelFile('war3mapImported\\Model\\GenericBar.mdx')
private.unit_type:setModelSize(0.85)
private.unit_type:setNormalAbilities({'Aloc', 'Abun'})
private.unit_type:setMoveSpeed(1)

-- Disable hero glow. In reforged glow makes bar be transparent.
local sep = Compiletime(package.config:sub(1,1))
ImportFile.load(lib_path:gsub('%.', sep)..'Effects'..sep..'glow'..sep..'heroglow_bw.dds',
                'textures'..sep..'fx'..sep..'flare'..sep..'heroglow_bw.dds')

---@param self ShieldBar
---@param target Unit
function private.newData(self, target)
    local priv = {
        target = target,
    }
    private.data[self] = priv

    self:setColor(0.3, 0.9, 0.9, 1)
end

if not IsCompiletime() then
    local timer = Timer.new()
    timer:start(0.01, true, function()
        for self, priv in pairs(private.data) do
            self:updatePos()
        end
    end)
end

return static