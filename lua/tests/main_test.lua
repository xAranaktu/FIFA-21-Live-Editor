--- Test script registered in luarunner
Log("Run LUA Test")
ReloadDB()

local bIsInCM = IsInCM();
assert(type(bIsInCM) == "boolean", "IsInCM not a boolean")

if (bIsInCM) then
    Log("Is In Career Mode")
    
    local user_teamid = GetUserTeamID()
    
    Log("user_teamid: " .. user_teamid)
    assert(type(user_teamid) == "number", "user_teamid not a number")

    local arr_table_names = GetDBTablesNames()
    assert(type(arr_table_names) == "table", "arr_table_names not a table")
    Log("Elements in arr_table_names: " .. #arr_table_names)
    
    local first = arr_table_names[1]
    assert(type(first) == "string", "arr_table_names[1] not a string")
    assert(first == "assetcryptokeys", "arr_table_names[1] != assetcryptokeys")
    
    local fields = GetDBTableFields("career_users")
    assert(#fields > 0, "fields <= 0")
    Log(#fields)
    Log(fields[1]["name"])
    
    local rows = GetDBTableRows("teams")
    
    local row = rows[6]
    local success = false;
    
    row.teamname.value = "Edited String123"
    success = EditDBTableField(row["teamname"])
    assert(success, "EditDBTableField false for teamname")
    row.transferbudget.value = "6543210"
    success = EditDBTableField(row["transferbudget"])
    assert(success, "EditDBTableField false for transferbudget")
else 
    Log("Not in Career Mode")
end

local currentdate = GetCurrentDate()
assert(type(currentdate) == "table", "GetCurrentDate() not table")
Log("Current Date (day/month/year): " .. currentdate.day .. "/" .. currentdate.month .. "/" .. currentdate.year )

local team_name1 = GetTeamName(241) --- FC Barcelona
Log("team_name1 (241): " .. team_name1)
assert(type(team_name1) == "string", "GetTeamName(241) not a string")
assert(team_name1 == "FC Barcelona", "team_name1 != FC Barcelona")
    
local team_name2 = GetTeamName(7)   --- Everton
Log("team_name2 (7): " .. team_name2)
assert(type(team_name2) == "string", "GetTeamName(7) not a string")
assert(team_name2 == "Everton", "team_name2 != Everton")

local playername1 = GetPlayerName(20801)
Log("playername1 (20801): " .. playername1)
assert(type(playername1) == "string", "GetPlayerName(20801) not a string")
assert(playername1 == "Cristiano Ronaldo", "playername1 != Cristiano Ronaldo")

local playername2 = GetPlayerName(158023)
Log("playername2 (158023): " .. playername2)
assert(type(playername2) == "string", "GetPlayerName(158023) not a string")
assert(playername2 == "Lionel Messi", "playername2 != Lionel Messi")

local teamid1 = GetTeamIdFromPlayerId(158023)
Log("teamid1 (158023): " .. teamid1)
assert(type(teamid1) == "number", "GetTeamIdFromPlayerId(158023) not a number")
assert(teamid1 == 241, "teamid1 != 241")

local teamid2 = GetTeamIdFromPlayerId(20801)
Log("teamid2 (20801): " .. teamid2)
assert(type(teamid2) == "number", "GetTeamIdFromPlayerId(20801) not a number")
assert(teamid2 == 114153, "teamid2 != 114153")

Log("LUA Test Passed")
MessageBox("LUA TEST", "TEST PASSED")
