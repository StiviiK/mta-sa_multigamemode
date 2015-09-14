GamemodePedMouseMenu = inherit(GUIMouseMenu)

function GamemodePedMouseMenu:constructor(posX, posY, instance)
  GUIMouseMenu.constructor(self, posX, posY, 330, 1)

  self:addItem(_("Gamemode: %s (Id: %s)", instance:getGamemode():getName(), instance:getId()))
      :setTextColor(Color.Red)

  self:addItem(_"Gamemode Infos",
    function ()
      GamemodeInfo:new(instance:getGamemode():getId())
    end
  )

  self:addItem(_"Gamemode beitreten",
    function ()
      triggerServerEvent("Event_JoinGamemode", localPlayer, instance:getGamemode():getId())
    end
  )

  if localPlayer:getRank() >= RANK.Administrator then
    self:addItem(_"Admin: Ped respawnen",
      function ()
        local skin, pos, rot, dimension, interior, gamemode = instance:getModel(), instance:getPosition(), instance:getRotation(), instance:getDimension(), instance:getInterior(), instance:getGamemode()
        delete(instance)

        GamemodePed:new(skin, pos, rot, dimension, interior, gamemode)
      end
    )

    self:addItem(_"Admin: Ped löschen",
      function ()
        delete(instance)
      end
    )

    self:addItem(_"Developer: Gamemode deaktivieren",
      function ()
        QuestionBox:new(_"Möchtest du diesen Gamemode wirklich dauerhaft deaktivieren?\nDiese Aktion kann nicht rückgängig gemacht werden!",
          function ()
            triggerServerEvent("Event_DisableGamemode", localPlayer, instance:getGamemode():getId())
          end
        )
      end
    )
  end
end
