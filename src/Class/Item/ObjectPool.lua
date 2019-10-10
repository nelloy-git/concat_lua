--==========
-- Includes
--==========

---@type Settings
local Settings = require('utils.Settings')
---@type Item
local Item = require('Class.Item.Main')

--=======
-- Class
--=======

local ItemObjectPool = newClass('ItemObjectPool')
local ItemObjectPool_meta = newMeta(ItemObjectPool)

local Objects = compiletime(function()
    local objEdit = require('compiletime.objEdit.objEdit')
    local weItem = objEdit.Item.Item

    local objects = {}
    for i = 1, 

end)
local function newItemObjectPool(size)
    
end

return ItemObjectPool