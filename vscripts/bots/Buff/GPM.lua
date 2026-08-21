dofile('bots/Buff/Helper')

if GPM == nil
then
    GPM = {}
end

-- Reasonable GPM (XPM later)
function GPM.TargetGPM(time)
    if time <= 5 then
        return 0
    elseif time <= 10 then
        return 550
    elseif time <= 15 then
        return 650
    elseif time <= 20 then
        return 750
    elseif time <= 25 then
        return 850
    elseif time <= 30 then
        return 950
    else
        return 1100
    end
end

function GPM.TargetGPMBasedOnKills(time, targetGPM, BotTotalKills)
     if time > 5 and BotTotalKills < 5 then
        return targetGPM + 50
    elseif time > 15 and BotTotalKills < 10 then
        return targetGPM + 50
    elseif time > 23 and BotTotalKills < 20 then
        return targetGPM + 100
    elseif time > 30 and BotTotalKills < 30 then
        return targetGPM + 100
    else
        return targetGPM
    end
end

function GPM.UpdateBotGold(bot, nTeam, BotTotalKills, PlayerTotalKills, godmode)
    local isCore = Helper.IsCore(bot, nTeam)
    local gameTime = Helper.DotaTime() / 60
    local targetGPM = GPM.TargetGPM(gameTime)

    -- Set GPM based on team kills
    targetGPM = GPM.TargetGPMBasedOnKills(gameTime, targetGPM, BotTotalKills)

    -- Support will have lower GPM than cores
    if not isCore and targetGPM > 0 then
        targetGPM = targetGPM - 200
    end

    if godmode.DifficultyMode == 0 then
        targetGPM = targetGPM - 100
    elseif godmode.DifficultyMode == 1 then
        targetGPM = targetGPM
    elseif godmode.DifficultyMode == 2 then
        targetGPM = targetGPM + 100
    end

    local currentGPM = PlayerResource:GetGoldPerMin(bot:GetPlayerID())
    local expected = targetGPM * gameTime
    local actual = currentGPM * gameTime
    local missing = expected - actual
    local goldPerTick = math.max(1, missing / 60)

    if gameTime > 0
    then
        bot:ModifyGold(math.ceil(goldPerTick), true, 0)
    end
end

return GPM