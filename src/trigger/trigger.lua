---@type Player
local Player = require('player.player')

---@class Trigger
local Trigger = {}
local Trigger_meta = {
    __index = Trigger,
    __gc = Trigger.destroy
}

function Trigger_meta.__tostring(self)
    return string.format("Trigger with %d action(s).", #self.__actions)
end

---@return Trigger
function Trigger.new()
    ---@type Trigger
    local trigger = {
        __trigger_obj = CreateTrigger(),
        __actions = {}
    }
    setmetatable(trigger, Trigger_meta)

    return trigger
end

---@return nil
function Trigger:destroy()
    self:clearActions()
    DestroyTrigger(self.__trigger_obj)
    self.__trigger_obj = 0
end

---@alias TriggerCallback function()
---@alias TriggerAction userdata

---@param callback TriggerCallback
---@return TriggerAction
function Trigger:addAction(callback)
    local action = TriggerAddAction(self.__trigger_obj, callback)
    if #self.__actions == 0 then
        table.insert(self.__actions, 1, action)
    else
        table.insert(self.__actions, #self.__actions, action)
    end
    return action
end

---@param action TriggerAction
---@return boolean
function Trigger:removeAction(action)
    local pos = -1
    for i = 1, #self.__actions do
        if self.__actions[i] == action then
            pos = i
            break
        end
    end

    if pos > 0 then
        table.remove(self.__actions, pos)
        TriggerRemoveAction(self.__trigger_obj. action)
        return true
    end
    return false
end

---Function removes all callbacks from trigger.
---@return nil
function Trigger:clearActions()
    while #self.__actions > 0 do
        local action = table.remove(self.__actions, 1)
        TriggerRemoveAction(self.__trigger_obj, action)
    end
end

---Function executes all callbacks of function.
---@return nil
function Trigger:execute()
    TriggerExecute(self.__trigger_obj)
end

-- Game events
---@return nil
function Trigger:addEvent_GameVictory() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_VICTORY) end
---@return nil
function Trigger:addEvent_GameEnd() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_END_LEVEL) end
---@return nil
function Trigger:addEvent_GameVariableLimit() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_VARIABLE_LIMIT) end
---@return nil
function Trigger:addEvent_GameStateLimit() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_STATE_LIMIT) end
---@return nil
function Trigger:addEvent_GameTimerExpired() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_TIMER_EXPIRED) end
---@return nil
function Trigger:addEvent_GameEnterRegion() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_ENTER_REGION) end
---@return nil
function Trigger:addEvent_GameLeaveRegion() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_LEAVE_REGION) end
---@return nil
function Trigger:addEvent_GameTrackableHit() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_TRACKABLE_HIT) end
---@return nil
function Trigger:addEvent_GameTrackableTrack() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_TRACKABLE_TRACK) end
---@return nil
function Trigger:addEvent_GameShowSkill() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_SHOW_SKILL) end
---@return nil
function Trigger:addEvent_GameBuildSubmenu() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_BUILD_SUBMENU) end
---@return nil
function Trigger:addEvent_GameLoaded() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_LOADED) end
---@return nil
function Trigger:addEvent_GameTournamentFinishSoon() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_SOON) end
---@return nil
function Trigger:addEvent_GameTournamentFinishNow() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_NOW) end
---@return nil
function Trigger:addEvent_GameSave() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_SAVE) end
---@return nil
function Trigger:addEvent_GameCustomUIFrame() TriggerRegisterGameEvent(self.__trigger_obj, EVENT_GAME_CUSTOM_UI_FRAME) end


-- Player events
---@param player Player
---@return nil
function Trigger:addEvent_PlayerStateLimit(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_STATE_LIMIT) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerAllianceChanged(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ALLIANCE_CHANGED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerDefeat(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_DEFEAT) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerVictory(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_VICTORY) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerLeave(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_LEAVE) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerChat(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_CHAT) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerEndCinematic(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_END_CINEMATIC) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowLeft_Down(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_LEFT_DOWN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowLeft_Up(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_LEFT_UP) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowRight_Down(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_RIGHT_DOWN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowRight_Up(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_RIGHT_UP) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowDown_Down(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_DOWN_DOWN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowDown_Up(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_DOWN_UP) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowUp_Down(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_UP_DOWN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerArrowUp_Up(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_ARROW_UP_UP) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerMouseDown(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_MOUSE_DOWN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerMouseUp(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_MOUSE_UP) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerMouseMove(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_MOUSE_MOVE) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerSyncData(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_SYNC_DATA) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerKey(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_KEY) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerKeyDown(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_KEY_DOWN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerKeyUp(player) TriggerRegisterPlayerEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_KEY_UP) end


-- Any unit events
---@return nil
function Trigger:addEvent_AnyUnitAttacked() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_ATTACKED) end end
---@return nil
function Trigger:addEvent_AnyUnitResqued() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_RESCUED) end end
---@return nil
function Trigger:addEvent_AnyUnitDeath() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DEATH) end end
---@return nil
function Trigger:addEvent_AnyUnitDecay() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DECAY) end end
---@return nil
function Trigger:addEvent_AnyUnitDetect() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DETECTED) end end
---@return nil
function Trigger:addEvent_AnyUnitHidden() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_HIDDEN) end end
---@return nil
function Trigger:addEvent_AnyUnitSelected() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SELECTED) end end
---@return nil
function Trigger:addEvent_AnyUnitDeselected() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DESELECTED) end end
---@return nil
function Trigger:addEvent_AnyUnitConstructStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_CONSTRUCT_START) end end
---@return nil
function Trigger:addEvent_AnyUnitConstructCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitConstructFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitUpgradeStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_UPGRADE_START) end end
---@return nil
function Trigger:addEvent_AnyUnitCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitTrainStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_TRAIN_START) end end
---@return nil
function Trigger:addEvent_AnyUnitTrainCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitTrainFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_TRAIN_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitResearchStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_RESEARCH_START) end end
---@return nil
function Trigger:addEvent_AnyUnitResearchCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitResearchFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrder() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_ISSUED_ORDER) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrderPointTarget() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrderTarget() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrderUnitTarget() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end end
---@return nil
function Trigger:addEvent_AnyHeroLevel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_HERO_LEVEL) end end
---@return nil
function Trigger:addEvent_AnyHeroSkill() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_HERO_SKILL) end end
---@return nil
function Trigger:addEvent_AnyHeroRevivable() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_HERO_REVIVABLE) end end
---@return nil
function Trigger:addEvent_AnyHeroReviveStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_HERO_REVIVE_START) end end
---@return nil
function Trigger:addEvent_AnyHeroReviveCance() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_HERO_REVIVE_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyHeroReviveFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_HERO_REVIVE_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitSummon() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SUMMON) end end
---@return nil
function Trigger:addEvent_AnyUnitDropItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DROP_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitPickUpItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_PICKUP_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitUseItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_USE_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitLoaded() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_LOADED) end end
---@return nil
function Trigger:addEvent_AnyUnitDamaged() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DAMAGED) end end
---@return nil
function Trigger:addEvent_AnyUnitDamaging() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_DAMAGING) end end
---@return nil
function Trigger:addEvent_AnyUnitSell() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SELL) end end
---@return nil
function Trigger:addEvent_AnyUnitChangeOwner() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_CHANGE_OWNER) end end
---@return nil
function Trigger:addEvent_AnyUnitSellItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SELL_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellChannel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellCast() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SPELL_CAST) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellEffect() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SPELL_EFFECT) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SPELL_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellEndCast() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end end
---@return nil
function Trigger:addEvent_AnyUnitPawnItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.__trigger_obj, Player(i):getObj(), EVENT_PLAYER_UNIT_PAWN_ITEM) end end


-- Player unit events
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitAttacked(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_ATTACKED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitResqued(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_RESCUED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDeath(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DEATH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDecay(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DECAY) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDeath(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DETECTED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitHidden(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_HIDDEN) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSelected(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SELECTED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDeselected(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DESELECTED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitConstructStart(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_CONSTRUCT_START) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitConstructCancel(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitConstructFinish(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitUpgradeStart(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_UPGRADE_START) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitCancel(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitFinish(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitTrainStart(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_TRAIN_START) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitTrainCancel(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitTrainFinish(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_TRAIN_FINISH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitResearchStart(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_RESEARCH_START) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitResearchCancel(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitResearchFinish(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrder(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_ISSUED_ORDER) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrderPointTartet(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrderTarget(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrderUnitTarget(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerHeroLevel(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_HERO_LEVEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerHeroSkill(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_HERO_SKILL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerHeroRevivable(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_HERO_REVIVABLE) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerHeroReviveStart(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_HERO_REVIVE_START) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerHeroReviveCance(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_HERO_REVIVE_CANCEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerHeroReviveFinish(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_HERO_REVIVE_FINISH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSummon(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SUMMON) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDropItem(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DROP_ITEM) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitPickUpItem(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_PICKUP_ITEM) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitUseItem(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_USE_ITEM) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitLoaded(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_LOADED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDamaged(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DAMAGED) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitDamaging(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_DAMAGING) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSell(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SELL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitChangeOwner(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_CHANGE_OWNER) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSellItem(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SELL_ITEM) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSpellChannel(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSpellCast(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SPELL_CAST) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSpellEffect(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SPELL_EFFECT) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSpellFinish(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SPELL_FINISH) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitSpellEndCast(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end
---@param player Player
---@return nil
function Trigger:addEvent_PlayerUnitPawnItem(player) TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player:getObj(), EVENT_PLAYER_UNIT_PAWN_ITEM) end


-- Unit events
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDamaged(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DAMAGED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDamaging(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DAMAGING) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDeath(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DEATH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDecay(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DECAY) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDetected(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DETECTED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitHiden(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HIDDEN) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSelected(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SELECTED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDeselected(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DESELECTED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitStateLimit(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_STATE_LIMIT) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitAcquiredTarget(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_ACQUIRED_TARGET) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTargetInRange(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_TARGET_IN_RANGE) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitAttacked(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_ATTACKED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResqued(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_RESCUED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitConstructCancel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_CONSTRUCT_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitConstructFinish(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_CONSTRUCT_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUpgradeStart(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUpgradeCancel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUpgradeFinish(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTrainStart(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTrainCancel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTrainFinish(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResearchStart(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResearchCancel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResearchFinish(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitIssuedOrder(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_ORDER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitIssuedOrderPoint(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_POINT_ORDER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitIssuedOrderTarget(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_TARGET_ORDER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroLevel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_LEVEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroSkill(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_SKILL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroRevivable(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVABLE) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroReviveStart(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroReviveCancel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroReviveFinish(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSummon(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SUMMON) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDropItem(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_DROP_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitPickUpItem(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_PICKUP_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUseItem(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_USE_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitLoaded(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_LOADED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSell(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SELL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitChangeOwner(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_CHANGE_OWNER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSellItem(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SELL_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellChannel(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_CHANNEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellCast(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_CAST) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellEffect(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_EFFECT) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellFinish(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellEndCast(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_ENDCAST) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitPawnItem(unit) TriggerRegisterUnitEvent(self.__trigger_obj, unit.unit_obj, EVENT_UNIT_PAWN_ITEM) end
-- Dialog events
---@return nil
function Trigger:addEvent_Dialog(dialog) TriggerRegisterDialogEvent(self.__trigger_obj, dialog) end
---@return nil
function Trigger:addEvent_DialogButtonClicked(button) TriggerRegisterDialogButtonEvent(self.__trigger_obj, button) end

return Trigger