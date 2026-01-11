dofile('bots/Buff/Helper')

if StatsAwards == nil
then
    StatsAwards = {}
end

-- just eyeballed
function StatsAwards.AddStats(bot, nTeam)
    local gameTime = Helper.DotaTime() / 60
    local botPos = Helper.GetPosition(bot, nTeam)

    if gameTime >= 20 and gameTime <=50 then
        local stat
        local bonus = 0.01667
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
    end
end

return StatsAwards