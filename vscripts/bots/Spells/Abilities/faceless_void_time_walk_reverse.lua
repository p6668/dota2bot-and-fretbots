local bot
local J = require(GetScriptDirectory()..'/FunLib/jmz_func')
local X = {}

local TimeWalkReverse

function X.Cast()
    bot = GetBot()
    TimeWalkReverse = bot:GetAbilityByName('faceless_void_time_walk_reverse')

    Desire = X.Consider()
    if Desire > 0
    then
        J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbility(TimeWalkReverse)
        return
    end
end

function X.Consider()
    if not TimeWalkReverse:IsTrained()
	or not TimeWalkReverse:IsFullyCastable()
	or not TimeWalkReverse:IsActivated()
	then
		return BOT_ACTION_DESIRE_NONE
	end

    local botTarget = J.GetProperTarget(bot)

	if J.IsStunProjectileIncoming(bot, 350)
	or J.IsUnitTargetProjectileIncoming(bot, 350)
    then
        return BOT_ACTION_DESIRE_HIGH
    end

	if  not bot:HasModifier('modifier_sniper_assassinate')
	and not bot:IsMagicImmune()
	then
		if J.IsWillBeCastUnitTargetSpell(bot, 350)
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	if  not bot:HasModifier('modifier_faceless_void_chronosphere_speed')
	and J.IsValidTarget(botTarget)
	and J.IsInRange(bot, botTarget, 1600)
	and not J.IsSuspiciousIllusion(botTarget)
	then
		local nInRangeAlly = botTarget:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
		local nInRangeEnemy = botTarget:GetNearbyHeroes(1600, false, BOT_MODE_NONE)

		if nInRangeAlly ~= nil and nInRangeEnemy ~= nil
		then
			if  #nInRangeEnemy > #nInRangeAlly
			and GetUnitToLocationDistance(bot, bot.TimeWalkPrevLocation) > GetUnitToLocationDistance(botTarget, bot.TimeWalkPrevLocation)
			and GetUnitToLocationDistance(bot, bot.TimeWalkPrevLocation) > GetUnitToUnitDistance(bot, botTarget)
			then
				return BOT_ACTION_DESIRE_HIGH
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE
end

return X