---@class Ability
local Ability = {}
local Ability_meta = {
    __index = Ability
}

---@param self Ability
---@return string
function Ability_meta.__tostring(self)
    local function getName(type)
        local f = self:getCallback(type)
        if f == nil then
            return 'nil'
        else
            return debug.getinfo(self:getCallback("start"), 'n').name
        end
    end

    local abil_name = self:getName()
    local start_name = getName("start")
    local casting_name = getName("casting")
    local interrupt_name = getName("interrupt")
    local finish_name = getName("finish")
    return string.format('Ability %s (%s) with callbacks:\nStart: %s\nWhile casting: %s\nInterrupt: %s\nFinish: %s',
                          abil_name, ID2str(self:getId()),
                          start_name, casting_name, interrupt_name, finish_name)
end

---@type table<integer, Ability>
local AbilityDB = {}

---@alias AbilityCallbackType string
---| '"start"'       #Callback is called when unit starts casting.
---| '"casting"'     #Callback is called every loop of timer while unit is casting an ability.
---| '"interrupt"'   #Callback is called when unit interrupted casting.
---| '"finish"'      #Callback is called if casting was not interrupted and cast time passed.

---@alias AbilityStartCallback fun(caster:Unit, target:Unit|userdata|nil, x:number, y:number):boolean
---@alias AbilityCastingCallback fun(caster:Unit, target:Unit|userdata|nil, x:number, y:number, cur_time:number, full_time:number):boolean
---@alias AbilityInterruptCallback fun(caster:Unit, target:Unit|userdata|nil, x:number, y:number, cur_time:number, full_time:number)
---@alias AbilityFinishCallback fun(caster:Unit, target:Unit|userdata|nil, x:number, y:number, full_time:number)
---@alias AbilityCallback AbilityStartCallback|AbilityCastingCallback|AbilityInterruptCallback|AbilityFinishCallback

---Create new Ability instance.
---@param id string|integer
---@return Ability
function Ability.new(id)
    id = ID(id)
    local ability = {
        id = id,
        _start = nil,
        _casting = nil,
        _interrupt = nil,
        _finish = nil,
        _castingTime = nil
    }
    setmetatable(ability, Ability_meta)
    AbilityDB[id] = ability
    return ability
end

---Function returns Ability class instance for id. 
---@param id string|integer
---@return Ability
function Ability.getAbility(id)
    id = ID(id)
    if id then
        return AbilityDB[id]
    end
    return nil
end

---Function returns id.
---@return integer
function Ability:getId()
    return self.id
end

---Function sets callback for ability events.
---@param callback AbilityCallback
---@param type AbilityCallbackType
---@return nil
function Ability:setCallback(callback, type)
    if type == 'start' then self._start = callback end
    if type == 'casting' then self._casting = callback end
    if type == 'interrupt' then self._interrupt = callback end
    if type == 'finish' then self._finish = callback end
    if type == 'getCastingTime' then self._castingTime = callback end
end

---Function returns current ability callback of type.
---@param type AbilityCallbackType
---@return AbilityCallback
function Ability:getCallback(type)
    if type == 'start' then return self._start end
    if type == 'casting' then return self._casting end
    if type == 'interrupt' then return self._interrupt end
    if type == 'finish' then return self._finish end
    if type == 'getCastingTime' then return self._castingTime end
end

---Function runs ability event callback.
---@param type AbilityCallbackType
---@return nil
function Ability:runCallback(type, ...)
    if type == 'start' then if self._start ~= nil then return self._start(...) end else return true end
    if type == 'casting' then if self._casting ~= nil then return self._casting(...) end else return true end
    if type == 'interrupt' then if self._interrupt ~= nil then self._interrupt(...) end end
    if type == 'finish' then if self._finish ~= nil then self._finish(...) end end
    if type == 'castingTime' then if self._castingTime ~= nil then return self._castingTime(...) end end
end

func

---Function sets ability name.
---@param name string
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