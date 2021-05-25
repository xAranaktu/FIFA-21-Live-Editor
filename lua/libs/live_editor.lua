--- Main live editor lib
--- Documentation in -> DOC.MD

Log("Init live_editor.lua")

--- CreateOfferForPlayer(158023, 243, 5)
function CreateOfferForPlayer(playerid, teamid, offer_type)
    cCreateOfferForPlayer(playerid, teamid, offer_type or 5)
end

--- TransferPlayer(20801, 1794, 500, 600, 60)
--- TransferPlayer(188567, 7, 500000000, 600000, 60)
--- TransferPlayer(158023, 1, 500000000, 600000, 60)
function TransferPlayer(playerid, to_teamid, transfersum, wage, contract_length, from_teamid, release_clause)
    cTransferPlayer(playerid, from_teamid or 0, to_teamid, transfersum, release_clause or 0, wage, contract_length)
end

function ReleasePlayerFromTeam(playerid)
    player_teamid = GetTeamIdFromPlayerId(playerid)
    free_agents_teamid = 111592
    cTransferPlayer(playerid, player_teamid, free_agents_teamid, 0, 0, 0, 12)
end

function IsPlayerTransferListed(playerid, teamid)
    return cIsPlayerTransferListed(playerid, teamid or 0)
end

function IsPlayerLoanListed(playerid, teamid)
    return cIsPlayerLoanListed(playerid, teamid or 0)
end

function AddPlayerToTransferList(playerid, teamid)
    cAddPlayerToTransferList(playerid, teamid or 0)
end

function AddPlayerToLoanList(playerid, teamid)
    cAddPlayerToLoanList(playerid, teamid or 0)
end

function RemovePlayerFromLoanList(playerid, teamid)
    cRemovePlayerFromLoanList(playerid, teamid or 0)
end

function RemovePlayerFromTransferList(playerid, teamid)
    cRemovePlayerFromTransferList(playerid, teamid or 0)
end

function RemovePlayerFromLists(playerid, teamid)
    cRemovePlayerFromLists(playerid, teamid or 0)
end
