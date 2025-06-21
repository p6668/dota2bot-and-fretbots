local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_ancient_apparition'
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
					['t20'] = {10, 0},
					['t15'] = {0, 10},
					['t10'] = {0, 10},
				},
            },
            ['ability'] = {
                [1] = {3,1,3,2,3,6,3,2,2,2,6,1,1,1,6},
                [2] = {3,2,3,1,3,6,3,2,1,2,6,1,2,1,6},
            },
            ['buy_list'] = {
				"item_double_branches",
				"item_tango",
				"item_double_circlet",
                "item_faerie_fire",
	
				"item_bottle",
				"item_magic_wand",
				"item_power_treads",
				"item_double_null_talisman",
				"item_witch_blade",
                "item_force_staff",
				"item_ultimate_scepter",
				"item_black_king_bar",--
                "item_aghanims_shard",
				"item_devastator",--
                "item_revenants_brooch",--
				"item_hurricane_pike",--
				"item_bloodthorn",--
				"item_ultimate_scepter_2",
				"item_moon_shard",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_magic_wand", "item_force_staff",
				"item_null_talisman", "item_ultimate_scepter",
                "item_null_talisman", "item_black_king_bar",
				"item_bottle", "item_revenants_brooch",
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
					['t20'] = {0, 10},
					['t15'] = {0, 10},
					['t10'] = {10, 0},
				},
            },
            ['ability'] = {
                [1] = {3,1,2,2,2,6,2,1,1,1,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_faerie_fire",
				"item_blood_grenade",
                "item_magic_stick",
	
				"item_tranquil_boots",
				"item_magic_wand",
				"item_glimmer_cape",--
                "item_rod_of_atos",
                "item_ancient_janggo",
				"item_aghanims_shard",
				"item_boots_of_bearing",--
				"item_sheepstick",--
				"item_wind_waker",--
				"item_lotus_orb",--
				"item_moon_shard",
				"item_gungir",--
				"item_ultimate_scepter_2",
			},
            ['sell_list'] = {
				"item_magic_wand", "item_lotus_orb",
			},
        },
    },
    ['pos_5'] = {
        [1] = {
            ['talent'] = {
				[1] = {
					['t25'] = {10, 0},
					['t20'] = {0, 10},
					['t15'] = {0, 10},
					['t10'] = {10, 0},
				}
            },
            ['ability'] = {
                [1] = {3,1,2,2,2,6,2,1,1,1,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_faerie_fire",
				"item_blood_grenade",
                "item_magic_stick",
	
				"item_arcane_boots",
				"item_magic_wand",
				"item_glimmer_cape",--
                "item_rod_of_atos",
                "item_mekansm",
				"item_aghanims_shard",
				"item_guardian_greaves",--
				"item_sheepstick",--
				"item_wind_waker",--
				"item_lotus_orb",--
				"item_moon_shard",
				"item_gungir",--
				"item_ultimate_scepter_2",
			},
            ['sell_list'] = {
				"item_magic_wand", "item_lotus_orb",
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

function X.MinionThink( hMinionUnit )
	if Minion.IsValidUnit( hMinionUnit )
	then
		if hMinionUnit:IsIllusion()
		then
			Minion.IllusionThink( hMinionUnit )
		end
	end
end

end

local ColdFeet          = bot:GetAbilityByName('ancient_apparition_cold_feet')
local IceVortex         = bot:GetAbilityByName('ancient_apparition_ice_vortex')
local ChillingTouch     = bot:GetAbilityByName('ancient_apparition_chilling_touch')
local IceBlast          = bot:GetAbilityByName('ancient_apparition_ice_blast')
local IceBlastRelease   = bot:GetAbilityByName('ancient_apparition_ice_blast_release')

local ColdFeetDesire, ColdFeetTarget
local IceVortexDesire, IceVortextLocation
local ChillingTouchDesire, ChillingTouchTarget
local IceBlastDesire, IceBlastLocation
local IceBlastReleaseDesire

local IceBlastReleaseLocation

function X.SkillsComplement()
	if J.CanNotUseAbility(bot) then return end

    if GetBot():GetUnitName() ~= 'npc_dota_hero_ancient_apparition' then
        ColdFeet          = bot:GetAbilityByName('ancient_apparition_cold_feet')
        IceVortex         = bot:GetAbilityByName('ancient_apparition_ice_vortex')
        ChillingTouch     = bot:GetAbilityByName('ancient_apparition_chilling_touch')
        IceBlast          = bot:GetAbilityByName('ancient_apparition_ice_blast')
        IceBlastRelease   = bot:GetAbilityByName('ancient_apparition_ice_blast_release')
    end

    if bot:HasScepter()
    and ChillingTouch ~= nil
	and ChillingTouch:IsTrained()
    then
        if (J.IsGoingOnSomeone(bot) and J.IsValidHero(J.GetProperTarget(bot)) and J.IsInRange(bot, J.GetProperTarget(bot), 1600))
        then
            if  J.GetMP(bot) > 0.3
            and ChillingTouch:GetAutoCastState() == false
            then
                ChillingTouch:ToggleAutoCast()
            end

            if  J.GetMP(bot) < 0.3
            and ChillingTouch:GetAutoCastState() == true
            then
                ChillingTouch:ToggleAutoCast()
            end
        else
            if ChillingTouch:GetAutoCastState() == true
            then
                ChillingTouch:ToggleAutoCast()
            end
        end
    end

    IceBlastReleaseDesire = X.ConsiderIceBlastRelease()
    if IceBlastReleaseDesire > 0
    then
        bot:Action_UseAbility(IceBlastRelease)
        return
    end

    IceBlastDesire, IceBlastLocation = X.ConsiderIceBlast()
    if IceBlastDesire > 0
    then
		J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnLocation(IceBlast, IceBlastLocation)
        IceBlastReleaseLocation = IceBlastLocation
        return
    end

    IceVortexDesire, IceVortextLocation = X.ConsiderIceVortex()
    if IceVortexDesire > 0
    then
		J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnLocation(IceVortex, IceVortextLocation)
        return
    end

    ColdFeetDesire, ColdFeetTarget = X.ConsiderColdFeet()
    if ColdFeetDesire > 0
    then
		J.SetQueuePtToINT(bot, false)
        if J.CheckBitfieldFlag(ColdFeet:GetBehavior(), ABILITY_BEHAVIOR_UNIT_TARGET) then
            bot:ActionQueue_UseAbilityOnEntity(ColdFeet, ColdFeetTarget)
        else
            if ColdFeetTarget then
                if (IceBlast ~= nil and IceBlast:IsTrained())
                or (IceBlastRelease ~= nil and IceBlastRelease:IsTrained())
                then
                    local nRadius = 200 + (IceBlast:GetLevel() - 1) * 150
                    local nLocationAoE = bot:FindAoELocation(true, true, ColdFeetTarget:GetLocation(), 0, nRadius, 0, 0)
                    local nInRangeEnemy = J.GetEnemiesNearLoc(nLocationAoE.targetloc, nRadius)
                    if #nInRangeEnemy >= 2 then
                        bot:ActionQueue_UseAbilityOnLocation(ColdFeet, nLocationAoE.targetloc)
                    end
                end

                bot:ActionQueue_UseAbilityOnLocation(ColdFeet, ColdFeetTarget:GetLocation())
            end
        end
        return
    end

    ChillingTouchDesire, ChillingTouchTarget = X.ConsiderChillingTouch()
    if ChillingTouchDesire > 0
    then
		J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnEntity(ChillingTouch, ChillingTouchTarget)
        return
    end
end

function X.ConsiderColdFeet()
	if not J.CanCastAbility(ColdFeet)
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, ColdFeet:GetCastRange())
    local botTarget = J.GetProperTarget(bot)

    local nAllyHeroes = bot:GetNearbyHeroes(1600, false, BOT_MODE_NONE)
    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

    for _, allyHero in pairs(nAllyHeroes)
    do
        if  bot ~= allyHero
        and J.IsValidHero(allyHero)
        and J.IsInRange(bot, allyHero, nCastRange + 150)
        and J.IsRetreating(allyHero)
        and allyHero:WasRecentlyDamagedByAnyHero(1.5)
        and not allyHero:IsIllusion()
        then
            for _, enemyHero in pairs(nEnemyHeroes) do
                if J.IsValidHero(enemyHero)
                and J.CanCastOnNonMagicImmune(enemyHero)
                and J.CanCastOnTargetAdvanced(enemyHero)
                and J.IsInRange(bot, enemyHero, nCastRange)
                and J.IsChasingTarget(enemyHero, allyHero)
                and not J.IsDisabled(enemyHero)
                and not enemyHero:HasModifier('modifier_legion_commander_duel')
                and not enemyHero:HasModifier('modifier_enigma_black_hole_pull')
                and not enemyHero:HasModifier('modifier_faceless_void_chronosphere_freeze')
                and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
                then
                    return BOT_ACTION_DESIRE_HIGH, enemyHero
                end
            end
        end
    end

    if J.IsGoingOnSomeone(bot)
    then
        if  J.IsValidTarget(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.CanCastOnTargetAdvanced(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and not J.IsDisabled(botTarget)
        and not botTarget:HasModifier('modifier_cold_feet')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    if J.IsRetreating(bot)
    and not J.IsRealInvisible(bot)
    then
        for _, enemyHero in pairs(nEnemyHeroes)
        do
            if J.IsValidHero(enemyHero)
            and (bot:GetActiveModeDesire() and bot:WasRecentlyDamagedByHero(enemyHero, 1.5))
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.CanCastOnTargetAdvanced(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and not J.IsDisabled(enemyHero)
            and not enemyHero:HasModifier('modifier_cold_feet')
            and not enemyHero:HasModifier('modifier_ice_vortex')
            then
                return BOT_ACTION_DESIRE_HIGH, enemyHero
            end
        end
    end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and not J.IsDisabled(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and J.IsAttacking(bot)
        and not botTarget:HasModifier('modifier_cold_feet')
        and not botTarget:HasModifier('modifier_ice_vortex')
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and J.IsAttacking(bot)
        and not botTarget:HasModifier('modifier_cold_feet')
        and not botTarget:HasModifier('modifier_ice_vortex')
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderIceVortex()
	if not J.CanCastAbility(IceVortex)
    then
        return BOT_ACTION_DESIRE_NONE, 0
    end

    local nCastRange = J.GetProperCastRange(false, bot, IceVortex:GetCastRange())
    local nRadius = IceVortex:GetSpecialValueInt('radius')
    local nCastPoint = IceVortex:GetCastPoint()
    local botTarget = J.GetProperTarget(bot)

    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
    local nEnemyLanecreeps = bot:GetNearbyLaneCreeps(1600, true)

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
        and not J.IsDisabled(botTarget)
        and not botTarget:HasModifier('modifier_ice_vortex')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        then
            return BOT_ACTION_DESIRE_HIGH, J.GetCorrectLoc(botTarget, nCastPoint)
        end
    end

    if J.IsRetreating(bot)
    and not J.IsRealInvisible(bot)
    then
        for _, enemyHero in pairs(nEnemyHeroes)
        do
            if J.IsValidHero(enemyHero)
            and (bot:GetActiveModeDesire() > 0.88 and bot:WasRecentlyDamagedByHero(enemyHero, 2.5))
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and not J.IsDisabled(enemyHero)
            and not enemyHero:HasModifier('modifier_cold_feet')
            and not enemyHero:HasModifier('modifier_ice_vortex')
            then
                return BOT_ACTION_DESIRE_HIGH, (bot:GetLocation() + J.GetCorrectLoc(enemyHero, nCastPoint)) / 2
            end
        end
    end

    if  (J.IsDefending(bot) or J.IsPushing(bot))
    and (J.IsCore(bot) or not J.IsCore(bot) and not J.IsThereCoreNearby(1000))
	then
		if nEnemyLanecreeps ~= nil and #nEnemyLanecreeps >= 4
        and J.CanBeAttacked(nEnemyLanecreeps[1])
        and not J.IsRunning(nEnemyLanecreeps[1])
        and not nEnemyLanecreeps[1]:HasModifier('modifier_ice_vortex')
		then
			return BOT_ACTION_DESIRE_HIGH, J.GetCenterOfUnits(nEnemyLanecreeps)
		end

        local nLocationAoE = bot:FindAoELocation(true, true, bot:GetLocation(), nCastRange, nRadius, nCastPoint, 0)
        if nLocationAoE.count >= 2
        then
            return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
        end
	end

    if J.IsFarming(bot)
    then
        local nCreeps = bot:GetNearbyCreeps(1000, true)
        if  nCreeps ~= nil
        and J.CanBeAttacked(nCreeps[1])
        and not J.IsRunning(nCreeps[1])
        and not nCreeps[1]:HasModifier('modifier_ice_vortex')
        and (#nCreeps >= 3 or #nCreeps >= 2 and nCreeps[1]:IsAncientCreep())
        then
            return BOT_ACTION_DESIRE_HIGH, J.GetCenterOfUnits(nCreeps)
        end
    end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
        end
    end

    return BOT_ACTION_DESIRE_NONE, 0
end

function X.ConsiderChillingTouch()
	if not J.CanCastAbility(ChillingTouch)
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, ChillingTouch:GetCastRange()) + ChillingTouch:GetSpecialValueInt('attack_range_bonus')
    local nDamage = ChillingTouch:GetSpecialValueInt('damage')
    local botTarget = J.GetProperTarget(bot)

    local nAllyHeroes = bot:GetNearbyHeroes(1600, false, BOT_MODE_NONE)
    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.IsInRange(bot, enemyHero, nCastRange + 150)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and J.CanCastOnTargetAdvanced(enemyHero)
        and J.CanKillTarget(enemyHero, nDamage, DAMAGE_TYPE_MAGICAL)
        and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
        and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
        and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
        and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            return BOT_ACTION_DESIRE_HIGH, enemyHero
        end
    end

    for _, allyHero in pairs(nAllyHeroes)
    do
        if bot ~= allyHero
        and J.IsValidHero(allyHero)
        and J.IsInRange(bot, allyHero, nCastRange + 150)
        and J.IsRetreating(allyHero)
        and allyHero:WasRecentlyDamagedByAnyHero(1.5)
        and not allyHero:IsIllusion()
        then
            for _, enemyHero in pairs(nEnemyHeroes) do
                if J.IsValidHero(enemyHero)
                and J.CanCastOnNonMagicImmune(enemyHero)
                and J.CanCastOnTargetAdvanced(enemyHero)
                and J.IsInRange(bot, enemyHero, nCastRange)
                and J.IsChasingTarget(enemyHero, allyHero)
                and not J.IsDisabled(enemyHero)
                and not enemyHero:HasModifier('modifier_legion_commander_duel')
                and not enemyHero:HasModifier('modifier_enigma_black_hole_pull')
                and not enemyHero:HasModifier('modifier_faceless_void_chronosphere_freeze')
                and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
                then
                    return BOT_ACTION_DESIRE_HIGH, enemyHero
                end
            end
        end
    end

    if J.IsGoingOnSomeone(bot)
    then
        if  J.IsValidTarget(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.CanCastOnTargetAdvanced(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and not J.IsDisabled(botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not botTarget:HasModifier('modifier_oracle_false_promise_timer')
        and not botTarget:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    if J.IsRetreating(bot)
    and not J.IsRealInvisible(bot)
    then
        for _, enemyHero in pairs(nEnemyHeroes)
        do
            if J.IsValidHero(enemyHero)
            and (bot:GetActiveModeDesire() > 0.5 and bot:WasRecentlyDamagedByHero(enemyHero, 2))
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.CanCastOnTargetAdvanced(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and not J.IsDisabled(enemyHero)
            then
                return BOT_ACTION_DESIRE_HIGH, enemyHero
            end
        end
    end

    if  J.IsLaning(bot)
    and (J.IsCore(bot) or (not J.IsCore(bot) and not J.IsThereCoreNearby(1600)))
	then
		local nEnemyLaneCreeps = bot:GetNearbyLaneCreeps(nCastRange + 300, true)

		for _, creep in pairs(nEnemyLaneCreeps)
		do
			if  J.IsValid(creep)
            and J.CanBeAttacked(creep)
			and (J.IsKeyWordUnit('ranged', creep) or J.IsKeyWordUnit('siege', creep) or J.IsKeyWordUnit('flagbearer', creep))
			and creep:GetHealth() <= nDamage
            and creep:GetHealth() > bot:GetAttackDamage()
			then
				if J.IsValidHero(nEnemyHeroes[1])
                and GetUnitToUnitDistance(creep, nEnemyHeroes[1]) < 500
                and not J.IsSuspiciousIllusion(nEnemyHeroes[1])
				then
					return BOT_ACTION_DESIRE_HIGH, creep
				end
			end
		end
	end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

local nRadius = 0
function X.ConsiderIceBlast()
	if not J.CanCastAbility(IceBlast) then
        return BOT_ACTION_DESIRE_NONE, 0
    end

    local nMinRadius = IceBlast:GetSpecialValueInt('radius_min')
    local nGrowSpeed = IceBlast:GetSpecialValueInt('radius_grow')
    local nMaxRadius = IceBlast:GetSpecialValueInt('radius_max')
    local nSpeed = IceBlast:GetSpecialValueInt('speed')
    local nShatterThreshold = IceBlast:GetSpecialValueInt('kill_pct')
    local botTarget = J.GetProperTarget(bot)

    if J.IsInTeamFight(bot, 1600) then
        local nTeamFightLocation = J.GetTeamFightLocation(bot)
        if nTeamFightLocation ~= nil then
            local dist = GetUnitToLocationDistance(bot, nTeamFightLocation)
            nRadius = math.min(nMinRadius + ((dist / nSpeed) * nGrowSpeed), nMaxRadius)
            local nLocationAoE = bot:FindAoELocation(true, true, nTeamFightLocation, 0, nRadius, 0, 0)
            local nInRangeEnemy = J.GetEnemiesNearLoc(nLocationAoE.targetloc, nRadius)

            if nInRangeEnemy ~= nil and #nInRangeEnemy >= 2 then
                local count = 0
                for _, enemyHero in pairs(nInRangeEnemy) do
                    if J.IsValidHero(enemyHero)
                    and J.CanBeAttacked(enemyHero)
                    and not J.IsMeepoClone(enemyHero)
                    and not J.IsChasingTarget(bot, enemyHero)
                    and not enemyHero:HasModifier('modifier_doom_bringer_doom_aura_enemy')
                    and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
                    and not enemyHero:HasModifier('modifier_item_aeon_disk_buff')
                    and not enemyHero:HasModifier('modifier_eul_cyclone')
                    and not enemyHero:HasModifier('modifier_brewmaster_storm_cyclone')
                    then
                        count = count + 1
                    end
                end

                if count >= 2 then
                    return BOT_ACTION_DESIRE_HIGH, nLocationAoE.targetloc
                end
            end
        end
    end

    if J.IsGoingOnSomeone(bot) then
        if J.IsValidHero(botTarget)
        and J.IsInRange(bot, botTarget, 1200)
        and J.CanBeAttacked(botTarget)
        and not J.IsChasingTarget(bot, botTarget)
        and not J.IsSuspiciousIllusion(botTarget)
        and not botTarget:HasModifier('modifier_doom_bringer_doom_aura_enemy')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not botTarget:HasModifier('modifier_item_aeon_disk_buff')
        and not botTarget:HasModifier('modifier_eul_cyclone')
        and not botTarget:HasModifier('modifier_brewmaster_storm_cyclone')
        then
            local dist = GetUnitToUnitDistance(bot, botTarget)
            nRadius = math.min(nMinRadius + ((dist / nSpeed) * nGrowSpeed), nMaxRadius)
            local sBotTargetName = botTarget:GetUnitName()
            local nInRangeAlly = J.GetAlliesNearLoc(botTarget:GetLocation(), 800)

            if sBotTargetName == 'npc_dota_hero_alchemist'
            or sBotTargetName == 'npc_dota_hero_bristleback'
            or sBotTargetName == 'npc_dota_hero_dragon_knight'
            or sBotTargetName == 'npc_dota_hero_huskar'
            or sBotTargetName == 'npc_dota_hero_life_stealer'
            or sBotTargetName == 'npc_dota_hero_shredder'
            or sBotTargetName == 'npc_dota_hero_morphling'
            or sBotTargetName == 'npc_dota_hero_leshrac'
            or sBotTargetName == 'npc_dota_hero_necrolyte'
            or sBotTargetName == 'npc_dota_hero_pugna'
            or sBotTargetName == 'npc_dota_hero_abaddon'
            or sBotTargetName == 'npc_dota_hero_death_prophet'
            or (sBotTargetName == 'npc_dota_hero_wisp' and not botTarget:IsBot())
            or botTarget:HasModifier('modifier_item_satanic_unholy')
            or botTarget:HasModifier('modifier_item_bloodstone_active')
            then
                if (#nInRangeAlly >= 2 and J.IsThereCoreNearby(1000))
                    or (J.GetHP(botTarget) < (nShatterThreshold / 100) + 0.15) then
                    return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
                end
            end

            nInRangeAlly = J.GetAlliesNearLoc(botTarget:GetLocation(), 1200)
            local nInRangeEnemy = J.GetEnemiesNearLoc(botTarget:GetLocation(), 1200)
            if not (#nInRangeAlly >= #nInRangeEnemy + 2)
            and (#nInRangeAlly >= 2 and J.IsThereCoreNearby(1000))
                or (J.GetHP(botTarget) < (nShatterThreshold / 100) + 0.15)
            then
                return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation()
            end
        end
    end

    local nTeamFightLocation = J.GetTeamFightLocation(bot)

    if nTeamFightLocation ~= nil and GetUnitToLocationDistance(bot, nTeamFightLocation) > 1600 then
        local nInRangeEnemy = J.GetEnemiesNearLoc(nTeamFightLocation, nRadius)

        if nInRangeEnemy ~= nil and #nInRangeEnemy >= 1 then
            local count = 0
            for _, enemyHero in pairs(nInRangeEnemy) do
                if J.IsValidHero(enemyHero)
                and J.CanBeAttacked(enemyHero)
                and not J.IsMeepoClone(enemyHero)
                and not J.IsChasingTarget(bot, enemyHero)
                and not enemyHero:HasModifier('modifier_doom_bringer_doom_aura_enemy')
                and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
                and not enemyHero:HasModifier('modifier_item_aeon_disk_buff')
                and not enemyHero:HasModifier('modifier_eul_cyclone')
                and not enemyHero:HasModifier('modifier_brewmaster_storm_cyclone')
                then
                    count = count + 1
                end
            end

            if count >= 1 then
                local vLocation = J.GetCenterOfUnits(nInRangeEnemy)
                local dist = GetUnitToLocationDistance(bot, vLocation)
                nRadius = math.min(nMinRadius + ((dist / nSpeed) * nGrowSpeed), nMaxRadius)
                return BOT_ACTION_DESIRE_HIGH, vLocation
            end
        end
    end

    local vTormentorLocation = J.GetTormentorLocation(GetTeam())
    if not J.IsDoingTormentor(bot) and IsLocationVisible(vTormentorLocation) and GetUnitToLocationDistance(bot, vTormentorLocation) > 1600 then
        local dist = GetUnitToLocationDistance(bot, vTormentorLocation)
        nRadius = math.min(nMinRadius + ((dist / nSpeed) * nGrowSpeed), nMaxRadius)
        local nInRangeEnemy = J.GetEnemiesNearLoc(vTormentorLocation, nRadius)

        if #nInRangeEnemy > 0 then
            if J.IsValidHero(nInRangeEnemy[1]) and J.IsTormentor(nInRangeEnemy[1]:GetAttackTarget()) then
                return BOT_ACTION_DESIRE_HIGH, vTormentorLocation
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE, 0
end

function X.ConsiderIceBlastRelease()
	if not J.CanCastAbility(IceBlastRelease) then
        return BOT_ACTION_DESIRE_NONE
    end

    local nProjectiles = GetLinearProjectiles()

    for _, p in pairs(nProjectiles) do
		if p ~= nil and p.ability:GetName() == "ancient_apparition_ice_blast" then
			if  IceBlastReleaseLocation ~= nil
            and J.GetLocationToLocationDistance(IceBlastReleaseLocation, p.location) < nRadius
            then
				return BOT_ACTION_DESIRE_HIGH
			end
		end
	end

    return BOT_ACTION_DESIRE_NONE
end

return X