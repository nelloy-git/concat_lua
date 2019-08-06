---@type Timer
local Timer = require('utils.timer')
---@type Trigger
local Trigger = require('trigger.trigger')

---@class Ability
local Ability = {}
local Ability_meta = {__index = Ability}

---@type table<integer, Ability>
local AbilityDB = {}

---@alias AbilityStartCallback fun(self:Ability, caster:Unit, target:Unit|userdata|nil, x:number, y:number):boolean
---@alias AbilityCastingCallback fun(self:Ability, caster:Unit, target:Unit|userdata|nil, x:number, y:number, cur_time:number, full_time:number):boolean
---@alias AbilityInterruptCallback fun(self:Ability, caster:Unit, target:Unit|userdata|nil, x:number, y:number, cur_time:number, full_time:number)
---@alias AbilityFinishCallback fun(self:Ability, caster:Unit, target:Unit|userdata|nil, x:number, y:number, full_time:number)
---@alias AbilityGetName fun(self:Ability):string
---@alias AbilityGetCastTime fun(self:Ability, caster:Unit):number

---Create new Ability instance.
---@param id string|integer
---@return Ability
function Ability.new(id)
    ---@type integer
    id = ID(id)
    ---@type Ability
    local ability = {
        id = id,
        ---@type AbilityStartCallback
        _start = function() return true end,
        ---@type AbilityCastingCallback
        _casting = function() return true end,
        ---@type AbilityInterruptCallback
        _interrupt = function() end,
        ---@type AbilityFinishCallback
        _finish = function() end
    }
    setmetatable(ability, Ability_meta)
    AbilityDB[id] = ability
    return ability
end

---@param id integer
---@return Ability
function Ability.getAbility(id)
    id = ID(id)
    if id then
        return AbilityDB[ID(id)]
    end
    return nil
end

---@return integer
function Ability:getId()
    print(self.id)
    return self.id
end

---Function sets callback for ability events.
---@param callback AbilityStartCallback|AbilityCastingCallback|AbilityInterruptCallback|AbilityFinishCallback
---@param type string|"start"|"casting"|"interrupt"|"finish"
function Ability:setCallback(callback, type)
    if type == 'start' then
        ---@type AbilityStartCallback
        self._start = callback
    end
    if type == 'casting' then
        ---@type AbilityCastingCallback
        self._casting = callback
    end
    if type == 'interrupt' then
        ---@type AbilityInterruptCallback
        self._interrupt = callback
    end
    if type == 'finish' then
        ---@type AbilityFinishCallback
        self._finish = callback
    end
end

---Function runs ability event callback.
---@param type string|"start"|"casting"|"interrupt"|"finish"
function Ability:runCallback(type, ...)
    if type == 'start' then return self._start(...) end
    if type == 'casting' then return self._casting(...) end
    if type == 'interrupt' then return self._interrupt(...) end
    if type == 'finish' then return self._finish(...) end
end

---Function sets ability cast time.
---@param cast_time number|AbilityGetCastTime
function Ability:setCastTime(cast_time)
    self.cast_time = cast_time
end

---Function returns ability casting duration.
---@param caster Unit
---@return number
function Ability:getCastTime(caster)
    if type(self.cast_time) == 'number' then
        return self.cast_time
    elseif type(self.cast_time) == 'function' then
        return self.cast_time(caster)
    end
    return 0
end

---Function sets ability name.
---@param name string|AbilityGetName
function Ability:setName(name)
    self.name = name
end

---Function returns ability name.
---@return string
function Ability:getName()
    if type(self.name) == 'string' then
        return self.name
    elseif type(self.name) == 'function' then
        return self.name()
    end
    return ''
end

---Function changes ability tooltip(name) for player with index. (nil for all players)
---@param tooltip string
---@param lvl integer
---@param player_index integer
function Ability:setTooltip(tooltip, lvl, player_index)
    if player_index == nil then BlzSetAbilityTooltip(self.id, tooltip, lvl) return nil end
    local local_player_index = player2index(GetLocalPlayer())
    if player_index == local_player_index then
        BlzSetAbilityTooltip(self.id, tooltip, lvl)
    end
end

---Function changes ability extended tooltip for player with index. (nil for all players)
---@param ext_tooltip string
---@param lvl integer
---@param player_index integer
function Ability:setExtendedTooltip(ext_tooltip, lvl, player_index)
    if player_index == nil then BlzSetAbilityExtendedTooltip(self.id, ext_tooltip, lvl) return nil end
    local local_player_index = player2index(GetLocalPlayer())
    if player_index == local_player_index then
        BlzSetAbilityExtendedTooltip(self.id, ext_tooltip, lvl)
    end
end

---Function changes ability icon for player with index. (nil for all players)
---@param icon_path string
---@param player_index integer
function Ability:setIcon(icon_path, player_index)
    if player_index == nil then BlzSetAbilityIcon(self.id, icon_path) return nil end
    local local_player_index = player2index(GetLocalPlayer())
    if player_index == local_player_index then
        BlzSetAbilityIcon(self.id, icon_path)
    end
end

---Function moves ability button to position. (nil for all players)
---@param x integer
---@param y integer
---@param player_index integer
function Ability:setPosition(x, y, player_index)
    if player_index == nil then BlzSetAbilityPosX(self.id, x) BlzSetAbilityPosY(self.id, y) return nil end
    local local_player_index = player2index(GetLocalPlayer())
    if player_index == local_player_index then
        BlzSetAbilityPosX(self.id, x)
        BlzSetAbilityPosY(self.id, y)
    end
end

return Ability