dofile('bots/Buff/Helper')

if GPM == nil
then
    GPM = {}
end

-- Reasonable GPM (XPM later)
function GPM.TargetGPM(time)
    if time <= 2 then
        return 0
    elseif time <= 5 then
        return 400
    elseif time <= 10 then
        return 600
    elseif time <= 15 then
        return 800
    elseif time <= 20 then
        return 1000
    elseif time <= 25 then
        return 1200
    elseif time <= 30 then
        return 1300
    elseif time <= 40 then
        return 1400
    else
        return 1100
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

    if gameTime > 0
    then
        bot:ModifyGold(math.ceil(goldPerTick), true, 0)
    end
end

return GPM