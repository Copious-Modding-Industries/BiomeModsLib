--- ## Checks if biome modifiers have been moved to a file or not, and if not moves them to a file to append to.
--- ***
---@return string path The new path for the biome modifiers file
local function BMLToFile()
    local str = ModTextFileGetContent("data/scripts/biome_modifiers.lua")
    if str:match("BML APPEND DONE") == nil then
        local s1, s2 = str:find([=[biome_modifiers =]=])
        local s3, s4 = str:find(
 [=[--[[-- dry - fire spreads faster than usually, fire demons spawn
    -- bouncy - projectiles and physics bodies bounce from surfaces
    -- corrupted - corruption grows everywhere. corruption = some sort of easily destructible static material
    -- toxic - pools of toxic sludge, toxic rock everywhere
    -- vulcanous - lava, lava rock everywhere
    -- haunted - ghost crystals spawn
    -- rat infested - rats spawn everywhere
    -- worm infested - more worm spawn than usually
    -- alchemic - humanoid enemies drop random potions on death
    -- peaceful - enemies don't attack unless projectile spells are used
    -- portal upwards - a box can be found that spawns a portal when kicked
    -- portal downwards - a box can be found that spawns a portal when kicked
    -- more based on various perks?
    ]]--
}]=])
        ModTextFileSetContent("data/shared/biome_modifiers.lua", str:sub(s1, s4) .. [[
        return biome_modifiers]])
        ModTextFileSetContent("data/scripts/biome_modifiers.lua", 
        table.concat{str:sub(1, s1-1), [[biome_modifiers = dofile_once("data/shared/biome_modifiers.lua")]], str:sub(s4+1, -1), [=[-- [[BML APPEND DONE]] ]=]})
    end
    return "data/shared/biome_modifiers.lua"
end

return {BMLToFile = BMLToFile}