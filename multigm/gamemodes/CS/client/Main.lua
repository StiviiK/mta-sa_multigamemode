function CS:constructor()
--Handler--
  addRemoteEvents{"onCSStartDownload"}
  addEventHandler("onCSStartDownload", root, bind(CS.onDownloadStart, self))
  
  CS_GamemodeManager:new()
  CS_MapLoader:new()
  -- FirstPerson:new()
  
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS:destructor()

end

function CS:onPlayerJoin()
-- showChat(false)
-- FirstPerson:getSingleton():CreateFirstPerson()
  -- Change HelpBar Text
  -- HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end





function CS:onPlayerLeft()
-- showChat(true)
-- FirstPerson:getSingleton():RemoveFirstPerson()
-- delete(CS_Lobby_Menu:getSingleton())

end

function CS:onDownloadStart()
  Provider:getSingleton():requestFile(CS_DOWNLOAD_FILE, bind(CS.onDownloadFinish, self))
end

function CS:onDownloadFinish()
  triggerServerEvent("onCSDownloadFinished", localPlayer)
  -- CS_Lobby_Menu:new(self)
  CS_MapLoader:getSingleton():LoadMap(self,1)
  
  localPlayer:setPosition(
  CS_MapLoader:getSingleton().MapSettings["T_Spawn"][1]["position"]
  )
end


	