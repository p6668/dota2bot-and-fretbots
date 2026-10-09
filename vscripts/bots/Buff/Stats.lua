dofile('bots/Buff/Helper')

if Stats == nil
then
    Stats = {}
end

-- just eyeballed
function Stats.UpdateStats(bot, godmode)
    local gameTime = Helper.DotaTime() / 60
    local unitStats = 1/60
    local KillsGap = 0
    if bot:GetTeam() == DOTA_TEAM_GOODGUYS then
        KillsGap = PlayerResource:GetTeamKills(DOTA_TEAM_BADGUYS) - PlayerResource:GetTeamKills(DOTA_TEAM_GOODGUYS)
    else
        KillsGap = PlayerResource:GetTeamKills(DOTA_TEAM_GOODGUYS) - PlayerResource:GetTeamKills(DOTA_TEAM_BADGUYS)
    end

    if gameTime >= 10 and gameTime <=20 then 
        local stat
        local bonus = unitStats * 0.5 -- add 0.5 stats per min 
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime > 20 and gameTime <=30 then 
        local stat
        local bonus = unitStats * 0.5 -- add 0.5 stats per min
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime > 30 and gameTime <=40 then
        local stat
        local bonus = unitStats * 1 -- add 1 stats per min
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime >= godmode.StartTime and godmode.enabled and godmode.done == false and KillsGap >= godmode.KillThreshold then
        local stat
        local bonus = 50 -- god mode +50 str, agi, and int instantly.
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus)
        GameRules:SendCustomMessage("<font color='#70EA71'>"..string.gsub(bot:GetUnitName(), 'npc_dota_hero_', '').."</font>"..' is in god mode. Cautious!', -1, 0)
        return true
    end
    return false
end

return Stats