local X = {}

local bot = GetBot()
local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )

local Tormentor = nil
local TormentorLocation = 0
local vWaitingLocation = 0

local tormentorMessageTime = 0
local canDoTormentor = false

if bot.tormentor_state == nil then bot.tormentor_state = false end
if bot.tormentor_kill_time == nil then bot.tormentor_kill_time = 0 end

local nCoreCountInLoc = 0
local nSuppCountInLoc = 0
local bHumanInTeam = false

function GetDesire()
    return BOT_MODE_DESIRE_NONE
end

local fNextMovementTime = 0
local fStillAlive = 0
local bTormentorAlive = false
function Think()
    if J.CanNotUseAction(bot) then return end

    if bot.tormentor_state == true and GetUnitToLocationDistance(bot, TormentorLocation) > 800 and GetUnitToLocationDistance(bot, TormentorLocation) < 1800 then
        local nLaneCreeps = bot:GetNearbyLaneCreeps(Min(1600, bot:GetAttackRange() + 300), true)
        if J.IsValid(nLaneCreeps[1])
        and J.CanBeAttacked(nLaneCreeps[1])
        then
            bot:Action_AttackUnit(nLaneCreeps[1], true)
            return
        end
    end

    if bot.tormentor_state == true and not X.IsEnoughAllies(vWaitingLocation, 1600) then
        if X.GetClosestBot() == bot and DotaTime() > fStillAlive + 15.0 then
            if GetUnitToLocationDistance(bot, TormentorLocation) <= 350 then
                local nNeutralCreeps = bot:GetNearbyNeutralCreeps(900)
                for i = #nNeutralCreeps, 1, -1 do
                    if J.IsValid(nNeutralCreeps[i]) and string.find(nNeutralCreeps[i]:GetUnitName(), 'miniboss') then
                        fStillAlive = DotaTime()
                        bTormentorAlive = true
                    end
                end
                if not bTormentorAlive then
                    bot.tormentor_kill_time = DotaTime()
                    bot.tormentor_state = false
                    bTormentorAlive = false
                end
            end

            bot:Action_MoveToLocation(TormentorLocation)
            return
        end

        if DotaTime() >= fNextMovementTime then
            bot:Action_MoveToLocation(vWaitingLocation + RandomVector(300))
            fNextMovementTime = DotaTime() + RandomFloat(0.05, 0.2)
            return
        end
    else
        if GetUnitToLocationDistance(bot, TormentorLocation) > bot:GetAttackRange() + 50 then
            bot:Action_MoveToLocation(TormentorLocation)
            return
        else
            local tCreeps = bot:GetNearbyNeutralCreeps(900)
            for _, c in pairs(tCreeps) do
                if J.IsValid(c) and string.find(c:GetUnitName(), 'miniboss') then
                    Tormentor = c
                    if GetUnitToUnitDistance(bot, c) > bot:GetAttackRange() + 50 then
                        bot:Action_MoveDirectly(TormentorLocation)
                        return
                    else
                        if X.IsEnoughAllies(TormentorLocation, 900) or J.GetHP(c) < 0.25 then
                            bot:Action_AttackUnit(c, true)
                            return
                        end
                    end

                    if J.GetFirstBotInTeam() == bot and canDoTormentor and (DotaTime() > tormentorMessageTime + 15) then
                        tormentorMessageTime = DotaTime()
                        bot:ActionImmediate_Chat("Let's try Tormentor?", false)
                        bot:ActionImmediate_Ping(c:GetLocation().x, c:GetLocation().y, true)
                        return
                    end
                end
            end
        end
    end
end

function X.IsTormentorAlive()
    if IsLocationVisible(TormentorLocation) then
        for i = 1, 5 do
            local member = GetTeamMember(i)
            if member ~= nil and member:IsAlive() then
                if GetUnitToLocationDistance(member, TormentorLocation) <= 350 then
                    local nNeutralCreeps = member:GetNearbyNeutralCreeps(900)
                    for j = #nNeutralCreeps, 1, -1 do
                        if J.IsValid(nNeutralCreeps[j]) and string.find(nNeutralCreeps[j]:GetUnitName(), 'miniboss') then
                            return true
                        end
                    end

                    member.tormentor_kill_time = DotaTime()
                end
            end
        end
	end

	return false
end

function X.IsEnoughAllies(vLocation, nRadius)
    local nAllyCount = 0
    local nCoreCountInLoc2 = 0
    local nSuppCountInLoc2 = 0
	for i = 1, 5 do
		local member = GetTeamMember(i)
		if member ~= nil and member:IsAlive() then
            if GetUnitToLocationDistance(member, vLocation) <= nRadius then
                nAllyCount = nAllyCount + 1
                if J.IsCore(member) then
                    nCoreCountInLoc2 = nCoreCountInLoc2 + 1
                else
                    nSuppCountInLoc2 = nSuppCountInLoc2 + 1
                end
            end
		end
	end

	return ((bot.tormentor_kill_time == 0 and nAllyCount >= 5)
         or (bot.tormentor_kill_time == 0 and nAllyCount >= 4 and nCoreCountInLoc2 >= 3 and nSuppCountInLoc2 >= 1)
         or (bot.tormentor_kill_time > 0 and nAllyCount >= 3))
    and nCoreCountInLoc2 >= 2
end

function X.GetClosestBot()
    local hUnitList = J.GetAlliesNearLoc(vWaitingLocation, 2800)
    local hTarget = nil
    local hTargetDistance = math.huge
    for _, unit in pairs(hUnitList) do
        if J.IsValidHero(unit) and GetUnitToLocationDistance(unit, TormentorLocation) < 2000 then
            local unitDistance = GetUnitToLocationDistance(unit, TormentorLocation)
            if hTargetDistance > unitDistance * (1 - J.GetHP(unit)) then
                hTargetDistance = unitDistance
                hTarget = unit
            end
        end
    end

    if hTarget ~= nil then
        return hTarget
    end
    return nil
end

function X.IsTeamHealthy()
	local nHealthyAlly = 0
	for i = 1, 5 do
		local member = GetTeamMember(i)
		if J.IsValid(member) and (J.GetHP(member) > 0.5 or not member:IsBot()) then
			nHealthyAlly = nHealthyAlly + 1
		end
	end

	return nHealthyAlly >= J.GetNumOfAliveHeroes(false)
end

-- just some threshold
local tTeamDamage = {}
local fThresholdChatTime = 0
function X.IsGoodRighClickDamage()
    if bot.tormentor_kill_time > 0 then return true end

    for i = 1, 5 do
		local member = GetTeamMember(i)
		if member ~= nil
        and member:CanBeSeen()
        and J.IsCore(member)
        and not J.DoesUnitHaveTemporaryBuff(member)
        then
            local memberPosition = J.GetPosition(member)
            local attackDamage = member:GetAttackDamage() * member:GetAttackSpeed()
            if memberPosition == 1 then
                attackDamage = attackDamage * 0.50
            elseif memberPosition == 2 then
                attackDamage = attackDamage * 0.25
            elseif memberPosition == 3 then
                attackDamage = attackDamage * 0.25
            end

            local id = member:GetPlayerID()
			if tTeamDamage[id] == nil then tTeamDamage[id] = 0 end
            if tTeamDamage[id] < attackDamage then
                tTeamDamage[id] = attackDamage
            end
		end
	end

    local totalAttackDamage = 0
    for _, damage in pairs(tTeamDamage) do totalAttackDamage = totalAttackDamage + damage end

    if not J.IsDoingTormentor(bot) and J.GetFirstBotInTeam() == bot and bot.tormentor_state == true and DotaTime() - fThresholdChatTime < 30 and totalAttackDamage >= 400.0 then
        bot:ActionImmediate_Chat("Tormentor threshold met..", false)
        fThresholdChatTime = DotaTime()
    end

    -- if math.floor(DotaTime()) % 5 == 0 then
    --     if GetTeam() == TEAM_RADIANT then
    --         print(bot.tormentor_team_healthy, 'RADIANT:', totalAttackDamage)
    --     else
    --         print(bot.tormentor_team_healthy, 'DIRE:', totalAttackDamage)
    --     end
    -- end

    return totalAttackDamage >= 400.0
end

local bHumanPinged = false
function X.DidHumanPingedOrAtLocation()
    local human, ping = J.GetHumanPing()
    if bot.tormentor_state == true and human and ping and not bHumanPinged then
        if J.GetDistance(ping.location, vWaitingLocation) <= 800
        or J.GetDistance(ping.location, TormentorLocation) <= 800
        then
            if GameTime() < ping.time + 15 then
                bHumanPinged = true
            end
        end
    end

    if bot.tormentor_state == false then
        bHumanPinged = false
    elseif bot.tormentor_state == true and bHumanPinged then
        return true
    end

    return false
end
