---@class TriggerEvent
local Event = {
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
---| '"Resqued"'
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
---| '"IssuedOrderPointTartet"'
---| '"IssuedOrderTarget"'
---| '"IssuedOrderUnitTarget"'
---| '"Level"'
---| '"Skill"'
---| '"Revivable"'
---| '"ReviveStart"'
---| '"ReviveCance"'
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
---| '"Resqued"'
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
---| '"ReviveCance"'
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
---| '"Resqued"'
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

    Event.Game["Victory"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VICTORY) end
    Event.Game["End"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_END_LEVEL) end
    Event.Game["VariableLimit"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VARIABLE_LIMIT) end
    Event.Game["StateLimit"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_STATE_LIMIT) end
    Event.Game["TimerExpired"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TIMER_EXPIRED) end
    Event.Game["EnterRegion"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_ENTER_REGION) end
    Event.Game["LeaveRegion"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LEAVE_REGION) end
    Event.Game["TrackableHit"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_HIT) end
    Event.Game["TrackableTrack"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_TRACK) end
    Event.Game["ShowSkill"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SHOW_SKILL) end
    Event.Game["BuildSubmenu"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_BUILD_SUBMENU) end
    Event.Game["Loaded"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LOADED) end
    Event.Game["TournamentFinishSoon"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_SOON) end
    Event.Game["TournamentFinishNow"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_NOW) end
    Event.Game["Save"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SAVE) end
    Event.Game["CustomUIFrame"] = function(wc3_trigger) TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_CUSTOM_UI_FRAME) end

    Event.Player["StateLimit"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_STATE_LIMIT) end
    Event.Player["AllianceChanged"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ALLIANCE_CHANGED) end
    Event.Player["Defeat"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_DEFEAT) end
    Event.Player["Victory"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_VICTORY) end
    Event.Player["Leave"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_LEAVE) end
    Event.Player["Chat"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_CHAT) end
    Event.Player["EndCinematic"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_END_CINEMATIC) end
    Event.Player["ArrowLeft_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_DOWN) end
    Event.Player["ArrowLeft_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_UP) end
    Event.Player["ArrowRight_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_DOWN) end
    Event.Player["ArrowRight_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_UP) end
    Event.Player["ArrowDown_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_DOWN) end
    Event.Player["ArrowDown_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_UP) end
    Event.Player["ArrowUp_Down"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_DOWN) end
    Event.Player["ArrowUp_Up"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_UP) end
    Event.Player["MouseDown"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_DOWN) end
    Event.Player["MouseUp"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_UP) end
    Event.Player["MouseMove"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_MOVE) end
    Event.Player["SyncData"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_SYNC_DATA) end
    Event.Player["Key"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY) end
    Event.Player["KeyDown"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_DOWN) end
    Event.Player["KeyUp"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_UP) end

    Event.PlayerUnit["Attacked"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ATTACKED) end
    Event.PlayerUnit["Resqued"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESCUED) end
    Event.PlayerUnit["Death"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DEATH) end
    Event.PlayerUnit["Decay"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DECAY) end
    Event.PlayerUnit["Death"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DETECTED) end
    Event.PlayerUnit["Hidden"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_HIDDEN) end
    Event.PlayerUnit["Selected"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELECTED) end
    Event.PlayerUnit["Deselected"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DESELECTED) end
    Event.PlayerUnit["ConstructStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_START) end
    Event.PlayerUnit["ConstructCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end
    Event.PlayerUnit["ConstructFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end
    Event.PlayerUnit["UpgradeStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_START) end
    Event.PlayerUnit["Cancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end
    Event.PlayerUnit["Finish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_FINISH) end
    Event.PlayerUnit["TrainStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_START) end
    Event.PlayerUnit["TrainCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_CANCEL) end
    Event.PlayerUnit["TrainFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_FINISH) end
    Event.PlayerUnit["ResearchStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_START) end
    Event.PlayerUnit["ResearchCancel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end
    Event.PlayerUnit["ResearchFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_FINISH) end
    Event.PlayerUnit["IssuedOrder"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_ORDER) end
    Event.PlayerUnit["IssuedOrderPointTartet"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end
    Event.PlayerUnit["IssuedOrderTarget"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end
    Event.PlayerUnit["IssuedOrderUnitTarget"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end
    Event.PlayerUnit["Level"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_LEVEL) end
    Event.PlayerUnit["Skill"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_SKILL) end
    Event.PlayerUnit["Revivable"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVABLE) end
    Event.PlayerUnit["ReviveStart"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_START) end
    Event.PlayerUnit["ReviveCance"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_CANCEL) end
    Event.PlayerUnit["ReviveFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_FINISH) end
    Event.PlayerUnit["Summon"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SUMMON) end
    Event.PlayerUnit["DropItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DROP_ITEM) end
    Event.PlayerUnit["PickUpItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PICKUP_ITEM) end
    Event.PlayerUnit["UseItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_USE_ITEM) end
    Event.PlayerUnit["Loaded"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_LOADED) end
    Event.PlayerUnit["Damaged"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGED) end
    Event.PlayerUnit["Damaging"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGING) end
    Event.PlayerUnit["Sell"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL) end
    Event.PlayerUnit["ChangeOwner"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CHANGE_OWNER) end
    Event.PlayerUnit["SellItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL_ITEM) end
    Event.PlayerUnit["SpellChannel"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CHANNEL) end
    Event.PlayerUnit["SpellCast"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CAST) end
    Event.PlayerUnit["SpellEffect"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_EFFECT) end
    Event.PlayerUnit["SpellFinish"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_FINISH) end
    Event.PlayerUnit["SpellEndCast"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_ENDCAST) end
    Event.PlayerUnit["PawnItem"] = function(wc3_trigger, wc3_player) TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PAWN_ITEM) end

    Event.AnyUnit["Attacked"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED) end end
    Event.AnyUnit["Resqued"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESCUED) end end
    Event.AnyUnit["Death"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH) end end
    Event.AnyUnit["Decay"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DECAY) end end
    Event.AnyUnit["Detect"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DETECTED) end end
    Event.AnyUnit["Hidden"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_HIDDEN) end end
    Event.AnyUnit["Selected"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELECTED) end end
    Event.AnyUnit["Deselected"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DESELECTED) end end
    Event.AnyUnit["ConstructStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START) end end
    Event.AnyUnit["ConstructCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end end
    Event.AnyUnit["ConstructFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end end
    Event.AnyUnit["UpgradeStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START) end end
    Event.AnyUnit["Cancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end end
    Event.AnyUnit["Finish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end end
    Event.AnyUnit["TrainStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_START) end end
    Event.AnyUnit["TrainCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end end
    Event.AnyUnit["TrainFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH) end end
    Event.AnyUnit["ResearchStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START) end end
    Event.AnyUnit["ResearchCancel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end end
    Event.AnyUnit["ResearchFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end end
    Event.AnyUnit["IssuedOrder"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER) end end
    Event.AnyUnit["IssuedOrderPointTarget"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end end
    Event.AnyUnit["IssuedOrderTarget"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end end
    Event.AnyUnit["IssuedOrderUnitTarget"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end end
    Event.AnyUnit["Level"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_LEVEL) end end
    Event.AnyUnit["Skill"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_SKILL) end end
    Event.AnyUnit["Revivable"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVABLE) end end
    Event.AnyUnit["ReviveStart"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_START) end end
    Event.AnyUnit["ReviveCance"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL) end end
    Event.AnyUnit["ReviveFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH) end end
    Event.AnyUnit["Summon"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SUMMON) end end
    Event.AnyUnit["DropItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM) end end
    Event.AnyUnit["PickUpItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM) end end
    Event.AnyUnit["UseItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_USE_ITEM) end end
    Event.AnyUnit["Loaded"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_LOADED) end end
    Event.AnyUnit["Damaged"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED) end end
    Event.AnyUnit["Damaging"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING) end end
    Event.AnyUnit["Sell"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL) end end
    Event.AnyUnit["ChangeOwner"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER) end end
    Event.AnyUnit["SellItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM) end end
    Event.AnyUnit["SpellChannel"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end end
    Event.AnyUnit["SpellCast"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST) end end
    Event.AnyUnit["SpellEffect"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT) end end
    Event.AnyUnit["SpellFinish"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH) end end
    Event.AnyUnit["SpellEndCast"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end end
    Event.AnyUnit["PawnItem"] = function(wc3_trigger) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM) end end

    Event.Unit["Damaged"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGED) end
    Event.Unit["Damaging"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGING) end
    Event.Unit["Death"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DEATH) end
    Event.Unit["Decay"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DECAY) end
    Event.Unit["Detected"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DETECTED) end
    Event.Unit["Hiden"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HIDDEN) end
    Event.Unit["Selected"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELECTED) end
    Event.Unit["Deselected"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DESELECTED) end
    Event.Unit["StateLimit"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_STATE_LIMIT) end
    Event.Unit["AcquiredTarget"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ACQUIRED_TARGET) end
    Event.Unit["TargetInRange"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TARGET_IN_RANGE) end
    Event.Unit["Attacked"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ATTACKED) end
    Event.Unit["Resqued"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESCUED) end
    Event.Unit["ConstructCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_CANCEL) end
    Event.Unit["ConstructFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_FINISH) end
    Event.Unit["UpgradeStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_START) end
    Event.Unit["UpgradeCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_CANCEL) end
    Event.Unit["UpgradeFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_FINISH) end
    Event.Unit["TrainStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_START) end
    Event.Unit["TrainCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_CANCEL) end
    Event.Unit["TrainFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_FINISH) end
    Event.Unit["ResearchStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_START) end
    Event.Unit["ResearchCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_CANCEL) end
    Event.Unit["ResearchFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_FINISH) end
    Event.Unit["IssuedOrder"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_ORDER) end
    Event.Unit["IssuedOrderPoint"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_POINT_ORDER) end
    Event.Unit["IssuedOrderTarget"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_TARGET_ORDER) end
    Event.Unit["Level"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_LEVEL) end
    Event.Unit["Skill"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_SKILL) end
    Event.Unit["Revivable"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVABLE) end
    Event.Unit["ReviveStart"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_START) end
    Event.Unit["ReviveCancel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_CANCEL) end
    Event.Unit["ReviveFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_FINISH) end
    Event.Unit["Summon"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SUMMON) end
    Event.Unit["DropItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DROP_ITEM) end
    Event.Unit["PickUpItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PICKUP_ITEM) end
    Event.Unit["UseItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_USE_ITEM) end
    Event.Unit["Loaded"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_LOADED) end
    Event.Unit["Sell"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL) end
    Event.Unit["ChangeOwner"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CHANGE_OWNER) end
    Event.Unit["SellItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL_ITEM) end
    Event.Unit["SpellChannel"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CHANNEL) end
    Event.Unit["SpellCast"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CAST) end
    Event.Unit["SpellEffect"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_EFFECT) end
    Event.Unit["SpellFinish"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_FINISH) end
    Event.Unit["SpellEndCast"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_ENDCAST) end
    Event.Unit["PawnItem"] = function(wc3_trigger, wc3_unit) TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PAWN_ITEM) end

return Event