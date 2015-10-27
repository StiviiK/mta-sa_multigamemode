PRIVATE_DIMENSION_SERVER = 65535 -- This dimension should not be used for playing
PRIVATE_DIMENSION_CLIENT = 2 -- This dimension should be used for things which
							 -- happen while the player is in PRIVATE_DIMENSION on the server

-- VERSION
PROJECT_NAME = "vMultigamemode"
VERSION = "0.1"
BUILD = "development"

-- RANKS
RANK = {}
RANK[-1] = "Banned"
RANK[0] = "User"
RANK[1] = "Supporter"
RANK[2] = "Moderator"
RANK[3] = "SuperModerator"
RANK[4] = "Administrator"
RANK[5] = "Developer"

local r2 = {}
for k, v in pairs(RANK) do
	r2[k] = v
	r2[v] = k
end
RANK = r2

-- ACOUNT TYPES
ACCOUNTTYPE = {}
ACCOUNTTYPE[0] = "Normal"
ACCOUNTTYPE[1] = "Premium"
ACCOUNTTYPE[2] = "Donator"
ACCOUNTTYPE[3] = "God"

local r2 = {}
for k, v in pairs(ACCOUNTTYPE) do
	r2[k] = v
	r2[v] = k
end
ACCOUNTTYPE = r2

-- LANGUAGE CODES
LOCALE = {}
LOCALE[1] = "de"
LOCALE[2] = "en"

local r2 = {}
for k, v in pairs(LOCALE) do
	r2[k] = v
	r2[v] = k
end
LOCALE = r2

-- LANGUAGES
LANG = {}
LANG[1] = "Deutsch"
LANG[2] = "Englisch"

local r2 = {}
for k, v in pairs(LANG) do
	r2[k] = v
	r2[v] = k
end
LANG = r2

-- IMPORTANT CORE ERROR HASHES
ERROR_MYSQL_CONNECTION_FAILED = toHex(crc32("ERROR_MYSQL_CONNECTION_FAILED")) -- 0xCFF7725 (1)
ERROR_MASTER_CON_FAILED = toHex(crc32("ERROR_MASTER_CON_FAILED")) -- 0x4C31598E (2)

-- IMPORTANT DOWNLOAD ERROR HASHES
DOWNLOAD_ERROR_UNKOWN_FILE = toHex(crc32("DOWNLOAD_ERROR_UNKOWN_FILE")) -- 0xBEE359DD (3)
DOWNLOAD_ERROR_INVALID_FILE = toHex(crc32("DOWNLOAD_ERROR_INVALID_FILE")) -- 0x50151BB9 (4)

-- RUNTIME ERROR HASHES
RUNTIME_ERROR_NO_ROOM = toHex(crc32("RUNTIME_ERROR_NO_ROOM")) -- 0xEBB175DD (5)

-- PROVIDER TYPES
PROVIDER_ON_DEMAND = 1
PROVIDER_INSTANT = 2

SPAWN_DEFAULT_POSITION = Vector3(0, 0, 0)
SPAWN_DEFAULT_ROTATION = 0
SPAWN_DEFAULT_INTERIOR = 0
SPAWN_DEFAULT_SKIN = 0

-- Threads
COROUTINE_STATUS_RUNNING = "running"
COROUTINE_STATUS_SUSPENDED = "suspended"
COROUTINE_STATUS_DEAD = "dead"

THREAD_PIORITY_LOW = 500
THREAD_PIORITY_MIDDLE = 250
THREAD_PIORITY_HIGH = 150
THREAD_PIORITY_HIGHEST = 50

-- Map loading
MAP_LOADING_NORMAL = 1
MAP_LOADING_FAST = 2
MAP_STOP_FAST = 500
MAP_STOP_NORMAL = 250

-- Download Speed
PROVIDER_DOWNLOAD_SPEED = 1 * 1024 * 1024
if DEBUG then
  PROVIDER_DOWNLOAD_SPEED = 99999 * 1024 * 1024
end
