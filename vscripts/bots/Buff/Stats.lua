dofile('bots/Buff/Helper')

if Stats == nil
then
    Stats = {}
end

-- just eyeballed
function Stats.UpdateStats(bot, nTeam)
    local gameTime = Helper.DotaTime() / 60
    local botPos = Helper.GetPosition(bot, nTeam)

    if gameTime >= 25 and gameTime <=60 then
        local stat
        local bonus = 0.01667
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
    end
end

return Stats