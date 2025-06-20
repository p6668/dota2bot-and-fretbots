local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_omniknight'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {"item_pipe", "item_heavens_halberd", "item_lotus_orb"}
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
					['t15'] = {0, 10},
					['t10'] = {10, 0},
				}
            },
            ['ability'] = {
				[1] = {3,1,3,1,3,1,1,3,2,6,6,2,2,2,6},
				[2] = {3,2,3,1,3,6,3,2,2,2,1,1,1,6,6},
				[3] = {3,1,1,3,2,6,1,3,3,1,6,2,2,2,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
				"item_double_gauntlets",
			
				"item_bottle",
				"item_magic_wand",
				"item_boots",
				"item_double_bracer",
				"item_radiance",--
				"item_phase_boots",
				"item_harpoon",--
				"item_aghanims_shard",
				"item_sange_and_yasha",--
				"item_bloodthorn",--
				"item_nullifier",--
				"item_moon_shard",
				"item_ultimate_scepter_2",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_quelling_blade", "item_radiance",
				"item_magic_wand", "item_harpoon",
				"item_bottle", "item_sange_and_yasha",
				"item_bracer", "item_bloodthorn",
				"item_bracer", "item_nullifier",
			},
        },
    },
    ['pos_3'] = {
        [1] = {
            ['talent'] = {
				[1] = {
					['t25'] = {10, 0},
					['t20'] = {0, 10},
					['t15'] = {10, 0},
					['t10'] = {10, 0},
				}
            },
            ['ability'] = {
				[1] = {3,1,3,1,3,1,3,1,6,2,6,2,2,2,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
				"item_double_gauntlets",
			
				"item_magic_wand",
				"item_double_bracer",
				"item_phase_boots",
				"item_crimson_guard",--
				"item_blink",
				"item_aghanims_shard",
				"item_black_king_bar",--
				sUtilityItem,--
				"item_shivas_guard",--
				"item_overwhelming_blink",--
				"item_moon_shard",
				"item_ultimate_scepter_2",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_quelling_blade", "item_blink",
				"item_magic_wand", "item_black_king_bar",
				"item_bracer", sUtilityItem,
				"item_bracer", "item_shivas_guard",
			},
        },
    },
    ['pos_4'] = {
        [1] = {
            ['talent'] = {
				[1] = {
					['t25'] = {0, 10},
					['t20'] = {0, 10},
					['t15'] = {10, 0},
					['t10'] = {0, 10},
				}
            },
            ['ability'] = {
                [1] = {3,1,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_enchanted_mango",
				"item_double_branches",
				"item_faerie_fire",
				"item_blood_grenade",
			
				"item_magic_wand",
				"item_tranquil_boots",
				"item_solar_crest",--
				"item_force_staff",--
				"item_boots_of_bearing",--
				"item_holy_locket",--
				"item_ultimate_scepter",
				"item_sheepstick",--
				"item_wind_waker",--
				"item_ultimate_scepter_2",
				"item_aghanims_shard",
				"item_moon_shard",
			},
            ['sell_list'] = {},
        },
    },
    ['pos_5'] = {
        [1] = {
            ['talent'] = {
				[1] = {
					['t25'] = {0, 10},
					['t20'] = {0, 10},
					['t15'] = {10, 0},
					['t10'] = {0, 10},
				}
            },
            ['ability'] = {
                [1] = {3,1,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_enchanted_mango",
				"item_double_branches",
				"item_faerie_fire",
				"item_blood_grenade",
			
				"item_magic_wand",
				"item_arcane_boots",
				"item_solar_crest",--
				"item_force_staff",--
				"item_guardian_greaves",--
				"item_holy_locket",--
				"item_ultimate_scepter",
				"item_sheepstick",--
				"item_wind_waker",--
				"item_ultimate_scepter_2",
				"item_aghanims_shard",
				"item_moon_shard",
			},
            ['sell_list'] = {},
        },
    },
}

local sSelectedBuild = HeroBuild[sRole][RandomInt(1, #HeroBuild[sRole])]

local nTalentBuildList = J.Skill.GetTalentBuild(J.Skill.GetRandomBuild(sSelectedBuild.talent))
local nAbilityBuildList = J.Skill.GetRandomBuild(sSelectedBuild.ability)

X['sBuyList'] = sSelectedBuild.buy_list
X['sSellList'] = sSelectedBuild.sell_list

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_tank' }, {"item_power_treads", 'item_quelling_blade'} end

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

local abilityQ = bot:GetAbilityByName('omniknight_purification')
local abilityW = bot:GetAbilityByName('omniknight_martyr')
local abilityE = bot:GetAbilityByName('omniknight_hammer_of_purity')
local abilityR = bot:GetAbilityByName('omniknight_guardian_angel')
local talent7 = bot:GetAbilityByName( sTalentList[7] )

local castQDesire, castQTarget
local castWDesire, castWTarget
local castEDesire, castETarget
local castRDesire, castRTarget

local nKeepMana, nMP, nHP, nLV, hEnemyList, hAllyList, botTarget, sMotive
local aetherRange = 0


function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	abilityQ = bot:GetAbilityByName('omniknight_purification')
	abilityW = bot:GetAbilityByName('omniknight_martyr')
	abilityE = bot:GetAbilityByName('omniknight_hammer_of_purity')
	abilityR = bot:GetAbilityByName('omniknight_guardian_angel')

	nKeepMana = 400
	aetherRange = 0
	nLV = bot:GetLevel()
	nMP = bot:GetMana() / bot:GetMaxMana()
	nHP = bot:GetHealth() / bot:GetMaxHealth()
	botTarget = J.GetProperTarget( bot )
	hEnemyList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	hAllyList = J.GetAlliesNearLoc( bot:GetLocation(), 1600 )


	--计算天赋可能带来的通用变化
	local aether = J.IsItemAvailable( "item_aether_lens" )
	if aether ~= nil then aetherRange = 250 end

	-- to be improve
	castRDesire, castRTarget = X.ConsiderR()
	if castRDesire > 0
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRTarget )
		return
	end
	
	
	castQDesire, castQTarget, sMotive = X.ConsiderQ()
	if castQDesire > 0
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end

	castWDesire, castWTarget, sMotive = X.ConsiderW()
	if castWDesire > 0
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end

	castEDesire, castETarget, sMotive = X.ConsiderE()
	if castEDesire > 0
	then

		J.SetQueuePtToINT( bot, true )

		bot:Action_UseAbilityOnEntity( abilityE, castETarget )
		return
	end

end


function X.ConsiderQ()


	if not J.CanCastAbility(abilityQ) then return 0 end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + aetherRange
	local nRadius = abilityQ:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( 'heal' )
	
	if talent7:IsTrained() then nDamage = nDamage + talent7:GetSpecialValueInt( 'value' ) end
	
	local nDamageType = DAMAGE_TYPE_PURE
	local nInRangeEnemyList = J.GetAroundEnemyHeroList( nCastRange + nRadius )
	local nInBonusEnemyList = J.GetAroundEnemyHeroList( nCastRange + 200 + nRadius )
	
	local nInRangeAllyHeroList = bot:GetNearbyHeroes( nCastRange + 350, false, BOT_MODE_NONE )
	local nInRangeAllyCreepList = bot:GetNearbyCreeps( nCastRange + 200, false )
	
	local hCastTarget = nil
	local sCastMotive = nil

	
	--击杀低血量敌人
	for _, npcEnemy in pairs( nInBonusEnemyList )
	do 
		if J.IsValid( npcEnemy )
			and J.CanCastOnMagicImmune( npcEnemy )
			and J.CanKillTarget( npcEnemy, nDamage , nDamageType )
		then
			local bestTarget = nil
			local bestTargetHP = 9
			
			--优先通过治疗队友来击杀
			for _, npcAlly in pairs( nInRangeAllyHeroList )
			do 
				if J.IsInRange( npcAlly, npcEnemy, nRadius )
					and J.GetHP( npcAlly ) < bestTargetHP
				then
					bestTarget = npcAlly
					bestTargetHP = J.GetHP( npcAlly )				
				end
			end		
			if bestTarget ~= nil
			then		
				hCastTarget = bestTarget
				sCastMotive = 'Q-击杀1'..J.Chat.GetNormName( npcEnemy )
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
			end
			
			--通过治疗小兵击杀敌人
			for _, creep in pairs( nInRangeAllyCreepList )
			do 
				if J.IsInRange( creep, npcEnemy, nRadius )
					and J.GetHP( creep ) < bestTargetHP
				then
					bestTarget = creep
					bestTargetHP = J.GetHP( creep )				
				end
			end		
			if bestTarget ~= nil
			then		
				hCastTarget = bestTarget
				sCastMotive = 'Q-击杀2'..J.Chat.GetNormName( npcEnemy )
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
			end			
		end
	end
	
	
	--攻击和撤退
	if J.IsGoingOnSomeone( bot ) 
		or J.IsRetreating( bot ) 
	then
		
		local bestTarget = nil
		local bestAoeCount = 0
	
		for _, npcAlly in pairs( hAllyList )
		do 
			if J.IsInRange( bot, npcAlly, nCastRange )
				and npcAlly:GetMaxHealth() - npcAlly:GetHealth() > nDamage + 50
			then
				local nearbyEnemyList = npcAlly:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE )
				if #nearbyEnemyList > bestAoeCount
				then
					bestAoeCount = #nearbyEnemyList 
					bestTarget = npcAlly
				end		
			end
		end
		
		if bestTarget ~= nil
		then
			local nearbyEnemyList = bestTarget:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE)
			for _, npcEnemy in pairs( nearbyEnemyList )
			do 
				if J.CanCastOnMagicImmune( npcEnemy )
				then
					hCastTarget = bestTarget
					sCastMotive = 'Q-AOE:'..J.Chat.GetNormName( bestTarget )
					return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
				end
			end
		end
		
		
		if J.IsValidHero( botTarget )
			and J.IsInRange( bot, botTarget, nRadius )
			and J.CanCastOnMagicImmune( botTarget )
			and	bot:GetMaxHealth() - bot:GetHealth() > nDamage
		then
			hCastTarget = bot
			sCastMotive = 'Q-攻击时奶自己'..J.Chat.GetNormName( hCastTarget )
			return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
		end
	end
	
	
	--奶队友
	for i = 1, 5
	do 
		local npcAlly = GetTeamMember( i )
		if npcAlly ~= nil
			and npcAlly:IsAlive()
			and not npcAlly:HasModifier( 'modifier_fountain_aura' )
			and J.IsInRange( bot, npcAlly, nCastRange )
			and ( J.GetHP( npcAlly ) < 0.15 
					or ( J.GetHP( npcAlly ) < 0.3 and npcAlly:WasRecentlyDamagedByAnyHero( 3.0 ) ) )
		then
			hCastTarget = npcAlly
			sCastMotive = 'Q-奶队友:'..J.Chat.GetNormName( hCastTarget )
			return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive		
		end	
	end
	
	
	--对线
	if J.IsLaning( bot )
	then
		for _, npcAlly in pairs( nInRangeAllyHeroList )
		do 
			if npcAlly:GetMaxHealth() - npcAlly:GetHealth() > nDamage * 1.2
			then
				local nearbyEnemyList = npcAlly:GetNearbyHeroes( nRadius - 20, true, BOT_MODE_NONE )
				if J.IsValidHero( nearbyEnemyList[1] )
					and J.CanCastOnMagicImmune(  nearbyEnemyList[1]  )
				then
					hCastTarget = npcAlly
					sCastMotive = 'Q-对线治疗'..J.Chat.GetNormName( npcAlly )
					return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
				end
			end
		end
	end
	
	
	--推线
	local enemyLaneCreepList = bot:GetNearbyLaneCreeps( 1600, true )
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost )
		and #hAllyList <= 3 and #enemyLaneCreepList >= 3
	then
		--以自己为Aoe中心
		local laneCreepList = bot:GetNearbyLaneCreeps( nRadius , true )
		if ( #laneCreepList >= 4 or ( #laneCreepList >= 3 and nMP > 0.82 ) )
			and not laneCreepList[1]:HasModifier( "modifier_fountain_glyph" )
		then			
			hCastTarget = bot
			sCastMotive = 'Q-带线AOE'..(#laneCreepList)
			return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
		end
		
		--以小兵为中心
		if enemyLaneCreepList[1] ~= nil 
			and not enemyLaneCreepList[1]:HasModifier('modifier_fountain_glyph')
		then
		
			local bestTarget = nil
			local bestAoeCount = 0
			
			for _, creep in pairs( nInRangeAllyCreepList )
			do 	
				local creepCount = 0
				for i = 1, #enemyLaneCreepList
				do 
					if enemyLaneCreepList[i]:GetHealth() < nDamage
					then
						creepCount = creepCount + 1
					end
				end
				
				if creepCount > bestAoeCount
				then
					bestTarget = creep
					bestAoeCount = creepCount
				end
				
			end
			
			if bestTarget ~= nil and bestAoeCount >= 3 
			then
				hCastTarget = bestTarget
				sCastMotive = 'Q-清兵AOE'..(bestAoeCount)
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive			
			end
		end
	end
	
	
	--打钱
	if J.IsFarming( bot )
		and J.IsAllowedToSpam( bot, nManaCost )
		and ( bot:GetMaxHealth() - bot:GetHealth() > nDamage or nMP > 0.85 )
	then
		local creepList = bot:GetNearbyNeutralCreeps( nRadius - 20 )

		if ( #creepList >= 3 or ( #creepList >= 2 and nMP > 0.88 ) )
		then
			hCastTarget = bot
			sCastMotive = 'Q-打野AOE'..(#creepList)
			return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
	    end	
	end

	
	--肉山
	if J.IsDoingRoshan( bot ) and bot:GetMana() > 660
	then
		for _, npcAlly in pairs( hAllyList )
		do 
			if npcAlly:GetMaxHealth() - npcAlly:GetHealth() > nDamage
			then
				local allyTarget = npcAlly:GetAttackTarget()
				if J.IsRoshan( allyTarget )
					and J.IsInRange( npcAlly, allyTarget, nRadius )
				then
					hCastTarget = npcAlly
					sCastMotive = 'Q-肉山'..J.Chat.GetNormName( hCastTarget )
					return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
				end
			end
		end
	end
	
	

	return BOT_ACTION_DESIRE_NONE


end

function X.ConsiderW()


	if not J.CanCastAbility(abilityW) then return 0 end

	local nSkillLV = abilityW:GetLevel()
	local nCastRange = abilityW:GetCastRange() + aetherRange
	local nRadius = 600
	local nCastPoint = abilityW:GetCastPoint()
	local nManaCost = abilityW:GetManaCost()
	local nDamage = 0
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nDuration = abilityW:GetSpecialValueInt( "duration" )
	local nHealHealth = abilityW:GetSpecialValueInt( "hp_regen" ) * nDuration
--	local nInRangeEnemyList = J.GetAroundEnemyHeroList( nCastRange )
--	local nInBonusEnemyList = J.GetAroundEnemyHeroList( nCastRange + 200 )
	local hCastTarget = nil
	local sCastMotive = nil

	for _, npcAlly in pairs( hAllyList )
	do 
		if J.IsValidHero( npcAlly )
			and J.IsInRange( bot, npcAlly, nCastRange + 300 )
			and not npcAlly:HasModifier( 'modifier_omniknight_repel' )
			and not npcAlly:IsMagicImmune()
			and not npcAlly:IsInvulnerable()
			and not npcAlly:IsIllusion()
		then
		
		
			--为加状态抗性
			if not npcAlly:IsBot()
				and npcAlly:GetLevel() >= 6
				and npcAlly:GetAttackTarget() ~= nil
				and npcAlly:GetAttackTarget():IsHero()
				and npcAlly:GetMaxHealth() - npcAlly:GetHealth() >= nHealHealth * 0.8
			then
				hCastTarget = npcAlly
				sCastMotive = 'W-加状态抗性:'..J.Chat.GetNormName( hCastTarget )
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive	
			end
		
			--为被控制队友解状态
			if J.IsDisabled( npcAlly )
			then
				hCastTarget = npcAlly
				sCastMotive = 'W-解状态:'..J.Chat.GetNormName( hCastTarget )
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive			
			end

			--为撤退中的队友加血
			if J.IsRetreating( npcAlly )
				and not npcAlly:HasModifier( 'modifier_fountain_aura' )
				and npcAlly:GetMaxHealth() - npcAlly:GetHealth() >= nHealHealth * 0.7
				and npcAlly:WasRecentlyDamagedByAnyHero( 3.0 )
			then
				hCastTarget = npcAlly
				sCastMotive = 'W-加撤退中的队友:'..J.Chat.GetNormName( hCastTarget )
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
			end
			
			
			--为准备打架的力量队友辅助
			if J.IsGoingOnSomeone( npcAlly )
				and npcAlly:GetPrimaryAttribute() == ATTRIBUTE_STRENGTH
			then
				local allyTarget = J.GetProperTarget( npcAlly )
				if J.IsValidHero( allyTarget )
					and npcAlly:IsFacingLocation( allyTarget:GetLocation(), 20 )
					and J.IsInRange( npcAlly, allyTarget, npcAlly:GetAttackRange() + 60 )
				then
					hCastTarget = npcAlly
					sCastMotive = 'W-进攻辅助力量队友:'..J.Chat.GetNormName( hCastTarget )
					return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive
				end
			end
			
			--为残血队友buff
			if J.GetHP( npcAlly ) < 0.5
				and ( npcAlly:WasRecentlyDamagedByAnyHero( 5.0 ) or J.GetHP( npcAlly ) < 0.25 ) 
				and not npcAlly:HasModifier( 'modifier_fountain_aura' )
			then
				hCastTarget = npcAlly
				sCastMotive = 'W-为队友回血:'..J.Chat.GetNormName( hCastTarget )
				return BOT_ACTION_DESIRE_HIGH, hCastTarget, sCastMotive			
			end			
		end
	end


	return BOT_ACTION_DESIRE_NONE


end



function X.ConsiderE()


	if not J.CanCastAbility(abilityE) then return 0 end
	
	local nCastRange = abilityE:GetCastRange()
	local nCastPoint = abilityE:GetCastPoint()
	local nManaCost = abilityE:GetManaCost()
	local nSkillLV = abilityE:GetLevel()
	local nDamage = 25 * nSkillLV + 25 + bot:GetAttackDamage() * ( 0.5 + nSkillLV * 0.1 )
	local nDamageType = DAMAGE_TYPE_PURE

	local allyList =  bot:GetNearbyHeroes( 1200, false, BOT_MODE_NONE )

	local nEnemysHerosInView = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )


	local nEnemysHerosInRange = bot:GetNearbyHeroes( nCastRange + 43, true, BOT_MODE_NONE )
	local nEnemysHerosInBonus = bot:GetNearbyHeroes( nCastRange + 330, true, BOT_MODE_NONE )

	--击杀
	for _, npcEnemy in pairs( nEnemysHerosInBonus )
	do
		if J.IsValid( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
		then
		
			if GetUnitToUnitDistance( bot, npcEnemy ) <= nCastRange + 80
				and J.CanKillTarget( npcEnemy, nDamage * 1.18, nDamageType )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end

		end
	end


	--对线期间对敌方英雄使用
	if bot:GetActiveMode() == BOT_MODE_LANING or nLV <= 5
	then
		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and J.GetHP( npcEnemy ) < 0.6
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end
		end
	end


	--打架时先手
	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = J.GetProperTarget( bot )
		if J.IsValidHero( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and J.CanCastOnTargetAdvanced( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange + 80 )
		then
			if nSkillLV >= 3 or nMP > 0.68 or J.GetHP( npcTarget ) < 0.4 or nHP < 0.25
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget
			end
		end
	end

	--撤退时保护自己
	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and ( bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
						or nMP > 0.8
						or GetUnitToUnitDistance( bot, npcEnemy ) <= 400 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end
		end
	end

	if J.IsFarming( bot )
		and nSkillLV >= 3
		and ( bot:GetAttackDamage() < 200 or nMP > 0.88 )
		and nMP > 0.71 and #hEnemyList == 0
	then
		local nCreeps = bot:GetNearbyNeutralCreeps( nCastRange + 100 )

		local targetCreep = bot:GetAttackTarget()

		if J.IsValid( targetCreep )
			and bot:IsFacingLocation( targetCreep:GetLocation(), 46 )
			and ( #nCreeps >= 2 or GetUnitToUnitDistance( targetCreep, bot ) <= 400 )
			and not J.IsRoshan( targetCreep )
			and not J.IsOtherAllysTarget( targetCreep )
			and not J.CanKillTarget( targetCreep, bot:GetAttackDamage() * 1.68, DAMAGE_TYPE_PHYSICAL )
			and not J.CanKillTarget( targetCreep, nDamage, nDamageType )
		then
			return BOT_ACTION_DESIRE_HIGH, targetCreep
		end
	end

	
	--打肉的时候输出
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and bot:GetMana() >= 600
	then
		local npcTarget = bot:GetAttackTarget()
		if J.IsRoshan( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget
		end
	end

	--受到伤害时保护自己
	if bot:WasRecentlyDamagedByAnyHero( 3.0 )
		and bot:GetActiveMode() ~= BOT_MODE_RETREAT
		and #nEnemysHerosInRange >= 1
		and nLV >= 8
	then
		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and npcEnemy:IsFacingLocation( bot:GetLocation(), 45 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end
		end
	end
	

	return BOT_ACTION_DESIRE_NONE


end

function X.ConsiderR()


	if not J.CanCastAbility(abilityR) then return 0 end

	local nRadius = abilityR:GetSpecialValueInt( 'radius' )	
	local nCastRange = nRadius
	
	if bot:HasScepter() then nCastRange = 1600 end

	local hCastTarget = nil
	local sCastMotive = nil

	
	if J.IsGoingOnSomeone( bot ) 
		and nHP < ( #hEnemyList >= 3 and 0.65 or 0.45 )
		and bot:WasRecentlyDamagedByAnyHero( 4.0 )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( bot, botTarget, 500 )
			and J.CanCastOnMagicImmune( botTarget )
			and not J.IsSuspiciousIllusion(botTarget)
			and not J.IsDisabled( botTarget )
			and not botTarget:IsDisarmed()
			and botTarget:GetAttackTarget() == bot
		then
			hCastTarget = bot:GetLocation()
			return BOT_ACTION_DESIRE_HIGH, hCastTarget					
		end
	end
	
	
	
	for i = 1, 5
	do 
		local npcAlly = GetTeamMember( i )
		if npcAlly ~= nil
			and npcAlly:IsAlive()
			and ( bot:HasScepter() or J.IsInRange( bot, npcAlly, 700 ) )
		then
			if J.IsInTeamFight( npcAlly, 1300 )
			then
				local allyList = J.GetAlliesNearLoc( npcAlly:GetLocation(), nCastRange )
				local enemyList = npcAlly:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )
				if #enemyList >= 2 
					and ( #enemyList >= #allyList or #enemyList >= 3 )
				then
					local guardianCount = 0
					for _, allyHero in pairs(allyList)
					do 
						if allyHero:WasRecentlyDamagedByAnyHero(3.0)
							and J.GetHP( allyHero ) < 0.8
						then
						
							guardianCount = guardianCount + 1
							
							if J.GetHP( allyHero ) < 0.4 then guardianCount = guardianCount + 1 end
						
						end
					end
					
					if guardianCount >= 2
					then
						hCastTarget = npcAlly:GetLocation()
						return BOT_ACTION_DESIRE_HIGH, hCastTarget	
					end
				end
			end
			if J.IsRetreating( npcAlly )
				and npcAlly:WasRecentlyDamagedByAnyHero( 5.0 )
			then
				local attackModeAlly = npcAlly:GetNearbyHeroes( nRadius, false, BOT_MODE_ATTACK )
				local retreatModeAlly = npcAlly:GetNearbyHeroes( nRadius, false, BOT_MODE_RETREAT )
				if ( #attackModeAlly >= 2 or ( #attackModeAlly >= 1 and #retreatModeAlly >= 2 ) )
				then
					hCastTarget = npcAlly:GetLocation()
					return BOT_ACTION_DESIRE_HIGH, hCastTarget	
				end
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE
end

return X