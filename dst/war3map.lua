  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["modules.utils"] = function()
    local WeUtils = {}
    function WeUtils.str2byte(data)
      return data.."\0"
    end
    function WeUtils.byte2str(data)
      return data:sub(1, #data-1)
    end
    function WeUtils.int2byte(data)
      local bytes = ""
      for i = 0, 3 do
        bytes = bytes..string.char(data >> 8*i&255)
      end
      return bytes
    end
    function WeUtils.byte2int(data)
      local res = 0
      for i = 0, 3 do
        res = res << 8
        res = res+data:sub(#data-i, #data-i):byte()
      end
      return res
    end
    function WeUtils.byte2hex(data, bytes_per_line)
      local res = ""
      for i = 1, data:len() do
        local c = data:sub(i, i)
        res = res.." "..string.format("%02x", c:byte())
        if (i%bytes_per_line == 0) then
          res = res.."\n"
        end
      end
      return res
    end
    function WeUtils.byte2float(data)
      local s = 1
      if (data >> 31 == 1) then
        s = -1
      end
      local e = data >> 23&255
      local m = 0
      if (e ~= 0) then
        m = data&8388607|8388608
      else
        m = data&8388607 << 1
      end
      local m1 = m*2^-23
      return s*m1*2^e-127
    end
    return WeUtils
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
  _G.Debug = true
  local CompileFuncs = true
  local str_compile = "Compiletime string"
  local glTimer = require("modules.global_timer")
  local utils = require("modules.utils")
  local function showText_callback(user_data)
    DisplayTextToPlayer(user_data.player, 0, 0, user_data.text)
  end
  GG_trg_Melee_Initialization = nil
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
    DisplayTextToPlayer(Player(0), 0, 0, "azaza")
    DisplayTextToPlayer(Player(0), 0, 0, I2S(FourCC("h001")))
    local u = CreateUnit(Player(0), FourCC("h001"), 0, 0, 0)
    UnitAddAbility(u, FourCC("A001"))
  end
  function InitTrig_Melee_Initialization()
    GG_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(GG_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitializationTriggers()
    ConditionalTriggerExecute(GG_trg_Melee_Initialization)
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