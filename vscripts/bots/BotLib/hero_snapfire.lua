local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_snapfire'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {}
local sUtilityItem = RI.GetBestUtilityItem(sUtility)

local HeroBuild = {
    ['pos_1'] = {
        [1] = {
            ['talent'] = {
                [1] = {},
            },
            ['ability'] = {
                [1] = {},
            },
            ['buy_list'] = {},
            ['sell_list'] = {},
        },
    },
    ['pos_2'] = {
        [1] = {
            ['talent'] = {
                [1] = {
                    ['t25'] = {0, 10},
                    ['t20'] = {0, 10},
                    ['t15'] = {0, 10},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {1,2,1,3,3,6,3,3,1,1,6,2,2,2,6},
            },
            ['buy_list'] = {
                "item_double_branches",
                "item_tango",
                "item_circlet",
                "item_mantle",
                "item_enchanted_mango",
            
                "item_bottle",
                "item_magic_wand",
                "item_null_talisman",
                "item_power_treads",
                "item_maelstrom",
                "item_dragon_lance",
                "item_manta",--
                "item_mjollnir",--
                "item_black_king_bar",--
                "item_hurricane_pike",--
                "item_aghanims_shard",
                "item_greater_crit",--
                "item_moon_shard",
                "item_ultimate_scepter_2",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_manta",
                "item_null_talisman", "item_black_king_bar",
                "item_bottle", "item_greater_crit",
            },
        },
    },
    ['pos_3'] = {
        [1] = {
            ['talent'] = {
                [1] = {},
            },
            ['ability'] = {
                [1] = {},
            },
            ['buy_list'] = {},
            ['sell_list'] = {},
        },
    },
    ['pos_4'] = {
        [1] = {
            ['talent'] = {
                [1] = {
                    ['t25'] = {10, 0},
                    ['t20'] = {10, 0},
                    ['t15'] = {10, 0},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {1,2,1,2,1,6,1,2,2,3,6,3,3,3,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_blood_grenade",
                "item_magic_stick",
                "item_enchanted_mango",
            
                "item_tranquil_boots",
                "item_magic_wand",
                "item_force_staff",
                "item_ancient_janggo",
                "item_rod_of_atos",
                "item_boots_of_bearing",--
                "item_aghanims_shard",
                "item_solar_crest",--
                "item_shivas_guard",--
                "item_gungir",--
                "item_wind_waker",--
                "item_hurricane_pike",--
                "item_moon_shard",
                "item_ultimate_scepter_2",
            },
            ['sell_list'] = {
                "item_magic_wand", "item_wind_waker",
            },
        },
    },
    ['pos_5'] = {
        [1] = {
            ['talent'] = {
                [1] = {
                    ['t25'] = {10, 0},
                    ['t20'] = {10, 0},
                    ['t15'] = {10, 0},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {1,2,1,2,1,6,1,2,2,3,6,3,3,3,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_blood_grenade",
                "item_magic_stick",
                "item_enchanted_mango",
            
                "item_arcane_boots",
                "item_magic_wand",
                "item_force_staff",
                "item_mekansm",
                "item_rod_of_atos",
                "item_guardian_greaves",--
                "item_aghanims_shard",
                "item_solar_crest",--
                "item_shivas_guard",--
                "item_gungir",--
                "item_wind_waker",--
                "item_hurricane_pike",--
                "item_moon_shard",
                "item_ultimate_scepter_2",
            },
            ['sell_list'] = {
                "item_magic_wand", "item_wind_waker",
            },
        },
    },
}

local sSelectedBuild = HeroBuild[sRole][RandomInt(1, #HeroBuild[sRole])]

local nTalentBuildList = J.Skill.GetTalentBuild(J.Skill.GetRandomBuild(sSelectedBuild.talent))
local nAbilityBuildList = J.Skill.GetRandomBuild(sSelectedBuild.ability)

X['sBuyList'] = sSelectedBuild.buy_list
X['sSellList'] = sSelectedBuild.sell_list

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_antimage' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink(hMinionUnit)
    Minion.MinionThink(hMinionUnit)
end

end

local ScatterBlast      = bot:GetAbilityByName('snapfire_scatterblast')
local FiresnapCookie    = bot:GetAbilityByName('snapfire_firesnap_cookie')
local LilShredder       = bot:GetAbilityByName('snapfire_lil_shredder')
local GobbleUp          = bot:GetAbilityByName('snapfire_gobble_up')
local SpitOut           = bot:GetAbilityByName('snapfire_spit_creep')
local MortimerKisses    = bot:GetAbilityByName('snapfire_mortimer_kisses')

local ScatterBlastDesire, ScatterBlastLocation
local FiresnapCookieDesire, FiresnapCookieTarget
local LilShredderDesire
local GobbleUpDesire, GobbleUpTarget
local SpitOutDesire, SpitOutLocation
local MortimerKissesDesire, MortimerKissesLocation

function X.SkillsComplement()
	if J.CanNotUseAbility(bot) then return end

    ScatterBlast      = bot:GetAbilityByName('snapfire_scatterblast')
    FiresnapCookie    = bot:GetAbilityByName('snapfire_firesnap_cookie')
    LilShredder       = bot:GetAbilityByName('snapfire_lil_shredder')
    GobbleUp          = bot:GetAbilityByName('snapfire_gobble_up')
    SpitOut           = bot:GetAbilityByName('snapfire_spit_creep')
    MortimerKisses    = bot:GetAbilityByName('snapfire_mortimer_kisses')

    MortimerKissesDesire, MortimerKissesLocation = X.ConsiderMortimerKisses()
    if MortimerKissesDesire > 0
    then
        bot:Action_UseAbilityOnLocation(MortimerKisses, MortimerKissesLocation)
        return
    end

    LilShredderDesire = X.ConsiderLilShredder()
    if LilShredderDesire > 0
    then
        bot:Action_UseAbility(LilShredder)
        return
    end

    ScatterBlastDesire, ScatterBlastLocation = X.ConsiderScatterBlast()
    if ScatterBlastDesire > 0
    then
        bot:Action_UseAbilityOnLocation(ScatterBlast, ScatterBlastLocation)
        return
    end

    FiresnapCookieDesire, FiresnapCookieTarget = X.ConsiderFiresnapCookie()
    if FiresnapCookieDesire > 0
    then
        bot:Action_UseAbilityOnEntity(FiresnapCookie, FiresnapCookieTarget)
        return
    end

    SpitOutDesire, SpitOutLocation = X.ConsiderSpitOut()
    if SpitOutDesire > 0
    then
        bot:Action_UseAbilityOnLocation(SpitOut, SpitOutLocation)
        return
    end

    GobbleUpDesire, GobbleUpTarget = X.ConsiderGobbleUp()
    if GobbleUpDesire > 0
    then
        bot:Action_UseAbilityOnEntity(GobbleUp, GobbleUpTarget)
        return
    end
end

function X.ConsiderScatterBlast()
    if not J.CanCastAbility(ScatterBlast)
    or bot:HasModifier('modifier_snapfire_mortimer_kisses')
    then
        return BOT_ACTION_DESIRE_NONE, 0
    end

    local nCastRange = J.GetProperCastRange(false, bot, ScatterBlast:GetCastRange())
	local nCastPoint = ScatterBlast:GetCastPoint()
	local nRadius = ScatterBlast:GetSpecialValueInt('blast_width_end')
	local nDamage = ScatterBlast:GetSpecialValueInt('damage');
	local botTarget = J.GetProperTarget(bot)

    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and J.IsInRange(bot, enemyHero, nCastRange)
        and J.CanKillTarget(enemyHero, nDamage, DAMAGE_TYPE_MAGICAL)
        and not J.IsSuspiciousIllusion(enemyHero)
        and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
        and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
        and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
        and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
        and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            return BOT_ACTION_DESIRE_HIGH, enemyHero:GetExtrapolatedLocation(nCastPoint)
        end
    end

    if J.IsInTeamFight(bot, 1200)
	then
		local nLocationAoE = bot:FindAoELocation(true, true, bot:GetLocation(), nCastRange, nRadius, 0, 0)
        local nInRangeEnemy = J.GetEnemiesNearLoc(nLocationAoE.targetloc, nRadius)

		if nInRangeEnemy ~= nil and #nInRangeEnemy >= 2
		then
			return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
		end
	end

	if J.IsGoingOnSomeone(bot)
	then
		if  J.IsValidTarget(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and not J.IsSuspiciousIllusion(botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
		then
            local nInRangeAlly = botTarget:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
            local nTargetInRangeAlly = botTarget:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            then
                return BOT_ACTION_DESIRE_HIGH, botTarget:GetExtrapolatedLocation(nCastPoint)
            end
		end
	end

	if J.IsRetreating(bot)
	then
        for _, enemyHero in pairs(nEnemyHeroes)
        do
            if  J.IsValidHero(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and J.IsChasingTarget(enemyHero, bot)
            and J.CanKillTarget(enemyHero, nDamage, DAMAGE_TYPE_MAGICAL)
            and not J.IsSuspiciousIllusion(enemyHero)
            and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
            and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
            and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
            and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
            and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
            then
                return BOT_ACTION_DESIRE_HIGH, bot:GetExtrapolatedLocation(nCastPoint)
            end
        end
	end

    if  (J.IsPushing(bot) or J.IsDefending(bot))
    and not bot:HasModifier('modifier_snapfire_lil_shredder_buff')
    then
        local nLocationAoE = bot:FindAoELocation(true, false, bot:GetLocation(), nCastRange, nRadius, nCastPoint, 0)
        local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nCastRange, true)

        if  nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 4
        and nLocationAoE.count >= 4
        then
            return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
        end

        nLocationAoE = bot:FindAoELocation(true, true, bot:GetLocation(), nCastRange, nRadius, nCastPoint, 0)
        if nLocationAoE.count >= 1
        then
            return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
        end
    end

    if  J.IsFarming(bot)
    and not bot:HasModifier('modifier_snapfire_lil_shredder_buff')
    then
        local nLocationAoE = bot:FindAoELocation(true, false, bot:GetLocation(), nCastRange, nRadius, nCastPoint, 0)

        if J.IsAttacking(bot)
        then
            local nNeutralCreeps = bot:GetNearbyNeutralCreeps(nCastRange)
            if nNeutralCreeps ~= nil
            and ((#nNeutralCreeps >= 3 and nLocationAoE.count >= 3)
                or (#nNeutralCreeps >= 2 and nNeutralCreeps[1]:IsAncientCreep() and nLocationAoE.count >= 2))
            and J.GetMP(bot) > 0.33
            then
                return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
            end

            local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nCastRange, true)
            if  nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 3
            and nLocationAoE.count >= 3
            and J.GetMP(bot) > 0.37
            then
                return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
            end
        end
    end

    if  J.IsLaning(bot)
    and (J.IsCore(bot) or not J.IsCore(bot) and not J.IsThereCoreNearby(1200))
	then
        local canKill = 0
        local creepList = {}
		local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nCastRange, true)
        local nInRangeEnemy = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)

		for _, creep in pairs(nEnemyLaneCreeps)
		do
			if  J.IsValid(creep)
			and (J.IsKeyWordUnit('ranged', creep) or J.IsKeyWordUnit('siege', creep) or J.IsKeyWordUnit('flagbearer', creep))
			and creep:GetHealth() <= nDamage
            and J.CanBeAttacked(creep)
			then
				local nCreepInRangeHero = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

				if  J.IsValid(nCreepInRangeHero[1])
                and GetUnitToUnitDistance(nCreepInRangeHero[1], creep) < 500
                and J.GetMP(bot) > 0.35
				then
					return BOT_ACTION_DESIRE_HIGH, creep:GetLocation()
				end
			end

            if  J.IsValid(creep)
            and creep:GetHealth() <= nDamage
            then
                canKill = canKill + 1
                table.insert(creepList, creep)
            end
		end

        if  canKill >= 2
        and J.GetMP(bot) > 0.25
        and nInRangeEnemy ~= nil and #nInRangeEnemy >= 1
        then
            return BOT_ACTION_DESIRE_HIGH, J.GetCenterOfUnits(creepList)
        end

        if  nInRangeEnemy ~= nil and #nInRangeEnemy ~= nil
        and J.IsValidHero(nInRangeEnemy[1])
        and J.IsAttacking(nInRangeEnemy[1])
        and J.GetMP(bot) > 0.55
        and J.GetHP(bot) < J.GetHP(nInRangeEnemy[1])
        and nInRangeEnemy[1]:GetAttackTarget() == bot
        then
            return BOT_ACTION_DESIRE_HIGH, nInRangeEnemy[1]:GetLocation()
        end
	end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, 400)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
        end
    end

    return BOT_ACTION_DESIRE_NONE, 0
end

function X.ConsiderFiresnapCookie()
    if not J.CanCastAbility(FiresnapCookie)
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, FiresnapCookie:GetCastRange())
	local nCastPoint = FiresnapCookie:GetCastPoint()
	local nRadius = FiresnapCookie:GetSpecialValueInt('impact_radius')
	local nJumpDistance = FiresnapCookie:GetSpecialValueInt('jump_horizontal_distance')
    local nJumpDuration = FiresnapCookie:GetSpecialValueInt('jump_duration')
	local botTarget = J.GetProperTarget(bot)

    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and enemyHero:IsChanneling()
        and bot:IsFacingLocation(enemyHero:GetLocation(), 15)
        and not J.IsSuspiciousIllusion(enemyHero)
        then
            local nInRangeAlly = enemyHero:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
            local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

            if  J.IsInRange(bot, enemyHero, nJumpDistance + nRadius)
            and not J.IsInRange(bot, enemyHero, nJumpDistance * 0.51)
            and nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            then
                return BOT_ACTION_DESIRE_HIGH, bot
            end
        end
    end

    if J.IsStuck(bot)
	then
		return BOT_ACTION_DESIRE_HIGH, bot
	end

    if J.IsInTeamFight(bot, 1200)
	then
		local nLocationAoE = bot:FindAoELocation(true, true, bot:GetLocation(), nJumpDistance, nRadius, nJumpDuration + nCastPoint, 0)
        local nInRangeEnemy = J.GetEnemiesNearLoc(nLocationAoE.targetloc, nJumpDistance)
		local nNonStunnedEnemy = J.CountNotStunnedUnits(nInRangeEnemy, nLocationAoE, nRadius, 2)

		if  nInRangeEnemy ~= nil and #nInRangeEnemy >= 2
        and nNonStunnedEnemy >= 2
        and bot:IsFacingLocation(nLocationAoE.targetloc, 15)
		then
			return BOT_ACTION_DESIRE_LOW, bot
		end
	end

	if J.IsGoingOnSomeone(bot)
	then
        local nInRangeEnemy = bot:GetNearbyHeroes(600, true, BOT_MODE_NONE)
        for _, enemyHero in pairs(nInRangeEnemy)
        do
            if  J.IsValidHero(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.IsChasingTarget(bot, enemyHero)
            and not J.IsSuspiciousIllusion(enemyHero)
            and not J.IsDisabled(enemyHero)
            and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
            and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
            and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
            and not J.IsLocationInChrono(enemyHero:GetLocation())
            and not J.IsLocationInBlackHole(enemyHero:GetLocation())
            then
                local nInRangeAlly = enemyHero:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
                local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

                if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
                and #nInRangeAlly >= #nTargetInRangeAlly
                then
                    return BOT_ACTION_DESIRE_HIGH, bot
                end
            end
        end

        local nInRangeAlly = bot:GetNearbyHeroes(nCastRange, false, BOT_MODE_ATTACK)
        for _, allyHero in pairs(nInRangeAlly)
        do
            local allyTarget = allyHero:GetAttackTarget()

            if  J.IsValidHero(allyHero)
            and J.IsValidTarget(allyTarget)
            and J.CanCastOnNonMagicImmune(allyTarget)
            and J.IsChasingTarget(allyHero, allyTarget)
            and J.IsInRange(allyHero, allyTarget, nJumpDistance)
            and not J.IsInRange(allyHero, allyTarget, nJumpDistance / 2)
            and not allyHero:IsIllusion()
            and not J.IsSuspiciousIllusion(allyTarget)
            and not J.IsDisabled(allyTarget)
            and not allyTarget:HasModifier('modifier_abaddon_borrowed_time')
            and not allyTarget:HasModifier('modifier_dazzle_shallow_grave')
            and not allyTarget:HasModifier('modifier_necrolyte_reapers_scythe')
            and not J.IsLocationInChrono(allyTarget:GetLocation())
            and not J.IsLocationInBlackHole(allyTarget:GetLocation())
            then
                local nAllyInRangeAlly = allyTarget:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
                local nAllyTargetInRangeAlly = allyTarget:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

                if  nAllyInRangeAlly ~= nil and nAllyTargetInRangeAlly ~= nil
                and #nAllyInRangeAlly >= #nAllyTargetInRangeAlly
                then
                    return BOT_ACTION_DESIRE_HIGH, allyHero
                end
            end
        end
	end

    if J.IsRetreating(bot)
    then
        local nInRangeAlly = bot:GetNearbyHeroes(1000, false, BOT_MODE_NONE)
        local nInRangeEnemy = bot:GetNearbyHeroes(1200, true, BOT_MODE_NONE)

        if  nInRangeAlly ~= nil and nInRangeEnemy ~= nil
        and J.IsValidHero(nInRangeEnemy[1])
        and not J.IsSuspiciousIllusion(nInRangeEnemy[1])
        and not J.IsDisabled(nInRangeEnemy[1])
        then
            local nTargetInRangeAlly = nInRangeEnemy[1]:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

            if  nTargetInRangeAlly ~= nil
            and ((#nTargetInRangeAlly > #nInRangeAlly)
                or (J.GetHP(bot) < 0.65 and bot:WasRecentlyDamagedByAnyHero(1.5)))
            and bot:IsFacingLocation(J.GetEscapeLoc(), 30)
            then
		        return BOT_ACTION_DESIRE_HIGH, bot
            end
        end
    end

    local nAllyHeroes = bot:GetNearbyHeroes(1000, false, BOT_MODE_NONE)
    for _, allyHero in pairs(nAllyHeroes)
    do
        if  J.IsValidHero(allyHero)
        and J.IsStuck(allyHero)
        and not allyHero:IsIllusion()
        then
            return BOT_ACTION_DESIRE_HIGH, allyHero
        end

        local nAllyInRangeEnemy = allyHero:GetNearbyHeroes(800, true, BOT_MODE_NONE)

        if  J.IsRetreating(allyHero)
        and not allyHero:IsIllusion()
        then
            if  nAllyInRangeEnemy ~= nil and #nAllyInRangeEnemy >= 1
            and J.IsValidHero(nAllyInRangeEnemy[1])
            and J.IsInRange(bot, allyHero, nCastRange)
            and J.IsChasingTarget(nAllyInRangeEnemy[1], allyHero)
            and allyHero:IsFacingLocation(J.GetEscapeLoc(), 30)
            and not J.IsSuspiciousIllusion(nAllyInRangeEnemy[1])
            and not J.IsDisabled(nAllyInRangeEnemy[1])
            and not J.IsTaunted(nAllyInRangeEnemy[1])
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_enigma_black_hole_pull')
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_faceless_void_chronosphere_freeze')
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_necrolyte_reapers_scythe')
            then
                return BOT_ACTION_DESIRE_HIGH, allyHero
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderLilShredder()
    if not J.CanCastAbility(LilShredder)
    or bot:HasModifier('modifier_snapfire_mortimer_kisses')
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nAttackRange = bot:GetAttackRange() + LilShredder:GetSpecialValueInt('attack_range_bonus')
    local botTarget = J.GetProperTarget(bot)

	if  botTarget ~= nil
    and botTarget:IsBuilding()
    and J.IsAttacking(bot)
    then
		return BOT_ACTION_DESIRE_HIGH
	end

	if J.IsGoingOnSomeone(bot)
	then
		if  J.IsValidTarget(botTarget)
        and J.IsInRange(bot, botTarget, nAttackRange - 100)
        and J.IsAttacking(bot)
        and not J.IsSuspiciousIllusion(botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
		then
            local nInRangeAlly = botTarget:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
            local nTargetInRangeAlly = botTarget:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            then
                return BOT_ACTION_DESIRE_HIGH
            end
		end
	end

    if (J.IsPushing(bot) or J.IsDefending(bot))
    then
        local nInRangeEnemy = bot:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
        local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nAttackRange, true)
        local nEnemyTowers = bot:GetNearbyTowers(bot:GetAttackRange(), true)

        if  J.IsAttacking(bot)
        and nInRangeEnemy ~= nil and #nInRangeEnemy <= 1
        and ((nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 4)
            or (nEnemyTowers ~= nil and #nEnemyTowers >= 1))
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsFarming(bot)
    then
        if  J.IsAttacking(bot)
        and J.GetMP(bot) > 0.33
        then
            local nNeutralCreeps = bot:GetNearbyNeutralCreeps(nAttackRange)
            if  nNeutralCreeps ~= nil
            and ((#nNeutralCreeps >= 3)
                or (#nNeutralCreeps >= 2 and nNeutralCreeps[1]:IsAncientCreep()))
            then
                return BOT_ACTION_DESIRE_HIGH
            end

            local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nAttackRange, true)
            if nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 3
            then
                return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, 400)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderMortimerKisses()
    if not J.CanCastAbility(MortimerKisses)
    then
        return BOT_ACTION_DESIRE_NONE, 0
    end

    local nMinDistance = MortimerKisses:GetSpecialValueInt('min_range')

	if J.IsGoingOnSomeone(bot)
	then
        local nInRangeEnemy = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
        for _, enemyHero in pairs(nInRangeEnemy)
        do
            if  J.IsValidHero(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and not J.IsInRange(bot, enemyHero, nMinDistance)
            and not J.IsSuspiciousIllusion(enemyHero)
            then
                if J.IsLocationInChrono(enemyHero:GetLocation())
                or J.IsLocationInBlackHole(enemyHero:GetLocation())
                then
                    return BOT_ACTION_DESIRE_HIGH, enemyHero:GetLocation()
                end
            end

            if  J.IsValidHero(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and not J.IsInRange(bot, enemyHero, nMinDistance)
            and not J.IsSuspiciousIllusion(enemyHero)
            and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
            and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
            and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
            and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
            then
                local nInRangeAlly = enemyHero:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
                local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1600, false, BOT_MODE_NONE)

                if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
                and #nInRangeAlly >= #nTargetInRangeAlly
                then
                    if (#nTargetInRangeAlly >= 1 and #nTargetInRangeAlly >= 1)
                    or (#nTargetInRangeAlly == 0
                        and J.IsCore(enemyHero))
                    then
                        return BOT_ACTION_DESIRE_HIGH, enemyHero:GetLocation()
                    end
                end
            end
        end
	end

    return BOT_ACTION_DESIRE_NONE, 0
end

function X.ConsiderGobbleUp()
    if not bot:HasScepter()
    or not J.CanCastAbility(GobbleUp)
    or bot:HasModifier('modifier_snapfire_mortimer_kisses')
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

	local nCastRange = J.GetProperCastRange(false, bot, GobbleUp:GetCastRange())
    local nSpitRange = J.GetProperCastRange(false, bot, MortimerKisses:GetCastRange())
    local botTarget = J.GetProperTarget(bot)

	if J.IsGoingOnSomeone(bot)
	then
		if  J.IsValidTarget(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, nSpitRange)
        and not J.IsInRange(bot, botTarget, 600)
        and not J.IsSuspiciousIllusion(botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not J.IsLocationInChrono(botTarget:GetLocation())
        and not J.IsLocationInBlackHole(botTarget:GetLocation())
		then
			local nCreeps = bot:GetNearbyCreeps(nCastRange + 100, true)

			if nCreeps ~= nil and #nCreeps >= 1
            then
				GobledUnit = 'creep'
				return BOT_ACTION_DESIRE_HIGH, nCreeps[1]
			end
		end
	end

    local nAllyHeroes = bot:GetNearbyHeroes(1000, false, BOT_MODE_NONE)
    for _, allyHero in pairs(nAllyHeroes)
    do
        local nAllyInRangeEnemy = allyHero:GetNearbyHeroes(800, true, BOT_MODE_NONE)

        if  J.IsRetreating(allyHero)
        and allyHero:WasRecentlyDamagedByAnyHero(1.5)
        and not allyHero:IsIllusion()
        then
            if  nAllyInRangeEnemy ~= nil and #nAllyInRangeEnemy >= 1
            and J.IsValidHero(nAllyInRangeEnemy[1])
            and J.IsInRange(bot, allyHero, nCastRange)
            and J.IsInRange(allyHero, nAllyInRangeEnemy[1], 600)
            and J.IsChasingTarget(nAllyInRangeEnemy[1], allyHero)
            and not J.IsSuspiciousIllusion(nAllyInRangeEnemy[1])
            and not J.IsDisabled(nAllyInRangeEnemy[1])
            and not J.IsTaunted(nAllyInRangeEnemy[1])
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_enigma_black_hole_pull')
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_faceless_void_chronosphere_freeze')
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_necrolyte_reapers_scythe')
            then
                GobbleUp = 'hero'
                return BOT_ACTION_DESIRE_HIGH, allyHero
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderSpitOut()
    if not J.CanCastAbility(SpitOut)
    or not bot:HasModifier('modifier_snapfire_gobble_up_belly_has_unit')
    then
        return BOT_ACTION_DESIRE_NONE, 0
    end

	local nSpitRange = J.GetProperCastRange(false, bot, MortimerKisses:GetCastRange())
    local botTarget = J.GetProperTarget(bot)

	if  J.IsGoingOnSomeone(bot)
    and GobbleUp == 'creep'
	then
		if J.IsValidTarget(botTarget)
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
		end
	end

	if GobbleUp == 'hero'
    then
		return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, J.GetEscapeLoc(), nSpitRange)
	end

    return BOT_ACTION_DESIRE_NONE, 0
end

return X