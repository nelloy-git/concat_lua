--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('Class.DataBase')

--================
-- Abstract Class
--================

---@type FrameClass
local Frame = newClass('Frame')

---@class FrameClass
local static = Frame.static
---@class Frame
local public = Frame.public
---@type table
local override = Frame.override
---@type table(Frame, table)
local private = {}

--=========
-- Methods
--=========

function public:update() Log(Log.Err, getClassName(Frame), 'function \"update\" is not redeclared in child.') end
---@param parent Frame
function public:setParent(parent) Log(Log.Err, getClassName(Frame), 'function \"setParent\" is not redeclared in child.') end
---@return Frame
function public:getParent() Log(Log.Err, getClassName(Frame), 'function \"getParent\" is not redeclared in child.') end
---@param x number
function public:setX(x) Log(Log.Err, getClassName(Frame), 'function \"setX\" is not redeclared in child.') end
---@return number
function public:getX() Log(Log.Err, getClassName(Frame), 'function \"getX\" is not redeclared in child.') end
---@param y number
function public:setY(y) Log(Log.Err, getClassName(Frame), 'function \"setY\" is not redeclared in child.') end
---@return number
function public:getY() Log(Log.Err, getClassName(Frame), 'function \"getY\" is not redeclared in child.') end
---@param width number
function public:setWidth(width) Log(Log.Err, getClassName(Frame), 'function \"setWidth\" is not redeclared in child.') end
---@return number
function public:getWidth() Log(Log.Err, getClassName(Frame), 'function \"getWidth\" is not redeclared in child.') end
---@param height number
function public:setHeight(height) Log(Log.Err, getClassName(Frame), 'function \"setHeight\" is not redeclared in child.') end
---@return number
function public:getHeight() Log(Log.Err, getClassName(Frame), 'function \"getHeight\" is not redeclared in child.') end

return Frame