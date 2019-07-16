  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
  Debug = true
  local CompileFuncs = true
  local str_compile = "Compiletime string"
  local glTimer = require("modules.global_timer")
  function showText_callback(user_data)
    DisplayTextToPlayer(user_data.player, 0, 0, user_data.text)
  end
  gg_trg_Melee_Initialization = nil
  function InitGlobals()

  end
  function Trig_Melee_Initialization_Actions()
    MeleeStartingVisibility()
    MeleeStartingHeroLimit()
    MeleeGrantHeroItems()
    MeleeStartingResources()
    MeleeClearExcessUnits()
    MeleeStartingUnits()
    MeleeStartingAI()
    MeleeInitVictoryDefeat()
    glTimer.init(0.1)
    glTimer.addAction(3, showText_callback, {player = Player(0), text = "Delayed text"})
  end
  function InitTrig_Melee_Initialization()
    gg_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(gg_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Melee_Initialization)
  end
  function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
  end
  function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
  end
  function main()
    SetCameraBounds(-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0-GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0-GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
  end
  function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, -1953.6, -3131.3)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
  end
__require_data.module["modules.global_timer"] = function()
    local Timer = {cur_time = 0, accuracy = 0.1, time = {}, callback = {}, user_data = {}}
    function Timer.init(accuracy)
      Timer.timer = CreateTimer()
      Timer.accuracy = accuracy
      TimerStart(Timer.timer, Timer.accuracy, false, Timer.period)
    end
    function Timer.period()
      Timer.cur_time = Timer.cur_time+Timer.accuracy
      for i = 1, #Timer.time do
        if (Timer.time[i] <= Timer.cur_time) then
          table.remove(Timer.time, i)
          local cb = table.remove(Timer.callback, i)
          local ud = table.remove(Timer.user_data, i)
          cb(ud)
        end
      end
      TimerStart(Timer.timer, Timer.accuracy, false, Timer.period)
    end
    function Timer.addAction(time, callback, user_data)
      table.insert(Timer.time, 1, Timer.cur_time+time)
      table.insert(Timer.callback, 1, callback)
      table.insert(Timer.user_data, 1, user_data)
    end
    return Timer
end