Core = inherit(Object)

function Core:constructor ()
  outputDebug("Initializing core...")

  -- Small hack to get the global core immediately
	core = self

  -- Important Data
  self.ms_StartTime = getRealTime().timestamp
  self.ms_StartTick = getTickCount()


  if USE_REMOTE_API then
    -- Instantiate API
    self.ms_API = API:new()
    self:setAPIStatements()

    -- Connect to the API(-Server)
    self.ms_API:call(self.ms_API:getStatement("onConnect"))
  end

  if DEBUG then
    Debugging:new()
  end

  -- Establish database connection
	sql = MySQL:new(MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PW, MYSQL_DB, "")
	sql:setPrefix("multigm")

  -- Register Maps
  MapManager:new()
  MapManager:getSingleton():registerMap("gamemodes/Lobby/files/maps/Test.map")

	-- Instantiate classes
  Provider:new()
  PlayerManager:new()
  GamemodeManager:new()

  -- instantiate all players
  for k, v in pairs(getElementsByType("player")) do
    enew(v, Player)
	end

  -- Generate Download-Package
  local gamemodes = {
    ["main"] = "";
    ["lobby"] = "gamemodes/Lobby/";
  }
  for name, path in pairs(gamemodes) do
    outputDebug(("Generating Package for %s..."):format(name:upperFirst()))

    local files = {}
    local xml = xmlLoadFile(("%smeta.xml"):format(path))
    for k, v in pairs(xmlNodeGetChildren(xml)) do
      if xmlNodeGetName(v) == "transferfile" then
        files[#files+1] = xmlNodeGetAttribute(v, "src")
      end
    end

    -- Create Data Package and offer it (On-Demand)
    local fileName = ("%s%s.data"):format(path, name)
    Package.save(fileName, files)
    Provider:getSingleton():offerFile(fileName, PROVIDER_ON_DEMAND)
  end
end

function Core:destructor ()
  if DEBUG then
    delete(Debugging:getSingleton())
  end

  delete(GamemodeManager:getSingleton())
  delete(MapManager:getSingleton())
  delete(PlayerManager:getSingleton())
  delete(sql)

  if self.ms_API then
    delete(self.ms_API)
  end
end

function Core:onInternalError(error)
  for i, v in pairs(getElementsByType("player")) do
    v:kick("System - Core", ("An Internal Error occured! Error Id: %s"):format(error))
  end

  stopResource(getThisResource())
end

function Core:setAPIStatements()
  if (not self.ms_API) or (not instanceof(self.ms_API, API, true)) then return end

  -- Set APIStatements
  self.ms_API:setStatement("onConnect", "parameter", {"method=connect"})
  self.ms_API:setStatement("onConnect", "callback",
    function (returnJSON, errno)
      if errno == 0 then
        local result = fromJSON(returnJSON)
        if result.status then
          outputDebug("[API] Connected succesfully!")
          --outputDebug(("[API] Using Token: %s"):format(result.result))

          self.ms_API.m_SecurityToken = result.result
        else
          outputDebug(("[API] Failure. Server returned: %s"):format(result.message))
        end
      else
        outputDebug(("AN INTERNAL API ERROR OCCURED! [Id: %s]"):format(tostring(errno)))
        delete(self.ms_API)
      end
    end
  )

  self.ms_API:setStatement("onDestruct", "parameter", {"method=disconnect"})
  self.ms_API:setStatement("onDestruct", "callback",
    function ()
      outputDebug("Disconnected")
    end
  )
end
