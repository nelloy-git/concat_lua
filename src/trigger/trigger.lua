---@class Trigger
local Trigger = {}
local Trigger_meta = {__index = Trigger}

---@return Trigger
function Trigger.new()
    local trigger = {
        trigger_obj = CreateTrigger(),
        actions = {}
    }
    setmetatable(trigger, Trigger_meta)

    return trigger
end

---@alias TriggerCallback function()

---Function adds callback to trigger. Use closuares for userdata.
---@param callback TriggerCallback
function Trigger:addAction(callback)
    local action = TriggerAddAction(self.trigger_obj, callback)
    self.actions[callback] = action
end

---Function removes callback from trigger.
---@param callback TriggerCallback
function Trigger:removeAction(callback)
    local action = self.actions[callback]
    self.actions[callback] = nil
    TriggerRemoveAction(self.trigger_obj, action)
end

---Function removes all callbacks from trigger.
function Trigger:clearActions()
    for callback, action in pairs(self.actions) do
        TriggerRemoveAction(self.trigger_obj, action)
        self.actions[callback] = nil
    end
end

---Function executes all callbacks of function.
function Trigger:execute()
    TriggerExecute(self.trigger_obj)
end

-- Game events
---@return nil
function Trigger:addEvent_GameVictory() TriggerRegisterGameEvent(self, EVENT_GAME_VICTORY) end
---@return nil
function Trigger:addEvent_GameEnd() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_END_LEVEL) end
---@return nil
function Trigger:addEvent_GameVariableLimit() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_VARIABLE_LIMIT) end
---@return nil
function Trigger:addEvent_GameStateLimit() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_STATE_LIMIT) end
---@return nil
function Trigger:addEvent_GameTimerExpired() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TIMER_EXPIRED) end
---@return nil
function Trigger:addEvent_GameEnterRegion() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_ENTER_REGION) end
---@return nil
function Trigger:addEvent_GameLeaveRegion() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_LEAVE_REGION) end
---@return nil
function Trigger:addEvent_GameTrackableHit() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TRACKABLE_HIT) end
---@return nil
function Trigger:addEvent_GameTrackableTrack() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TRACKABLE_TRACK) end
---@return nil
function Trigger:addEvent_GameShowSkill() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_SHOW_SKILL) end
---@return nil
function Trigger:addEvent_GameBuildSubmenu() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_BUILD_SUBMENU) end
---@return nil
function Trigger:addEvent_GameLoaded() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_LOADED) end
---@return nil
function Trigger:addEvent_GameTournamentFinishSoon() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_SOON) end
---@return nil
function Trigger:addEvent_GameTournamentFinishNow() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_NOW) end
---@return nil
function Trigger:addEvent_GameSave() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_SAVE) end
---@return nil
function Trigger:addEvent_GameCustomUIFrame() TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_CUSTOM_UI_FRAME) end
-- Player events
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerStateLimit(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_STATE_LIMIT) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerAllianceChanged(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ALLIANCE_CHANGED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerDefeat(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_DEFEAT) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerVictory(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_VICTORY) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerLeave(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_LEAVE) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerChat(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_CHAT) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerEndCinematic(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_END_CINEMATIC) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowLeft_Down(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_LEFT_DOWN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowLeft_Up(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_LEFT_UP) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowRight_Down(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_RIGHT_DOWN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowRight_Up(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_RIGHT_UP) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowDown_Down(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_DOWN_DOWN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowDown_Up(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_DOWN_UP) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowUp_Down(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_UP_DOWN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerArrowUp_Up(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_UP_UP) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerMouseDown(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_MOUSE_DOWN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerMouseUp(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_MOUSE_UP) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerMouseMove(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_MOUSE_MOVE) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerSyncData(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_SYNC_DATA) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerKey(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_KEY) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerKeyDown(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_KEY_DOWN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerKeyUp(player_index) TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_KEY_UP) end
-- Any unit events
---@return nil
function Trigger:addEvent_AnyUnitAttacked() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ATTACKED) end end
---@return nil
function Trigger:addEvent_AnyUnitResqued() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESCUED) end end
---@return nil
function Trigger:addEvent_AnyUnitDeath() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DEATH) end end
---@return nil
function Trigger:addEvent_AnyUnitDecay() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DECAY) end end
---@return nil
function Trigger:addEvent_AnyUnitDetect() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DETECTED) end end
---@return nil
function Trigger:addEvent_AnyUnitHidden() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_HIDDEN) end end
---@return nil
function Trigger:addEvent_AnyUnitSelected() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELECTED) end end
---@return nil
function Trigger:addEvent_AnyUnitDeselected() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DESELECTED) end end
---@return nil
function Trigger:addEvent_AnyUnitConstructStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START) end end
---@return nil
function Trigger:addEvent_AnyUnitConstructCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitConstructFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitUpgradeStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START) end end
---@return nil
function Trigger:addEvent_AnyUnitCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitTrainStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_START) end end
---@return nil
function Trigger:addEvent_AnyUnitTrainCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitTrainFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitResearchStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START) end end
---@return nil
function Trigger:addEvent_AnyUnitResearchCancel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyUnitResearchFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrder() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrderPointTarget() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrderTarget() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end end
---@return nil
function Trigger:addEvent_AnyUnitIssuedOrderUnitTarget() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end end
---@return nil
function Trigger:addEvent_AnyHeroLevel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_LEVEL) end end
---@return nil
function Trigger:addEvent_AnyHeroSkill() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_SKILL) end end
---@return nil
function Trigger:addEvent_AnyHeroRevivable() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVABLE) end end
---@return nil
function Trigger:addEvent_AnyHeroReviveStart() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_START) end end
---@return nil
function Trigger:addEvent_AnyHeroReviveCance() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL) end end
---@return nil
function Trigger:addEvent_AnyHeroReviveFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitSummon() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SUMMON) end end
---@return nil
function Trigger:addEvent_AnyUnitDropItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitPickUpItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitUseItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_USE_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitLoaded() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_LOADED) end end
---@return nil
function Trigger:addEvent_AnyUnitDamaged() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DAMAGED) end end
---@return nil
function Trigger:addEvent_AnyUnitDamaging() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DAMAGING) end end
---@return nil
function Trigger:addEvent_AnyUnitSell() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELL) end end
---@return nil
function Trigger:addEvent_AnyUnitChangeOwner() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER) end end
---@return nil
function Trigger:addEvent_AnyUnitSellItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellChannel() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellCast() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellEffect() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellFinish() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH) end end
---@return nil
function Trigger:addEvent_AnyUnitSpellEndCast() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end end
---@return nil
function Trigger:addEvent_AnyUnitPawnItem() for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM) end end
-- Player unit events
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitAttacked(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ATTACKED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitResqued(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESCUED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDeath(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DEATH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDecay(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DECAY) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDeath(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DETECTED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitHidden(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_HIDDEN) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSelected(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SELECTED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDeselected(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DESELECTED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitConstructStart(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CONSTRUCT_START) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitConstructCancel(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitConstructFinish(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitUpgradeStart(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_UPGRADE_START) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitCancel(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitFinish(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitTrainStart(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_TRAIN_START) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitTrainCancel(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitTrainFinish(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_TRAIN_FINISH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitResearchStart(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESEARCH_START) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitResearchCancel(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitResearchFinish(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrder(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_ORDER) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrderPointTartet(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrderTarget(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitIssuedOrderUnitTarget(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerHeroLevel(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_LEVEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerHeroSkill(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_SKILL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerHeroRevivable(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVABLE) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerHeroReviveStart(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVE_START) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerHeroReviveCance(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVE_CANCEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerHeroReviveFinish(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVE_FINISH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSummon(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SUMMON) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDropItem(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DROP_ITEM) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitPickUpItem(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_PICKUP_ITEM) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitUseItem(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_USE_ITEM) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitLoaded(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_LOADED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDamaged(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DAMAGED) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitDamaging(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DAMAGING) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSell(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SELL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitChangeOwner(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CHANGE_OWNER) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSellItem(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SELL_ITEM) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSpellChannel(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSpellCast(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_CAST) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSpellEffect(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_EFFECT) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSpellFinish(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_FINISH) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitSpellEndCast(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end
---@param player_index integer
---@return nil
function Trigger:addEvent_PlayerUnitPawnItem(player_index) TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_PAWN_ITEM) end
-- Unit events
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDamaged(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DAMAGED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDamaging(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DAMAGING) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDeath(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DEATH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDecay(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DECAY) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDetected(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DETECTED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitHiden(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HIDDEN) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSelected(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SELECTED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDeselected(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DESELECTED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitStateLimit(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_STATE_LIMIT) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitAcquiredTarget(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ACQUIRED_TARGET) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTargetInRange(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TARGET_IN_RANGE) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitAttacked(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ATTACKED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResqued(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESCUED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitConstructCancel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_CONSTRUCT_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitConstructFinish(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_CONSTRUCT_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUpgradeStart(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUpgradeCancel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUpgradeFinish(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTrainStart(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTrainCancel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitTrainFinish(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResearchStart(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResearchCancel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitResearchFinish(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitIssuedOrder(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_ORDER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitIssuedOrderPoint(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_POINT_ORDER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitIssuedOrderTarget(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_TARGET_ORDER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroLevel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_LEVEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroSkill(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_SKILL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroRevivable(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVABLE) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroReviveStart(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_START) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroReviveCancel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_CANCEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_HeroReviveFinish(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSummon(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SUMMON) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitDropItem(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DROP_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitPickUpItem(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_PICKUP_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitUseItem(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_USE_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitLoaded(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_LOADED) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSell(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SELL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitChangeOwner(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_CHANGE_OWNER) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSellItem(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SELL_ITEM) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellChannel(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_CHANNEL) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellCast(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_CAST) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellEffect(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_EFFECT) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellFinish(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_FINISH) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitSpellEndCast(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_ENDCAST) end
---@param unit Unit
---@return nil
function Trigger:addEvent_UnitPawnItem(unit) TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_PAWN_ITEM) end
-- Dialog events
---@return nil
function Trigger:addEvent_Dialog(dialog) TriggerRegisterDialogEvent(self.trigger_obj, dialog) end
---@return nil
function Trigger:addEvent_DialogButtonClicked(button) TriggerRegisterDialogButtonEvent(self.trigger_obj, button) end

return Trigger