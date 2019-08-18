  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["utils.timer.TimerDB"] = function()
    local TimerDB = {}
    function TimerDB.add(timer_obj, timer)
      TimerDB[timer_obj] = timer
    end
    function TimerDB.rm(timer_obj)
      TimerDB[timer_obj] = nil
    end
    function TimerDB.get(timer_obj)
      return TimerDB[timer_obj]
    end
    return TimerDB
end
__require_data.module["utils.timer.TimerAction"] = function()
    local TimerAction = {}
    local TimerAction_meta = {__index = TimerAction}
    function TimerAction.new(time, callback, data)
      local action = {__time = time, __callback = callback, __data = data}
      setmetatable(action, TimerAction_meta)
      return action
    end
    function TimerAction:getTime()
      return self.__time
    end
    function TimerAction:run()
      self.__callback(self.__data)
    end
    return TimerAction
end
__require_data.module["utils.timer.Timer"] = function()
    local TimerAction = require("utils.timer.TimerAction")
    local TimerDB = require("utils.timer.TimerDB")
    local Timer = {timer = nil, cur_time = 0, precision = 0.03125, __actions = {}}
    local Timer_meta = {__index = Timer, __gc = Timer.destroy}
    function Timer.init()
      glTimer = Timer.new(0.03125)
    end
    function Timer.new(period)
      local timer = {__timer_obj = CreateTimer(), __cur_time = 0.0, __period = period, __actions = {}}
      setmetatable(timer, Timer_meta)
      TimerDB.add(timer.__timer_obj, timer)
      TimerStart(timer.__timer_obj, timer.__period, true, Timer.timeout)
      return timer
    end
    function Timer:getPeriod()
      return self.__period
    end
    function Timer.timeout()
      local self = TimerDB.get(GetExpiredTimer())
      local cur_time = (self.__cur_time+self.__period)
      while(#self.__actions > 0) do
        local action = table.remove(self.__actions, 1)
        if (action:getTime() <= cur_time) then
          action:run()
        else
          table.insert(self.__actions, 1, action)
          break
        end
      end
      self.__cur_time = cur_time
    end
    local function findPos(time, first, last, list)
      local len = ((last-first)+1)
      if (len <= 1) then
        return 1
      end
      local i, _ = math.modf((len/2))
      local pos = (first+i)
      if (list[pos]:getTime() < time) then
        return findPos(time, first, (pos-1), list)
      else
        return findPos(time, pos, last, list)
      end
    end
    local function findPosSimple(time)
      local count = #Timer.actions
      if (count == 0) then
        return 1
      end
      for i = 1, count do
        if (Timer.actions[i]:getTime() > time) then
          return i
        end
      end
      return (count+1)
    end
    function Timer:addAction(delay, callback, data)
      if (delay <= 0) then
        delay = 0.01
      end
      local time = (self.__cur_time+delay)
      local action = TimerAction.new(time, callback, data)
      local pos = findPos(time, 1, #self.__actions, self.__actions)
      Debug(pos)
      table.insert(self.__actions, pos, action)
      return action
    end
    function Timer:removeAction(action)
      local count = #self.__actions
      for i = 1, count do
        if (self.__actions[i] == action) then
          table.remove(self.__actions, i)
          return true
        end
      end
      return false
    end
    local count = 100
    local test_result = {}
    local function test(num)
      Debug(num)
      table.insert(test_result, (#test_result+1), num)
    end
    local function check_test()
      for i = 1, count do
        if (test_result[i] ~= i) then
          Debug("Timer test failed")
          return nil
        end
      end
      Debug("Timer test passed.")
    end
    function Timer.test()
      local t = 0.05
      for i = 1, count do
        glTimer:addAction((i*t), test, i)
      end
      local timer = CreateTimer()
      TimerStart(timer, ((1.2*t)*count), false, check_test)
    end
    return Timer
end
__require_data.module["utils.Settings"] = function()
    local Settings = {debug = true, testTimer = true, UnitParameters = {attack_dispersion = 0.15, value_to_get_half_cap_for_percent_value = 500}}
    return Settings
end
__require_data.module["utils.global"] = function()
    local Settings = require("utils.Settings")
    local compiletime_print = print
    function Debug(...)
      if (is_compiletime) then
        compiletime_print(...)
      elseif (Settings.debug) then
        local s = ""
        for i = 1, select("#", ...) do
          local v = select(i, ...)
          local t = type(v)
          if (t == "nil") then
            v = "nil"
          elseif (t == "userdata") then
            v = "userdata"
          elseif (t == "string") then
            v = v
          elseif (t == "integer" or t == "number") then
            v = tostring(v)
          elseif (t == "table" or t == "function") then
            v = tostring(v)
          else
            v = ""
          end




          s = s.." "..v
        end
        DisplayTimedTextToPlayer(Player.getLocal():getObj(), 0, 0, 30, "[Debug]: "..s)
      end

    end
    function ID(id)
      if (type(id) == "string") then
        return string.unpack(">I4", id)
      elseif (type(id) == "number" and math.fmod(id, 1) == 0) then
        return id
      end

      print("Wrong id fromat")
      return nil
    end
    function ID2str(id)
      return string.pack(">I4", id)
    end
    function torange(val, min, max)
      if (val < min) then
        return min
      end
      if (val > max) then
        return max
      end
      return val
    end
end
__require_data.module["utils.player.PlayerDB"] = function()
    local PlayerDB = {}
    function PlayerDB.add(player_obj, player)
      PlayerDB[player_obj] = player
    end
    function PlayerDB.rm(player_obj)
      PlayerDB[player_obj] = nil
    end
    function PlayerDB.get(player_obj)
      return PlayerDB[player_obj]
    end
    return PlayerDB
end
__require_data.module["utils.player.player"] = function()
    local PlayerDB = require("utils.player.PlayerDB")
    local PlayerIndexDB = {}
    __replaced_class = {Player = Player}
    Player = {}
    local Player_meta = {__index = Player}
    setmetatable(Player, Player_meta)
    function Player_meta.__call(_, index)
      if (type(index) ~= "number") then
        Debug("Player index can be number(integer) only")
        return nil
      end
      local player = PlayerIndexDB[math.floor(index)]
      return player
    end
    function Player_meta.__tostring(self)
      return string.format("Player_%d", self:getIndex())
    end
    local function newPlayer(index)
      local player = {index = index, player_obj = __replaced_class.Player(index)}
      setmetatable(player, Player_meta)
      PlayerDB.add(player.player_obj, player)
      PlayerIndexDB[index] = player
      return player
    end
    local local_player = nil
    if (not is_compiletime) then
      if (local_player ~= nil) then
        return nil
      end
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        newPlayer(i)
      end
      local_player = PlayerDB.get(GetLocalPlayer())
    end
    function Player.getLocal()
      return local_player
    end
    function Player:getObj()
      return self.player_obj
    end
    function Player:getIndex()
      return self.index
    end
    function Player:forceUIKey(key)
      if (self == local_player) then
        key = string.upper(key)
        ForceUIKey(key)
      end
    end
    function Player.getLocal()
      return local_player
    end
    local __replaced_functions = {GetOwningPlayer = GetOwningPlayer}
    function GetOwningPlayer(unit)
      local player_obj = __replaced_functions.GetOwningPlayer(unit.unit_obj)
      return PlayerDB.get(player_obj)
    end
end
__require_data.module["utils.init"] = function()
    local Init = {}
    require("utils.player.player")
    require("utils.global")
    require("utils.timer.Timer")
    local Settings = require("utils.Settings")
    function Init.start()
      for name, _ in pairs(__require_data.module) do
        Debug(name)
        if (not __require_data.loaded[name]) then
          local success, result = pcall(__require_data.module[name])
          if (success) then
            __require_data.result[name] = result
            __require_data.loaded[name] = true
          else
            Debug(string.format("Error in loading %s\n%s", name, result))
          end
        end
        if (__require_data.result[name] ~= nil) then
          if (__require_data.result[name].init ~= nil) then
            local success, result = pcall(__require_data.result[name].init)
            if (not success) then
              Debug(string.format("Error in %s initialization\n%s", name, result))
            end
          end
        end
      end
      Debug("Initialisation finished")
      if (Settings.testTimer) then
        glTimer.test()
      end
    end
    return Init
end
  
  GG_trg_Melee_Initialization = nil
  function InitGlobals()

  end
  function Trig_Melee_Initialization_Actions()

  end
  function InitTrig_Melee_Initialization()
    GG_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(GG_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitialization()
    DestroyTimer(GetExpiredTimer())
    local Init = require("utils.init")
    Init.start()
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
    SetCameraBounds((-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT)), (-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM)), (3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT)), (3072.0-GetCameraMargin(CAMERA_MARGIN_TOP)), (-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT)), (3072.0-GetCameraMargin(CAMERA_MARGIN_TOP)), (3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT)), (-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM)))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    TimerStart(CreateTimer(), 0.1, false, RunInitialization)
  end
  function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 0, 0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
  end