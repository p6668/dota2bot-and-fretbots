dofile('bots/Buff/Helper')

if Stats == nil
then
    Stats = {}
end

-- just eyeballed
function Stats.UpdateStats(bot, nTeam, BotTotalKills, PlayerTotalKills, godmode)
    local gameTime = Helper.DotaTime() / 60
    local botPos = Helper.GetPosition(bot, nTeam)
    local unitStats = 1/60

    if gameTime >= 10 and gameTime <=20 then 
        local stat
        local bonus
        if godmode.DifficultyMode == 0 then
            bonus = unitStats * 0 -- add 0 stats per min 
        elseif godmode.DifficultyMode == 1 then
            bonus = unitStats * 0.5 -- add 0.5 stats per min 
        elseif godmode.DifficultyMode == 2 then
            bonus = unitStats * 1.5 -- add 1.5 stats per min 
        end
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime > 20 and gameTime <=30 then 
        local stat
        local bonus
        if godmode.DifficultyMode == 0 then
            bonus = unitStats * 0 -- add 0 stats per min 
        elseif godmode.DifficultyMode == 1 then
            bonus = unitStats * 1 -- add 1 stats per min 
        elseif godmode.DifficultyMode == 2 then
            bonus = unitStats * 2 -- add 2 stats per min 
        end
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime > 30 and gameTime <=40 then
        local stat
        local bonus
        if godmode.DifficultyMode == 0 then
            bonus = unitStats * 0.5 -- add 0.5 stats per min 
        elseif godmode.DifficultyMode == 1 then
            bonus = unitStats * 1.5 -- add 1.5 stats per min 
        elseif godmode.DifficultyMode == 2 then
            bonus = unitStats * 2.5 -- add 2.5 stats per min 
        end
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime >= godmode.StartTime and godmode.enabled and godmode.done == false and (PlayerTotalKills - BotTotalKills) >= godmode.KillThreshold then
        local stat
        local bonus = 100 -- god mode +100 str, agi, and int instantly.
        GameRules:SendCustomMessage("PlayerTotalKills:"..tostring(godmode.StartTime), -1, 0)
        GameRules:SendCustomMessage("BotTotalKills:"..tostring(godmode.StartTime), -1, 0)
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus)
        GameRules:SendCustomMessage("<font color='#70EA71'>"..string.gsub(bot:GetUnitName(), 'npc_dota_hero_', '').."</font>"..' is in god mode. Cautious!', -1, 0)
        return true
    elseif gameTime > 40 and gameTime <=60 then  
        local stat
        local bonus
        if godmode.DifficultyMode == 0 then
            bonus = unitStats * 1 -- add 1 stats per min 
        elseif godmode.DifficultyMode == 1 then
            bonus = unitStats * 2 -- add 2 stats per min 
        elseif godmode.DifficultyMode == 2 then
            bonus = unitStats * 3 -- add 3 stats per min 
        end
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    end
    return false
end

return Stats