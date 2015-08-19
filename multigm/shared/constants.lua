PRIVATE_DIMENSION_SERVER = 65535 -- This dimension should not be used for playing
PRIVATE_DIMENSION_CLIENT = 2 -- This dimension should be used for things which
							 -- happen while the player is in PRIVATE_DIMENSION on the server

-- IMPORTANT CORE ERROR IDs
ERROR_MYSQL_CONNECTION_FAILED = 1
ERROR_MASTER_CON_FAILED = 2

-- IMPORTANT DOWNLOAD ERROR IDs
DOWNLOAD_ERROR_UNKOWN_FILE = 3
DOWNLOAD_ERROR_INVALID_FILE = 4

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

THREAD_PIORITY_LOW = "low"
THREAD_PIORITY_MIDDLE = "middle"
THREAD_PIORITY_HIGH = "high"
THREAD_PIORITY_HIGHEST = "highest"
