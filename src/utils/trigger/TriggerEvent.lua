---@class TriggerEvent
local TriggerEvent = {
    Game = {},
    Player = {},
    PlayerUnit = {},
    AnyUnit = {},
    Unit = {}
}

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

    TriggerEvent.Game["Victory"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VICTORY) end
    TriggerEvent.Game["End"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_END_LEVEL) end
    TriggerEvent.Game["VariableLimit"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VARIABLE_LIMIT) end
    TriggerEvent.Game["StateLimit"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_STATE_LIMIT) end
    TriggerEvent.Game["TimerExpired"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TIMER_EXPIRED) end
    TriggerEvent.Game["EnterRegion"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_ENTER_REGION) end
    TriggerEvent.Game["LeaveRegion"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LEAVE_REGION) end
    TriggerEvent.Game["TrackableHit"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_HIT) end
    TriggerEvent.Game["TrackableTrack"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_TRACK) end
    TriggerEvent.Game["ShowSkill"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SHOW_SKILL) end
    TriggerEvent.Game["BuildSubmenu"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_BUILD_SUBMENU) end
    TriggerEvent.Game["Loaded"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LOADED) end
    TriggerEvent.Game["TournamentFinishSoon"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_SOON) end
    TriggerEvent.Game["TournamentFinishNow"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_NOW) end
    TriggerEvent.Game["Save"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SAVE) end
    TriggerEvent.Game["CustomUIFrame"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_CUSTOM_UI_FRAME) end

    TriggerEvent.Player["StateLimit"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_STATE_LIMIT) end
    TriggerEvent.Player["AllianceChanged"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ALLIANCE_CHANGED) end
    TriggerEvent.Player["Defeat"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_DEFEAT) end
    TriggerEvent.Player["Victory"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_VICTORY) end
    TriggerEvent.Player["Leave"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_LEAVE) end
    TriggerEvent.Player["Chat"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_CHAT) end
    TriggerEvent.Player["EndCinematic"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_END_CINEMATIC) end
    TriggerEvent.Player["ArrowLeft_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_DOWN) end
    TriggerEvent.Player["ArrowLeft_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_UP) end
    TriggerEvent.Player["ArrowRight_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_DOWN) end
    TriggerEvent.Player["ArrowRight_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_UP) end
    TriggerEvent.Player["ArrowDown_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_DOWN) end
    TriggerEvent.Player["ArrowDown_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_UP) end
    TriggerEvent.Player["ArrowUp_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_DOWN) end
    TriggerEvent.Player["ArrowUp_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_UP) end
    TriggerEvent.Player["MouseDown"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_DOWN) end
    TriggerEvent.Player["MouseUp"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_UP) end
    TriggerEvent.Player["MouseMove"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_MOVE) end
    TriggerEvent.Player["SyncData"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_SYNC_DATA) end
    TriggerEvent.Player["Key"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY) end
    TriggerEvent.Player["KeyDown"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_DOWN) end
    TriggerEvent.Player["KeyUp"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_UP) end

    TriggerEvent.PlayerUnit["Attacked"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ATTACKED) end
    TriggerEvent.PlayerUnit["Rescued"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESCUED) end
    TriggerEvent.PlayerUnit["Death"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DEATH) end
    TriggerEvent.PlayerUnit["Decay"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DECAY) end
    TriggerEvent.PlayerUnit["Death"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DETECTED) end
    TriggerEvent.PlayerUnit["Hidden"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_HIDDEN) end
    TriggerEvent.PlayerUnit["Selected"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELECTED) end
    TriggerEvent.PlayerUnit["Deselected"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DESELECTED) end
    TriggerEvent.PlayerUnit["ConstructStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_START) end
    TriggerEvent.PlayerUnit["ConstructCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end
    TriggerEvent.PlayerUnit["ConstructFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end
    TriggerEvent.PlayerUnit["UpgradeStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_START) end
    TriggerEvent.PlayerUnit["Cancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end
    TriggerEvent.PlayerUnit["Finish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_FINISH) end
    TriggerEvent.PlayerUnit["TrainStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_START) end
    TriggerEvent.PlayerUnit["TrainCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_CANCEL) end
    TriggerEvent.PlayerUnit["TrainFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_FINISH) end
    TriggerEvent.PlayerUnit["ResearchStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_START) end
    TriggerEvent.PlayerUnit["ResearchCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end
    TriggerEvent.PlayerUnit["ResearchFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_FINISH) end
    TriggerEvent.PlayerUnit["IssuedOrder"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_ORDER) end
    TriggerEvent.PlayerUnit["IssuedOrderPointTarget"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end
    TriggerEvent.PlayerUnit["IssuedOrderTarget"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end
    TriggerEvent.PlayerUnit["IssuedOrderUnitTarget"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end
    TriggerEvent.PlayerUnit["Level"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_LEVEL) end
    TriggerEvent.PlayerUnit["Skill"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_SKILL) end
    TriggerEvent.PlayerUnit["Revivable"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVABLE) end
    TriggerEvent.PlayerUnit["ReviveStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_START) end
    TriggerEvent.PlayerUnit["ReviveCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_CANCEL) end
    TriggerEvent.PlayerUnit["ReviveFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_FINISH) end
    TriggerEvent.PlayerUnit["Summon"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SUMMON) end
    TriggerEvent.PlayerUnit["DropItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DROP_ITEM) end
    TriggerEvent.PlayerUnit["PickUpItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PICKUP_ITEM) end
    TriggerEvent.PlayerUnit["UseItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_USE_ITEM) end
    TriggerEvent.PlayerUnit["Loaded"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_LOADED) end
    TriggerEvent.PlayerUnit["Damaged"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGED) end
    TriggerEvent.PlayerUnit["Damaging"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGING) end
    TriggerEvent.PlayerUnit["Sell"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL) end
    TriggerEvent.PlayerUnit["ChangeOwner"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CHANGE_OWNER) end
    TriggerEvent.PlayerUnit["SellItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL_ITEM) end
    TriggerEvent.PlayerUnit["SpellChannel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CHANNEL) end
    TriggerEvent.PlayerUnit["SpellCast"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CAST) end
    TriggerEvent.PlayerUnit["SpellEffect"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_EFFECT) end
    TriggerEvent.PlayerUnit["SpellFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_FINISH) end
    TriggerEvent.PlayerUnit["SpellEndCast"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_ENDCAST) end
    TriggerEvent.PlayerUnit["PawnItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PAWN_ITEM) end

    TriggerEvent.AnyUnit["Attacked"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED) end end
    TriggerEvent.AnyUnit["Rescued"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESCUED) end end
    TriggerEvent.AnyUnit["Death"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH) end end
    TriggerEvent.AnyUnit["Decay"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DECAY) end end
    TriggerEvent.AnyUnit["Detect"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DETECTED) end end
    TriggerEvent.AnyUnit["Hidden"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_HIDDEN) end end
    TriggerEvent.AnyUnit["Selected"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELECTED) end end
    TriggerEvent.AnyUnit["Deselected"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DESELECTED) end end
    TriggerEvent.AnyUnit["ConstructStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START) end end
    TriggerEvent.AnyUnit["ConstructCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end end
    TriggerEvent.AnyUnit["ConstructFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end end
    TriggerEvent.AnyUnit["UpgradeStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START) end end
    TriggerEvent.AnyUnit["Cancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end end
    TriggerEvent.AnyUnit["Finish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end end
    TriggerEvent.AnyUnit["TrainStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_START) end end
    TriggerEvent.AnyUnit["TrainCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end end
    TriggerEvent.AnyUnit["TrainFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH) end end
    TriggerEvent.AnyUnit["ResearchStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START) end end
    TriggerEvent.AnyUnit["ResearchCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end end
    TriggerEvent.AnyUnit["ResearchFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end end
    TriggerEvent.AnyUnit["IssuedOrder"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER) end end
    TriggerEvent.AnyUnit["IssuedOrderPointTarget"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end end
    TriggerEvent.AnyUnit["IssuedOrderTarget"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end end
    TriggerEvent.AnyUnit["IssuedOrderUnitTarget"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end end
    TriggerEvent.AnyUnit["Level"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_LEVEL) end end
    TriggerEvent.AnyUnit["Skill"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_SKILL) end end
    TriggerEvent.AnyUnit["Revivable"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVABLE) end end
    TriggerEvent.AnyUnit["ReviveStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_START) end end
    TriggerEvent.AnyUnit["ReviveCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL) end end
    TriggerEvent.AnyUnit["ReviveFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH) end end
    TriggerEvent.AnyUnit["Summon"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SUMMON) end end
    TriggerEvent.AnyUnit["DropItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM) end end
    TriggerEvent.AnyUnit["PickUpItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM) end end
    TriggerEvent.AnyUnit["UseItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_USE_ITEM) end end
    TriggerEvent.AnyUnit["Loaded"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_LOADED) end end
    TriggerEvent.AnyUnit["Damaged"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED) end end
    TriggerEvent.AnyUnit["Damaging"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING) end end
    TriggerEvent.AnyUnit["Sell"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL) end end
    TriggerEvent.AnyUnit["ChangeOwner"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER) end end
    TriggerEvent.AnyUnit["SellItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM) end end
    TriggerEvent.AnyUnit["SpellChannel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end end
    TriggerEvent.AnyUnit["SpellCast"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST) end end
    TriggerEvent.AnyUnit["SpellEffect"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT) end end
    TriggerEvent.AnyUnit["SpellFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH) end end
    TriggerEvent.AnyUnit["SpellEndCast"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end end
    TriggerEvent.AnyUnit["PawnItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM) end end

    TriggerEvent.Unit["Damaged"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGED) end
    TriggerEvent.Unit["Damaging"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGING) end
    TriggerEvent.Unit["Death"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DEATH) end
    TriggerEvent.Unit["Decay"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DECAY) end
    TriggerEvent.Unit["Detected"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DETECTED) end
    TriggerEvent.Unit["Hiden"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HIDDEN) end
    TriggerEvent.Unit["Selected"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELECTED) end
    TriggerEvent.Unit["Deselected"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DESELECTED) end
    TriggerEvent.Unit["StateLimit"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_STATE_LIMIT) end
    TriggerEvent.Unit["AcquiredTarget"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ACQUIRED_TARGET) end
    TriggerEvent.Unit["TargetInRange"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TARGET_IN_RANGE) end
    TriggerEvent.Unit["Attacked"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ATTACKED) end
    TriggerEvent.Unit["Rescued"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESCUED) end
    TriggerEvent.Unit["ConstructCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_CANCEL) end
    TriggerEvent.Unit["ConstructFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_FINISH) end
    TriggerEvent.Unit["UpgradeStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_START) end
    TriggerEvent.Unit["UpgradeCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_CANCEL) end
    TriggerEvent.Unit["UpgradeFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_FINISH) end
    TriggerEvent.Unit["TrainStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_START) end
    TriggerEvent.Unit["TrainCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_CANCEL) end
    TriggerEvent.Unit["TrainFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_FINISH) end
    TriggerEvent.Unit["ResearchStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_START) end
    TriggerEvent.Unit["ResearchCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_CANCEL) end
    TriggerEvent.Unit["ResearchFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_FINISH) end
    TriggerEvent.Unit["IssuedOrder"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_ORDER) end
    TriggerEvent.Unit["IssuedOrderPoint"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_POINT_ORDER) end
    TriggerEvent.Unit["IssuedOrderTarget"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_TARGET_ORDER) end
    TriggerEvent.Unit["Level"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_LEVEL) end
    TriggerEvent.Unit["Skill"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_SKILL) end
    TriggerEvent.Unit["Revivable"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVABLE) end
    TriggerEvent.Unit["ReviveStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_START) end
    TriggerEvent.Unit["ReviveCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_CANCEL) end
    TriggerEvent.Unit["ReviveFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_FINISH) end
    TriggerEvent.Unit["Summon"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SUMMON) end
    TriggerEvent.Unit["DropItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DROP_ITEM) end
    TriggerEvent.Unit["PickUpItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PICKUP_ITEM) end
    TriggerEvent.Unit["UseItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_USE_ITEM) end
    TriggerEvent.Unit["Loaded"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_LOADED) end
    TriggerEvent.Unit["Sell"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL) end
    TriggerEvent.Unit["ChangeOwner"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CHANGE_OWNER) end
    TriggerEvent.Unit["SellItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL_ITEM) end
    TriggerEvent.Unit["SpellChannel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CHANNEL) end
    TriggerEvent.Unit["SpellCast"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CAST) end
    TriggerEvent.Unit["SpellEffect"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_EFFECT) end
    TriggerEvent.Unit["SpellFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_FINISH) end
    TriggerEvent.Unit["SpellEndCast"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_ENDCAST) end
    TriggerEvent.Unit["PawnItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PAWN_ITEM) end

return TriggerEvent