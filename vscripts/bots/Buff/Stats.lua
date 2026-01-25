dofile('bots/Buff/Helper')

if Stats == nil
then
    Stats = {}
end

-- just eyeballed
function Stats.UpdateStats(bot, nTeam)
    local gameTime = Helper.DotaTime() / 60
    local botPos = Helper.GetPosition(bot, nTeam)
    local unitStats = 1/60

    if gameTime >= 10 and gameTime <=30 then 
        local stat
        local bonus = unitStats * 1.3 -- add 1 stats per min 
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
    elseif gameTime > 30 and gameTime <=40 then
        local stat
        local bonus = unitStats * 1.5 -- add 1.5 stats per min
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
    elseif gameTime > 40 and gameTime <=60 then  
        local stat
        local bonus = unitStats * 2 -- add 2 stats per min
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
    elseif gameTime > 60 and gameTime <=61 then
        local stat
        local bonus = unitStats * 100 -- god mode +100 str, agi, and int.
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus)
        if gameTime > 60.9 and gameTime <=61 then
            GameRules:SendCustomMessage("<font color='#70EA71'>"..string.gsub(bot:GetUnitName(), 'npc_dota_hero_', '').."</font>"..' is in god mode. Cautious!', -1, 0)
        end
    end
end

return Stats