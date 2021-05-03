--- Main live editor lib
--- Documentation in -> DOC.MD

Log("Init live_editor.lua")

--- CreateOfferForPlayer(158023, 243, 5)
function CreateOfferForPlayer(playerid, teamid, offer_type)
    cCreateOfferForPlayer(playerid, teamid, offer_type or 5)
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
