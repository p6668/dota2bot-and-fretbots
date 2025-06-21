local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_pangolier'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {"item_lotus_orb", "item_crimson_guard", "item_pipe", "item_heavens_halberd"}
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
                    ['t25'] = {10, 0},
                    ['t20'] = {10, 0},
                    ['t15'] = {10, 0},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {2,1,2,1,1,6,1,2,2,3,6,3,3,3,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_quelling_blade",
                "item_faerie_fire",
            
                "item_bottle",
                "item_magic_wand",
                "item_arcane_boots",
                "item_diffusal_blade",
                "item_blink",
                "item_ultimate_scepter",
                "item_aghanims_shard",
                "item_basher",
                "item_octarine_core",--
                "item_disperser",--
                "item_shivas_guard",--
                "item_ultimate_scepter_2",
                "item_overwhelming_blink",--
                "item_abyssal_blade",--
                "item_moon_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_quelling_blade", "item_ultimate_scepter",
                "item_magic_wand", "item_basher",
                "item_bottle", "item_octarine_core",
            },
        },
    },
    ['pos_3'] = {
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
                [1] = {2,1,3,2,2,6,2,1,1,1,6,3,3,3,6},
            },
            ['buy_list'] = {
                "item_quelling_blade",
                "item_tango",
                "item_double_branches",
            
                "item_magic_wand",
                "item_arcane_boots",
                "item_soul_ring",
                "item_diffusal_blade",
                "item_blink",
                "item_assault",--
                "item_ultimate_scepter",
                "item_aghanims_shard",
                "item_disperser",--
                "item_shivas_guard",--
                "item_abyssal_blade",--
                "item_ultimate_scepter_2",
                "item_overwhelming_blink",--
                "item_moon_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_quelling_blade", "item_assault",
                "item_magic_wand", "item_ultimate_scepter",
                "item_soul_ring", "item_shivas_guard",
            },
        },
    },
    ['pos_4'] = {
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
    ['pos_5'] = {
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
}

local sSelectedBuild = HeroBuild[sRole][RandomInt(1, #HeroBuild[sRole])]

local nTalentBuildList = J.Skill.GetTalentBuild(J.Skill.GetRandomBuild(sSelectedBuild.talent))
local nAbilityBuildList = J.Skill.GetRandomBuild(sSelectedBuild.ability)

X['sBuyList'] = sSelectedBuild.buy_list
X['sSellList'] = sSelectedBuild.sell_list

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_mid' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink( hMinionUnit )

	if Minion.IsValidUnit( hMinionUnit )
	then
		Minion.IllusionThink( hMinionUnit )
	end
end

end

local Swashbuckle       = bot:GetAbilityByName('pangolier_swashbuckle')
local ShieldCrash       = bot:GetAbilityByName('pangolier_shield_crash')
-- local LuckyShot         = bot:GetAbilityByName('pangolier_luckyshot')
local RollUp            = bot:GetAbilityByName('pangolier_rollup')
local EndRollUp         = bot:GetAbilityByName('pangolier_rollup_stop')
local RollingThunder    = bot:GetAbilityByName('pangolier_gyroshell')
local EndRollingThunder    = bot:GetAbilityByName('pangolier_gyroshell_stop')

local SwashbuckleDesire, SwashbuckleLocation
local ShieldCrashDesire
local RollUpDesire
local EndRollUpDesire
local RollingThunderDesire
local EndRollingThunderDesire

function X.SkillsComplement()
    if J.CanNotUseAbility(bot) then return end

    Swashbuckle       = bot:GetAbilityByName('pangolier_swashbuckle')
    ShieldCrash       = bot:GetAbilityByName('pangolier_shield_crash')
    RollUp            = bot:GetAbilityByName('pangolier_rollup')
    EndRollUp         = bot:GetAbilityByName('pangolier_rollup_stop')
    RollingThunder    = bot:GetAbilityByName('pangolier_gyroshell')
    EndRollingThunder    = bot:GetAbilityByName('pangolier_gyroshell_stop')

    EndRollUpDesire = X.ConsiderEndRollUp()
    if EndRollUpDesire > 0
    then
        bot:Action_UseAbility(EndRollUp)
        return
    end

    RollUpDesire = X.ConsiderRollUp()
    if RollUpDesire > 0
    then
        bot:Action_UseAbility(RollUp)
        return
    end

    EndRollingThunderDesire = X.ConsiderEndRollingThunder()
    if EndRollingThunderDesire > 0
    then
        bot:Action_UseAbility(EndRollingThunder)
        return
    end

    RollingThunderDesire = X.ConsiderRollingThunder()
    if RollingThunderDesire > 0
    then
        bot:Action_UseAbility(RollingThunder)
        return
    end

    ShieldCrashDesire = X.ConsiderShieldCrash()
    if ShieldCrashDesire > 0
    then
        bot:Action_UseAbility(ShieldCrash)
        return
    end

    SwashbuckleDesire, SwashbuckleLocation = X.ConsiderSwashbuckle()
    if SwashbuckleDesire > 0
    then
        bot:Action_UseAbilityOnLocation(Swashbuckle, SwashbuckleLocation)
        return
    end
end

function X.ConsiderSwashbuckle()
    if not J.CanCastAbility(Swashbuckle)
    or bot:HasModifier('modifier_pangolier_gyroshell')
    or bot:HasModifier('modifier_pangolier_swashbuckle_stunned')
    then
        return BOT_ACTION_DESIRE_NONE, 0
    end

	local nDashRange = Swashbuckle:GetSpecialValueInt('dash_range')
    local nSwashRange = Swashbuckle:GetSpecialValueInt('range')
	local nRadius = 140
    local nDamage = Swashbuckle:GetSpecialValueInt('damage')
    local nStrikeCount = Swashbuckle:GetSpecialValueInt('strikes')
    local botTarget = J.GetProperTarget(bot)

    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if J.IsValidHero(enemyHero)
        and J.CanKillTarget(enemyHero, nDamage * nStrikeCount, DAMAGE_TYPE_PHYSICAL)
        and not J.IsSuspiciousIllusion(enemyHero)
        and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
        and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
        and not enemyHero:HasModifier('modifier_enigma_black_hole_pull')
        and not enemyHero:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
        and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            if bot:IsFacingLocation(enemyHero:GetLocation(), 5)
            then
                if J.IsInRange(bot, enemyHero, nDashRange)
                then
                    return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
                end

                if  J.IsInRange(bot, enemyHero, nDashRange + nSwashRange)
                and not J.IsInRange(bot, enemyHero, nDashRange)
                and not enemyHero:HasModifier('modifier_faceless_void_chronosphere_freeze')
                then
                    return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, enemyHero:GetLocation(), nDashRange)
                end
            end
        end
    end

	if J.IsStuck(bot)
	then
		local loc = J.GetEscapeLoc()
		return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, loc, nDashRange)
	end

    if J.IsGoingOnSomeone(bot)
    then
        local weakestTarget = J.GetVulnerableWeakestUnit(bot, true, true, 1200)
        local nInRangeAlly = bot:GetNearbyHeroes(1000, false, BOT_MODE_NONE)

        if  J.IsValidTarget(weakestTarget)
        and not J.IsSuspiciousIllusion(weakestTarget)
        and not weakestTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not weakestTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not weakestTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        then
            local nTargetInRangeAlly = weakestTarget:GetNearbyHeroes(800, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            and bot:IsFacingLocation(weakestTarget:GetLocation(), 5)
            then
                if J.IsInRange(bot, weakestTarget, nDashRange)
                then
                    if #nInRangeAlly >= #nTargetInRangeAlly + 2
                    then
                        return BOT_ACTION_DESIRE_HIGH, weakestTarget:GetLocation()
                    else
                        return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
                    end
                end

                if  J.IsInRange(bot, weakestTarget, nDashRange + nSwashRange)
                and not J.IsInRange(bot, weakestTarget, nDashRange)
                and not weakestTarget:HasModifier('modifier_faceless_void_chronosphere_freeze')
                then
                    return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, weakestTarget:GetLocation(), nDashRange)
                end
            end
        end
    end

    if J.IsRetreating(bot)
    then
        local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)
        local nInRangeEnemy = bot:GetNearbyHeroes(1000, true, BOT_MODE_NONE)

        if  nInRangeAlly ~= nil and nInRangeEnemy
        and J.IsValidHero(nInRangeEnemy[1])
        and not J.IsSuspiciousIllusion(nInRangeEnemy[1])
        and not J.IsDisabled(nInRangeEnemy[1])
        and not nInRangeEnemy[1]:HasModifier('modifier_enigma_black_hole_pull')
        and not nInRangeEnemy[1]:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not nInRangeEnemy[1]:HasModifier('modifier_legion_commander_duel')
        and not nInRangeEnemy[1]:HasModifier('modifier_necrolyte_reapers_scythe')
        then
            local nTargetInRangeAlly = nInRangeEnemy[1]:GetNearbyHeroes(1000, false, BOT_MODE_NONE)

            if  nTargetInRangeAlly ~= nil
            and ((#nTargetInRangeAlly > #nInRangeAlly)
                or (J.GetHP(bot) < 0.68 and bot:WasRecentlyDamagedByAnyHero(1.6)))
            then
                local loc = J.GetEscapeLoc()
		        return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, loc, nDashRange)
            end
        end
    end

    if (J.IsPushing(bot) or J.IsDefending(bot))
    then
        local nLocationAoE = bot:FindAoELocation(true, false, bot:GetLocation(), nSwashRange, nRadius, 0, 0)
        local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nSwashRange, true)
        local nInRangeEnemy = bot:GetNearbyHeroes(1200, true, BOT_MODE_NONE)

        if  nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 4
        and nLocationAoE.count >= 4
        and nInRangeEnemy ~= nil and #nInRangeEnemy == 0
        and bot:IsFacingLocation(nLocationAoE.targetloc, 10)
        then
            return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
        end

        nLocationAoE = bot:FindAoELocation(true, true, bot:GetLocation(), nSwashRange, nRadius, 0, 0)
        if  nLocationAoE.count >= 1
        and bot:IsFacingLocation(nLocationAoE.targetloc, 10)
        then
            return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
        end
    end

    if  J.IsFarming(bot)
    and J.GetMP(bot) > 0.33
    then
        local nLocationAoE = bot:FindAoELocation(true, false, bot:GetLocation(), nSwashRange, nRadius, 0, 0)

        local nNeutralCreeps = bot:GetNearbyNeutralCreeps(nSwashRange)
        if nNeutralCreeps ~= nil
        and ((#nNeutralCreeps >= 3 and nLocationAoE.count >= 3)
            or (#nNeutralCreeps >= 2 and nNeutralCreeps[1]:IsAncientCreep() and nLocationAoE.count >= 2))
        and bot:IsFacingLocation(nLocationAoE.targetloc, 10)
        then
            return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
        end

        local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nSwashRange, true)
        if  nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 3
        and nLocationAoE.count >= 3
        and bot:IsFacingLocation(nLocationAoE.targetloc, 10)
        then
            return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
        end
    end

    if  J.IsLaning(bot)
    and J.GetMP(bot) > 0.33
	then
        local canKill = 0
        local nInRangeEnemy = bot:GetNearbyHeroes(800, true, BOT_MODE_NONE)
        local nCreepRange = nDashRange + nSwashRange

        if nCreepRange > 1600 then nCreepRange = 1600 end

        local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nCreepRange, true)

		for _, creep in pairs(nEnemyLaneCreeps)
		do
			if  J.IsValid(creep)
			and (J.IsKeyWordUnit('ranged', creep) or J.IsKeyWordUnit('siege', creep) or J.IsKeyWordUnit('flagbearer', creep))
			and creep:GetHealth() <= nDamage * nStrikeCount
            and bot:IsFacingLocation(creep:GetLocation(), 10)
            and J.CanBeAttacked(creep)
			then
				local nCreepInRangeHero = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

				if  J.IsValid(nCreepInRangeHero[1])
                and GetUnitToUnitDistance(nCreepInRangeHero[1], creep) < 500
				then
                    if J.IsInRange(bot, creep, nDashRange)
                    then
                        return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
                    end

                    if  J.IsInRange(bot, creep, nDashRange + nSwashRange)
                    and not J.IsInRange(bot, creep, nDashRange)
                    then
                        return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, creep:GetLocation(), nDashRange)
                    end
				end

				if  J.IsValid(nCreepInRangeHero[1])
                and GetUnitToUnitDistance(nCreepInRangeHero[1], creep) < nRadius
                then
                    if J.IsInRange(bot, creep, nDashRange)
                    then
                        return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
                    end
                end
			end

            if  J.IsValid(creep)
            and creep:GetHealth() <= nDamage * nStrikeCount
            then
                canKill = canKill + 1
            end
		end

        local nLocationAoE = bot:FindAoELocation(true, false, bot:GetLocation(), 1000, nRadius, 0, 0)

        if  canKill >= 2
        and nInRangeEnemy ~= nil and #nInRangeEnemy >= 1
        and nLocationAoE.count >= 2
        and bot:IsFacingLocation(nLocationAoE.targetloc, 5)
        then
            if GetUnitToLocationDistance(bot, nLocationAoE.targetloc) <= nDashRange
            then
                return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
            end

            if  GetUnitToLocationDistance(bot, nLocationAoE.targetloc) <= nDashRange + nSwashRange
            and not (GetUnitToLocationDistance(bot, nLocationAoE.targetloc) <= nDashRange)
            then
                return BOT_ACTION_DESIRE_HIGH, J.Site.GetXUnitsTowardsLocation(bot, nLocationAoE.targetloc, nDashRange)
            end
        end
	end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        and bot:IsFacingLocation(botTarget:GetLocation(), 10)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, 400)
        and J.IsAttacking(bot)
        and bot:IsFacingLocation(botTarget:GetLocation(), 10)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
        end
    end

    return BOT_ACTION_DESIRE_NONE, 0
end

function X.ConsiderShieldCrash()
    if not J.CanCastAbility(ShieldCrash)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nRadius = ShieldCrash:GetSpecialValueInt('radius')
    local nDamage = ShieldCrash:GetSpecialValueInt('damage')
    local nAbilityLevel = ShieldCrash:GetLevel()
    local botTarget = J.GetProperTarget(bot)

    if J.IsStuck(bot)
	then
		return BOT_ACTION_DESIRE_HIGH
	end

    if bot:HasModifier('modifier_pangolier_rollup')
    then
        local realEnemyCount = J.GetEnemiesNearLoc(bot:GetLocation(), nRadius)

        if realEnemyCount ~= nil and #realEnemyCount >= 2
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsInTeamFight(bot, 1200)
    then
        local realEnemyCount = J.GetEnemiesNearLoc(bot:GetLocation(), nRadius)

        if  realEnemyCount ~= nil and #realEnemyCount >= 2
        and not bot:HasModifier('modifier_pangolier_gyroshell')
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsGoingOnSomeone(bot)
    then
        local weakestTarget = J.GetVulnerableWeakestUnit(bot, true, true, nRadius)
        local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)

        if  J.IsValidTarget(weakestTarget)
        and bot:HasModifier('modifier_pangolier_gyroshell')
        and bot:IsFacingLocation(weakestTarget:GetLocation(), 5)
        then
            return BOT_ACTION_DESIRE_HIGH
        end

        if  J.IsValidTarget(weakestTarget)
        and not J.IsSuspiciousIllusion(weakestTarget)
        and not weakestTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not weakestTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not weakestTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not weakestTarget:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            local nTargetInRangeAlly = weakestTarget:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            and bot:IsFacingLocation(weakestTarget:GetLocation(), 30)
            then
                return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    if J.IsRetreating(bot)
    then
        local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)
        local nInRangeEnemy = bot:GetNearbyHeroes(1000, true, BOT_MODE_NONE)

        if  nInRangeAlly ~= nil and nInRangeEnemy
        and J.IsValidHero(nInRangeEnemy[1])
        and not J.IsSuspiciousIllusion(nInRangeEnemy[1])
        and not nInRangeEnemy[1]:HasModifier('modifier_enigma_black_hole_pull')
        and not nInRangeEnemy[1]:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not nInRangeEnemy[1]:HasModifier('modifier_legion_commander_duel')
        and not nInRangeEnemy[1]:HasModifier('modifier_necrolyte_reapers_scythe')
        then
            local nTargetInRangeAlly = nInRangeEnemy[1]:GetNearbyHeroes(1000, false, BOT_MODE_NONE)

            if  nTargetInRangeAlly ~= nil
            and ((#nTargetInRangeAlly > #nInRangeAlly)
                or (J.GetHP(bot) < 0.68 and bot:WasRecentlyDamagedByAnyHero(1.6)))
            and bot:IsFacingLocation(J.GetEscapeLoc(), 30)
            then
		        return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    if (J.IsPushing(bot) or J.IsDefending(bot))
    then
        local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nRadius, true)

        if J.IsAttacking(bot)
        then
            if  nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 4
            and bot:IsFacingLocation(nEnemyLaneCreeps[1]:GetLocation(), 30)
            then
                return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    if  J.IsFarming(bot)
    and J.GetMP(bot) > 0.33
    and nAbilityLevel >= 2
    then
        if J.IsAttacking(bot)
        then
            local nNeutralCreeps = bot:GetNearbyNeutralCreeps(nRadius)
            if nNeutralCreeps ~= nil
            and ((#nNeutralCreeps >= 3)
                or (#nNeutralCreeps >= 2 and nNeutralCreeps[1]:IsAncientCreep()))
            and bot:IsFacingLocation(nNeutralCreeps[1]:GetLocation(), 15)
            then
                return BOT_ACTION_DESIRE_HIGH
            end

            local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nRadius, true)
            if  nEnemyLaneCreeps ~= nil and #nEnemyLaneCreeps >= 3
            and bot:IsFacingLocation(nEnemyLaneCreeps[1]:GetLocation(), 15)
            then
                return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    if J.IsLaning(bot)
	then
        local canKill = 0
        local creepList = {}
		local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nRadius, true)
        local nInRangeEnemy = bot:GetNearbyHeroes(800, true, BOT_MODE_NONE)

		for _, creep in pairs(nEnemyLaneCreeps)
		do
			if  J.IsValid(creep)
			and (J.IsKeyWordUnit('ranged', creep) or J.IsKeyWordUnit('siege', creep) or J.IsKeyWordUnit('flagbearer', creep))
			and creep:GetHealth() <= nDamage
			then
				local nCreepInRangeHero = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

				if  J.IsValid(nCreepInRangeHero[1])
                and GetUnitToUnitDistance(nCreepInRangeHero[1], creep) < 500
                and botTarget ~= creep
                and J.GetMP(bot) > 0.33
                and bot:IsFacingLocation(creep:GetLocation(), 15)
				then
					return BOT_ACTION_DESIRE_HIGH
				end
			end

            if  J.IsValid(creep)
            and creep:GetHealth() <= nDamage
            then
                if  J.GetMP(bot) > 0.33
                and bot:IsFacingLocation(creep:GetLocation(), 15)
                and not J.IsInRange(bot, creep, bot:GetAttackRange())
                and not J.IsAttacking(bot)
                then
                    return BOT_ACTION_DESIRE_HIGH
                end

                canKill = canKill + 1
                table.insert(creepList, creep)
            end
		end

        if  canKill >= 2
        and J.GetMP(bot) > 0.25
        and nInRangeEnemy ~= nil and #nInRangeEnemy >= 1
        and bot:IsFacingLocation(J.GetCenterOfUnits(creepList), 15)
        then
            return BOT_ACTION_DESIRE_HIGH
        end

        if  nInRangeEnemy ~= nil and #nInRangeEnemy >= 1
        and bot:IsFacingLocation(nInRangeEnemy[1]:GetLocation(), 15)
        and J.IsInRange(bot, nInRangeEnemy[1], nRadius)
        then
            local nTargetInRangeTowers = nInRangeEnemy[1]:GetNearbyTowers(700, false)

            if nTargetInRangeTowers ~= nil and #nTargetInRangeTowers == 0
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
        and bot:IsFacingLocation(botTarget:GetLocation(), 15)
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, 400)
        and J.IsAttacking(bot)
        and bot:IsFacingLocation(botTarget:GetLocation(), 15)
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderRollingThunder()
    if not J.CanCastAbility(RollingThunder)
    or bot:HasModifier('modifier_bloodseeker_rupture')
    then
        return BOT_ACTION_DESIRE_NONE
    end

    if J.IsInTeamFight(bot, 1200)
	then
        local realEnemyCount = J.GetEnemiesNearLoc(bot:GetLocation(), 1200)

        if realEnemyCount ~= nil and #realEnemyCount >= 2
        then
            return BOT_ACTION_DESIRE_HIGH
        end
	end

    if J.IsRetreating(bot)
    then
        local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)
        local nInRangeEnemy = bot:GetNearbyHeroes(1000, true, BOT_MODE_NONE)

        if  nInRangeAlly ~= nil and nInRangeEnemy
        and J.IsValidHero(nInRangeEnemy[1])
        and J.IsRunning(nInRangeEnemy[1])
        and nInRangeEnemy[1]:IsFacingLocation(bot:GetLocation(), 30)
        and not J.IsSuspiciousIllusion(nInRangeEnemy[1])
        then
            local nTargetInRangeAlly = nInRangeEnemy[1]:GetNearbyHeroes(1000, false, BOT_MODE_NONE)

            if  nTargetInRangeAlly ~= nil
            and ((#nTargetInRangeAlly > #nInRangeAlly)
            and (J.GetHP(bot) < 0.55 and bot:WasRecentlyDamagedByAnyHero(2)))
            then
		        return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderEndRollingThunder()
    if not J.CanCastAbility(EndRollingThunder)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nInRangeEnemy = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

    if nInRangeEnemy ~= nil and #nInRangeEnemy == 0
    then
        return BOT_ACTION_DESIRE_HIGH
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderRollUp()
    if not J.CanCastAbility(RollUp)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    if J.IsUnitTargetProjectileIncoming(bot, 400)
	then
		return BOT_ACTION_DESIRE_HIGH
	end

	if  not bot:HasModifier('modifier_sniper_assassinate')
	and not bot:IsMagicImmune()
	then
		if J.IsWillBeCastUnitTargetSpell(bot, 1400)
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

    if J.IsInTeamFight(bot, 1200)
    then
        local realEnemyCount = J.GetEnemiesNearLoc(bot:GetLocation(), 800)

        if realEnemyCount ~= nil and #realEnemyCount >= 3
        then
            return BOT_ACTION_DESIRE_HIGH
        end

        local weakestTarget = J.GetVulnerableWeakestUnit(bot, true, true, 1200)

        if  J.IsValidTarget(weakestTarget)
        and not J.IsSuspiciousIllusion(weakestTarget)
        then
            if  bot:HasModifier('modifier_pangolier_gyroshell')
            and not bot:IsFacingLocation(weakestTarget:GetLocation(), 90)
            then
                return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderEndRollUp()
    if not J.CanCastAbility(EndRollUp)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    if J.IsInTeamFight(bot, 1200)
    then
        local weakestTarget = J.GetVulnerableWeakestUnit(bot, true, true, 1200)

        if  J.IsValidTarget(weakestTarget)
        and not J.IsSuspiciousIllusion(weakestTarget)
        then
            if bot:HasModifier('modifier_pangolier_roll')
            and bot:IsFacingLocation(weakestTarget:GetLocation(), 15)
            then
                return BOT_ACTION_DESIRE_HIGH
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

return X