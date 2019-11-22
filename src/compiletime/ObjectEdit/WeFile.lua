--=========
-- Include
--=========

--=======
-- Class
--=======

---@type WeFileClass
local WeFile = newClass('WeFile')

---@alias WeType string | "'ability'" | "'buff'" | "'unit'" | "'item'"

---@class WeFile
local public = WeFile.public
---@class WeFileClass
local static = WeFile.static
---@type table
local override = WeFile.override
---@type table(WeFile, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return WeFile
function static.open(we_type, path, instance_data)
    local instance = instance_data or newInstanceData(WeFile)
    local priv = {
        we_type = we_type,
        path = path,
        content = "",
        objects = {}
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

function public:updateContent()
    local priv = private[self]
    priv.content = private.readFile(priv.path)

    for i = 1, #self.objects do
        local we_obj = self.objects[i]
        local bytes = we_obj:serialize()
        self:setChangesCount(self:getChangesCount() + 1)
        self.content = self.content .. bytes
        local name = ''
        if type(we_obj.getName) == 'function' then
            name = we_obj:getName() or ''
        end
        if we_obj.verbouse then
            print(string.format('Created %s %s with id: \'%s\' based on \'%s\'', we_obj.we_type, name, we_obj.id, we_obj.base_id))
        end
    end
    self:writeToDst()
end

---@param path string
---@return bytes
function private.readFile(path)
    local t = nil
    local f = io.open(path, "rb")
    if f then
        t = f:read("*all")
        f:close()
    else
        t = string.char(2)..string.char(0)..string.char(0)..string.char(0)..  -- file version
            string.char(0)..string.char(0)..string.char(0)..string.char(0)..  -- object tables
            string.char(0)..string.char(0)..string.char(0)..string.char(0)    -- changes count
    end
    return t
end

return WeFile

---@type WeUtils
local utils = require('compiletime.objEdit.weUtils')

---@class WeFile
local WeFile = {}

---@param we_type string|'ability'|'buff'|'unit'
---@return string
local function weType2file(we_type)
    if we_type == 'ability' then return 'war3map.w3a' end
    if we_type == 'buff' then return 'war3map.w3h'end
    if we_type == 'unit' then return 'war3map.w3u' end
    if we_type == 'item' then return 'war3map.w3t' end
end

---@param path string
---@return bytes
local function readFile(path)
    local path = path

    local t = nil
    local f = io.open(path, "rb")
    if f then
        t = f:read("*all")
        f:close()
    else
        t = string.char(2)..string.char(0)..string.char(0)..string.char(0)..  -- file version
            string.char(0)..string.char(0)..string.char(0)..string.char(0)..  -- object tables
            string.char(0)..string.char(0)..string.char(0)..string.char(0)    -- changes count
    end
    return t
end

---@param we_type string|''abil''|''buff''|''unit''|''item''
---@return WeFile
function WeFile.readFromSrc(we_type)
    local separator = package.config:sub(1,1)
    local path = WeFile.src_dir .. separator .. weType2file(we_type)
    local we_file = {
        we_type = we_type,
        content = readFile(path),
        objects = {}
    }
    setmetatable(we_file, {__index = WeFile})
    return we_file
end

function WeFile:writeToDst()
    local separator = package.config:sub(1,1)
    local path = WeFile.dst_dir .. separator .. weType2file(self.we_type)

    local f = assert(io.open(path, "w"))
    local t = f:write(self.content)
    f:close()
end

---@return integer
function WeFile:getChangesCount()
    return utils.byte2int(self.content:sub(9, 12))
end

---@param count integer
function WeFile:setChangesCount(count)
    self.content = self.content:sub(1, 8) .. utils.int2byte(count) .. self.content:sub(13)
end

function WeFile:applyChanges()
    for i = 1, #self.objects do
        local we_obj = self.objects[i]
        local bytes = we_obj:serialize()
        self:setChangesCount(self:getChangesCount() + 1)
        self.content = self.content .. bytes
        local name = ''
        if type(we_obj.getName) == 'function' then
            name = we_obj:getName() or ''
        end
        if we_obj.verbouse then
            print(string.format('Created %s %s with id: \'%s\' based on \'%s\'', we_obj.we_type, name, we_obj.id, we_obj.base_id))
        end
    end
    self:writeToDst()
end

---@param we_obj WeObject
---@return boolean
function WeFile:add(we_obj)
    if we_obj.we_type ~= self.we_type then
        print('Warning: can not add object of type', we_obj.we_type, 'to file of type', self.we_type)
        print(utils.getErrorPos())
        return false
    end
    table.insert(self.objects, 1, we_obj)
    return true
end

---Function initialize object files.
---@param src_dir string
---@param dst_dir string
function WeFile.init(src_dir, dst_dir)
    WeFile.src_dir = src_dir
    WeFile.dst_dir = dst_dir

    WeFile.abils = WeFile.readFromSrc('abil')
    WeFile.buffs = WeFile.readFromSrc('buff')
    WeFile.units = WeFile.readFromSrc('unit')
    WeFile.items = WeFile.readFromSrc('item')
end

function WeFile.close()
    WeFile.abils:applyChanges()
    WeFile.units:applyChanges()
    WeFile.buffs:applyChanges()
    WeFile.items:applyChanges()
end

return WeFile