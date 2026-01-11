dofile('bots/Buff/Helper')

if GPM == nil
then
    GPM = {}
end

-- Reasonable GPM (XPM later)
function GPM.TargetGPM(time)
    -- if time <= 10 * 60 then
    --     return 450
    -- elseif time <= 20 * 60 then
    --     return 600
    -- elseif time <= 30 * 60 then
    --     return 750
    -- else
    --     return RandomInt(900, 1000)
    -- end
    if time <= 5 then
        return 800
    elseif time <= 10 then
        return 900
    elseif time <= 15 then
        return 1000
    elseif time <= 20 then
        return 1100
    elseif time <= 25 then
        return 1200
    elseif time <= 30 then
        return 1300
    else
        return 1400
    end
end

function GPM.UpdateBotGold(bot, nTeam)
    local isCore = Helper.IsCore(bot, nTeam)
    local gameTime = Helper.DotaTime() / 60
    local targetGPM = GPM.TargetGPM(gameTime)

    local currentGPM = PlayerResource:GetGoldPerMin(bot:GetPlayerID())
    local expected = targetGPM * gameTime
    local actual = currentGPM * gameTime
    local missing = expected - actual
    local goldPerTick = math.max(1, missing / 60)

    -- Give Supports "passive" Philosopher's stone
    -- Juice up cores more
    -- local nAdd = 2.5
    -- if not isCore
    -- then
    --     nAdd = 75 / 60
    --     goldPerTick = 0
    -- end

    if gameTime > 0
    then
        bot:ModifyGold(math.ceil(goldPerTick), true, 0)
    end
end

return GPM