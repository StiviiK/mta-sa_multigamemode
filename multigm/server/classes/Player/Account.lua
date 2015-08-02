Account = inherit(Object)
Account.Map = {}

function Account.login(player, username, password, hashed)
  if player:getAccount() then return false, "already loggedin" end
	if (not username or not password) and not pwhash then return false, "Now data?" end

  local row = sql:asyncQueryFetchSingle("SELECT Id, Salt FROM ??_account WHERE Name = ? ", sql:getPrefix(), username)
  if not row or not row.Id then
		-- Error: Invalid username
		return false, "invalid username"
	end

  if not hashed then
		pwhash = sha256(row.Salt..password)
	end

  local row = sql:asyncQueryFetchSingle("SELECT Id FROM ??_account WHERE Id = ? AND Password = ?;", sql:getPrefix(), row.Id, pwhash)
  if not row or not row.Id then
  	-- Error: Wrong Password
  	return false, "wrong password"
  end

  if DatabasePlayer.getFromId(row.Id) then
  	-- Error: Already in use
  	return false, "already in use"
	end

  -- Update last serial and last login
	sql:queryExec("UPDATE ??_account SET LastSerial = ?, LastLogin = NOW() WHERE Id = ?", sql:getPrefix(), player:getSerial(), row.Id)

  player.m_Account = Account:new(row.Id, username, player, false)
  player:loadCharacter()
end
addEvent("accountlogin", true)
addEventHandler("accountlogin", root, function(...) Async.create(Account.login)(client, ...) end)

function Account.register()
end

function Account.guest(player)
  player.m_Account = Account:new(0, getRandomUniqueNick(), player, true)
  player:loadCharacter()
end

function Account.getFromId(id)
  return Account.Map[id]
end

function Account:constructor(id, username, player, guest)
	-- Account Information
	self.m_Id = id
	self.m_Username = username
	self.m_Player = player
	player.m_IsGuest = guest;
	player.m_Id = self.m_Id

  Account.Map[self.m_Id] = self
end

function Account:destructor()
  Account.Map[self.m_Id] = nil
  self.m_Player.m_Account = nil
end

function Account:getId()
	return self.m_Id;
end

function Account:getPlayer()
  return self.m_Player
end

function Account:getName()
  return self.m_Username
end
