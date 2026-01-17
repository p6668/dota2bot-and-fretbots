dofile('bots/Buff/Helper')

if XP == nil
then
    XP = {}
end

local XPNeeded = {
    [1]  = 240,
    [2]  = 400,
    [3]  = 520,
    [4]  = 600,
    [5]  = 680,
    [6]  = 760,
    [7]  = 800,
    [8]  = 900,
    [9]  = 1000,
    [10] = 1100,
    [11] = 1200,
    [12] = 1300,
    [13] = 1400,
    [14] = 1500,
    [15] = 1600,
    [16] = 1700,
    [17] = 1800,
    [18] = 1900,
    [19] = 2000,
    [20] = 2200,
    [21] = 2400,
    [22] = 2600,
    [23] = 2800,
    [24] = 3000,
    [25] = 4000,
    [26] = 5000,
    [27] = 6000,
    [28] = 7000,
    [29] = 7500,
    [30] = 0,
}

-- just eyeballed
function XP.UpdateXP(bot, nTeam)
    local gameTime = Helper.DotaTime() / 60
    local botPos = Helper.GetPosition(bot, nTeam)

    if gameTime <= 2.5 then
        xp = 0
    elseif gameTime <= 6 then
        xp = 0
    elseif gameTime <= 10 then
        xp = 5
    elseif gameTime <= 12.5 then
        xp = 10
    elseif gameTime <= 15 then
        xp = 15
    elseif gameTime <= 20 then
        xp = 20
    elseif gameTime <= 25 then
        xp = 25
    elseif gameTime <= 30 then
        xp = 30
    else
        xp = 35
    end

    if gameTime > 0 then
        bot:AddExperience(math.floor(xp), 0, false, true)
    end
end

return XP