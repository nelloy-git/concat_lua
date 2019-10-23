--=========
-- Include
--=========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Frame
local Frame = require('Class.Frame.Main')

--========
-- Module
--========

---@param key string
---@param frame Frame
function Frame:setSubframe(key, frame)
    if not self.__subframes then
        self.__subframes = DataBase.new('string', 'Frame')
    end

    self.__subframes:add(key, frame)
    frame:setParent(self)
end

---@param key string
---@return Frame|nil
function Frame:getSubframe(key)
    if self.__subframes == nil then return nil end
    return self.__subframes:get(key)
end

---@param key string
---@return Frame|nil
function Frame:removeSubframe(key)
    local sub = self:getSubfarme(key)
    if not key then return nil end
    self.__subframes:remove(key)
    sub:setParent(nil)
    return sub
end

--- Returns pos
---@param parent Frame
---@return number
function Frame:setParent(parent)
    -- Remove child from previous parent.
    if self.__parent ~= nil then
        for i = 1, #self.__parent.__childrens do
            if self.__parent.__childrens[i] == self then
                table.remove(self.__parent.__childrens, i)
                break
            end
        end
    end

    self.__parent = parent
    if parent ~= nil then
        table.insert(parent.__childrens, #parent.__childrens + 1, self)
    end

    return #parent.__childrens
end

---@return Frame
function Frame:getParent()
    return self.__parent
end

---@return Frame[]
function Frame:getChildrens()
    return self.__childrens
end