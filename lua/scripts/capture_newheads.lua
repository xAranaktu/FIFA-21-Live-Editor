local new_heads = {
    234579,
    237695,
    244448,
    253100
}

-- Reload Database in Live Editor memory
ReloadDB()

-- Get all rows for players table
local rows = GetDBTableRows("players")

local counter = 0;
for i=1, #rows do
    if counter > #new_heads then break end

    local player = rows[i]

    local iplayerid = math.floor(player.playerid.value)
    local teamid = 111
    local headassetid = new_heads[counter+1]

    if (headassetid) then
        Log(string.format("PID: %d, headassetid: %d", iplayerid, headassetid))
        player.hashighqualityhead.value = "1"
        EditDBTableField(player.hashighqualityhead)

        player.headclasscode.value = "0"
        EditDBTableField(player.headclasscode)

        player.headassetid.value = tostring(headassetid)
        EditDBTableField(player.headassetid)
        local path = string.format("generated minifaces/p%d.DDS", headassetid)
        AddMinifaceToGenerate(iplayerid, teamid, path)
        counter = counter + 1
    end
end

Log("Start Generating")
GenerateMinifaces()
