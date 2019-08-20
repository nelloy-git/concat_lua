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

    Event.Game["Victory"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_VICTORY) end
    Event.Game["End"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_END_LEVEL) end
    Event.Game["VariableLimit"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_VARIABLE_LIMIT) end
    Event.Game["StateLimit"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_STATE_LIMIT) end
    Event.Game["TimerExpired"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_TIMER_EXPIRED) end
    Event.Game["EnterRegion"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_ENTER_REGION) end
    Event.Game["LeaveRegion"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_LEAVE_REGION) end
    Event.Game["TrackableHit"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_TRACKABLE_HIT) end
    Event.Game["TrackableTrack"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_TRACKABLE_TRACK) end
    Event.Game["ShowSkill"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_SHOW_SKILL) end
    Event.Game["BuildSubmenu"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_BUILD_SUBMENU) end
    Event.Game["Loaded"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_LOADED) end
    Event.Game["TournamentFinishSoon"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_SOON) end
    Event.Game["TournamentFinishNow"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_NOW) end
    Event.Game["Save"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_SAVE) end
    Event.Game["CustomUIFrame"] = function(trigger_obj) TriggerRegisterGameEvent(trigger_obj, EVENT_GAME_CUSTOM_UI_FRAME) end

    Event.Player["StateLimit"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_STATE_LIMIT) end
    Event.Player["AllianceChanged"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ALLIANCE_CHANGED) end
    Event.Player["Defeat"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_DEFEAT) end
    Event.Player["Victory"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_VICTORY) end
    Event.Player["Leave"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_LEAVE) end
    Event.Player["Chat"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_CHAT) end
    Event.Player["EndCinematic"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_END_CINEMATIC) end
    Event.Player["ArrowLeft_Down"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_LEFT_DOWN) end
    Event.Player["ArrowLeft_Up"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_LEFT_UP) end
    Event.Player["ArrowRight_Down"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_RIGHT_DOWN) end
    Event.Player["ArrowRight_Up"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_RIGHT_UP) end
    Event.Player["ArrowDown_Down"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_DOWN_DOWN) end
    Event.Player["ArrowDown_Up"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_DOWN_UP) end
    Event.Player["ArrowUp_Down"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_UP_DOWN) end
    Event.Player["ArrowUp_Up"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_ARROW_UP_UP) end
    Event.Player["MouseDown"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_MOUSE_DOWN) end
    Event.Player["MouseUp"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_MOUSE_UP) end
    Event.Player["MouseMove"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_MOUSE_MOVE) end
    Event.Player["SyncData"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_SYNC_DATA) end
    Event.Player["Key"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_KEY) end
    Event.Player["KeyDown"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_KEY_DOWN) end
    Event.Player["KeyUp"] = function(trigger_obj, player_obj) TriggerRegisterPlayerEvent(trigger_obj, player_obj, EVENT_PLAYER_KEY_UP) end

    Event.PlayerUnit["Attacked"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_ATTACKED) end
    Event.PlayerUnit["Resqued"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_RESCUED) end
    Event.PlayerUnit["Death"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DEATH) end
    Event.PlayerUnit["Decay"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DECAY) end
    Event.PlayerUnit["Death"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DETECTED) end
    Event.PlayerUnit["Hidden"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_HIDDEN) end
    Event.PlayerUnit["Selected"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SELECTED) end
    Event.PlayerUnit["Deselected"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DESELECTED) end
    Event.PlayerUnit["ConstructStart"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_CONSTRUCT_START) end
    Event.PlayerUnit["ConstructCancel"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end
    Event.PlayerUnit["ConstructFinish"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end
    Event.PlayerUnit["UpgradeStart"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_UPGRADE_START) end
    Event.PlayerUnit["Cancel"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end
    Event.PlayerUnit["Finish"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_UPGRADE_FINISH) end
    Event.PlayerUnit["TrainStart"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_TRAIN_START) end
    Event.PlayerUnit["TrainCancel"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_TRAIN_CANCEL) end
    Event.PlayerUnit["TrainFinish"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_TRAIN_FINISH) end
    Event.PlayerUnit["ResearchStart"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_RESEARCH_START) end
    Event.PlayerUnit["ResearchCancel"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end
    Event.PlayerUnit["ResearchFinish"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_RESEARCH_FINISH) end
    Event.PlayerUnit["IssuedOrder"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_ISSUED_ORDER) end
    Event.PlayerUnit["IssuedOrderPointTartet"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end
    Event.PlayerUnit["IssuedOrderTarget"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end
    Event.PlayerUnit["IssuedOrderUnitTarget"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end
    Event.PlayerUnit["Level"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_HERO_LEVEL) end
    Event.PlayerUnit["Skill"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_HERO_SKILL) end
    Event.PlayerUnit["Revivable"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_HERO_REVIVABLE) end
    Event.PlayerUnit["ReviveStart"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_HERO_REVIVE_START) end
    Event.PlayerUnit["ReviveCance"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_HERO_REVIVE_CANCEL) end
    Event.PlayerUnit["ReviveFinish"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_HERO_REVIVE_FINISH) end
    Event.PlayerUnit["Summon"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SUMMON) end
    Event.PlayerUnit["DropItem"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DROP_ITEM) end
    Event.PlayerUnit["PickUpItem"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_PICKUP_ITEM) end
    Event.PlayerUnit["UseItem"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_USE_ITEM) end
    Event.PlayerUnit["Loaded"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_LOADED) end
    Event.PlayerUnit["Damaged"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DAMAGED) end
    Event.PlayerUnit["Damaging"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_DAMAGING) end
    Event.PlayerUnit["Sell"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SELL) end
    Event.PlayerUnit["ChangeOwner"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_CHANGE_OWNER) end
    Event.PlayerUnit["SellItem"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SELL_ITEM) end
    Event.PlayerUnit["SpellChannel"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SPELL_CHANNEL) end
    Event.PlayerUnit["SpellCast"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SPELL_CAST) end
    Event.PlayerUnit["SpellEffect"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SPELL_EFFECT) end
    Event.PlayerUnit["SpellFinish"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SPELL_FINISH) end
    Event.PlayerUnit["SpellEndCast"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_SPELL_ENDCAST) end
    Event.PlayerUnit["PawnItem"] = function(trigger_obj, player_obj) TriggerRegisterPlayerUnitEvent(trigger_obj, player_obj, EVENT_PLAYER_UNIT_PAWN_ITEM) end

    Event.AnyUnit["Attacked"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_ATTACKED) end end
    Event.AnyUnit["Resqued"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESCUED) end end
    Event.AnyUnit["Death"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DEATH) end end
    Event.AnyUnit["Decay"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DECAY) end end
    Event.AnyUnit["Detect"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DETECTED) end end
    Event.AnyUnit["Hidden"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_HIDDEN) end end
    Event.AnyUnit["Selected"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELECTED) end end
    Event.AnyUnit["Deselected"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DESELECTED) end end
    Event.AnyUnit["ConstructStart"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START) end end
    Event.AnyUnit["ConstructCancel"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL) end end
    Event.AnyUnit["ConstructFinish"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH) end end
    Event.AnyUnit["UpgradeStart"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START) end end
    Event.AnyUnit["Cancel"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL) end end
    Event.AnyUnit["Finish"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH) end end
    Event.AnyUnit["TrainStart"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_START) end end
    Event.AnyUnit["TrainCancel"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL) end end
    Event.AnyUnit["TrainFinish"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH) end end
    Event.AnyUnit["ResearchStart"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START) end end
    Event.AnyUnit["ResearchCancel"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL) end end
    Event.AnyUnit["ResearchFinish"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH) end end
    Event.AnyUnit["IssuedOrder"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER) end end
    Event.AnyUnit["IssuedOrderPointTarget"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) end end
    Event.AnyUnit["IssuedOrderTarget"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) end end
    Event.AnyUnit["IssuedOrderUnitTarget"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER) end end
    Event.AnyUnit["Level"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_HERO_LEVEL) end end
    Event.AnyUnit["Skill"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_HERO_SKILL) end end
    Event.AnyUnit["Revivable"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVABLE) end end
    Event.AnyUnit["ReviveStart"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_START) end end
    Event.AnyUnit["ReviveCance"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL) end end
    Event.AnyUnit["ReviveFinish"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH) end end
    Event.AnyUnit["Summon"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SUMMON) end end
    Event.AnyUnit["DropItem"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM) end end
    Event.AnyUnit["PickUpItem"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM) end end
    Event.AnyUnit["UseItem"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_USE_ITEM) end end
    Event.AnyUnit["Loaded"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_LOADED) end end
    Event.AnyUnit["Damaged"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DAMAGED) end end
    Event.AnyUnit["Damaging"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_DAMAGING) end end
    Event.AnyUnit["Sell"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELL) end end
    Event.AnyUnit["ChangeOwner"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER) end end
    Event.AnyUnit["SellItem"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM) end end
    Event.AnyUnit["SpellChannel"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL) end end
    Event.AnyUnit["SpellCast"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST) end end
    Event.AnyUnit["SpellEffect"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT) end end
    Event.AnyUnit["SpellFinish"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH) end end
    Event.AnyUnit["SpellEndCast"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST) end end
    Event.AnyUnit["PawnItem"] = function(trigger_obj) for i = 0, bj_MAX_PLAYER_SLOTS - 1 do TriggerRegisterPlayerUnitEvent(trigger_obj, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM) end end

    Event.Unit["Damaged"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DAMAGED) end
    Event.Unit["Damaging"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DAMAGING) end
    Event.Unit["Death"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DEATH) end
    Event.Unit["Decay"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DECAY) end
    Event.Unit["Detected"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DETECTED) end
    Event.Unit["Hiden"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HIDDEN) end
    Event.Unit["Selected"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SELECTED) end
    Event.Unit["Deselected"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DESELECTED) end
    Event.Unit["StateLimit"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_STATE_LIMIT) end
    Event.Unit["AcquiredTarget"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_ACQUIRED_TARGET) end
    Event.Unit["TargetInRange"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_TARGET_IN_RANGE) end
    Event.Unit["Attacked"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_ATTACKED) end
    Event.Unit["Resqued"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_RESCUED) end
    Event.Unit["ConstructCancel"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_CONSTRUCT_CANCEL) end
    Event.Unit["ConstructFinish"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_CONSTRUCT_FINISH) end
    Event.Unit["UpgradeStart"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_UPGRADE_START) end
    Event.Unit["UpgradeCancel"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_UPGRADE_CANCEL) end
    Event.Unit["UpgradeFinish"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_UPGRADE_FINISH) end
    Event.Unit["TrainStart"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_TRAIN_START) end
    Event.Unit["TrainCancel"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_TRAIN_CANCEL) end
    Event.Unit["TrainFinish"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_TRAIN_FINISH) end
    Event.Unit["ResearchStart"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_RESEARCH_START) end
    Event.Unit["ResearchCancel"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_RESEARCH_CANCEL) end
    Event.Unit["ResearchFinish"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_RESEARCH_FINISH) end
    Event.Unit["IssuedOrder"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_ISSUED_ORDER) end
    Event.Unit["IssuedOrderPoint"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_ISSUED_POINT_ORDER) end
    Event.Unit["IssuedOrderTarget"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_ISSUED_TARGET_ORDER) end
    Event.Unit["Level"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HERO_LEVEL) end
    Event.Unit["Skill"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HERO_SKILL) end
    Event.Unit["Revivable"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HERO_REVIVABLE) end
    Event.Unit["ReviveStart"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HERO_REVIVE_START) end
    Event.Unit["ReviveCancel"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HERO_REVIVE_CANCEL) end
    Event.Unit["ReviveFinish"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_HERO_REVIVE_FINISH) end
    Event.Unit["Summon"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SUMMON) end
    Event.Unit["DropItem"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_DROP_ITEM) end
    Event.Unit["PickUpItem"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_PICKUP_ITEM) end
    Event.Unit["UseItem"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_USE_ITEM) end
    Event.Unit["Loaded"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_LOADED) end
    Event.Unit["Sell"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SELL) end
    Event.Unit["ChangeOwner"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_CHANGE_OWNER) end
    Event.Unit["SellItem"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SELL_ITEM) end
    Event.Unit["SpellChannel"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SPELL_CHANNEL) end
    Event.Unit["SpellCast"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SPELL_CAST) end
    Event.Unit["SpellEffect"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SPELL_EFFECT) end
    Event.Unit["SpellFinish"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SPELL_FINISH) end
    Event.Unit["SpellEndCast"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_SPELL_ENDCAST) end
    Event.Unit["PawnItem"] = function(trigger_obj, unit_obj) TriggerRegisterUnitEvent(trigger_obj, unit_obj, EVENT_UNIT_PAWN_ITEM) end

return Event