local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_phantom_assassin'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {}
local sUtilityItem = RI.GetBestUtilityItem(sUtility)

local HeroBuild = {
    ['pos_1'] = {
        [1] = {
            ['talent'] = {
				[1] = {
					['t25'] = {0, 10},
					['t20'] = {10, 0},
					['t15'] = {10, 0},
					['t10'] = {0, 10},
				}
            },
            ['ability'] = {
                [1] = {1,2,1,5,1,6,2,2,2,1,6,5,5,5,6},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_quelling_blade",
			
				"item_magic_wand",
				"item_power_treads",
				"item_bfury",--
				"item_black_king_bar",--
				"item_desolator",--
				"item_aghanims_shard",
				"item_basher",
				"item_satanic",--
				"item_abyssal_blade",--
				"item_monkey_king_bar",--
				"item_moon_shard",
				"item_ultimate_scepter_2",
			},
            ['sell_list'] = {
				'item_magic_wand', "item_satanic",
				"item_power_treads", "item_monkey_king_bar",
			},
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

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_PA' }, {"item_power_treads", 'item_quelling_blade'} end

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

npc_dota_hero_phantom_assassin

"Ability1"		"phantom_assassin_stifling_dagger"
"Ability2"		"phantom_assassin_phantom_strike"
"Ability3"		"phantom_assassin_blur"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"phantom_assassin_coup_de_grace"
"Ability10"		"special_bonus_hp_150"
"Ability11"		"special_bonus_attack_damage_15"
"Ability12"		"special_bonus_lifesteal_15"
"Ability13"		"special_bonus_cleave_25"
"Ability14"		"special_bonus_corruption_4"
"Ability15"		"special_bonus_unique_phantom_assassin_3"
"Ability16"		"special_bonus_unique_phantom_assassin_2"
"Ability17"		"special_bonus_unique_phantom_assassin"

modifier_phantom_assassin_stiflingdagger_caster
modifier_phantom_assassin_stiflingdagger
modifier_phantom_assassin_phantom_strike
modifier_phantom_assassin_blur
modifier_phantom_assassin_blur_active
modifier_phantom_assassin_coupdegrace

--]]


local abilityQ = bot:GetAbilityByName('phantom_assassin_stifling_dagger')
local abilityW = bot:GetAbilityByName('phantom_assassin_phantom_strike')
local abilityE = bot:GetAbilityByName('phantom_assassin_blur')
local Immaterial = bot:GetAbilityByName('phantom_assassin_immaterial')
local abilityAS = bot:GetAbilityByName('phantom_assassin_fan_of_knives')
local abilityR = bot:GetAbilityByName('phantom_assassin_coup_de_grace')


local castQDesire, castQTarget
local castWDesire, castWTarget
local castEDesire
local castASDesire, castASTarget


local nKeepMana, nMP, nHP, nLV, hEnemyList, hAllyList, botTarget, sMotive


local lastSkillCreep

function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) then return end

	abilityQ = bot:GetAbilityByName('phantom_assassin_stifling_dagger')
	abilityW = bot:GetAbilityByName('phantom_assassin_phantom_strike')
	abilityE = bot:GetAbilityByName('phantom_assassin_blur')
	abilityAS = bot:GetAbilityByName('phantom_assassin_fan_of_knives')

	nKeepMana = 300
	nLV = bot:GetLevel()
	nMP = bot:GetMana()/bot:GetMaxMana()
	nHP = bot:GetHealth()/bot:GetMaxHealth()
	botTarget = J.GetProperTarget( bot )
	hEnemyList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	hAllyList = J.GetAlliesNearLoc( bot:GetLocation(), 1600 )


	castEDesire = X.ConsiderE()
	if castEDesire > 0
	then

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityE )
		return

	end
	
	castASDesire = X.ConsiderAS()
	if castASDesire > 0
	then

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityAS )
		return

	end

	castQDesire, castQTarget = X.ConsiderQ()
	if castQDesire > 0
	then
		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ , castQTarget )
		return
	end

	castWDesire, castWTarget = X.ConsiderW()
	if castWDesire > 0
	then

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityW , castWTarget )
		return
	end


end


function X.ConsiderQ()

	if not J.CanCastAbility(abilityQ) then
		return BOT_ACTION_DESIRE_NONE
	end

	local nAttackDamage = bot:GetAttackDamage()
	local nCastRange = abilityQ:GetCastRange()
	if nCastRange < 700 then nCastRange = 700 end
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nSkillLV = abilityQ:GetLevel()
	local nBonusPer = 0.1 + 0.15 * nSkillLV
	local nDamage = 65 + nAttackDamage * nBonusPer
	local nBonusDamage= 8 * nBonusPer

	local nDamageType = DAMAGE_TYPE_PHYSICAL

	local nAllies = bot:GetNearbyHeroes( 1200, false, BOT_MODE_NONE )

	local nEnemysHerosInView = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	local nEnemysHerosInRange = bot:GetNearbyHeroes( nCastRange + 50, true, BOT_MODE_NONE )
	local nEnemysHerosInBonus = bot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE )


	--击杀敌人
	for _, npcEnemy in pairs( nEnemysHerosInBonus )
	do
		if J.IsValid( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and GetUnitToUnitDistance( bot, npcEnemy ) <= nCastRange + 80
			and ( J.CanKillTarget( npcEnemy, nDamage * 1.6, nDamageType )
				or ( npcEnemy:IsChanneling() and J.CanKillTarget( npcEnemy, nDamage * 4.5, nDamageType ) ) )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy
		end
	end


	--打架时先手
	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = J.GetProperTarget( bot )
		if J.IsValidHero( npcTarget )
			and J.CanCastOnNonMagicImmune( npcTarget )
			and J.CanCastOnTargetAdvanced( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange + 50 )
		then
			if nSkillLV >= 3
				or nMP > 0.6 or nHP < 0.4
				or J.GetHP( npcTarget ) < 0.38
				or DotaTime() > 6 * 60
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget
			end
		end
	end


	--团战中对血量最低的敌人使用
	if J.IsInTeamFight( bot, 1200 )
	then
		local npcWeakestEnemy = nil
		local npcWeakestEnemyHealth = 10000

		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
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



	--撤退时保护自己
	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
				and ( bot:IsFacingLocation( npcEnemy:GetLocation(), 60 )
						or not J.IsInRange( npcEnemy, bot, nCastRange - 300 ) )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end
		end
	end


	--对线期间对线上小兵和敌人使用
	if ( bot:GetActiveMode() == BOT_MODE_LANING or ( nLV <= 14 and not J.IsGoingOnSomeone( bot ) ) )
		and not J.IsValid( botTarget )
	then
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 168, true )
		local keyWord = "ranged"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.IsKeyWordUnit( keyWord, creep )
				and ( GetUnitToUnitDistance( creep, bot ) > 300 or nDamage + nBonusDamage - 10 > nAttackDamage + 24 )
			then
				local nTime = nCastPoint + GetUnitToUnitDistance( bot, creep )/1250
				if J.WillKillTarget( creep, nDamage + nBonusDamage, nDamageType, nTime * 0.94 )
				then
					lastSkillCreep = creep
					return BOT_ACTION_DESIRE_HIGH, creep
				end
			end
		end

		if bot:GetMana() > 80 + nLV * 10
			and ( nLV <= 9 or #nEnemysHerosInBonus == 0 )
		then
			local keyWord = "melee"
			for _, creep in pairs( nLaneCreeps )
			do
				if J.IsValid( creep )
					and not creep:HasModifier( "modifier_fountain_glyph" )
					and J.IsKeyWordUnit( keyWord, creep )
					and GetUnitToUnitDistance( creep, bot ) > 240 + nLV * 20
				then
					local nTime = nCastPoint + GetUnitToUnitDistance( bot, creep )/1250
					if J.WillKillTarget( creep, nDamage + nBonusDamage, nDamageType, nTime * 0.9 )
					then
						lastSkillCreep = creep
						return BOT_ACTION_DESIRE_HIGH, creep
					end
				end
			end
		end

		--对线期间对敌人使用
		local nWeakestEnemyLaneCreep = J.GetVulnerableWeakestUnit( bot, false, true, nCastRange + 100 )
		local nWeakestEnemyLaneHero = J.GetVulnerableWeakestUnit( bot, true , true, nCastRange + 40 )
		if nWeakestEnemyLaneCreep == nil
			or not J.CanKillTarget( nWeakestEnemyLaneCreep, ( nDamage + nBonusDamage ) * 2, nDamageType )
		then
			if nWeakestEnemyLaneHero ~= nil
				and ( J.GetHP( nWeakestEnemyLaneHero ) <= 0.48
					  or J.IsInRange( bot, nWeakestEnemyLaneHero, 400 ) )
			then
				return BOT_ACTION_DESIRE_HIGH, nWeakestEnemyLaneHero
			end
		end

		--打断回复
		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and GetUnitToUnitDistance( bot, npcEnemy ) <= nCastRange + 80
				and ( npcEnemy:HasModifier( "modifier_flask_healing" )
					or npcEnemy:HasModifier( "modifier_clarity_potion" )
					or npcEnemy:HasModifier( "modifier_bottle_regeneration" )
					or npcEnemy:HasModifier( "modifier_rune_regen" ) )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end
		end
	end


	--发育时对野怪输出
	if J.IsFarming( bot )
		and ( nSkillLV >= 3 or nMP > 0.88 )
		and J.IsAllowedToSpam( bot, nManaCost * 2 )
	then
		local nCreeps = bot:GetNearbyNeutralCreeps( nCastRange )

		local targetCreep = J.GetMostHpUnit( nCreeps )

		if J.IsValid( targetCreep )
			and GetUnitToUnitDistance( targetCreep, bot ) >= 600
			and not J.IsRoshan( targetCreep )
			and bot:IsFacingLocation( targetCreep:GetLocation(), 60 )
			and ( not J.CanKillTarget( targetCreep, nDamage + nBonusDamage, nDamageType ) or #nCreeps == 1 )
		then
			return BOT_ACTION_DESIRE_HIGH, targetCreep
		end
	end


	--推进时对小兵用
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost )
		and ( bot:GetAttackDamage() >= 90 or nLV >= 15 )
		and #nEnemysHerosInView == 0
		and #nAllies <= 2
	then

		--补刀远程程兵
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 188, true )
		local keyWord = "ranged"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
			then
				if J.IsKeyWordUnit( keyWord, creep )
				then
					local nTime = nCastPoint + GetUnitToUnitDistance( bot, creep )/1250
					if J.WillKillTarget( creep, nDamage + nBonusDamage, nDamageType, nTime * 0.9 )
					then
						return BOT_ACTION_DESIRE_HIGH, creep
					end
				end

				if not J.CanKillTarget( creep, bot:GetAttackDamage(), DAMAGE_TYPE_PHYSICAL )
					and not J.IsInRange( creep, bot, nCastRange - 300 )
					and ( J.CanKillTarget( creep, nDamage-2, nDamageType )
						or J.GetUnitAllyCountAroundEnemyTarget( creep, 450 ) <= 1 )
				then
					return BOT_ACTION_DESIRE_HIGH, creep
				end

			end
		end

		--补刀非狂战范围内的兵
		local keyWord = "melee"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.IsKeyWordUnit( keyWord, creep )
				and GetUnitToUnitDistance( creep, bot ) > 350
				and not bot:IsFacingLocation( creep:GetLocation(), 50 )
			then
				local nTime = nCastPoint + GetUnitToUnitDistance( bot, creep )/1250
				if J.WillKillTarget( creep, nDamage + nBonusDamage, nDamageType, nTime * 0.9 )
				then
					return BOT_ACTION_DESIRE_HIGH, creep
				end
			end
		end
	end


	--打肉的时候输出
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and bot:GetMana() >= 200
	then
		local npcTarget = bot:GetAttackTarget()
		if J.IsRoshan( npcTarget )
			and J.CanBeAttacked(npcTarget)
			and J.IsInRange( npcTarget, bot, nCastRange )
			and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget
		end
	end

    if J.IsDoingTormentor(bot)
	then
		if J.IsTormentor(botTarget)
        and J.IsInRange( botTarget, bot, nCastRange )
        and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end


	--通用消耗敌人或受到伤害时保护自己
	if ( #nEnemysHerosInView > 0 or bot:WasRecentlyDamagedByAnyHero( 3.0 ) )
		and ( bot:GetActiveMode() ~= BOT_MODE_RETREAT or #nAllies >= 2 )
		and #nEnemysHerosInRange >= 1
		and nLV >= 7
	then
		for _, npcEnemy in pairs( nEnemysHerosInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetLocation(), 80 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy
			end
		end
	end


	return 0

end


function X.ConsiderW()

	if not J.CanCastAbility(abilityW) then
		return BOT_ACTION_DESIRE_NONE, 0
	end

	local nAttackDamage = bot:GetAttackDamage()
	local nCastRange = abilityW:GetCastRange()
	local nCastPoint = abilityW:GetCastPoint()
	local nManaCost = abilityW:GetManaCost()
	local nSkillLV = abilityW:GetLevel()
	local nBonus	 = 18
	local nDamage = nAttackDamage
	local nDamageType = DAMAGE_TYPE_PHYSICAL

	local nAllies =  bot:GetNearbyHeroes( 1200, false, BOT_MODE_NONE )

	local nEnemysHerosInView = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	local nEnemysHerosInRange = bot:GetNearbyHeroes( nCastRange + 50, true, BOT_MODE_NONE )
	local nEnemysHerosInBonus = bot:GetNearbyHeroes( nCastRange + 300, true, BOT_MODE_NONE )

	local nEnemysTowers = bot:GetNearbyTowers( 1400, true )
	local aliveEnemyCount = J.GetNumOfAliveHeroes( true )

	local npcTarget = J.GetProperTarget( bot )

	--击杀敌人
	if J.IsValid( npcTarget )
		and not npcTarget:IsAttackImmune()
		and J.CanCastOnNonMagicImmune( npcTarget )
		and GetUnitToUnitDistance( bot, npcTarget ) <= nCastRange + 80
		and ( J.CanKillTarget( npcTarget, nDamage * 1.28, nDamageType )
			or ( npcTarget:IsChanneling() and J.CanKillTarget( npcTarget, nDamage * 2.28, nDamageType ) ) )
	then
		return BOT_ACTION_DESIRE_HIGH, npcTarget
	end
	



	--打架时先手
	if J.IsGoingOnSomeone( bot ) 
		and ( nLV >= 2 or #nEnemysHerosInView <= 1 )
		and ( #nAllies >= 2 or #nEnemysHerosInView <= 1 or nLV >= 6 )
	then

		if J.IsValidHero( npcTarget )
			and not npcTarget:IsAttackImmune()
			and J.CanCastOnNonMagicImmune( npcTarget )
			and J.IsInRange( npcTarget, bot, nCastRange + 50 )
		then
			local tableNearbyEnemyHeroes = npcTarget:GetNearbyHeroes( 800, false, BOT_MODE_NONE )
			local tableNearbyAllyHeroes = npcTarget:GetNearbyHeroes( 800, true, BOT_MODE_NONE )
			local tableAllEnemyHeroes = npcTarget:GetNearbyHeroes( 1600, false, BOT_MODE_NONE )
			if ( J.WillKillTarget( npcTarget, nAttackDamage * 3, DAMAGE_TYPE_PHYSICAL, 1.0 ) )
				or ( #tableNearbyEnemyHeroes <= #tableNearbyAllyHeroes )
				or ( #tableAllEnemyHeroes <= 1 )
				or GetUnitToUnitDistance( bot, npcTarget ) <= 400
				or aliveEnemyCount <= 2
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget
			end
		end
	end


	--撤退时逃跑
	if J.IsRetreating( bot )
		and bot:WasRecentlyDamagedByAnyHero( 2.0 )
	then
		local nAttackAllys = bot:GetNearbyHeroes( 600, false, BOT_MODE_ATTACK )
		if #nAttackAllys == 0 or nHP < 0.16
		then
			local nAllyInCastRange = bot:GetNearbyHeroes( nCastRange + 80, false, BOT_MODE_NONE )
			local nAllyCreeps	 = bot:GetNearbyCreeps( nCastRange + 80, false )
			local nEnemyCreeps = bot:GetNearbyCreeps( nCastRange + 80, true )
			local nAllyUnits = J.CombineTwoTable( nAllyInCastRange, nAllyCreeps )
			local nAllUnits = J.CombineTwoTable( nAllyUnits, nEnemyCreeps )

			local targetUnit = nil
			local targetUnitDistance = J.GetDistanceFromAllyFountain( bot )
			for _, unit in pairs( nAllUnits )
			do
				if J.IsValid( unit )
					and GetUnitToUnitDistance( unit, bot ) > 260
					and J.GetDistanceFromAllyFountain( unit ) < targetUnitDistance
				then
					targetUnit = unit
					targetUnitDistance = J.GetDistanceFromAllyFountain( unit )
				end
			end

			if targetUnit ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, targetUnit
			end
		end
	end


	--对线期间对线上小兵使用
	if bot:GetActiveMode() == BOT_MODE_LANING and #nEnemysHerosInView == 0 and #nEnemysTowers == 0
	then
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 80, true )
		local keyWord = "ranged"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and creep ~= lastSkillCreep
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.IsKeyWordUnit( keyWord, creep )
				and GetUnitToUnitDistance( creep, bot ) > 400
			then
				local nTime = nCastPoint * 3
				if J.WillKillTarget( creep, nDamage + nBonus, nDamageType, nTime )
				then
					return BOT_ACTION_DESIRE_HIGH, creep
				end
			end
		end
	end


	--发育时对野怪输出
	if J.IsFarming( bot )
		--and not bot:HasModifier( "modifier_filler_heal" )
		and ( bot:GetAttackTarget() == nil or not bot:GetAttackTarget():IsBuilding() )
		and nLV >= 6
	then
		local nCreeps = bot:GetNearbyNeutralCreeps( nCastRange )

		local targetCreep = J.GetProperTarget( bot )

		if J.IsValid( targetCreep )
			and not J.IsRoshan( targetCreep )
			and ( not J.CanKillTarget( targetCreep, nDamage * 2, nDamageType )
				  or GetUnitToUnitDistance( targetCreep, bot ) >= 650 )
		then

			if J.IsAllowedToSpam( bot, nManaCost )
			then
				if ( #nCreeps >= 3 and GetUnitToUnitDistance( targetCreep, bot ) <= 400 )
					or ( #nCreeps >= 2 and not J.CanKillTarget( targetCreep, nDamage * 3, nDamageType ) )
					or ( #nCreeps >= 1 and not J.CanKillTarget( targetCreep, nDamage * 6, nDamageType ) )
				then
					return BOT_ACTION_DESIRE_HIGH, targetCreep
				end
			end

			if bot:GetMana() >= 100
				and GetUnitToUnitDistance( targetCreep, bot ) >= 550
			then
				return BOT_ACTION_DESIRE_HIGH, targetCreep
			end

		end

	end

	--推进时对小兵用
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and nLV >= 8
		and #nEnemysHerosInView == 0
		and #nAllies <= 2
	then
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 300, true )
		--local targetCreep = nLaneCreeps[1]
		if J.IsValid( npcTarget )
			and not npcTarget:IsHero()
			and not npcTarget :HasModifier( "modifier_fountain_glyph" )
			and ( ( not J.IsInRange( bot, npcTarget, 630 ) and bot:GetMana() >= 100 )
				or ( #nLaneCreeps >= 3 and J.IsAllowedToSpam( bot, nManaCost ) ) )
		then
			if not J.IsEnemyHeroAroundLocation( npcTarget:GetLocation(), 660 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget
			end
		end
	end

	--打肉的时候输出
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
	then
		local npcTarget = bot:GetAttackTarget()
		if J.IsRoshan( npcTarget )
			and J.CanBeAttacked(npcTarget)
			and J.GetHP( npcTarget ) > 0.15
			and J.IsInRange( npcTarget, bot, nCastRange )
			and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget
		end
	end

	if J.IsDoingTormentor(bot)
	then
		if J.IsTormentor(botTarget)
        and J.IsInRange( botTarget, bot, nCastRange )
        and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	return 0

end


function X.ConsiderE()

	local nEnemyTowers = bot:GetNearbyTowers( 878, true )

	if not J.CanCastAbility(abilityE)
		or bot:IsInvisible()
		or #nEnemyTowers >= 1
		or bot:DistanceFromFountain() < 600
	then
		return BOT_ACTION_DESIRE_NONE, 0
	end

	--撤退逃跑
	if J.IsRetreating( bot )
		and bot:WasRecentlyDamagedByAnyHero( 3.1 )
		and ( nLV >= 6 or nHP <= 0.3 )
	then
		local nEnemysHerosInRange = bot:GetNearbyHeroes( 740, true, BOT_MODE_NONE )
		if #nEnemysHerosInRange == 0
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	--过河道接近敌方基地
	if J.IsInEnemyArea( bot ) and nLV >= 7
	then
		local nEnemies = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
		local nAllies = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
		local nEnemyTowers = bot:GetNearbyTowers( 1600, true )
		if #nEnemies == 0 and #nAllies <= 2 and nEnemyTowers == 0
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	--低血量打远古
	if J.IsFarming( bot )
	then
		local nTarget = J.GetProperTarget( bot )
		if J.IsValid( nTarget )
			and ( nTarget:IsAncientCreep() or nHP < 0.28 )
			and nHP <= 0.58
		then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	return 0

end


function X.ConsiderAS()


	if not J.CanCastAbility(abilityAS)
	then
		return BOT_ACTION_DESIRE_NONE
	end
	
	local nRadius = 550 - 30

	local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE )

	if #tableNearbyEnemyHeroes <= 0 then return BOT_ACTION_DESIRE_NONE end
	
	if J.IsRetreating( bot ) or J.IsInTeamFight( bot, 800 )
	then
		for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if J.CanCastOnMagicImmune(npcEnemy)
			then
				return BOT_ACTION_DESIRE_MODERATE
			end
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		local npcTarget = J.GetProperTarget( bot )
		if J.IsValidHero( npcTarget )
			and J.CanCastOnMagicImmune( npcTarget )
			and J.IsInRange( bot, npcTarget, nRadius - 160 )
		then
			return BOT_ACTION_DESIRE_MODERATE
		end
	end


	return 0

end


return X
