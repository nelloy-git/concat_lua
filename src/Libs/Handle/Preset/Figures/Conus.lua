--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type TimerClass
local Timer = require(lib_path..'Types.Timer') or error('')

--=======
-- Class
--=======

local FigureConus = Class.new('FigureConus')
---@class FigureConus : Effect
local public = FigureConus.public
---@class FigureConusClass : EffectClass
local static = FigureConus.static
---@type FigureConusClass
local override = FigureConus.override
local private = {}

--=========
-- Static
--=========

---@param elem_file string
---@param elem_size number
---@param step number
---@param child FigureConus | nil
---@return FigureConus
function override.new(elem_file, elem_size, child)
    isTypeErr(elem_file, 'string', 'elem_file')
    isTypeErr(elem_size, 'number', 'elem_size')
    if child then isTypeErr(child, FigureConus, 'child') end

    local instance = child or Class.allocate(FigureConus)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:setRange(range)
    private.data[self].range = range
end

function public:setAngle(angle)
    private.data[self].angle = angle
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FigureConus
function private.newData(self)
    local priv = {
        start_x = 0,
        start_y = 0,
        targ_x = 0,
        targ_y = 0,

        range = 0,
        angle = 0,

        line1 = {},
        line2 = {},
        arc = {}
    }
    private.data[self] = priv
end

---@param val number
---@param range number
---@param angle number
---@return number
function private.getOffset(val, range, angle)
    return val + range * math.cos(angle)
end

---@param img_list table<integer, Image>
---@param sx number
---@param sy number
---@param ex number
---@param ey number
function private.moveLine(img_list, sx, sy, ex, ey)
    if (#img_list < 1) then return end

    local step_x = (ex - sx) / #img_list
    local step_y = (ey - sy) / #img_list

    for i = 1, #img_list do
        local cur = img_list[i]
        cur
    end
end

return static