local X = {}

local bot = GetBot()
local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )

local Tormentor = nil
local TormentorLocation = 0

local tormentorMessageTime = 0
local canDoTormentor = false

if bot.tormentor_state == nil then bot.tormentor_state = false end
if bot.tormentor_kill_time == nil then bot.tormentor_kill_time = 0 end

function GetDesire()
    return BOT_MODE_DESIRE_NONE
end

function Think()
    if GetUnitToLocationDistance(bot, TormentorLocation) > 100 then
        bot:Action_MoveToLocation(TormentorLocation)
        return
    else
        local tCreeps = bot:GetNearbyNeutralCreeps(900)
        for _, c in pairs(tCreeps) do
            if J.IsValid(c) and string.find(c:GetUnitName(), 'miniboss') then
                Tormentor = c
                if X.IsEnoughAllies() or J.GetHP(c) < 0.25 then
                    bot:Action_AttackUnit(c, true)
                    return
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

function X.IsTormentorAlive()
    if IsLocationVisible(TormentorLocation) then
        for i = 1, 5 do
            local member = GetTeamMember(i)
            if member ~= nil and member:IsAlive() then
                if GetUnitToLocationDistance(member, TormentorLocation) <= 150 then
                    local tCreeps = member:GetNearbyNeutralCreeps(800)
                    for _, c in pairs(tCreeps) do
                        if J.IsValid(c) and string.find(c:GetUnitName(), 'miniboss') then
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

function X.IsEnoughAllies()
    local nAllyCount = 0
    local nCoreCountInLoc = 0

	for i = 1, 5
    do
		local member = GetTeamMember(i)
		if member ~= nil and member:IsAlive()
		and GetUnitToLocationDistance(member, TormentorLocation) <= 900
		then
            if J.IsCore(member) then
                nCoreCountInLoc = nCoreCountInLoc + 1
            end

			nAllyCount = nAllyCount + 1
		end
	end

	return ((((bot.tormentor_kill_time == 0 and nAllyCount >= 5) or (bot.tormentor_kill_time > 0 and nAllyCount >= 3))) and nCoreCountInLoc >= 2)
end