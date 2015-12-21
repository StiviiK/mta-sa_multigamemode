CS_GamemodeManager = inherit(Singleton)
CS_GamemodeManager.Map = {}

function CS_GamemodeManager:constructor()
  addRemoteEvents{"onPlayerGamemodeJoin", "onPlayerGamemodeLeft", "onGamemodeDestruct", "CS_UpdateGamemodeSync"}
  addEventHandler("onPlayerGamemodeJoin", root, bind(CS_GamemodeManager.Event_OnPlayerGamemodeJoin, self))
  addEventHandler("onPlayerGamemodeLeft", root, bind(CS_GamemodeManager.Event_OnPlayerGamemodeLeft, self))
  addEventHandler("onGamemodeDestruct", root, bind(CS_GamemodeManager.Event_OnGamemodeDestruct, self))
  addEventHandler("CS_UpdateGamemodeSync", root, bind(CS_GamemodeManager.Event_UpdateGamemodeSync, self))


  local Gamemodes = {
	self:addRef(CS_Deathmath:new():setId(1));
	self:addRef(CS_DEMOLITION:new():setId(2));
	self:addRef(CS_BOMB_DEFUSAL:new():setId(3));
    -- self:addRef(CopsnRobbers:new(Color.Green):setId(2));
    -- self:addRef(RenegadeSquad:new(Color.Yellow):setId(3));
	-- self:addRef(CS:new(Color.Orange):setId(4));
  }
  for k, v in ipairs(Gamemodes) do
    if v.onGamemodesLoaded then
      v:onGamemodesLoaded(#Gamemodes)
    end
  end
end

function CS_GamemodeManager:destructor()
  for i, v in pairs(CS_GamemodeManager.Map) do
    delete(v)
  end
end

function CS_GamemodeManager.getFromId(Id)
  return CS_GamemodeManager.Map[Id]
end

function CS_GamemodeManager:addRef(ref)
  CS_GamemodeManager.Map[ref:getId()] = ref
  return ref
end

function CS_GamemodeManager:removeRef(ref)
  CS_GamemodeManager.Map[ref:getId()] = nil
end

function CS_GamemodeManager:Event_OnPlayerGamemodeJoin(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    gamemode:onPlayerJoin(source)
  end
end

function CS_GamemodeManager:Event_OnPlayerGamemodeLeft(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    gamemode:onPlayerLeft(source)
  end
end

function CS_GamemodeManager:Event_OnGamemodeDestruct(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    delete(gamemode)
  end
end

function CS_GamemodeManager:Event_UpdateGamemodeSync(SyncInfo)
  for Id, data in pairs(SyncInfo) do
    local gamemode = self.getFromId(Id)
    if gamemode then
      for k, v in pairs(data or {}) do
        gamemode.m_SyncInfo[k] = v

        local f = gamemode.m_SyncChangeHandler[k]
        if f then f(v) end
      end
    end
  end
end


