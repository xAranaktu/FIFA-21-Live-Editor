--- Main live editor lib
--- Documentation in -> DOC.MD

Log("Init live_editor.lua")

--- CreateOfferForPlayer(158023, 243, 5)
function CreateOfferForPlayer(playerid, teamid, offer_type)
    cCreateOfferForPlayer(playerid, teamid, offer_type or 5)
end
