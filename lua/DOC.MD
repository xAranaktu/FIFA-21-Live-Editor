# FIFA LIVE EDITOR LUA DOCUMENTATION

FIFA Live Editor is using Lua 5.3.4 (32 bit) as main scripting language. You can execute lua code by opening menu (F11) -> Lua Engine -> execute.

![](https://i.imgur.com/evZk7JG.png)

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
* [SetPlayerSharpness](#SetPlayerSharpness)
* [SetPlayerMorale](#SetPlayerMorale)
* [SetPlayerForm](#SetPlayerForm)
* [SetPlayerFitness](#SetPlayerFitness)
* [ReloadDB](#ReloadDB)
* [ReloadPlayersManager](#ReloadPlayersManager)
* [PlayerHasDevelopementPlan](#PlayerHasDevelopementPlan)
* [PlayerSetValueInDevelopementPlan](#PlayerSetValueInDevelopementPlan)
* [TransferPlayer](#TransferPlayer)
* [LoanPlayer](#LoanPlayer)
* [ReleasePlayerFromTeam](#ReleasePlayerFromTeam)
* [TerminateLoan](#TerminateLoan)
* [DeletePresignedContract](#DeletePresignedContract)
* [IsPlayerLoanedOut](#IsPlayerLoanedOut)
* [IsPlayerPresigned](#IsPlayerPresigned)
* [IsPlayerTransferListed](#IsPlayerTransferListed)
* [IsPlayerLoanListed](#IsPlayerLoanListed)
* [AddPlayerToTransferList](#AddPlayerToTransferList)
* [AddPlayerToLoanList](#AddPlayerToLoanList)
* [RemovePlayerFromLoanList](#RemovePlayerFromLoanList)
* [RemovePlayerFromTransferList](#RemovePlayerFromTransferList)
* [RemovePlayerFromLists](#RemovePlayerFromLists)
* [CreateOfferForPlayer](#CreateOfferForPlayer)
* [GetDBTablesNames](#GetDBTablesNames)
* [GetDBTableFields](#GetDBTableFields)
* [GetDBTableRows](#GetDBTableRows)
* [InsertDBTableRow](#InsertDBTableRow)
* [DeleteDBTableRow](#DeleteDBTableRow)
* [EditDBTableField](#EditDBTableField)
* [AddMinifaceToGenerate](#AddMinifaceToGenerate)
* [GenerateMinifaces](#GenerateMinifaces)
* [GetTransferBudget](#GetTransferBudget)
* [SetTransferBudget](#SetTransferBudget)
* [GetWageBudget](#GetWageBudget)
* [SetWageBudget](#SetWageBudget)

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

## SetPlayerSharpness

Set player sharpness.
Use value from 0 to 100.

**Constraints**: 
- Can be executed only in Career Mode.
- Only for player in user team

### Syntax
```
void SetPlayerSharpness(playerid, new_sharpness)
```
### Return
None

### Example
```
-- Set Messi sharpness to 100
-- Will work only if Messi is in your team
SetPlayerSharpness(158023, 100)
```

## SetPlayerMorale

Set player morale.
Use value from 0 to 100.


Min. Morale levels (may be different if you use an mod which changes them):
- Below 15 for Very Unhappy 
- 40 for Unhappy
- 65 for Content 
- 75 for Happy 
- 95 for Very Happy

**Constraints**: 
- Can be executed only in Career Mode.
- Only for player in user team

### Syntax
```
void SetPlayerMorale(playerid, new_morale)
```
### Return
None

### Example
```
-- Set Messi morale to 95 (Very Happy)
-- Will work only if Messi is in your team
SetPlayerMorale(158023, 95)
```

## SetPlayerForm

Set player form.
Use value from 0 to 100.

Min. Form levels (may be different if you use an mod which changes them):
- Below 25 for Bad
- 50 for Poor
- 65 for Okay 
- 75 for Good 
- 90 for Excellent

**Constraints**: 
- Can be executed only in Career Mode.
- Only for player in user team

### Syntax
```
void SetPlayerForm(playerid, new_form)
```
### Return
None

### Example
```
-- Set Messi form to 90 (Excellent)
-- Will work only if Messi is in your team
SetPlayerForm(158023, 90)
```

## SetPlayerFitness

Set player match fitness/durability/fitness/stamina (call it as you want ;)).

Use value from 5 to 95. Where 5 is completly tired and 95 is almost full fit.
I don't recommend to set the value below 5 as it will probably bug the stamina bar.
Above 95 may bug the whole player/game.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void SetPlayerFitness(playerid, new_fitness)
```
### Return
None

### Example
```
-- Set Messi fitness to 95 (Almost Full Fit)
SetPlayerFitness(158023, 95)
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

## TransferPlayer

**WARNING**

This can damage/break your career save (especially if you do something stupid, like trying to transfer player who is on loan in other club). Use with caution. Remember about backups.
Tested only in Manager Career Mode. May not work in Player Career Mode

Immediately transfer player to any club (including yours).

Can be used even if the transfer window is closed.

Wage only matters if you transfer the player to your club.

if from_teamid is 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally

if release_clause is 0 then there won't be any release clause

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void TransferPlayer(playerid, to_teamid, transfersum, wage, contract_length_in_months, from_teamid=0, release_clause=0)
or
void cTransferPlayer(playerid, from_teamid, to_teamid, transfersum, release_clause, wage, contract_length_in_months)
```
### Return
None

### Example
```
-- Transfer 
-- Cristiano Ronaldo (playerid: 20801)
-- To Manchester United (ID: 11)
-- For 500 euro/usd/gbp
-- Wage = 600
-- contract length = 60 months (5 years)

playerid = 20801
if (IsPlayerPresigned(playerid)) then
  -- Delete presigned contract to force transfer
  DeletePresignedContract(playerid)
end

if (IsPlayerLoanedOut(playerid)) then
  -- Terminate loan to force transfer
  TerminateLoan(playerid)
end

TransferPlayer(20801, 11, 500, 600, 60)
```

## LoanPlayer

**WARNING**

This can damage/break your career save. Use with caution. Remember about backups.
Tested only in Manager Career Mode. May not work in Player Career Mode

Immediately loan player to any club (including yours).

Can be used even if the transfer window is closed.


if from_teamid is 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally

For now keep the `loantobuy` == `-1`. I don't know how it works exactly, maybe will fix it later.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void LoanPlayer(playerid, to_teamid, length_in_months, loantobuy, from_teamid=0)
or
void cLoanPlayer(playerid, from_teamid, to_teamid, length_in_months, loantobuy)
```
### Return
None

### Example
```
-- Loan 
-- Cristiano Ronaldo (playerid: 20801)
-- To Manchester United (ID: 11)
-- contract length = 12 months (1 year)
-- loantobuy = -1 (no loan to buy)

local playerid = 20801
local to_teamid = 11
if (IsPlayerPresigned(playerid)) then
  -- Delete presigned contract to force loan
  DeletePresignedContract(playerid)
end

if (IsPlayerLoanedOut(playerid)) then
  -- Terminate loan to force new loan
  TerminateLoan(playerid)
end

LoanPlayer(playerid, to_teamid, 12, -1)
```

## ReleasePlayerFromTeam

**WARNING**

This can damage/break your career save (especially if you do something stupid, like trying to release player who is on loan in other club). Use with caution. Remember about backups.


Release player from current club.

Under the hood it's just transfering the player to free agents, like that:
```
player_teamid = GetTeamIdFromPlayerId(playerid)
free_agents_teamid = 111592
cTransferPlayer(playerid, player_teamid, free_agents_teamid, 0, 0, 0, 12)
```

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void ReleasePlayerFromTeam(playerid)
```
### Return
None

### Example
```
-- Make Messi Free Agent
ReleasePlayerFromTeam(158023)
```

## TerminateLoan

**WARNING**

This can damage/break your career save. Use with caution. Remember about backups.

Terminates player loan. The player will immediately back to his club.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void TerminateLoan(playerid)
```
### Return
None

### Example
```
-- Juan Camilo Hernández will immediately back to Watford (if he is loaned out in your career)
playerid = 237034 -- Juan Camilo Hernández
if (IsPlayerLoanedOut(playerid)) then
    TerminateLoan(playerid) 
end
```

## DeletePresignedContract

**WARNING**

This can damage/break your career save. Use with caution. Remember about backups.

Delete player related record from career_presignedcontract table.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void DeletePresignedContract(playerid)
```
### Return
none

### Example
```
-- Delete Juan Camilo Hernández presigned contract(if he has one)
playerid = 237034 -- Juan Camilo Hernández
if (IsPlayerPresigned(playerid)) then
    DeletePresignedContract(playerid)
end
```

## IsPlayerLoanedOut

Check if player is loaned out.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
bool IsPlayerLoanedOut(playerid)
```
### Return
Type: **Bool**
- **True** if player is loaned out
- **False** if player isn't loaned out

### Example
```
-- Check if Juan Camilo Hernández is loaned out
playerid = 237034 -- Juan Camilo Hernández
if (IsPlayerLoanedOut(playerid)) then
    Log("Player is Loaned out")
else
    Log("Player isn't Loaned out")
end
```

## IsPlayerPresigned

Check if player is has presigned contract.
To be more precise, it checks if the player reladed record exist in career_presignedcontract table

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
bool IsPlayerPresigned(playerid)
```
### Return
Type: **Bool**
- **True** if player has got record in career_presignedcontract
- **False** if player hasn't got record in career_presignedcontract

### Example
```
-- Juan Camilo Hernández will immediately back to Watford (if he is loaned out in your career)
playerid = 237034 -- Juan Camilo Hernández
if (IsPlayerPresigned(playerid)) then
    Log("Player is presigned")
else
    Log("Player isn't presigned")
end
```

## IsPlayerTransferListed

Check if player with given playerid is on transfer list.
If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
bool IsPlayerTransferListed(int playerid, int teamid=0)
or
bool cIsPlayerTransferListed(int playerid, int teamid)
```
### Return
Type: **Bool**
- **True** if player is on transfer list
- **False** if player isn't on transfer list

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Check if Messi is on transfer list
    local is_on_transferlist = IsPlayerTransferListed(158023)
    if (is_on_transferlist) then
        Log("Player is on transfer list")
    else
        Log("Player is not on transfer list")
    end
    
end

```

## IsPlayerLoanListed

Check if player with given playerid is on loan list.
If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
bool IsPlayerLoanListed(int playerid, int teamid=0)
or
bool cIsPlayerLoanListed(int playerid, int teamid)
```
### Return
Type: **Bool**
- **True** if player is on loan list
- **False** if player isn't on loan list

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Check if Messi is on loan list
    local is_on_loanlist = IsPlayerLoanListed(158023)
    if (is_on_loanlist) then
        Log("Player is on loan list")
    else
        Log("Player is not on loan list")
    end
    
end

```


## AddPlayerToTransferList

Adds player with given playerid to transfer list.
If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**WARNING!!**

Altho it's possible to make player transfer and loan listed, you shouldn't do that as it doesn't happen in "natural" game environment.
So, player should be only on loan list **or** only on transfer list.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void AddPlayerToTransferList(int playerid, int teamid=0)
or
void cAddPlayerToTransferList(int playerid, int teamid)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Make Messi transferlisted
    AddPlayerToTransferList(158023)
end

```

## AddPlayerToLoanList

Adds player with given playerid to loan list.
If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**WARNING!!**

Altho it's possible to make player transfer and loan listed, you shouldn't do that as it doesn't happen in "natural" game environment.
So, player should be only on loan list **or** only on transfer list.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void AddPlayerToLoanList(int playerid, int teamid=0)
or
void cAddPlayerToLoanList(int playerid, int teamid)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Make Messi loanlisted
    AddPlayerToLoanList(158023)
end

```

## RemovePlayerFromLists

Remove player with given playerid from transfer and loan list.

If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void RemovePlayerFromLists(int playerid, int teamid=0)
or
void cRemovePlayerFromLists(int playerid, int teamid)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Remove Messi from transfer and loan list
    RemovePlayerFromLists(158023)
end

```


## RemovePlayerFromTransferList

Remove player with given playerid from transfer list
If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void RemovePlayerFromTransferList(int playerid, int teamid=0)
or
void cRemovePlayerFromTransferList(int playerid, int teamid)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Remove Messi from transfer list
    RemovePlayerFromTransferList(158023)
end

```

## RemovePlayerFromLoanList

Remove player with given playerid from loan list
If given teamid == 0 then the tool will call [GetTeamIdFromPlayerId](#GetTeamIdFromPlayerId) internally.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void RemovePlayerFromLoanList(int playerid, int teamid=0)
or
void cRemovePlayerFromLoanList(int playerid, int teamid)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Remove Messi from loan list
    RemovePlayerFromLoanList(158023)
end

```


## CreateOfferForPlayer

Create Transfer or Loan offer for player.

Offer type can be any value between 0 and 5 (maybe 6).
Default offer type is 5. Game commonly uses offer type 3 or 5.
For loan offer use offer type == 2 (sometimes you may get loan to buy offer instead of normal offer).

Created offer should appear in-game after 2-5 days. Transfer window probably must be open.

You can use this to create offers for your players and also to initiate transfers between CPU teams.
Using this doesn't guarantee that the player will change his team. There is always chance that player or team will break negotiations.

The unrealistic transfer offers may not even appear. For example if you will try to create an transfer offer for Messi from AFC Wimbledon game may ignore it and not even show it (because AFC Wimbledon doesn't have enough transfer budget).
If the transfer offer will somehow appear then for 99% it will fail later on when Messi will negotiate his wage with team (AFC Wimbledon doesn't have enough wage budget to cover Messi salary).

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void CreateOfferForPlayer(int playerid, int offer_from_teamid, int offer_type=5)
or
void cCreateOfferForPlayer(int playerid, int offer_from_teamid, int offer_type)
```
### Return
None

### Example
```
local bIsInCM = IsInCM();

if (bIsInCM) then
    -- Create offer for Messi (playerid: 158023)
    -- From Manchester City (teamid: 10)
    -- With offer type == 5
    CreateOfferForPlayer(158023, 10, 5)
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

## InsertDBTableRow
Inserts new row into database table.
### Syntax
```
table InsertDBTableRow(string table_name, table row_data)
```
### Return
Return newly created row

Type: [DBRow](#DBRow)

### Example
```
-- Reload Database to make sure we are working with up to date copy
ReloadDB()

-- Assign custom name to Messi (Playerid: 158023)
local row_data = {
    playerid = "158023",
    firstname = "aaa",
    surname = "bbb",
    playerjerseyname = "ccc"
}

local row = InsertDBTableRow("editedplayernames", row_data)
Log(type(row))

-- That's how to verify if row has been inserted
if (row.addr == "0") then
    Log("Insert row failed. Check logs for more info")
    return    
end

Log(row["playerid"]["value"])

```
```
> table
> 158023

```

## DeleteDBTableRow
Delete row from database table.
### Syntax
```
bool InsertDBTableRow(string table_name, table row_data)
```
### Return
Type: **Bool**
- **True** if row has been deleted
- **False** if failed

### Example
```
-- Reload Database to make sure we are working with up to date copy
ReloadDB()

-- Assign custom name to Messi (Playerid: 158023)
local row_data = {
    playerid = "158023",
    firstname = "aaa",
    surname = "bbb",
    playerjerseyname = "ccc"
}

local row = InsertDBTableRow("editedplayernames", row_data)

-- That's how to verify if row has been inserted
if (row.addr == "0") then
    Log("Insert row failed. Check logs for more info")
    return    
end

-- Delete the row that we just created
local success = DeleteDBTableRow("editedplayernames", row)
if (success) then
    Log("Row deleted")
else
    Log("Failed to delete row")
end

```
```
Row deleted

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
## AddMinifaceToGenerate
Add player to the queue for generating minifaces.
Call [GenerateMinifaces](#GenerateMinifaces) to start generating.

**Constraints**: 
- Can be executed only in Career Mode.
### Syntax
```
void AddMinifaceToGenerate(int playerid, int teamid, string out_path)
```
### Return
void

### Example
```
local data = {
    {158023, 241}
}

local bIsInCM = IsInCM();
if (bIsInCM) then
    for i=1, #data do
        local playerid = data[i][1] // Render headmodel from this playerid
        local teamid = data[i][2]   // Render homekit from this teamid
        if (teamid <= 0) then
            teamid = 111
        end
        
        // Path is relative to the game installation directory
        local path = string.format("LiveEditorMods/root/Legacy/data/ui/imgAssets/heads/p%d.DDS", playerid)
        
        // Add to Queue
        AddMinifaceToGenerate(playerid, teamid, path)
    end
    Log("Start Generating")
    
    // Start generating from queue
    GenerateMinifaces()
end

```

## GenerateMinifaces
Generate minifaces for players in queue.
Add players by calling [AddMinifaceToGenerate](#AddMinifaceToGenerate)

On my PC it takes around 2s to generate one miniface, so be prepared that if you want to generate a lot of minifaces you will need to wait a while.

**Constraints**: 
- Can be executed only in Career Mode.
### Syntax
```
void GenerateMinifaces()
```
### Return
void

### Example
```
local data = {
    {158023, 241}
}

local bIsInCM = IsInCM();
if (bIsInCM) then
    for i=1, #data do
        local playerid = data[i][1] // Render headmodel from this playerid
        local teamid = data[i][2]   // Render homekit from this teamid
        if (teamid <= 0) then
            teamid = 111
        end
        
        // Path is relative to the game installation directory
        local path = string.format("LiveEditorMods/root/Legacy/data/ui/imgAssets/heads/p%d.DDS", playerid)
        
        // Add to Queue
        AddMinifaceToGenerate(playerid, teamid, path)
    end
    Log("Start Generating")
    
    // Start generating from queue
    GenerateMinifaces()
end

```

## GetTransferBudget
Get user club transfer budget

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
int GetTransferBudget()
```
### Return
Type: **Int**
- Transfer budget value

### Example
```
SetTransferBudget(6777656)
local transfer_budget = GetTransferBudget()
Log("transfer_budget: " .. transfer_budget)
Log(type(transfer_budget))

```
```
> transfer_budget: 6777656
> number
```

## SetTransferBudget
Set user club transfer budget

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void SetTransferBudget(int new_transfer_budget)
```
### Return
Type: **void**

### Example
```
SetTransferBudget(6777656)
local transfer_budget = GetTransferBudget()
Log("transfer_budget: " .. transfer_budget)
Log(type(transfer_budget))

```
```
> transfer_budget: 6777656
> number
```

## GetWageBudget
Get user club wage budget. The value returned will be different than the value you see in game.
The game divides it by the number of weeks until end of the season.

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
int GetWageBudget()
```
### Return
Type: **Int**
- Wage budget value

### Example
```
SetWageBudget(1234567)
local wage_budget = GetWageBudget()
Log("wage_budget: " .. wage_budget)
Log(type(wage_budget))

```
```
> wage_budget: 1234567
> number
```

## SetWageBudget
Set user club wage budget

**Constraints**: 
- Can be executed only in Career Mode.

### Syntax
```
void SetWageBudget(int new_wage_budget)
```
### Return
Type: **void**

### Example
```
SetWageBudget(1234567)
local wage_budget = GetWageBudget()
Log("wage_budget: " .. wage_budget)
Log(type(wage_budget))

```
```
> wage_budget: 1234567
> number
```

