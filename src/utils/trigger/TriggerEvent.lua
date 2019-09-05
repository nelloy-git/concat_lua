---@class TriggerEvent
local TriggerEvent = {
    Game = {},
    AnyPlayer = {},
    Player = {},
    PlayerUnit = {},
    AnyUnit = {},
    Unit = {},
    Keyboard = {}
}

---@alias TriggerEventType string
---| '"Game"'
---| '"AnyPlayer"'
---| '"Player"'
---| '"PlayerUnit"'
---| '"AnyUnit"'
---| '"Unit"'

---@alias TriggerGameEvent string
---| '"Victory"'
---| '"End"'
---| '"VariableLimit"'
---| '"StateLimit"'
---| '"TimerExpired"'
---| '"EnterRegion"'
---| '"LeaveRegion"'
---| '"TrackableHit"'
---| '"TrackableTrack"'
---| '"ShowSkill"'
---| '"BuildSubmenu"'
---| '"Loaded"'
---| '"TournamentFinishSoon"'
---| '"TournamentFinishNow"'
---| '"Save"'
---| '"CustomUIFrame"'

---@alias TriggerPlayerEvent string
---| '"StateLimit"'
---| '"AllianceChanged"'
---| '"Defeat"'
---| '"Victory"'
---| '"Leave"'
---| '"Chat"'
---| '"EndCinematic"'
---| '"ArrowLeft_Down"'
---| '"ArrowLeft_Up"'
---| '"ArrowRight_Down"'
---| '"ArrowRight_Up"'
---| '"ArrowDown_Down"'
---| '"ArrowDown_Up"'
---| '"ArrowUp_Down"'
---| '"ArrowUp_Up"'
---| '"MouseDown"'
---| '"MouseUp"'
---| '"MouseMove"'
---| '"SyncData"'
---| '"Key"'
---| '"KeyDown"'
---| '"KeyUp"'

---@alias TriggerAnyPlayerEvent string
---| '"StateLimit"'
---| '"AllianceChanged"'
---| '"Defeat"'
---| '"Victory"'
---| '"Leave"'
---| '"Chat"'
---| '"EndCinematic"'
---| '"ArrowLeft_Down"'
---| '"ArrowLeft_Up"'
---| '"ArrowRight_Down"'
---| '"ArrowRight_Up"'
---| '"ArrowDown_Down"'
---| '"ArrowDown_Up"'
---| '"ArrowUp_Down"'
---| '"ArrowUp_Up"'
---| '"MouseDown"'
---| '"MouseUp"'
---| '"MouseMove"'
---| '"SyncData"'
---| '"Key"'
---| '"KeyDown"'
---| '"KeyUp"'

---@alias TriggerPlayerUnitEvent string
---| '"Attacked"'
---| '"Rescued"'
---| '"Death"'
---| '"Decay"'
---| '"Death"'
---| '"Hidden"'
---| '"Selected"'
---| '"Deselected"'
---| '"ConstructStart"'
---| '"ConstructCancel"'
---| '"ConstructFinish"'
---| '"UpgradeStart"'
---| '"Cancel"'
---| '"Finish"'
---| '"TrainStart"'
---| '"TrainCancel"'
---| '"TrainFinish"'
---| '"ResearchStart"'
---| '"ResearchCancel"'
---| '"ResearchFinish"'
---| '"IssuedOrder"'
---| '"IssuedOrderPointTarget"'
---| '"IssuedOrderTarget"'
---| '"IssuedOrderUnitTarget"'
---| '"Level"'
---| '"Skill"'
---| '"Revivable"'
---| '"ReviveStart"'
---| '"ReviveCancel"'
---| '"ReviveFinish"'
---| '"Summon"'
---| '"DropItem"'
---| '"PickUpItem"'
---| '"UseItem"'
---| '"Loaded"'
---| '"Damaged"'
---| '"Damaging"'
---| '"Sell"'
---| '"ChangeOwner"'
---| '"SellItem"'
---| '"SpellChannel"'
---| '"SpellCast"'
---| '"SpellEffect"'
---| '"SpellFinish"'
---| '"SpellEndCast"'
---| '"PawnItem"'

---@alias TriggerAnyUnitEvent string
---| '"Attacked"'
---| '"Rescued"'
---| '"Death"'
---| '"Decay"'
---| '"Detect"'
---| '"Hidden"'
---| '"Selected"'
---| '"Deselected"'
---| '"ConstructStart"'
---| '"ConstructCancel"'
---| '"ConstructFinish"'
---| '"UpgradeStart"'
---| '"Cancel"'
---| '"Finish"'
---| '"TrainStart"'
---| '"TrainCancel"'
---| '"TrainFinish"'
---| '"ResearchStart"'
---| '"ResearchCancel"'
---| '"ResearchFinish"'
---| '"IssuedOrder"'
---| '"IssuedOrderPointTarget"'
---| '"IssuedOrderTarget"'
---| '"IssuedOrderUnitTarget"'
---| '"Level"'
---| '"Skill"'
---| '"Revivable"'
---| '"ReviveStart"'
---| '"ReviveCancel"'
---| '"ReviveFinish"'
---| '"Summon"'
---| '"DropItem"'
---| '"PickUpItem"'
---| '"UseItem"'
---| '"Loaded"'
---| '"Damaged"'
---| '"Damaging"'
---| '"Sell"'
---| '"ChangeOwner"'
---| '"SellItem"'
---| '"SpellChannel"'
---| '"SpellCast"'
---| '"SpellEffect"'
---| '"SpellFinish"'
---| '"SpellEndCast"'
---| '"PawnItem"'

---@alias TriggerUnitEvent string
---| '"Damaged"'
---| '"Damaging"'
---| '"Death"'
---| '"Decay"'
---| '"Detected"'
---| '"Hiden"'
---| '"Selected"'
---| '"Deselected"'
---| '"StateLimit"'
---| '"AcquiredTarget"'
---| '"TargetInRange"'
---| '"Attacked"'
---| '"Rescued"'
---| '"ConstructCancel"'
---| '"ConstructFinish"'
---| '"UpgradeStart"'
---| '"UpgradeCancel"'
---| '"UpgradeFinish"'
---| '"TrainStart"'
---| '"TrainCancel"'
---| '"TrainFinish"'
---| '"ResearchStart"'
---| '"ResearchCancel"'
---| '"ResearchFinish"'
---| '"IssuedOrder"'
---| '"IssuedOrderPoint"'
---| '"IssuedOrderTarget"'
---| '"Level"'
---| '"Skill"'
---| '"Revivable"'
---| '"ReviveStart"'
---| '"ReviveCancel"'
---| '"ReviveFinish"'
---| '"Summon"'
---| '"DropItem"'
---| '"PickUpItem"'
---| '"UseItem"'
---| '"Loaded"'
---| '"Sell"'
---| '"ChangeOwner"'
---| '"SellItem"'
---| '"SpellChannel"'
---| '"SpellCast"'
---| '"SpellEffect"'
---| '"SpellFinish"'
---| '"SpellEndCast"'
---| '"PawnItem"'

---@alias TriggerLocalKeyboardEvent string
---| '"KeyDown"'
---| '"KeyUp"'
   
    TriggerEvent.Game["Victory"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_VICTORY) end
    TriggerEvent.Game["End"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_END_LEVEL) end
    TriggerEvent.Game["VariableLimit"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_VARIABLE_LIMIT) end
    TriggerEvent.Game["StateLimit"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_STATE_LIMIT) end
    TriggerEvent.Game["TimerExpired"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_TIMER_EXPIRED) end
    TriggerEvent.Game["EnterRegion"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_ENTER_REGION) end
    TriggerEvent.Game["LeaveRegion"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_LEAVE_REGION) end
    TriggerEvent.Game["TrackableHit"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_TRACKABLE_HIT) end
    TriggerEvent.Game["TrackableTrack"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_TRACKABLE_TRACK) end
    TriggerEvent.Game["ShowSkill"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_SHOW_SKILL) end
    TriggerEvent.Game["BuildSubmenu"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_BUILD_SUBMENU) end
    TriggerEvent.Game["Loaded"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_LOADED) end
    TriggerEvent.Game["TournamentFinishSoon"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_TOURNAMENT_FINISH_SOON) end
    TriggerEvent.Game["TournamentFinishNow"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_TOURNAMENT_FINISH_NOW) end
    TriggerEvent.Game["Save"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_SAVE) end
    TriggerEvent.Game["CustomUIFrame"] = function(trigger) TriggerRegisterGameEvent(trigger, EVENT_GAME_CUSTOM_UI_FRAME) end

    TriggerEvent.Player["StateLimit"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_STATE_LIMIT) end
    TriggerEvent.Player["AllianceChanged"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ALLIANCE_CHANGED) end
    TriggerEvent.Player["Defeat"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_DEFEAT) end
    TriggerEvent.Player["Victory"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_VICTORY) end
    TriggerEvent.Player["Leave"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_LEAVE) end
    TriggerEvent.Player["Chat"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_CHAT) end
    TriggerEvent.Player["EndCinematic"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_END_CINEMATIC) end
    TriggerEvent.Player["ArrowLeft_Down"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_LEFT_DOWN) end
    TriggerEvent.Player["ArrowLeft_Up"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_LEFT_UP) end
    TriggerEvent.Player["ArrowRight_Down"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_RIGHT_DOWN) end
    TriggerEvent.Player["ArrowRight_Up"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_RIGHT_UP) end
    TriggerEvent.Player["ArrowDown_Down"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_DOWN_DOWN) end
    TriggerEvent.Player["ArrowDown_Up"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_DOWN_UP) end
    TriggerEvent.Player["ArrowUp_Down"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_UP_DOWN) end
    TriggerEvent.Player["ArrowUp_Up"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_ARROW_UP_UP) end
    TriggerEvent.Player["MouseDown"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_MOUSE_DOWN) end
    TriggerEvent.Player["MouseUp"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_MOUSE_UP) end
    TriggerEvent.Player["MouseMove"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_MOUSE_MOVE) end
    TriggerEvent.Player["SyncData"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_SYNC_DATA) end
    TriggerEvent.Player["Key"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_KEY) end
    TriggerEvent.Player["KeyDown"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_KEY_DOWN) end
    TriggerEvent.Player["KeyUp"] = function(trigger, player) TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_KEY_UP) end

    TriggerEvent.AnyPlayer["StateLimit"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_STATE_LIMIT) end end
    TriggerEvent.AnyPlayer["AllianceChanged"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ALLIANCE_CHANGED) end end
    TriggerEvent.AnyPlayer["Defeat"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_DEFEAT) end end
    TriggerEvent.AnyPlayer["Victory"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_VICTORY) end end
    TriggerEvent.AnyPlayer["Leave"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_LEAVE) end end
    TriggerEvent.AnyPlayer["Chat"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_CHAT) end end
    TriggerEvent.AnyPlayer["EndCinematic"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_END_CINEMATIC) end end
    TriggerEvent.AnyPlayer["ArrowLeft_Down"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_LEFT_DOWN) end end
    TriggerEvent.AnyPlayer["ArrowLeft_Up"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_LEFT_UP) end end
    TriggerEvent.AnyPlayer["ArrowRight_Down"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_RIGHT_DOWN) end end
    TriggerEvent.AnyPlayer["ArrowRight_Up"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_RIGHT_UP) end end
    TriggerEvent.AnyPlayer["ArrowDown_Down"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_DOWN_DOWN) end end
    TriggerEvent.AnyPlayer["ArrowDown_Up"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_DOWN_UP) end end
    TriggerEvent.AnyPlayer["ArrowUp_Down"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_UP_DOWN) end end
    TriggerEvent.AnyPlayer["ArrowUp_Up"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_ARROW_UP_UP) end end
    TriggerEvent.AnyPlayer["MouseDown"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_MOUSE_DOWN) end end
    TriggerEvent.AnyPlayer["MouseUp"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_MOUSE_UP) end end
    TriggerEvent.AnyPlayer["MouseMove"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_MOUSE_MOVE) end end
    TriggerEvent.AnyPlayer["SyncData"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_SYNC_DATA) end end
    TriggerEvent.AnyPlayer["Key"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_KEY) end end
    TriggerEvent.AnyPlayer["KeyDown"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_KEY_DOWN) end end
    TriggerEvent.AnyPlayer["KeyUp"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerEvent(trigger, Player(i), EVENT_PLAYER_KEY_UP) end end

    TriggerEvent.PlayerUnit["Attacked"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_ATTACKED) end
    TriggerEvent.PlayerUnit["Rescued"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_RESCUED) end
    TriggerEvent.PlayerUnit["Death"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DEATH) end
    TriggerEvent.PlayerUnit["Decay"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DECAY) end
    TriggerEvent.PlayerUnit["Death"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DETECTED) end
    TriggerEvent.PlayerUnit["Hidden"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_HIDDEN) end
    TriggerEvent.PlayerUnit["Selected"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SELECTED) end
    TriggerEvent.PlayerUnit["Deselected"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DESELECTED) end
    TriggerEvent.PlayerUnit["ConstructStart"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_CONSTRUCT_START) end
    TriggerEvent.PlayerUnit["ConstructCancel"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end
    TriggerEvent.PlayerUnit["ConstructFinish"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end
    TriggerEvent.PlayerUnit["UpgradeStart"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_UPGRADE_START) end
    TriggerEvent.PlayerUnit["Cancel"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end
    TriggerEvent.PlayerUnit["Finish"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_UPGRADE_FINISH) end
    TriggerEvent.PlayerUnit["TrainStart"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_TRAIN_START) end
    TriggerEvent.PlayerUnit["TrainCancel"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_TRAIN_CANCEL) end
    TriggerEvent.PlayerUnit["TrainFinish"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_TRAIN_FINISH) end
    TriggerEvent.PlayerUnit["ResearchStart"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_RESEARCH_START) end
    TriggerEvent.PlayerUnit["ResearchCancel"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end
    TriggerEvent.PlayerUnit["ResearchFinish"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_RESEARCH_FINISH) end
    TriggerEvent.PlayerUnit["IssuedOrder"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_ISSUED_ORDER) end
    TriggerEvent.PlayerUnit["IssuedOrderPointTarget"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end
    TriggerEvent.PlayerUnit["IssuedOrderTarget"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end
    TriggerEvent.PlayerUnit["IssuedOrderUnitTarget"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end
    TriggerEvent.PlayerUnit["Level"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_HERO_LEVEL) end
    TriggerEvent.PlayerUnit["Skill"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_HERO_SKILL) end
    TriggerEvent.PlayerUnit["Revivable"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_HERO_REVIVABLE) end
    TriggerEvent.PlayerUnit["ReviveStart"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_HERO_REVIVE_START) end
    TriggerEvent.PlayerUnit["ReviveCancel"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_HERO_REVIVE_CANCEL) end
    TriggerEvent.PlayerUnit["ReviveFinish"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_HERO_REVIVE_FINISH) end
    TriggerEvent.PlayerUnit["Summon"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SUMMON) end
    TriggerEvent.PlayerUnit["DropItem"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DROP_ITEM) end
    TriggerEvent.PlayerUnit["PickUpItem"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_PICKUP_ITEM) end
    TriggerEvent.PlayerUnit["UseItem"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_USE_ITEM) end
    TriggerEvent.PlayerUnit["Loaded"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_LOADED) end
    TriggerEvent.PlayerUnit["Damaged"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DAMAGED) end
    TriggerEvent.PlayerUnit["Damaging"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_DAMAGING) end
    TriggerEvent.PlayerUnit["Sell"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SELL) end
    TriggerEvent.PlayerUnit["ChangeOwner"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_CHANGE_OWNER) end
    TriggerEvent.PlayerUnit["SellItem"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SELL_ITEM) end
    TriggerEvent.PlayerUnit["SpellChannel"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SPELL_CHANNEL) end
    TriggerEvent.PlayerUnit["SpellCast"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SPELL_CAST) end
    TriggerEvent.PlayerUnit["SpellEffect"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SPELL_EFFECT) end
    TriggerEvent.PlayerUnit["SpellFinish"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SPELL_FINISH) end
    TriggerEvent.PlayerUnit["SpellEndCast"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_SPELL_ENDCAST) end
    TriggerEvent.PlayerUnit["PawnItem"] = function(trigger, player) TriggerRegisterPlayerUnitEvent(trigger, player, EVENT_PLAYER_UNIT_PAWN_ITEM) end

    TriggerEvent.AnyUnit["Attacked"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED) end end
    TriggerEvent.AnyUnit["Rescued"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_RESCUED) end end
    TriggerEvent.AnyUnit["Death"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DEATH) end end
    TriggerEvent.AnyUnit["Decay"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DECAY) end end
    TriggerEvent.AnyUnit["Detect"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DETECTED) end end
    TriggerEvent.AnyUnit["Hidden"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_HIDDEN) end end
    TriggerEvent.AnyUnit["Selected"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SELECTED) end end
    TriggerEvent.AnyUnit["Deselected"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DESELECTED) end end
    TriggerEvent.AnyUnit["ConstructStart"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START) end end
    TriggerEvent.AnyUnit["ConstructCancel"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end end
    TriggerEvent.AnyUnit["ConstructFinish"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end end
    TriggerEvent.AnyUnit["UpgradeStart"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START) end end
    TriggerEvent.AnyUnit["Cancel"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end end
    TriggerEvent.AnyUnit["Finish"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end end
    TriggerEvent.AnyUnit["TrainStart"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_START) end end
    TriggerEvent.AnyUnit["TrainCancel"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end end
    TriggerEvent.AnyUnit["TrainFinish"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH) end end
    TriggerEvent.AnyUnit["ResearchStart"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START) end end
    TriggerEvent.AnyUnit["ResearchCancel"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end end
    TriggerEvent.AnyUnit["ResearchFinish"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end end
    TriggerEvent.AnyUnit["IssuedOrder"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER) end end
    TriggerEvent.AnyUnit["IssuedOrderPointTarget"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end end
    TriggerEvent.AnyUnit["IssuedOrderTarget"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end end
    TriggerEvent.AnyUnit["IssuedOrderUnitTarget"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end end
    TriggerEvent.AnyUnit["Level"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_HERO_LEVEL) end end
    TriggerEvent.AnyUnit["Skill"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_HERO_SKILL) end end
    TriggerEvent.AnyUnit["Revivable"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_HERO_REVIVABLE) end end
    TriggerEvent.AnyUnit["ReviveStart"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_START) end end
    TriggerEvent.AnyUnit["ReviveCancel"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL) end end
    TriggerEvent.AnyUnit["ReviveFinish"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH) end end
    TriggerEvent.AnyUnit["Summon"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SUMMON) end end
    TriggerEvent.AnyUnit["DropItem"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM) end end
    TriggerEvent.AnyUnit["PickUpItem"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM) end end
    TriggerEvent.AnyUnit["UseItem"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_USE_ITEM) end end
    TriggerEvent.AnyUnit["Loaded"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_LOADED) end end
    TriggerEvent.AnyUnit["Damaged"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED) end end
    TriggerEvent.AnyUnit["Damaging"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING) end end
    TriggerEvent.AnyUnit["Sell"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SELL) end end
    TriggerEvent.AnyUnit["ChangeOwner"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER) end end
    TriggerEvent.AnyUnit["SellItem"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM) end end
    TriggerEvent.AnyUnit["SpellChannel"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end end
    TriggerEvent.AnyUnit["SpellCast"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST) end end
    TriggerEvent.AnyUnit["SpellEffect"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT) end end
    TriggerEvent.AnyUnit["SpellFinish"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH) end end
    TriggerEvent.AnyUnit["SpellEndCast"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end end
    TriggerEvent.AnyUnit["PawnItem"] = function(trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM) end end

    TriggerEvent.Unit["Damaged"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DAMAGED) end
    TriggerEvent.Unit["Damaging"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DAMAGING) end
    TriggerEvent.Unit["Death"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DEATH) end
    TriggerEvent.Unit["Decay"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DECAY) end
    TriggerEvent.Unit["Detected"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DETECTED) end
    TriggerEvent.Unit["Hiden"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HIDDEN) end
    TriggerEvent.Unit["Selected"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SELECTED) end
    TriggerEvent.Unit["Deselected"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DESELECTED) end
    TriggerEvent.Unit["StateLimit"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_STATE_LIMIT) end
    TriggerEvent.Unit["AcquiredTarget"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_ACQUIRED_TARGET) end
    TriggerEvent.Unit["TargetInRange"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_TARGET_IN_RANGE) end
    TriggerEvent.Unit["Attacked"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_ATTACKED) end
    TriggerEvent.Unit["Rescued"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_RESCUED) end
    TriggerEvent.Unit["ConstructCancel"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_CONSTRUCT_CANCEL) end
    TriggerEvent.Unit["ConstructFinish"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_CONSTRUCT_FINISH) end
    TriggerEvent.Unit["UpgradeStart"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_UPGRADE_START) end
    TriggerEvent.Unit["UpgradeCancel"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_UPGRADE_CANCEL) end
    TriggerEvent.Unit["UpgradeFinish"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_UPGRADE_FINISH) end
    TriggerEvent.Unit["TrainStart"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_TRAIN_START) end
    TriggerEvent.Unit["TrainCancel"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_TRAIN_CANCEL) end
    TriggerEvent.Unit["TrainFinish"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_TRAIN_FINISH) end
    TriggerEvent.Unit["ResearchStart"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_RESEARCH_START) end
    TriggerEvent.Unit["ResearchCancel"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_RESEARCH_CANCEL) end
    TriggerEvent.Unit["ResearchFinish"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_RESEARCH_FINISH) end
    TriggerEvent.Unit["IssuedOrder"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_ISSUED_ORDER) end
    TriggerEvent.Unit["IssuedOrderPoint"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_ISSUED_POINT_ORDER) end
    TriggerEvent.Unit["IssuedOrderTarget"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_ISSUED_TARGET_ORDER) end
    TriggerEvent.Unit["Level"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HERO_LEVEL) end
    TriggerEvent.Unit["Skill"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HERO_SKILL) end
    TriggerEvent.Unit["Revivable"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HERO_REVIVABLE) end
    TriggerEvent.Unit["ReviveStart"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HERO_REVIVE_START) end
    TriggerEvent.Unit["ReviveCancel"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HERO_REVIVE_CANCEL) end
    TriggerEvent.Unit["ReviveFinish"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_HERO_REVIVE_FINISH) end
    TriggerEvent.Unit["Summon"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SUMMON) end
    TriggerEvent.Unit["DropItem"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_DROP_ITEM) end
    TriggerEvent.Unit["PickUpItem"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_PICKUP_ITEM) end
    TriggerEvent.Unit["UseItem"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_USE_ITEM) end
    TriggerEvent.Unit["Loaded"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_LOADED) end
    TriggerEvent.Unit["Sell"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SELL) end
    TriggerEvent.Unit["ChangeOwner"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_CHANGE_OWNER) end
    TriggerEvent.Unit["SellItem"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SELL_ITEM) end
    TriggerEvent.Unit["SpellChannel"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SPELL_CHANNEL) end
    TriggerEvent.Unit["SpellCast"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SPELL_CAST) end
    TriggerEvent.Unit["SpellEffect"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SPELL_EFFECT) end
    TriggerEvent.Unit["SpellFinish"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SPELL_FINISH) end
    TriggerEvent.Unit["SpellEndCast"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_SPELL_ENDCAST) end
    TriggerEvent.Unit["PawnItem"] = function(trigger, unit) TriggerRegisterUnitEvent(trigger, unit, EVENT_UNIT_PAWN_ITEM) end

    TriggerEvent.Keyboard["KeyDown"] = function(trigger, player, key) BlzTriggerRegisterPlayerKeyEvent(trigger, player, key, 0, true) end
    TriggerEvent.Keyboard["KeyUp"] = function(trigger, player, key) BlzTriggerRegisterPlayerKeyEvent(trigger, player, key, 0, false) end

return TriggerEvent