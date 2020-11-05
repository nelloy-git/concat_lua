--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isType = UtilsLib.isType or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local splitStr = UtilsLib.splitStr or error('')

--=======
-- Class
--=======

local AbilityExtPoint = Class.new('AbilityExtPoint')
---@class AbilityExtPoint
local public = AbilityExtPoint.public
---@class AbilityExtPointClass
local static = AbilityExtPoint.static
---@type AbilityExtPointClass
local override = AbilityExtPoint.override
local private = {}

--=========
-- Static
--=========

---@param x any
---@param y any
---@return AbilityExtPoint
---@overload fun(str:string):AbilityExtPoint|nil
function override.new(x, y)
    local instance = Class.allocate(AbilityExtPoint)

    if y ~= nil then
        instance.x = x
        instance.y = y
        return instance
    elseif type(x) == 'string' then
        if not private.parse(instance, x) then
            instance = nil
        end
        return instance
    end
       
end

--========
-- Public
--========

public.x = 0
public.y = 0

function public:tostring()
    return private.l_border..tostring(self.x)..private.sep..tostring(self.y)..private.r_border
end

--=========
-- Private
--=========

private.l_border = '['
private.r_border = ']'
private.sep = ','

---@param str string
---@return boolean
function private.parse(self, str)
    if str:sub(1, 1) ~= private.l_border or
       str:sub(str:len(), str:len()) ~= private.r_border then
        return false
    end

    str = str:sub(2, str:len() - 1)
    local vals = splitStr(str, private.sep)

    vals[1] = tonumber(vals[1])
    vals[2] = tonumber(vals[2])

    if #vals ~= 2 or
       type(vals[1]) ~= 'number' or
       type(vals[2]) ~= 'number' then
        return false
    end

    self.x = vals[1]
    self.y = vals[2]
    return true
end

return static