dofile('bots/Buff/Helper')

if Stats == nil
then
    Stats = {}
end

local function GetBotPlayerID(bot)
    local playerCount = PlayerResource:GetPlayerCount()
    for playerID = 0, playerCount - 1 do
        local player = PlayerResource:GetPlayer(playerID)
        if player and player:GetAssignedHero() == bot then
            return playerID
        end
    end
    return nil
end

local SEMI_GOD_DURATION = 30
local SEMI_GOD_COOLDOWN = 600 -- 10 minutes in seconds

-- starts at 20, +10 per every 10 minutes of game time
local function GetSemiGodBuff(gameTime)
    return 20 + math.floor(gameTime / 10) * 10
end

function Stats.CheckSemiGodMode(bot, semigodmode, godmode)
    if not semigodmode.enabled then return end

    local now = GameRules:GetGameTime()

    -- Expire active buff and revert stats
    if bot.semigodmode_active and now >= bot.semigodmode_end_time then
        local applied = bot.semigodmode_buff_applied
        bot:SetBaseStrength(bot:GetBaseStrength() - applied)
        bot:SetBaseAgility(bot:GetBaseAgility() - applied)
        bot:SetBaseIntellect(bot:GetBaseIntellect() - applied)
        bot.semigodmode_active = false
        bot.semigodmode_buff_applied = nil
        bot.semigodmode_cooldown_end = now + SEMI_GOD_COOLDOWN
    end

    if godmode.done then return end

    -- Don't stack — skip if buff is already running
    if bot.semigodmode_active then return end

    -- Skip if on cooldown
    if bot.semigodmode_cooldown_end and now < bot.semigodmode_cooldown_end then return end

    -- Time threshold (in minutes)
    local gameTime = Helper.DotaTime() / 60
    if gameTime < semigodmode.StartTime then return end

    -- Kill/death deficit for this bot
    local playerID = GetBotPlayerID(bot)
    if not playerID then return end
    local deaths = PlayerResource:GetDeaths(playerID)
    local kills  = PlayerResource:GetKills(playerID)
    if (deaths - kills) <= 10 then return end

    -- Bot must be under attack
    local bBeingAttacked = false
    local hEnemies = FindUnitsInRadius(
        bot:GetTeam(), bot:GetAbsOrigin(), nil, 1200,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_COURIER,
        DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false
    )
    for _, enemy in pairs(hEnemies) do
        if enemy:IsAlive() and enemy:GetAttackTarget() == bot then
            bBeingAttacked = true
            break
        end
    end
    if not bBeingAttacked then return end

    -- No allied heroes within 2000 radius
    local hAllies = FindUnitsInRadius(
        bot:GetTeam(), bot:GetAbsOrigin(), nil, 2000,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false
    )
    for _, ally in pairs(hAllies) do
        if ally ~= bot and ally:IsAlive() and ally:IsHero() then
            return
        end
    end

    -- 5% chance to trigger
    if RandomInt(1, 100) > 5 then return end

    -- Apply semi-god mode (buff scales with game time)
    local buff = GetSemiGodBuff(gameTime)
    bot:SetBaseStrength(bot:GetBaseStrength() + buff)
    bot:SetBaseAgility(bot:GetBaseAgility() + buff)
    bot:SetBaseIntellect(bot:GetBaseIntellect() + buff)
    bot.semigodmode_active      = true
    bot.semigodmode_buff_applied = buff
    bot.semigodmode_end_time    = now + SEMI_GOD_DURATION

    GameRules:SendCustomMessage(
        "<font color='#FFD700'>"..string.gsub(bot:GetUnitName(), 'npc_dota_hero_', '').."</font> entered semi-god mode for 30s!",
        -1, 0
    )
    Say(bot, "I can do this all day.", false)
end

-- just eyeballed
function Stats.UpdateStats(bot, nTeam, BotTotalKills, PlayerTotalKills, godmode, semigodmode)
    local gameTime = Helper.DotaTime() / 60
    local botPos = Helper.GetPosition(bot, nTeam)
    local unitStats = 1/60

    Stats.CheckSemiGodMode(bot, semigodmode, godmode)

    if gameTime >= 10 and gameTime <=30 then
        local stat
        local bonus = unitStats * 1.3 -- add 1 stats per min
        stat = bot:GetBaseStrength()
        bot:SetBaseStrength(stat + bonus)
        stat = bot:GetBaseAgility()
        bot:SetBaseAgility(stat + bonus)
        stat = bot:GetBaseIntellect()
        bot:SetBaseIntellect(stat + bonus * 0.1) -- reduce int stats bonus due to 7.33 update giving magic resist
        return false
    elseif gameTime > 30 and gameTime <=40 then
        local stat
        local bonus = unitStats * 1.5 -- add 1.5 stats per min
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
        local bonus = unitStats * 2 -- add 2 stats per min
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
