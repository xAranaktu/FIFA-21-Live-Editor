--- Test script registered in luarunner
Log("Run LUA Test")
ReloadDB()


local bIsInCM = IsInCM();
assert(type(bIsInCM) == "boolean", "IsInCM not a boolean")

if (bIsInCM) then
    Log("Is In Career Mode")

    Log("Run the tests as FC Barcelona (ID: 241) Manager ")
    local user_teamid = GetUserTeamID()
    
    Log("user_teamid: " .. user_teamid)
    assert(type(user_teamid) == "number", "user_teamid not a number")

    SetTransferBudget(6777656)
    local transfer_budget = GetTransferBudget()
    Log("transfer_budget: " .. transfer_budget)
    assert(type(transfer_budget) == "number", "transfer_budget not a number")
    assert(transfer_budget == 6777656, "transfer_budget != 6777656")

    SetWageBudget(1234567)
    local wage_budget = GetWageBudget()
    Log("wage_budget: " .. wage_budget)
    assert(type(wage_budget) == "number", "wage_budget not a number")
    assert(wage_budget == 1234567, "wage_budget != 1234567")
    
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

    local playername1 = GetPlayerName(20801)
    Log("playername1 (20801): " .. playername1)
    assert(type(playername1) == "string", "GetPlayerName(20801) not a string")
    assert(playername1 == "Cristiano Ronaldo", "playername1 != Cristiano Ronaldo")

    local playername2 = GetPlayerName(158023)
    Log("playername2 (158023): " .. playername2)
    assert(type(playername2) == "string", "GetPlayerName(158023) not a string")
    assert(playername2 == "Lionel Messi", "playername2 != Lionel Messi")

    -- TODO Getters and check
    SetPlayerSharpness(158023, 100)
    SetPlayerMorale(158023, 95)
    SetPlayerForm(158023, 95)
    SetPlayerFitness(158023, 95)

    Log("Transfer test CPU")

    local transfer_test_playerid = 20801
    local transfer_test_playerteamid = GetTeamIdFromPlayerId(transfer_test_playerid)

    TransferPlayer(transfer_test_playerid, 11, 500, 600, 60)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == 11, "Ronaldo is not in Man United")

    TransferPlayer(transfer_test_playerid, user_teamid, 500000000, 60000, 60)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == user_teamid, "Ronaldo is not in user team")

    ReleasePlayerFromTeam(transfer_test_playerid)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == 111592, "Ronaldo is not in free agents")

    TransferPlayer(transfer_test_playerid, transfer_test_playerteamid, 500, 600, 60)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == transfer_test_playerteamid, "Ronaldo is not in org club")

    Log("Transfer test CPU Done")

    Log("Transfer test USER")

    transfer_test_playerid = 158023
    transfer_test_playerteamid = GetTeamIdFromPlayerId(transfer_test_playerid)

    TransferPlayer(transfer_test_playerid, 243, 500, 600, 60)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == 243, "Messi is not in Real Madrid")

    TransferPlayer(transfer_test_playerid, user_teamid, 500000000, 60000, 60)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == user_teamid, "Messi is not in user team")

    ReleasePlayerFromTeam(transfer_test_playerid)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == 111592, "Messi is not in free agents")

    TransferPlayer(transfer_test_playerid, transfer_test_playerteamid, 500, 600, 60)
    ReloadDB()
    assert(GetTeamIdFromPlayerId(transfer_test_playerid) == transfer_test_playerteamid, "Messi is not in org club")

    Log("Transfer test USER Done")

    Log("Transfer/Loan List Checks for user player")
    local listing_checks_playerid = 158023
    local is_on_transferlist = IsPlayerTransferListed(listing_checks_playerid)
    assert(type(is_on_transferlist) == "boolean", "is_on_transferlist not a boolean")

    local is_on_loanlist = IsPlayerLoanListed(listing_checks_playerid)
    assert(type(is_on_loanlist) == "boolean", "is_on_loanlist not a boolean")

    RemovePlayerFromLists(listing_checks_playerid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_playerid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_playerid)

    assert(is_on_loanlist == false, listing_checks_playerid .. " is on loan list after RemovePlayerFromLists called")
    assert(is_on_transferlist == false, listing_checks_playerid .. " is on transfer list after RemovePlayerFromLists called")

    AddPlayerToTransferList(listing_checks_playerid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_playerid)
    assert(is_on_transferlist, listing_checks_playerid .. " is not on transfer list after AddPlayerToTransferList called")
    RemovePlayerFromTransferList(listing_checks_playerid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_playerid)
    assert(is_on_transferlist == false, listing_checks_playerid .. " is on transfer list after RemovePlayerFromTransferList called")

    AddPlayerToLoanList(listing_checks_playerid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_playerid)
    assert(is_on_loanlist, listing_checks_playerid .. " is not on loan list after AddPlayerToLoanList called")
    RemovePlayerFromLoanList(listing_checks_playerid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_playerid)
    assert(is_on_loanlist == false, listing_checks_playerid .. " is not on loan list after RemovePlayerFromTransferList called")
    
    RemovePlayerFromLists(listing_checks_playerid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_playerid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_playerid)

    assert(is_on_loanlist == false, listing_checks_playerid .. " is on loan list after second RemovePlayerFromLists called")
    assert(is_on_transferlist == false, listing_checks_playerid .. " is on transfer list after second RemovePlayerFromLists called")

    Log("Transfer/Loan List Checks for CPU player")
    local listing_checks_cpu_playerid = 41
    local listing_checks_cpu_teamid = GetTeamIdFromPlayerId(listing_checks_cpu_playerid)
    Log("listing_checks_cpu_playerid: " .. listing_checks_cpu_playerid)
    Log("listing_checks_cpu_teamid: " .. listing_checks_cpu_teamid)

    RemovePlayerFromLists(listing_checks_cpu_playerid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)

    assert(is_on_loanlist == false, listing_checks_cpu_playerid .. " is on loan list after RemovePlayerFromLists called")
    assert(is_on_transferlist == false, listing_checks_cpu_playerid .. " is on transfer list after RemovePlayerFromLists called")

    AddPlayerToTransferList(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    AddPlayerToLoanList(listing_checks_cpu_playerid, listing_checks_cpu_teamid)

    is_on_loanlist = IsPlayerLoanListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    assert(is_on_loanlist, listing_checks_cpu_playerid .. " is not on loan list after AddPlayerToLoanList called")
    assert(is_on_transferlist, listing_checks_cpu_playerid .. " is not on transfer list after AddPlayerToTransferList called")

    RemovePlayerFromTransferList(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    assert(is_on_loanlist, listing_checks_cpu_playerid .. " is not on loan list after RemovePlayerFromTransferList called")
    assert(is_on_transferlist == false, listing_checks_cpu_playerid .. " is on transfer list after RemovePlayerFromTransferList called")

    AddPlayerToTransferList(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    RemovePlayerFromLoanList(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    assert(is_on_loanlist == false, listing_checks_cpu_playerid .. " is on loan list after RemovePlayerFromLoanList called")
    assert(is_on_transferlist, listing_checks_cpu_playerid .. " is on not transfer list after RemovePlayerFromLoanList called")
    AddPlayerToLoanList(listing_checks_cpu_playerid, listing_checks_cpu_teamid)

    RemovePlayerFromLists(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_loanlist = IsPlayerLoanListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)
    is_on_transferlist = IsPlayerTransferListed(listing_checks_cpu_playerid, listing_checks_cpu_teamid)

    assert(is_on_loanlist == false, listing_checks_cpu_playerid .. " is on loan list after second RemovePlayerFromLists called")
    assert(is_on_transferlist == false, listing_checks_cpu_playerid .. " is on transfer list after second RemovePlayerFromLists called")

    Log("Transfer/Loan List Checks Done")

    local loan_test1 = IsPlayerLoanedOut(158023)
    local loan_test2 = IsPlayerLoanedOut(240915)

    assert(loan_test1 == false, "Messi shouldnt be on loan")
    assert(loan_test2, "Miranda should be on loan")

    TerminateLoan(240915)
    LoanPlayer(20801, 11, 12, -1)
    LoanPlayer(208722, 241, 12, -1)

    IsPlayerPresigned(158023)
    DeletePresignedContract(158023)
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
