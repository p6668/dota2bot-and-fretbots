local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_kunkka'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {"item_pipe", "item_heavens_halberd", "item_lotus_orb"}
local sUtilityItem = RI.GetBestUtilityItem(sUtility)

local HeroBuild = {
    ['pos_1'] = {
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
                [1] = {2,1,2,3,2,6,2,3,3,3,6,1,1,1,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
				"item_circlet",
				"item_gauntlets",
			
				"item_magic_wand",
				"item_bracer",
				"item_phase_boots",
				"item_radiance",--
				"item_aghanims_shard",
				"item_black_king_bar",--
				"item_satanic",--
				"item_bloodthorn",--
				"item_greater_crit",--
				"item_moon_shard",
				"item_ultimate_scepter_2",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_quelling_blade", "item_satanic",
				"item_magic_wand", "item_bloodthorn",
				"item_bracer", "item_greater_crit",
			},
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
                [1] = {2,1,2,3,2,6,2,3,3,3,6,1,1,1,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
				"item_circlet",
				"item_gauntlets",
			
				"item_bottle",
				"item_magic_wand",
				"item_double_bracer",
				"item_phase_boots",
				"item_blade_mail",
				"item_aghanims_shard",
				"item_ultimate_scepter",
				"item_black_king_bar",--
				"item_shivas_guard",--
				"item_octarine_core",--
				"item_sheepstick",--
				"item_ultimate_scepter_2",
				"item_heart",--
				"item_moon_shard",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_quelling_blade", "item_blade_mail",
				"item_magic_wand", "item_ultimate_scepter",
				"item_bracer", "item_black_king_bar",
				"item_bracer", "item_shivas_guard",
				"item_bottle", "item_octarine_core",
				"item_blade_mail", "item_heart",
			},
        },
        [2] = {
            ['talent'] = {
				[1] = {
					['t25'] = {10, 0},
					['t20'] = {10, 0},
					['t15'] = {10, 0},
					['t10'] = {0, 10},
				}
            },
            ['ability'] = {
                [1] = {2,1,2,3,2,6,2,3,3,3,6,1,1,1,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
				"item_circlet",
				"item_gauntlets",
			
				"item_bottle",
				"item_magic_wand",
				"item_bracer",
				"item_phase_boots",
				"item_radiance",--
				"item_blade_mail",
				"item_aghanims_shard",
				"item_black_king_bar",--
				"item_satanic",--
				"item_bloodthorn",--
				"item_greater_crit",--
				"item_moon_shard",
				"item_ultimate_scepter_2",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_quelling_blade", "item_satanic",
				"item_magic_wand", "item_black_king_bar",
				"item_bottle", "item_satanic",
				"item_bracer", "item_bloodthorn",
				"item_blade_mail", "item_greater_crit",
			},
        },
    },
    ['pos_3'] = {
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
                [1] = {2,1,2,3,2,6,2,3,3,3,6,1,1,1,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
				"item_circlet",
				"item_gauntlets",
			
				"item_magic_wand",
				"item_boots",
				"item_double_bracer",
				"item_phase_boots",
				"item_blade_mail",
				"item_crimson_guard",--
				"item_aghanims_shard",
				"item_ultimate_scepter",
				sUtilityItem,--
				"item_black_king_bar",--
				"item_shivas_guard",--
				"item_ultimate_scepter_2",
				"item_octarine_core",--
				"item_moon_shard",
				"item_travel_boots_2",--
			},
            ['sell_list'] = {
				"item_quelling_blade", "item_crimson_guard",
				"item_magic_wand", "item_ultimate_scepter",
				"item_bracer", sUtilityItem,
				"item_bracer", "item_black_king_bar",
				"item_blade_mail", "item_octarine_core",
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

--[[

npc_dota_hero_kunkka

"Ability1"		"kunkka_torrent"
"Ability2"		"kunkka_tidebringer"
"Ability3"		"kunkka_x_marks_the_spot"
"Ability4"		"kunkka_torrent_storm"
"Ability5"		"generic_hidden"
"Ability6"		"kunkka_ghostship"
"Ability7"		"kunkka_return"
"Ability10"		"special_bonus_attack_damage_40"
"Ability11"		"special_bonus_armor_6"
"Ability12"		"special_bonus_hp_regen_12"
"Ability13"		"special_bonus_unique_kunkka_2"
"Ability14"		"special_bonus_unique_kunkka"
"Ability15"		"special_bonus_strength_25"
"Ability16"		"special_bonus_unique_kunkka_3"
"Ability17"		"special_bonus_unique_kunkka_4"

modifier_kunkka_torrent_thinker
modifier_kunkka_torrent
modifier_kunkka_torrent_slow
modifier_kunkka_tidebringer
modifier_kunkka_x_marks_the_spot
modifier_kunkka_x_marks_the_spot_marker
modifier_kunkka_x_marks_the_spot_thinker
modifier_kunkka_ghost_ship_fleet
modifier_kunkka_ghost_ship_knockback
modifier_kunkka_ghost_ship_loaded
modifier_kunkka_ghost_ship_damage_absorb
modifier_kunkka_ghost_ship_damage_delay

--]]

local abilityQ = bot:GetAbilityByName('kunkka_torrent')
local abilityW = bot:GetAbilityByName('kunkka_tidebringer')
local abilityE = bot:GetAbilityByName('kunkka_x_marks_the_spot')
local abilityE2 = bot:GetAbilityByName( 'kunkka_return' )
-- local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityAS = bot:GetAbilityByName('kunkka_tidal_wave')
local abilityR = bot:GetAbilityByName('kunkka_ghostship')


local castQDesire, castQLocation
local castWDesire, castWTarget
local castEDesire, castETarget
local castASDesire, castASTarget
local castE2Desire
-- local castDDesire
local castRDesire, castRLocation
local Combo1Desire, C1Target, C1Location
local Combo2Desire, C2Target, C2Location
local Combo3Desire, C3Target, C3Location

local nKeepMana, nMP, nHP, nLV, hEnemyHeroList



local Combo1Time = 0 --X船水  0.4, 0.3, 0.4, 0.4.
local Combo2Time = 0 --X船
local Combo3Time = 0 --X水

local C1Delay = 2.25 --2.3MAX
local C2Delay = 3.35 --3.4MAX
local C3Delay = 1.95 --2.0MAX 0.4 + 0.4 + 1.6 - 0.4

function X.SkillsComplement()

	if not bot:IsAlive()
	then
		Combo1Time = 0
		Combo2Time = 0
		Combo3Time = 0
	end

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	abilityQ = bot:GetAbilityByName('kunkka_torrent')
	abilityW = bot:GetAbilityByName('kunkka_tidebringer')
	abilityE = bot:GetAbilityByName('kunkka_x_marks_the_spot')
	abilityE2 = bot:GetAbilityByName( 'kunkka_return' )
	abilityAS = bot:GetAbilityByName('kunkka_tidal_wave')
	abilityR = bot:GetAbilityByName('kunkka_ghostship')

	nKeepMana = 240
	nMP = bot:GetMana()/bot:GetMaxMana()
	nHP = bot:GetHealth()/bot:GetMaxHealth()
	nLV = bot:GetLevel()
	hEnemyHeroList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )



	--三连的最后一下
	if abilityE2 ~= nil and abilityE2:IsHidden() == false
		and J.CanCastAbility(abilityE2)
		and ( ( Combo3Time ~= 0 and DotaTime() >= Combo3Time + C3Delay )
			or ( Combo1Time ~= 0 and DotaTime() >= Combo1Time + C1Delay )
			or ( Combo2Time ~= 0 and DotaTime() >= Combo2Time + C2Delay ) )
	then
		Combo1Time = 0
		Combo2Time = 0
		Combo3Time = 0
		bot:Action_UseAbility( abilityE2 )
		return
	end

	if abilityE2 ~= nil and abilityE2:IsHidden() == true
		or J.CanCastAbility(abilityE)
	then
		Combo1Time = 0
		Combo2Time = 0
		Combo3Time = 0
	end

	--正在连招的过程中
	if Combo1Time ~= 0
		or Combo2Time ~= 0
		or Combo2Time ~= 0
	then
		return
	end

	--连招一 X船水
	Combo1Desire, C1Target, C1Location = X.ConsiderCombo1()
	if Combo1Desire > 0
	then
		Combo1Time = DotaTime()
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityE, C1Target )
		bot:ActionQueue_UseAbilityOnLocation( abilityR, C1Location )
		bot:ActionQueue_UseAbilityOnLocation( abilityQ, C1Location )
		return
	end

	--连招二 X船
	Combo2Desire, C2Target, C2Location = X.ConsiderCombo2()
	if Combo2Desire > 0
	then
		Combo2Time = DotaTime()
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityE, C2Target )
		bot:ActionQueue_UseAbilityOnLocation( abilityR, C2Location )
		return
	end

	--连招三 X水
	Combo3Desire, C3Target, C3Location = X.ConsiderCombo3()
	if Combo3Desire > 0
	then
		Combo3Time = DotaTime()
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityE, C3Target )
		bot:ActionQueue_UseAbilityOnLocation( abilityQ, C3Location )
		return
	end

	--水
	castQDesire, castQLocation = X.ConsiderQ()
	if ( castQDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

	--X
	castEDesire, castETarget = X.ConsiderE()
	if ( castEDesire > 0 )
	then

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityE, castETarget )
		return
	end

	--船
	castRDesire, castRLocation = X.ConsiderR()
	if ( castRDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRLocation )
		return

	end

	--浪
	-- castDDesire, castDLocation = X.ConsiderD()
	-- if castDDesire > 0
	-- then
	-- 	J.SetQueuePtToINT( bot, true )

	-- 	bot:ActionQueue_UseAbilityOnLocation( abilityD, bot:GetLocation() )
	-- 	return

	-- end
	
	--魔晶
	castASDesire, castASTarget = X.ConsiderAS()
	if ( castASDesire > 0 )
	then
		
		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityAS, castASTarget )
		return

	end

	--刀
	castWDesire, castWTarget = X.ConsiderW()
	if ( castWDesire > 0 )
	then

		bot:Action_ClearActions( false )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return

	end

end


function X.GetTowardsFountainLocation( unitLoc, distance )
	local destination = {}
	if ( GetTeam() == TEAM_RADIANT ) then
		destination[1] = unitLoc[1] - distance / math.sqrt( 2 )
		destination[2] = unitLoc[2] - distance / math.sqrt( 2 )
	end

	if ( GetTeam() == TEAM_DIRE ) then
		destination[1] = unitLoc[1] + distance / math.sqrt( 2 )
		destination[2] = unitLoc[2] + distance / math.sqrt( 2 )
	end
	return Vector( destination[1], destination[2] )
end

--X船水
function X.ConsiderCombo1()
	if GetBot():GetUnitName() == 'npc_dota_hero_rubick'
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	if not J.CanCastAbility(abilityQ)
		or not J.CanCastAbility(abilityE)
		or not J.CanCastAbility(abilityR)
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local CurrMana = bot:GetMana()

	local ComboMana = abilityQ:GetManaCost() + abilityE:GetManaCost() + abilityR:GetManaCost()

	if ComboMana > CurrMana then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityE:GetCastRange() + 38

	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = bot:GetTarget()
		if ( J.IsValidHero( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and GetUnitToUnitDistance( npcTarget, bot ) > nCastRange/2
			and GetUnitToUnitDistance( npcTarget, bot ) < nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget, J.GetFaceTowardDistanceLocation( npcTarget, 30 )
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end


--X船
function X.ConsiderCombo2()
	if GetBot():GetUnitName() == 'npc_dota_hero_rubick'
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	if not J.CanCastAbility(abilityR) or not J.CanCastAbility(abilityE)
	then
		return BOT_ACTION_DESIRE_NONE, nil, {}
	end

	local CurrMana = bot:GetMana()

	local ComboMana = abilityR:GetManaCost() + abilityE:GetManaCost()

	if ComboMana > CurrMana then
		return BOT_ACTION_DESIRE_NONE, nil, {}
	end

	local nCastRange = abilityE:GetCastRange() + 38

	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = bot:GetTarget()
		if ( J.IsValidHero( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and GetUnitToUnitDistance( npcTarget, bot ) < nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget, npcTarget:GetLocation()
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil, {}
end


--X水
function X.ConsiderCombo3()
	if GetBot():GetUnitName() == 'npc_dota_hero_rubick'
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	if not J.CanCastAbility(abilityQ) or not J.CanCastAbility(abilityE) or J.CanCastAbility(abilityR)
	then
		return BOT_ACTION_DESIRE_NONE, nil, {}
	end

	local CurrMana = bot:GetMana()

	local ComboMana = abilityQ:GetManaCost() + abilityE:GetManaCost()

	if ComboMana > CurrMana then
		return BOT_ACTION_DESIRE_NONE, nil, {}
	end

	local nCastRange = abilityE:GetCastRange() + 38

	--打断持续施法
	local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE )
	for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling() )
		then
			return BOT_ACTION_DESIRE_MODERATE, npcEnemy, npcEnemy:GetLocation()
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = bot:GetTarget()
		if ( J.IsValidHero( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and GetUnitToUnitDistance( npcTarget, bot ) < nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget, J.GetFaceTowardDistanceLocation( npcTarget, 40 )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil, {}
end

-- function X.ConsiderD()

-- 	if not abilityD:IsFullyCastable()
-- 		or not bot:HasScepter()
-- 	then
-- 		return BOT_ACTION_DESIRE_NONE
-- 	end

-- 	if J.IsGoingOnSomeone( bot )
-- 	then
-- 		local npcTarget = J.GetProperTarget( bot )
-- 		if J.IsValidHero( npcTarget )
-- 			and J.IsInRange( bot, npcTarget, 300 )
-- 			and J.CanCastOnNonMagicImmune( npcTarget )
-- 		then
-- 			return BOT_ACTION_DESIRE_HIGH
-- 		end
-- 	end

-- 	if J.IsRetreating( bot ) or J.IsInTeamFight( bot, 1200 )
-- 	then
-- 		local nEnemyHeroList = J.GetEnemyList( bot, 1100 )
-- 		for _, enemy in pairs(nEnemyHeroList) do
-- 			if #nEnemyHeroList >= 3
-- 				or ( #nEnemyHeroList >= 2 and nHP <= 0.5 )
-- 				or ( #nEnemyHeroList >= 1 and nHP <= 0.4 and bot:WasRecentlyDamagedByHero( enemy, 3.0 ) )
-- 			then
-- 				return BOT_ACTION_DESIRE_HIGH
-- 			end
-- 		end
-- 	end

-- 	return BOT_ACTION_DESIRE_NONE

-- end


function X.ConsiderQ()

	if not J.CanCastAbility(abilityQ)
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastPoint = abilityQ:GetCastPoint()
	local nDelay = abilityQ:GetSpecialValueFloat( "delay" )

	if ( bot:GetActiveMode() == BOT_MODE_ROSHAN )
	then
		local npcTarget = bot:GetAttackTarget()
		if ( J.IsRoshan( npcTarget ) and J.CanCastOnMagicImmune( npcTarget ) and J.IsInRange( npcTarget, bot, 600 ) )
		then
			return BOT_ACTION_DESIRE_LOW, npcTarget:GetLocation()
		end
	end

	if J.CanCastAbility(abilityE)
	and abilityE:GetLevel() >= 3
		and bot:GetMana() > 160
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	if J.IsRetreating( bot )
	then
		local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE )
		for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( bot:WasRecentlyDamagedByHero( npcEnemy, 1.0 ) )
			then
				return BOT_ACTION_DESIRE_MODERATE, npcEnemy:GetExtrapolatedLocation( ( nDelay + nCastPoint ) * 0.68 )
			end
		end
	end

	--打断持续施法
	local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling() )
		then
			return BOT_ACTION_DESIRE_MODERATE, npcEnemy:GetLocation()
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = bot:GetTarget()
		if ( J.IsValidHero( npcTarget )
			and not J.IsRunning( npcTarget )
			and not J.IsMoving( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and GetUnitToUnitDistance( npcTarget, bot ) < 700 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget:GetExtrapolatedLocation( ( nDelay + nCastPoint ) * 0.68 )
		end
	end

	return BOT_ACTION_DESIRE_NONE, {}
end


function X.ConsiderE()

	if not J.CanCastAbility(abilityE)
		or J.CanCastAbility(abilityQ)
		or J.CanCastAbility(abilityR)
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityE:GetCastRange()

	if J.IsRetreating( bot )
	then
		local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE )
		for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if bot:WasRecentlyDamagedByHero( npcEnemy, 1.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
			then
				return BOT_ACTION_DESIRE_MODERATE, npcEnemy
			end
		end
	end

	local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1200, true, BOT_MODE_NONE )
	for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling()
			or ( bot:GetActiveMode() == BOT_MODE_ATTACK
				and #tableNearbyEnemyHeroes == 1
				and bot:GetLevel() >= 6
				and bot:IsFacingLocation( npcEnemy:GetLocation(), 30 )
				and npcEnemy:IsFacingLocation( J.GetEnemyFountain(), 30 ) ) )
		then
			return BOT_ACTION_DESIRE_MODERATE, npcEnemy
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end


function X.ConsiderR()

	if not J.CanCastAbility(abilityR) or J.CanCastAbility(abilityE) then
		return BOT_ACTION_DESIRE_NONE, nil
	end


	local nCastRange = abilityR:GetCastRange()
	local nRadius = abilityR:GetSpecialValueInt( "ghostship_width" )

	if J.IsRetreating( bot )
	then
		local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE )
		for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( bot:WasRecentlyDamagedByHero( npcEnemy, 1.0 ) )
			then
				return BOT_ACTION_DESIRE_MODERATE, X.GetTowardsFountainLocation( bot:GetLocation(), nCastRange - 200 )
			end
		end
	end

	--打断持续施法
	local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE )
	for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling() )
		then
			return BOT_ACTION_DESIRE_MODERATE, npcEnemy:GetLocation()
		end
	end


	--团战AOE
	if J.IsInTeamFight( bot, 1200 )
	then
		local locationAoE = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange * 0.8, nRadius, 0.8, 0 )
		local hTrueHeroList = J.GetEnemyList( bot, 1200 )
		if ( locationAoE.count >= 3 and #hTrueHeroList >= 2 )
		then
			return BOT_ACTION_DESIRE_MODERATE, locationAoE.targetloc
		end
	end

	return BOT_ACTION_DESIRE_NONE, nil
end


function X.ConsiderW()

	if not J.IsRunning( bot )
		or not J.CanCastAbility(abilityW)
	then return 0 end

	local npcTarget = J.GetProperTarget( bot )
	if not J.IsValid( npcTarget ) then return 0 end

	local nAttackRange = bot:GetAttackRange() + 40

	if nAttackRange < 200  then nAttackRange = 200  end

	local nNearbyEnemy = X.GetNearbyUnit( bot, npcTarget )

	if J.IsValid( nNearbyEnemy )
		and GetUnitToUnitDistance( npcTarget, bot ) >  nAttackRange 
	then
		return BOT_ACTION_DESIRE_HIGH, nNearbyEnemy
	end

	return BOT_ACTION_DESIRE_NONE

end


function X.GetNearbyUnit( bot, npcTarget )


	if bot:IsFacingLocation( npcTarget:GetLocation(), 39 )
	then
		local nCreeps = bot:GetNearbyCreeps( 240, true )
		for _, creep in pairs( nCreeps )
		do
			if J.IsValid( creep )
				and bot:IsFacingLocation( creep:GetLocation(), 38 )
			then
				return creep
			end
		end

		local nEnemys = bot:GetNearbyHeroes( 240, true, BOT_MODE_NONE )
		for _, enemy  in pairs( nEnemys )
		do
			if J.IsValid( enemy )
				and bot:IsFacingLocation( enemy:GetLocation(), 38 )
			then
				return enemy
			end
		end

	end


	return nil
end


function X.ConsiderAS()

	if not J.CanCastAbility(abilityAS)
	then
		return BOT_ACTION_DESIRE_NONE, 0
	end

	local nRadius = 350
	local nCastRange = 750
	local nCastPoint = abilityAS:GetCastPoint()
	local nManaCost = abilityAS:GetManaCost()

	if J.IsRetreating( bot )
	then
		local enemyHeroList = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
		local targetHero = enemyHeroList[1]
		if J.IsValidHero( targetHero )
			and J.CanCastOnNonMagicImmune( targetHero )
		then
			return BOT_ACTION_DESIRE_HIGH, targetHero:GetLocation()
		end		
	end
	

	if J.IsInTeamFight( bot, 1400 )
	then
		local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			local loc = bot:GetLocation() + (bot:GetLocation() - nAoeLoc)
			return BOT_ACTION_DESIRE_HIGH, nAoeLoc
		end		
	end
	

	if J.IsGoingOnSomeone( bot )
	then
		local targetHero = J.GetProperTarget( bot )
		if J.IsValidHero( targetHero )
			and J.IsInRange( bot, targetHero, 400 )
			and J.CanCastOnNonMagicImmune( targetHero )
		then
			local loc = bot:GetLocation() + (bot:GetLocation() - targetHero:GetLocation())
			return BOT_ACTION_DESIRE_HIGH, loc
		end
	end

	return BOT_ACTION_DESIRE_NONE, 0

end


return X
