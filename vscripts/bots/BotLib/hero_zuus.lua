local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_zuus'
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
					['t10'] = {10, 0},
				}
            },
            ['ability'] = {
                [1] = {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_faerie_fire",
				"item_circlet",
				"item_mantle",
			
				"item_bottle",
				"item_magic_wand",
				"item_arcane_boots",
				"item_null_talisman",
				"item_phylactery",
				"item_kaya",
				"item_ultimate_scepter",
				"item_octarine_core",--
				"item_black_king_bar",--
				"item_aghanims_shard",
				"item_kaya_and_sange",--
				"item_sheepstick",--
				"item_ultimate_scepter_2",
				"item_wind_waker",--
				"item_moon_shard",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_magic_wand", "item_ultimate_scepter",
				"item_null_talisman", "item_octarine_core",
				"item_bottle", "item_black_king_bar",
				"item_phylactery", "item_wind_waker",
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
					['t25'] = {0, 10},
					['t20'] = {0, 10},
					['t15'] = {0, 10},
					['t10'] = {10, 0},
				},
            },
            ['ability'] = {
                [1] = {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_magic_stick",
				"item_double_branches",
				"item_blood_grenade",
				"item_enchanted_mango",
			
				"item_tranquil_boots",
				"item_magic_wand",
				"item_phylactery",
				"item_aether_lens",
				"item_force_staff",
				"item_boots_of_bearing",--
				"item_octarine_core",--
				"item_ultimate_scepter",
				"item_sheepstick",--
				"item_ultimate_scepter_2",
				"item_aghanims_shard",
				"item_ethereal_blade",--
				"item_sphere",--
				"item_moon_shard",
				"item_hurricane_pike",--
			},
            ['sell_list'] = {
				"item_magic_wand", "item_ultimate_scepter",
				"item_phylactery", "item_sphere",
			},
        },
    },
    ['pos_5'] = {
        [1] = {
            ['talent'] = {
				[1] = {
					['t25'] = {0, 10},
					['t20'] = {0, 10},
					['t15'] = {0, 10},
					['t10'] = {10, 0},
				}
            },
            ['ability'] = {
                [1] = {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_magic_stick",
				"item_double_branches",
				"item_blood_grenade",
				"item_enchanted_mango",
			
				"item_arcane_boots",
				"item_magic_wand",
				"item_phylactery",
				"item_aether_lens",
				"item_force_staff",
				"item_guardian_greaves",--
				"item_octarine_core",--
				"item_ultimate_scepter",
				"item_sheepstick",--
				"item_ultimate_scepter_2",
				"item_aghanims_shard",
				"item_ethereal_blade",--
				"item_sphere",--
				"item_moon_shard",
				"item_hurricane_pike",--
			},
            ['sell_list'] = {
				"item_magic_wand", "item_ultimate_scepter",
				"item_phylactery", "item_sphere",
			},
        },
    },
}

local sSelectedBuild = HeroBuild[sRole][RandomInt(1, #HeroBuild[sRole])]

local nTalentBuildList = J.Skill.GetTalentBuild(J.Skill.GetRandomBuild(sSelectedBuild.talent))
local nAbilityBuildList = J.Skill.GetRandomBuild(sSelectedBuild.ability)

X['sBuyList'] = sSelectedBuild.buy_list
X['sSellList'] = sSelectedBuild.sell_list

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_mage' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = true

function X.MinionThink( hMinionUnit )

	if Minion.IsValidUnit( hMinionUnit )
		and hMinionUnit:GetUnitName() ~= 'npc_dota_zeus_cloud'
	then
		Minion.IllusionThink( hMinionUnit )
	end

end

end

local abilityQ = bot:GetAbilityByName('zuus_arc_lightning')
local abilityW = bot:GetAbilityByName('zuus_lightning_bolt')
local abilityE = bot:GetAbilityByName('zuus_heavenly_jump')
local abilityD = bot:GetAbilityByName('zuus_cloud')
local abilityAS = bot:GetAbilityByName('zuus_lightning_hands')
local abilityR = bot:GetAbilityByName('zuus_thundergods_wrath')

local talent5 = bot:GetAbilityByName( sTalentList[5] )
local talent7 = bot:GetAbilityByName( sTalentList[7] )
local talent8 = bot:GetAbilityByName( sTalentList[8] )

local castQDesire, castQTarget
local castWDesire, castWTarget
local castW2Desire, castWLocation
local castDDesire, castDLocation
local castRDesire
local castEDesire, castETarget


local nKeepMana, nMP, nHP, nLV, hEnemyHeroList, botName
local aetherRange = 0
local talentDamage = 0


local abilityASBonus = 0


function X.SkillsComplement()


	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	abilityQ = bot:GetAbilityByName('zuus_arc_lightning')
	abilityW = bot:GetAbilityByName('zuus_lightning_bolt')
	abilityE = bot:GetAbilityByName('zuus_heavenly_jump')
	abilityD = bot:GetAbilityByName('zuus_cloud')
	abilityR = bot:GetAbilityByName('zuus_thundergods_wrath')

	nKeepMana = 400
	aetherRange = 0
	talentDamage = 0
	abilityASBonus = 0
	nLV = bot:GetLevel()
	nMP = bot:GetMana()/bot:GetMaxMana()
	nHP = bot:GetHealth()/bot:GetMaxHealth()
	nManaPercentage = bot:GetMana()/bot:GetMaxMana()
	nHealthPercentage = bot:GetHealth()/bot:GetMaxHealth()
	hEnemyHeroList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	botName = GetBot():GetUnitName()

	local aether = J.IsItemAvailable( "item_aether_lens" )
	if aether ~= nil then aetherRange = 250 end
	if abilityAS ~= nil and abilityAS:IsTrained() then abilityASBonus = 0.09 end

	if string.find(botName, 'zuus')
	then
		if talent8:IsTrained() then talentDamage = talentDamage + talent8:GetSpecialValueInt( "value" ) end
	end

	castRDesire = X.ConsiderR()
	if ( castRDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbility( abilityR )
		return

	end

	castWDesire, castWTarget = X.ConsiderW()
	if ( castWDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )
		
		
		if talent7:IsTrained() 
		then
			bot:ActionQueue_UseAbilityOnLocation( abilityW, castWTarget:GetLocation() )
		else
			bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		end
		
		return
	end

	castW2Desire, castWLocation = X.ConsiderW2()
	if ( castW2Desire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityW, castWLocation )
		return
	end

	castQDesire, castQTarget = X.ConsiderQ()
	if ( castQDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end

	castDDesire, castDLocation = X.ConsiderD()
	if ( castDDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityD, castDLocation )
		return
	end
	
	castEDesire = X.ConsiderE()
	if ( castEDesire > 0 )
	then
	
		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbility( abilityE )
		return

	end

end

function X.ConsiderQ()

	if not J.CanCastAbility(abilityQ) then	return BOT_ACTION_DESIRE_NONE, nil	end

	local nCastRange = abilityQ:GetCastRange()
	local nCastPoint = abilityQ:GetCastPoint()
	local manaCost = abilityQ:GetManaCost()
	local nRadius = abilityQ:GetSpecialValueInt( "radius" )
	local nDamage = abilityQ:GetSpecialValueInt( "arc_damage" )
	local nEnemyHeroesInSkillRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )

	for _, npcEnemy in pairs( nEnemyHeroesInSkillRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.GetHP( npcEnemy ) <= 0.2
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy
		end
	end


	--对线期的使用
	if bot:GetActiveMode() == BOT_MODE_LANING
	then
		local hLaneCreepList = bot:GetNearbyLaneCreeps( nCastRange + 50, true )
		for _, creep in pairs( hLaneCreepList )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.IsEnemyTargetUnit( creep, 1400 )
				and J.WillKillTarget( creep, nDamage, DAMAGE_TYPE_MAGICAL, nCastPoint )
			then
				return BOT_ACTION_DESIRE_HIGH, creep
			end
		end

	end


	if J.IsRetreating( bot ) and bot:WasRecentlyDamagedByAnyHero( 2.0 )
	then
		local target = J.GetVulnerableWeakestUnit( bot, true, true, nCastRange )
		if target ~= nil
			and J.CanCastOnTargetAdvanced( target )
			and bot:IsFacingLocation( target:GetLocation(), 45 )
		then
			return BOT_ACTION_DESIRE_HIGH, target
		end
	end

	if J.IsInTeamFight( bot, 1300 )
	then
		local locationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
		if ( locationAoE.count >= 2 ) then
			local target = J.GetVulnerableUnitNearLoc( bot, true, true, nCastRange, nRadius, locationAoE.targetloc )
			if target ~= nil and J.CanCastOnTargetAdvanced( target ) then
				return BOT_ACTION_DESIRE_HIGH, target
			end
		end
	end

	if ( J.IsPushing( bot ) or J.IsDefending( bot ) ) and J.IsAllowedToSpam( bot, manaCost )
	then
		local locationAoE = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
		if ( locationAoE.count >= 3 ) then
			local target = J.GetVulnerableUnitNearLoc( bot, false, true, nCastRange, nRadius, locationAoE.targetloc )
			if target ~= nil then
				return BOT_ACTION_DESIRE_HIGH, target
			end
		end
	end

	if J.IsGoingOnSomeone( bot )
	then
		local target = J.GetProperTarget( bot )
		if J.IsValidHero( target )
			and J.CanCastOnNonMagicImmune( target )
			and J.CanCastOnTargetAdvanced( target )
			and J.IsInRange( target, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, target
		end
	end

	local botTarget = J.GetProperTarget(bot)
	if J.IsDoingRoshan(bot)
	then
		if J.IsRoshan( botTarget )
		and J.IsInRange( botTarget, bot, nCastRange)
		and J.CanBeAttacked(botTarget)
		and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget
		end
	end

    if J.IsDoingTormentor(bot)
	then
		if J.IsTormentor(botTarget)
        and J.IsInRange( botTarget, bot, nCastRange)
        and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderW()

	if not J.CanCastAbility(abilityW) then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = abilityW:GetCastRange()
	local nCastPoint = abilityW:GetCastPoint()
	local manaCost = abilityW:GetManaCost()
	local nDamage = abilityW:GetAbilityDamage() * ( 1 + bot:GetSpellAmp() )

	if J.IsRetreating( bot ) and bot:WasRecentlyDamagedByAnyHero( 2.0 )
	then
		local target = J.GetVulnerableWeakestUnit( bot, true, true, nCastRange )
		if target ~= nil and J.CanCastOnTargetAdvanced( target ) then
			return BOT_ACTION_DESIRE_HIGH, target
		end
	end

	if J.IsGoingOnSomeone( bot )
	then
		local target = J.GetProperTarget( bot )
		if J.IsValidHero( target )
			and J.CanCastOnNonMagicImmune( target )
			and J.CanCastOnTargetAdvanced( target )
			and J.IsInRange( target, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, target
		end
	end

	local targetRanged = X.GetRanged( bot, nCastRange )
	if targetRanged ~= nil
		and targetRanged:GetHealth() < targetRanged:GetActualIncomingDamage( nDamage + targetRanged:GetHealth() * abilityASBonus , DAMAGE_TYPE_MAGICAL )
	then
		return BOT_ACTION_DESIRE_HIGH, targetRanged
	end

	local botTarget = J.GetProperTarget(bot)
	if J.IsDoingRoshan(bot)
	then
		if J.IsRoshan( botTarget )
		and J.IsInRange( botTarget, bot, nCastRange)
		and J.CanBeAttacked(botTarget)
		and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget
		end
	end

    if J.IsDoingTormentor(bot)
	then
		if J.IsTormentor(botTarget)
        and J.IsInRange( botTarget, bot, nCastRange)
        and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderW2()

	if not J.CanCastAbility(abilityW) then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityW:GetCastRange()
	local nCastPoint = abilityW:GetCastPoint()
	local manaCost = abilityW:GetManaCost()
	local nDamage = abilityW:GetAbilityDamage()
	local nRadius = 325

	local nAllies = bot:GetNearbyHeroes( 800, false, BOT_MODE_NONE )

	local nEnemyHeroesInSkillRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )
	local nWeakestEnemyHeroInSkillRange = J.GetVulnerableWeakestUnit( bot, true, true, nCastRange + nRadius )
	local nCanKillHeroLocationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius , 0.3, nDamage )

	if nCanKillHeroLocationAoE.count >= 1
	then
		if J.IsValid( nWeakestEnemyHeroInSkillRange )
		then
			local nTargetLocation = J.GetCastLocation( bot, nWeakestEnemyHeroInSkillRange, nCastRange, nRadius )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation
			end
		end
	end

	for _, npcEnemy in pairs( nEnemyHeroesInSkillRange )
	do
		if J.IsValid( npcEnemy )
			and npcEnemy:IsChanneling()
			and not npcEnemy:IsMagicImmune()
		then
			local nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation
			end
		end
	end

	if bot:GetActiveMode() == BOT_MODE_RETREAT
		and ( bot:WasRecentlyDamagedByAnyHero( 2.0 ) or #nAllies >= 3 )
	then
		local nCanHurtHeroLocationAoENearby = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange -200, nRadius -20, 0.8, 0 )
		if nCanHurtHeroLocationAoENearby.count >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, nCanHurtHeroLocationAoENearby.targetloc
		end
	end


	if bot:GetActiveMode() ~= BOT_MODE_RETREAT
	then
		local npcEnemy = J.GetProperTarget( bot )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and GetUnitToUnitDistance( npcEnemy, bot ) <= nRadius + nCastRange
		then

			if nManaPercentage > 0.65
				or bot:GetMana() > nKeepMana * 2
			then
				local nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
				if nTargetLocation ~= nil
				then
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation
				end
			end

			if npcEnemy:GetHealth()/npcEnemy:GetMaxHealth() < 0.45 or #nAllies >= 3
			then
				local nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
				if nTargetLocation ~= nil
				then
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation
				end
			end

		end

		local npcEnemy = nWeakestEnemyHeroInSkillRange
		if J.IsValid( npcEnemy ) and DotaTime() > 0
			and ( npcEnemy:GetHealth()/npcEnemy:GetMaxHealth() < 0.4 or bot:GetMana() > nKeepMana * 2.3 or #nAllies >= 3 )
			and GetUnitToUnitDistance( npcEnemy, bot ) <= nRadius + nCastRange
		then
			local nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderD()

	if not J.CanCastAbility(abilityD)
		or bot:IsInvisible()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local numPlayer =  GetTeamPlayers( GetTeam() )
	for i = 1, #numPlayer
	do
		local member =  GetTeamMember( i )
		if J.IsValid( member )
			and J.IsGoingOnSomeone( member )
		then
			local target = J.GetProperTarget( member )
			if J.IsValidHero( target )
				and J.IsInRange( member, target, 1200 )
				and J.CanCastOnNonMagicImmune( target )
			then
				return BOT_ACTION_DESIRE_HIGH, target:GetExtrapolatedLocation( 1.0 )
			end
		end
	end

	--撤退时
	if J.IsRetreating( bot )
	then
		local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1200, true, BOT_MODE_NONE )
		for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( J.IsValid( npcEnemy ) and bot:WasRecentlyDamagedByHero( npcEnemy, 1.0 ) and J.CanCastOnNonMagicImmune( npcEnemy ) )
			then
				return BOT_ACTION_DESIRE_HIGH, bot:GetLocation()
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderR()

	if not J.CanCastAbility(abilityR) then
		return BOT_ACTION_DESIRE_NONE
	end

	local nCastRange = 1600
	local nCastPoint = abilityR:GetCastPoint()
	local manaCost = abilityR:GetManaCost()
	local nDamage = abilityR:GetSpecialValueInt( 'damage' )
	
	if talent5:IsTrained() then nDamage = nDamage + talent5:GetSpecialValueInt('value') end
	
	local nDamageType = DAMAGE_TYPE_MAGICAL


	if J.IsRetreating( bot ) and bot:WasRecentlyDamagedByAnyHero( 2.0 )
	then
		if bot:GetRespawnTime() > abilityR:GetCooldown()
			and nHealthPercentage <= 0.28
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	if J.IsInTeamFight( bot, 1400 )
	then
		local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )
		local nInvUnit = J.GetInvUnitCount( false, tableNearbyEnemyHeroes )
		if nInvUnit >= 5 then
			return BOT_ACTION_DESIRE_MODERATE
		end
	end

	-- modifier_warlock_fatal_bonds
	local lowHPCount = 0
	local fatalCount = 0
	local fatalBonus = false
	local gEnemies = GetUnitList( UNIT_LIST_ENEMY_HEROES )
	for _, e in pairs ( gEnemies )
	do
		if e ~= nil
			and J.CanCastOnNonMagicImmune( e )
		then
			local nEstDamage = nDamage + e:GetHealth() * abilityASBonus
			if J.WillMagicKillTarget( bot, e, nEstDamage, nCastPoint )
				and not J.IsOtherAllyCanKillTarget( bot, e )
			then
				lowHPCount = lowHPCount + 1
			end

			if e:HasModifier( "modifier_warlock_fatal_bonds" )
			then
				fatalCount = fatalCount + 1
				if e:GetHealth() <= e:GetActualIncomingDamage( nEstDamage * 2.28, nDamageType )
				then
					fatalBonus = true
				end
			end
		end
	end
	if lowHPCount >= 1
		or ( fatalCount >= 3 and fatalBonus == true )
	then
		return BOT_ACTION_DESIRE_MODERATE
	end

	return BOT_ACTION_DESIRE_NONE
end

function X.GetRanged( bot, nRadius )
	local mode = bot:GetActiveMode()
	local enemys = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )
	local allies = bot:GetNearbyHeroes( 800, false, BOT_MODE_NONE )

	if mode == BOT_MODE_TEAM_ROAM
		or mode == BOT_MODE_ATTACK
		or mode == BOT_MODE_DEFEND_ALLY
		or mode == BOT_MODE_RETREAT
		or #enemys >= 1
		or #allies >= 3
		or nManaPercentage <= 0.15
		or bot:WasRecentlyDamagedByAnyHero( 2.0 )
	then
		return nil
	end

	if mode == BOT_MODE_LANING or nManaPercentage >= 0.56
	then
		local nTowers = bot:GetNearbyTowers( 1600, false )
		if nTowers[1] ~= nil
		then
			local nTowerTarget = nTowers[1]:GetAttackTarget()
			if J.IsValid( nTowerTarget )
				and not nTowerTarget:HasModifier( 'modifier_fountain_glyph' )
				and J.IsKeyWordUnit( "ranged", nTowerTarget )
				and GetUnitToUnitDistance( nTowerTarget, bot ) <= 1400
				and not J.IsAllysTarget( nTowerTarget )
			then
				return nTowerTarget
			end
		end

		if nManaPercentage > 0.4 and bot:GetMana() > 400
		then
			local nLaneCreeps = bot:GetNearbyLaneCreeps( 990, true )
			for _, creep in pairs( nLaneCreeps )
			do
				if J.IsValid( creep )
					and J.IsKeyWordUnit( "ranged", creep )
					and not creep:HasModifier( 'modifier_fountain_glyph' )
					and not J.IsAllysTarget( creep )
					and creep:GetHealth() < bot:GetAttackDamage()
				then
					return creep
				end
			end
		end
	end

	return nil

end


function X.ConsiderE()

	if not J.CanCastAbility(abilityE)
		or bot:IsRooted()
	then
		return BOT_ACTION_DESIRE_NONE
	end

	local nJumpDistance = 450
	local nSkillLV = abilityE:GetLevel()
	local nCastRange = 600 + nSkillLV * 100
	local nCastPoint = abilityE:GetCastPoint()
	local nManaCost = abilityE:GetManaCost()

	local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	

	if J.IsRetreating( bot )
	then
		if J.IsRunning( bot )
		then
			local targetHero = tableNearbyEnemyHeroes[1]
			if J.IsValidHero( targetHero )
				and J.CanCastOnNonMagicImmune( targetHero )
				and not bot:IsFacingLocation( targetHero:GetLocation(), 120 )
			then
				return BOT_ACTION_DESIRE_HIGH
			end
		end
	end
	
	

	if J.IsGoingOnSomeone( bot )
	then
		local targetHero = J.GetProperTarget( bot )
		if J.IsValidHero( targetHero )
			and J.IsInRange( bot, targetHero, nCastRange )
			and J.CanCastOnNonMagicImmune( targetHero )
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	
	return BOT_ACTION_DESIRE_NONE

end


return X