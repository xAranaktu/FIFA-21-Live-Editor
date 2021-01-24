# FIFA LIVE EDITOR LUA DOCUMENTATION

FIFA Live Editor is using Lua 5.3.4 (32 bit) as main scripting language. You can execute lua code by opening menu (F11) -> Lua Engine -> execute.

Just for your info, Lua scripts created for cheat engine will not work.
Also, LUA Engine allows you to switch between lua states to access also in-game lua functions. These functions aren't covered in this documentation.

## Functions

* [Log](#Log)
* [MessageBox](#MessageBox)
* [IsInCM](#IsInCM)
* [GetCurrentDate](#GetCurrentDate)
* [GetUserTeamID](#GetUserTeamID)
* [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId)
* [GetTeamName](#GetTeamName)
* [GetPlayerName](#GetPlayerName)
* [ReloadDB](#ReloadDB)
* [ReloadPlayersManager](#ReloadPlayersManager)
* [PlayerHasDevelopementPlan](#PlayerHasDevelopementPlan)
* [PlayerSetValueInDevelopementPlan](#PlayerSetValueInDevelopementPlan)
* [GetDBTablesNames](#GetDBTablesNames)
* [GetDBTableFields](#GetDBTableFields)
* [GetDBTableRows](#GetDBTableRows)
* [EditDBTableField](#EditDBTableField)

## Data Types

* [DBFieldDescription](#DBFieldDescription)
* [DBRow](#DBRow)

## Log

Write to log file and console window.

### Syntax
```
void Log(string text)
```

## MessageBox

Show MessageBox with given title and text

### Syntax
```
void MessageBox(string title, string text)
```


## IsInCM

Check if we are in career mode.
### Syntax
```
bool IsInCM()
```

### Return
Type: **Bool**
- **True** if executed in career mode
- **False** if executed outside of career mode


### Example
```
local is_in_career_mode = IsInCM()
Log(type(is_in_career_mode))

if (is_in_career_mode) then
    Log("In career mode")
else
    Log("Not in career mode")
end
```
```
> boolean
> In career mode
```

## GetCurrentDate

Get current in-game date.
In career it will return date from career_calendar.
Outside of career it will be always 1st July 2019.

### Syntax
```
table GetCurrentDate()
```
### Return
Type: **Table**

Key(string)-Value(int) pair.

Valid keys: 
- day
- month
- year

### Example
```
local currentdate = GetCurrentDate()
Log(type(currentdate))
Log(type(currentdate.day))
Log(type(currentdate.month))
Log(type(currentdate.year))
Log("Current Date (day/month/year): " .. currentdate.day .. "/" .. currentdate.month .. "/" .. currentdate.year )
```
```
> table
> number
> number
> number
> Current Date (day/month/year): 1/7/2019
```
## GetUserTeamID

Get value from field "clubteamid" from first record in career_users table. Should be our teamid in manager career mode.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
int GetUserTeamID()
```
### Return
Type: **Int**
- Teamid of the team managed by user.
- OnError: Return 0 and write error in log file.

### Example
```
-- In Career mode
-- Manager of Everton
local user_teamid = GetUserTeamID()
Log(type(user_teamid))
Log(user_teamid) 
```
```
> number
> 7
```

## GetTeamIdFromPlayerId

Get teamid from playerid. Should be id of the player club.
Ignore teams in following leagues:
- 78, International
- 2136, International Women
- 76, Rest of World
- 383, Create Player League

### Syntax
```
int GetTeamIdFromPlayerId(int playerid)
```
### Return
Type: **Int**
- Club TeamId for playerid
- Returns -1 if team not found

### Example
```
-- Messi PlayerID: 158023
-- FC Barcelona TeamID: 241
local teamid1 = GetTeamIdFromPlayerId(158023)
Log("teamid1 (158023): " .. teamid1)
assert(type(teamid1) == "number", "GetTeamIdFromPlayerId(158023) not a number")

-- Cristiano Ronaldo PlayerID: 20801
-- Piemonte Calcio TeamID: 114153
local teamid2 = GetTeamIdFromPlayerId(20801)
Log("teamid2 (20801): " .. teamid2)
assert(type(teamid2) == "number", "GetTeamIdFromPlayerId(20801) not a number")

```
```
> teamid1 (158023): 241
> teamid2 (20801): 114153
```

## GetTeamName

Get name of the team for passed teamid.

Name is stored in localized database file. For example, for English game version it will be eng_us_db.db.

### Syntax
```
string GetTeamName(unsigned int teamid)
```
### Return
Type: **String**
- Name of the team
- OnError: Return empty string and write error in log file.
### Example
```
local teamname = GetTeamName(7)
Log(type(teamname))
Log(teamname) 

teamname = GetTeamName(241)
Log(teamname) 
```
```
> string
> Everton
> FC Barcelona
```

## GetPlayerName

Get name of the player for passed playerid.

### Syntax
```
string GetPlayerName(unsigned int playerid)
```
### Return
Type: **String**
- Name of the player
- OnError: Return empty string and write error in log file.
### Example
```
local playername = GetPlayerName(20801)
Log(playername)

playername = GetPlayerName(158023)
Log(playername)
```
```
> Cristiano Ronaldo
> Lionel Messi
```

## ReloadDB

Reload all database tables in Live Editor memory.
Use it to make sure you are working with up to date tables

### Syntax
```
void ReloadDB()
```
### Return
None

### Example
```
ReloadDB()
```

## ReloadPlayersManager

Reload Players Manager in Live Editor memory.

### Syntax
```
void ReloadPlayersManager()
```
### Return
None

### Example
```
ReloadPlayersManager()
```

## PlayerHasDevelopementPlan

Players in Manager Career mode that are in team managed by user got developement plans. Data stored in these plans got higher priority than fields in players table.
Following fields are part of the developement plan:
- All attributes
- Workrates
- Skillmoves
- Weakfoot

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
bool PlayerHasDevelopementPlan(int playerid)
```
### Return
Type: **Bool**
- **True** if player has developement plan
- **False** if player doesn't have developement plan

### Example
```
PlayerHasDevelopementPlan(158023)
```

## PlayerSetValueInDevelopementPlan

Players in Manager Career mode that are in team managed by user got developement plans. Data stored in these plans got higher priority than fields in players table.
Following fields are part of the developement plan:
- All attributes
- Workrates
- Skillmoves
- Weakfoot

Use this to set corresponding XP points for given field.
Use fieldnames same as in players table

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void PlayerSetValueInDevelopementPlan(int playerid, string field_name, int value)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

ReloadDB()
if (bIsInCM) then
    ReloadPlayersManager()
    if (PlayerHasDevelopementPlan(158023)) then
        PlayerSetValueInDevelopementPlan(158023, "composure", 99)
    end
end

```


## GetDBTablesNames
Get names of database tables that we can access (same tables are available in Database Editor)

### Syntax
```
array GetDBTablesNames()
```

### Return
Type: **Array of strings**
- List of database tables names
- OnError: Return empty string and write error in log file.

### Example
```
local tables = GetDBTablesNames()
Log(type(tables))
Log(type(tables[1]))
Log(tables[1])

```
```
> table
> string
> assetcryptokeys
```

## GetDBTableFields
Get field (column) and their description for database table

### Syntax
```
table GetDBTableFields(string table_name)
```
### Return
Type: **Array of** [DBFieldDescription](#DBFieldDescription)
### Example
```
-- Get field names for career_users table_
local fields = GetDBTableFields("career_users")

-- Number of fields
Log(#fields)

Log(fields[1]["name"])
Log(fields[2]["name"])
Log(fields[3]["name"])
Log(fields[4]["name"])
```
```
> 16
> sponsorid
> leagueseasonmessagesent
> seasoncount
> playertype
```
## GetDBTableRows
Get all valid rows for database table
### Syntax
```
array GetDBTableRows(string table_name)
```
### Return
Type: **Array of** [DBRow](#DBRow)
### Example
```
-- Reload Database in Live Editor memory
ReloadDB()
-- Get all rows for teams table
local rows = GetDBTableRows("teams")

-- Number of rows
Log(#rows)

-- 1st row
local row = rows[1]
Log(row["teamname"]["value"])
Log(row["teamid"]["value"])

-- 6th row
local row = rows[6]
Log(row["teamname"]["value"])
Log(row["teamid"]["value"])
```
```
> 763
> Arsenal
> 1
> Everton
> 7
```



## EditDBTableField
Edit field in database table
### Syntax
```
bool EditDBTableField(table field)
```
### Return
Type: **Bool**
- **True** if field edited succesfully
- **False** if failed

### Example
```
local success = false;

-- Reload Database to make sure we are working with up to date copy
ReloadDB() 
-- Get all rows for manager table
local rows = GetDBTableRows("manager")

-- first row
local row = rows[1]

-- Current Name of the manager
Log(row.firstname.value)
row.firstname.value = "Edited Firstname"

-- Commit
success = EditDBTableField(row["firstname"])
assert(success, "EditDBTableField false for firstname")

-- Current NationalityID of the manager
Log(row.nationality.value)
row.nationality.value = "37"

-- Commit
success = EditDBTableField(row["nationality"])
assert(success, "EditDBTableField false for nationality")

-- Check if values has changed

Log("After Edit")
-- Reload Database in Live Editor memory
ReloadDB()
-- Get all rows for manager table
local rows = GetDBTableRows("manager")

-- first row
local row = rows[1]
Log(row.firstname.value)
Log(row.nationality.value)

```
```
> Mikel
> 45
> After Edit
> Edited Firstname
> 37
```