local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_warlock'
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
                [1] = {},
            },
            ['ability'] = {
                [1] = {},
            },
            ['buy_list'] = {},
            ['sell_list'] = {},
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
				}
            },
            ['ability'] = {
                [1] = {1,3,3,1,3,6,3,1,1,2,6,2,2,2,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_magic_stick",
				"item_blood_grenade",
				"item_enchanted_mango",
			
				"item_tranquil_boots",
				"item_magic_wand",
				"item_glimmer_cape",--
				"item_aghanims_shard",
				"item_force_staff",
				"item_boots_of_bearing",--
				"item_ultimate_scepter",
				"item_refresher",--
				"item_aeon_disk",--
				"item_ultimate_scepter_2",
				"item_assault",--
				"item_moon_shard",
				"item_hurricane_pike",--
			},
            ['sell_list'] = {
				"item_magic_wand", "item_aeon_disk",
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
                [1] = {1,3,3,1,3,6,3,1,1,2,6,2,2,2,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_magic_stick",
				"item_blood_grenade",
				"item_enchanted_mango",
			
				"item_arcane_boots",
				"item_magic_wand",
				"item_glimmer_cape",--
				"item_aghanims_shard",
				"item_force_staff",
				"item_guardian_greaves",--
				"item_ultimate_scepter",
				"item_refresher",--
				"item_aeon_disk",--
				"item_ultimate_scepter_2",
				"item_assault",--
				"item_moon_shard",
				"item_hurricane_pike",--
			},
            ['sell_list'] = {
				"item_magic_wand", "item_aeon_disk",
			},
        },
    },
}

local sSelectedBuild = HeroBuild[sRole][RandomInt(1, #HeroBuild[sRole])]

local nTalentBuildList = J.Skill.GetTalentBuild(J.Skill.GetRandomBuild(sSelectedBuild.talent))
local nAbilityBuildList = J.Skill.GetRandomBuild(sSelectedBuild.ability)

X['sBuyList'] = sSelectedBuild.buy_list
X['sSellList'] = sSelectedBuild.sell_list

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_priest' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = true

function X.MinionThink( hMinionUnit )

	if Minion.IsValidUnit( hMinionUnit )
		and ( not J.IsKeyWordUnit( 'npc_dota_warlock_minor_imp', hMinionUnit ) )
	then
		Minion.IllusionThink( hMinionUnit )
	end

end

end

--[[

npc_dota_hero_warlock

"Ability1"		"warlock_fatal_bonds"
"Ability2"		"warlock_shadow_word"
"Ability3"		"warlock_upheaval"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"warlock_rain_of_chaos"
"Ability10"		"special_bonus_unique_warlock_5"
"Ability11"		"special_bonus_cast_range_150"
"Ability12"		"special_bonus_exp_boost_60"
"Ability13"		"special_bonus_unique_warlock_3"
"Ability14"		"special_bonus_unique_warlock_4"
"Ability15"		"special_bonus_unique_warlock_6"
"Ability16"		"special_bonus_unique_warlock_2"
"Ability17"		"special_bonus_unique_warlock_1"

modifier_warlock_fatal_bonds
modifier_warlock_shadow_word
modifier_warlock_upheaval
modifier_warlock_rain_of_chaos_death_trigger
modifier_warlock_rain_of_chaos_thinker
modifier_special_bonus_unique_warlock_1
modifier_special_bonus_unique_warlock_2
modifier_warlock_golem_flaming_fists
modifier_warlock_golem_permanent_immolation
modifier_warlock_golem_permanent_immolation_debuff

--]]


local abilityQ = bot:GetAbilityByName('warlock_fatal_bonds')
local abilityW = bot:GetAbilityByName('warlock_shadow_word')
local abilityE = bot:GetAbilityByName('warlock_upheaval')
local abilityR = bot:GetAbilityByName('warlock_rain_of_chaos')
local talent2 = bot:GetAbilityByName( sTalentList[2] )
local talent6 = bot:GetAbilityByName( sTalentList[6] )


local castQDesire, castQTarget
local castWDesire, castWTarget
local castEDesire, castELocation
local castRDesire, castRLocation
local castRFRDesire, castRFRLocation


local nKeepMana, nMP, nHP, nLV, hEnemyHeroList
local aetherRange = 0



local abilityRef = nil

function X.SkillsComplement()




	if X.ConsiderStop() == true
	then
		bot:Action_ClearActions( true )
		return
	end


	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	abilityQ = bot:GetAbilityByName('warlock_fatal_bonds')
	abilityW = bot:GetAbilityByName('warlock_shadow_word')
	abilityE = bot:GetAbilityByName('warlock_upheaval')
	abilityR = bot:GetAbilityByName('warlock_rain_of_chaos')

	nKeepMana = 400
	aetherRange = 0
	nLV = bot:GetLevel()
	nMP = bot:GetMana()/bot:GetMaxMana()
	nHP = bot:GetHealth()/bot:GetMaxHealth()
	hEnemyHeroList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	abilityRef = J.IsItemAvailable( "item_refresher" )



	local aether = J.IsItemAvailable( "item_aether_lens" )
	if aether ~= nil then aetherRange = 250 end


	castRFRDesire, castRFRLocation = X.ConsiderRFR()
	if ( castRFRDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRFRLocation + RandomVector( 50 ) )
		bot:ActionQueue_UseAbility( abilityRef )
		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRFRLocation + RandomVector( 50 ) )
		--bot:ActionImmediate_Chat( "Heed my call! Hellfire from the abyss! Come out!!!", true )
		return

	end


	castRDesire, castRLocation = X.ConsiderR()
	if ( castRDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRLocation )
		return

	end


	castQDesire, castQTarget = X.ConsiderQ()
	if ( castQDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end


	castWDesire, castWTarget = X.ConsiderW()
	if ( castWDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )
		
		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )

		return
	end

	castEDesire, castELocation = X.ConsiderE()
	if ( castEDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityE, castELocation )
		return
	end


end

function X.ConsiderStop()

	if bot:IsChanneling()
		and not bot:HasModifier( "modifier_teleporting" )
		and bot:GetActiveMode() ~= BOT_MODE_SIDE_SHOP
		and not J.CanCastAbility(abilityE)
	then
		local tableEnemyHeroes = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
		local tableAllyHeroes = bot:GetNearbyHeroes( 1600, false, BOT_MODE_NONE )
		if J.CanCastAbility(abilityR)
			or J.CanCastAbility(abilityQ)
			or J.CanCastAbility(abilityW)
			or #tableEnemyHeroes == 0
			or #tableAllyHeroes == 1
		then
			return true
		end
	end


	return false
end

function X.ConsiderR()

	if not J.CanCastAbility(abilityR) then return BOT_ACTION_DESIRE_NONE, nil	end

	if J.CanCastAbility(abilityQ)
	and abilityR ~= nil
		and bot:GetMana() >= ( abilityQ:GetManaCost() + abilityR:GetManaCost() )
		and nHP > 0.5
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityR:GetCastRange() + aetherRange
	local nCastPoint = abilityR:GetCastPoint()
	local manaCost = abilityR:GetManaCost()
	local nRadius = abilityR:GetSpecialValueInt( "aoe" )
	local hTrueHeroList = J.GetEnemyList( bot, 1400 )


	local locationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
	if ( locationAoE.count >= 2 and #hTrueHeroList >= 2 )
		or locationAoE.count >= 3
	then
		return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc
	end
	if locationAoE.count >= 1 and J.GetHP( bot ) < 0.38 and #hTrueHeroList >= 1
	then
		return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc
	end


	--进攻时
	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = J.GetProperTarget( bot )
		if J.IsValidHero( npcTarget )
			and J.CanCastOnMagicImmune( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange + 200 )
		then
			if #hTrueHeroList >= 2 then
				return BOT_ACTION_DESIRE_HIGH, npcTarget:GetExtrapolatedLocation( nCastPoint )
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderRFR()

	if not J.CanCastAbility(abilityR)
		or not J.CanCastAbility(abilityRef)
	then return BOT_ACTION_DESIRE_NONE, nil end

	if J.CanCastAbility(abilityQ)
	and abilityR ~= nil
		and bot:GetMana() >= ( abilityQ:GetManaCost() + abilityR:GetManaCost() )
		and nHP > 0.5
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	if bot:GetMana() < abilityR:GetManaCost() * 2 + abilityRef:GetManaCost()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityR:GetCastRange() + aetherRange
	local nCastPoint = abilityR:GetCastPoint()
	local manaCost = abilityR:GetManaCost()
	local nRadius = abilityR:GetSpecialValueInt( "aoe" )
	local hTrueHeroList = J.GetEnemyList( bot, 1600 )

	--进攻时
	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = J.GetProperTarget( bot )
		if J.IsValidHero( npcTarget )
			and J.CanCastOnMagicImmune( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange + 200 )
		then
			if #hTrueHeroList >= 3 then
				return BOT_ACTION_DESIRE_HIGH, npcTarget:GetExtrapolatedLocation( nCastPoint )
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderE()

	if not J.CanCastAbility(abilityE) then return BOT_ACTION_DESIRE_NONE, nil end

	if J.CanCastAbility(abilityR)
		or J.CanCastAbility(abilityQ)
		or J.CanCastAbility(abilityW)
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityE:GetCastRange() + 30 + aetherRange
	local nCastPoint = abilityE:GetCastPoint()
	local manaCost = abilityE:GetManaCost()
	local nRadius = abilityE:GetSpecialValueInt( "aoe" )

	if J.IsInTeamFight( bot, 1200 )
	then
		local locationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius/2, 0, 0 )
		if ( locationAoE.count >= 2 )
		then
			return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc
		end
	end

	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = J.GetProperTarget( bot )
		if J.IsValidHero( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange + 200 )
		then
			local enemies = npcTarget:GetNearbyHeroes( nRadius, false, BOT_MODE_NONE )
			if #enemies >= 2 then
				return BOT_ACTION_DESIRE_HIGH, npcTarget:GetExtrapolatedLocation( nCastPoint )
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

local lastCheck = -90
function X.ConsiderW()

	if not J.CanCastAbility(abilityW) then	return BOT_ACTION_DESIRE_NONE, nil	end

	local nCastRange = abilityW:GetCastRange() + 50 + aetherRange
	local nCastPoint = abilityW:GetCastPoint()
	local manaCost = abilityW:GetManaCost()
	local nRadius = 0

	if talent6:IsTrained() then nRadius = 250 end

	if DotaTime() >= lastCheck + 0.5 then
		local weakest = nil
		local minHP = 100000
		local allies = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
		if #allies > 0 then
			for i=1, #allies do
				if not allies[i]:HasModifier( "modifier_warlock_shadow_word" )
					and J.CanCastOnNonMagicImmune( allies[i] )
					and allies[i]:GetHealth() <= minHP
	 				and allies[i]:GetHealth() <= 0.65 * allies[i]:GetMaxHealth()
				then
					weakest = allies[i]
					minHP = allies[i]:GetHealth()
				end
			end
		end
		if weakest ~= nil 
		then
			return BOT_ACTION_DESIRE_HIGH, weakest
		end
		lastCheck = DotaTime()
	end

	if J.IsInTeamFight( bot, 1200 )
	then

		if talent6:IsTrained() and false
		then
			local locationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if ( locationAoE.count >= 2 )
			then
				return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc
			end
		else

			local npcWeakestEnemy = nil
			local npcWeakestEnemyHealth = 10000
			local nEnemysHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
			for _, npcEnemy in pairs( nEnemysHeroesInRange )
			do
				if J.IsValid( npcEnemy )
					and J.CanCastOnNonMagicImmune( npcEnemy )
					and J.CanCastOnTargetAdvanced( npcEnemy )
					and not npcEnemy:HasModifier( "modifier_warlock_shadow_word" )
				then
					local npcEnemyHealth = npcEnemy:GetHealth()
					if ( npcEnemyHealth < npcWeakestEnemyHealth )
					then
						npcWeakestEnemyHealth = npcEnemyHealth
						npcWeakestEnemy = npcEnemy
					end
				end
			end

			if ( npcWeakestEnemy ~= nil )
			then
				return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy
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
			and not target:HasModifier( "modifier_warlock_shadow_word" )
		then
			return BOT_ACTION_DESIRE_HIGH, target
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderQ()

	if not J.CanCastAbility(abilityQ) then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = abilityQ:GetCastRange() + 50 + aetherRange
	local nCastPoint = abilityQ:GetCastPoint()
	local manaCost = abilityQ:GetManaCost()
	local nRadius = abilityQ:GetSpecialValueInt( "search_aoe" )
	local nCount = abilityQ:GetSpecialValueInt( "count" )


	if J.IsInTeamFight( bot, 1000 )
	then
		local locationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
		if ( locationAoE.count >= 2 )
		then
			local nEnemyHeroes = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
			if J.IsValidHero( nEnemyHeroes[1] )
				and J.CanCastOnNonMagicImmune( nEnemyHeroes[1] )
				and J.CanCastOnTargetAdvanced( nEnemyHeroes[1] )
			then
				return  BOT_ACTION_DESIRE_HIGH, nEnemyHeroes[1]
			end
		end
	end

	if J.IsRetreating( bot )
	then
		local target = J.GetVulnerableWeakestUnit( bot, true, true, nCastRange - 100 )
		if target ~= nil and J.GetUnitAllyCountAroundEnemyTarget( target, nRadius ) >= 3 then
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
			if J.GetAroundTargetEnemyUnitCount( target, nRadius ) >= 3 then
				return BOT_ACTION_DESIRE_HIGH, target
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end

return X
