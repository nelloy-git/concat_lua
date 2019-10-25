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

---@param frame Frame
---@param child Frame
local function addChild(frame, child)
    local childrens = frame:getChildrens()
    table.insert(childrens, #childrens + 1, child)
    BlzFrameSetParent(child:getObj(), frame:getObj())
end

---Frame:update should be called to apply changes.
---@param parent Frame
function Frame:setParent(parent)
    local prev_parent = self:getParent()

    if not prev_parent then
        Debug("Frame error: Frame.GAME_UI's parent can not be changed.")
        return nil
    end

    -- Remove child from previous parent.
    local parents_chilrens = prev_parent:getChildrens()
    for i = 1, #parents_chilrens do
        if parents_chilrens[i] == self then
            table.remove(self.__parent.__childrens, i)
            break
        end
    end

    if not parent then
        self.__parent = Frame.GAME_UI
    else
        self.__parent = parent
    end
    addChild(self.__parent, self)
end

---@return Frame
function Frame:getParent()
    if not self.__parent and self ~= Frame.GAME_UI then
        self.__parent = Frame.GAME_UI
    end
    return self.__parent
end

---@return Frame[]
function Frame:getChildrens()
    if not self.__childrens then
        self.__childrens = {}
    end
    return self.__childrens
end