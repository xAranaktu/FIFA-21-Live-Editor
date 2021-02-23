local data = {
    {158023, 241},
    {152554, 324},
    {105846, 1871},
    {248149, 241},
    {209331, 241},
    {212831, 243},
    {212198, 11},
    {205175, 11},
    {188545, 11},
    {20801, 243}
}

local bIsInCM = IsInCM();
if (bIsInCM) then
    for i=1, #data do
        local playerid = data[i][1]
        local teamid = data[i][2]
        if (teamid <= 0) then
            teamid = 111
        end

        local path = string.format("LiveEditorMods/root/Legacy/data/ui/imgAssets/heads/p%d.DDS", playerid)
        AddMinifaceToGenerate(playerid, teamid, path)
    end
    Log("Start Generating")
    GenerateMinifaces()
end
