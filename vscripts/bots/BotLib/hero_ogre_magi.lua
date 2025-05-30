local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_ogre_magi'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {"item_pipe", "item_lotus_orb", "item_heavens_halberd"}
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
					['t20'] = {0, 10},
					['t15'] = {0, 10},
					['t10'] = {0, 10},
				},
				[2] = {
					['t25'] = {0, 10},
					['t20'] = {0, 10},
					['t15'] = {0, 10},
					['t10'] = {10, 0},
				}
            },
            ['ability'] = {
                [1] = {3,2,2,1,2,7,2,1,1,1,7,3,3,3,7},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",

				"item_bracer",
				"item_bottle",
				"item_magic_wand",
				"item_phase_boots",
				"item_soul_ring",
				"item_hand_of_midas",
				"item_blade_mail",
				"item_black_king_bar",--
				"item_heart",--
				"item_aghanims_shard",
				"item_shivas_guard",--
				"item_octarine_core",--
				"item_ultimate_scepter",
				"item_sheepstick",--
				"item_ultimate_scepter_2",
				"item_travel_boots_2",--
				"item_moon_shard",
			},
            ['sell_list'] = {
				"item_magic_wand", "item_blade_mail",
				"item_soul_ring", "item_black_king_bar",
				"item_bottle", "item_heart",
				"item_bracer", "item_shivas_guard",
				"item_hand_of_midas", "item_octarine_core",
				"item_blade_mail", "item_sheepstick",
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
                [1] = {2,1,2,3,2,7,3,1,1,1,7,3,3,2,7},
            },
            ['buy_list'] = {
				"item_tango",
				"item_double_branches",
				"item_double_gauntlets",
			
				"item_boots",
				"item_magic_wand",
				"item_soul_ring",
				"item_hand_of_midas",
				"item_crimson_guard",--
				"item_heart",--
				sUtilityItem,--
				"item_aghanims_shard",
				"item_sange_and_yasha",--
				"item_travel_boots",
				"item_sheepstick",--
				"item_travel_boots_2",--
				"item_ultimate_scepter_2",
				"item_moon_shard",
			},
            ['sell_list'] = {
				"item_magic_wand", sUtilityItem,
				"item_soul_ring", "item_sange_and_yasha",
				"item_hand_of_midas", "item_sheepstick",
			},
        },
    },
    ['pos_4'] = {
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
                [1] = {2,1,2,3,2,7,2,1,1,1,7,3,3,3,7},
            },
            ['buy_list'] = {
				"item_double_tango",
				"item_enchanted_mango",
				"item_faerie_fire",
				"item_double_branches",
				"item_blood_grenade",
			
				"item_magic_wand",
				"item_tranquil_boots",
				"item_aether_lens",--
				"item_hand_of_midas",
				"item_boots_of_bearing",--
				"item_aghanims_shard",
				"item_assault",--
				"item_heavens_halberd",--
				"item_sheepstick",--
				"item_heart",--
				"item_ultimate_scepter_2",
				"item_moon_shard",
			},
            ['sell_list'] = {
				"item_magic_wand", "item_boots_of_bearing",
				"item_hand_of_midas", "item_heart",
			},
        },
    },
    ['pos_5'] = {
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
                [1] = {2,1,2,3,2,7,2,1,1,1,7,3,3,3,7},
            },
            ['buy_list'] = {
				"item_double_tango",
				"item_enchanted_mango",
				"item_faerie_fire",
				"item_double_branches",
				"item_blood_grenade",
			
				"item_magic_wand",
				"item_arcane_boots",
				"item_aether_lens",--
				"item_hand_of_midas",
				"item_guardian_greaves",--
				"item_aghanims_shard",
				"item_assault",--
				"item_heavens_halberd",--
				"item_sheepstick",--
				"item_heart",--
				"item_ultimate_scepter_2",
				"item_moon_shard",
			},
            ['sell_list'] = {
				"item_magic_wand", "item_guardian_greaves",
				"item_hand_of_midas", "item_heart",
			},
        },
    },
}

local sSelectedBuild = HeroBuild[sRole][RandomInt(1, #HeroBuild[sRole])]

local nTalentBuildList = J.Skill.GetTalentBuild(J.Skill.GetRandomBuild(sSelectedBuild.talent))
local nAbilityBuildList = J.Skill.GetRandomBuild(sSelectedBuild.ability)

X['sBuyList'] = sSelectedBuild.buy_list
X['sSellList'] = sSelectedBuild.sell_list

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_OM' }, {"item_power_treads", 'item_quelling_blade'} end

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

local abilityQ = bot:GetAbilityByName('ogre_magi_fireblast')
local abilityW = bot:GetAbilityByName('ogre_magi_ignite')
local abilityE = bot:GetAbilityByName('ogre_magi_bloodlust')
local abilityD = bot:GetAbilityByName('ogre_magi_unrefined_fireblast')
local FireShield = bot:GetAbilityByName('ogre_magi_smash')
local abilityR = bot:GetAbilityByName('ogre_magi_multicast')
local talent2 = bot:GetAbilityByName( sTalentList[2] )
local talent8 = bot:GetAbilityByName( sTalentList[8] )

local castQDesire, castQTarget
local castWDesire, castWTarget
local castEDesire, castETarget
local castDDesire, castDTarget
local FireShieldDesire, FireShieldTarget


local nKeepMana, nMP, nHP, nLV, hEnemyList, hAllyList, botTarget, sMotive
local aetherRange = 0
local talent8Damage = 0


function X.SkillsComplement()


	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	abilityQ = bot:GetAbilityByName('ogre_magi_fireblast')
	abilityW = bot:GetAbilityByName('ogre_magi_ignite')
	abilityE = bot:GetAbilityByName('ogre_magi_bloodlust')
	abilityD = bot:GetAbilityByName('ogre_magi_unrefined_fireblast')
	FireShield = bot:GetAbilityByName('ogre_magi_smash')

	nKeepMana = 300
	aetherRange = 0
	talent8Damage = 0
	nLV = bot:GetLevel()
	nMP = bot:GetMana()/bot:GetMaxMana()
	nHP = bot:GetHealth()/bot:GetMaxHealth()
	botTarget = J.GetProperTarget( bot )
	hEnemyList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	hAllyList = J.GetAlliesNearLoc( bot:GetLocation(), 1600 )


	local aether = J.IsItemAvailable( "item_aether_lens" )
	if aether ~= nil then aetherRange = 250 end
--	if talent2:IsTrained() then aetherRange = aetherRange + talent2:GetSpecialValueInt( "value" ) end
	if talent8:IsTrained() then talent8Damage = talent8Damage + talent8:GetSpecialValueInt( "value" ) end


	castQDesire, castQTarget, sMotive = X.ConsiderQ()
	if ( castQDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end

	castWDesire, castWTarget, sMotive = X.ConsiderW()
	if ( castWDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end

	castEDesire, castETarget, sMotive = X.ConsiderE()
	if ( castEDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityE, castETarget )
		return
	end

	castDDesire, castDTarget, sMotive = X.ConsiderD()
	if ( castDDesire > 0 )
	then

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityD, castDTarget )
		return
	end
	
	FireShieldDesire, FireShieldTarget, sMotive = X.ConsiderFireShield()
	if ( FireShieldDesire > 0 )
	then

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( FireShield, FireShieldTarget )
		return

	end


end


function X.ConsiderQ()


	if not J.CanCastAbility(abilityQ) then return 0 end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + aetherRange

	if #hEnemyList <= 1 then nCastRange = nCastRange + 200 end

	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( "fireblast_damage" ) + talent8Damage
	local nDamageType = DAMAGE_TYPE_MAGICAL

	local nInRangeEnemyList = bot:GetNearbyHeroes( nCastRange + 50, true, BOT_MODE_NONE )
	local nInBonusEnemyList = bot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE )

	--打断和击杀
	for _, npcEnemy in pairs( nInBonusEnemyList )
	do
		if J.IsValid( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
		then
			if npcEnemy:IsChanneling()
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q打断'..J.Chat.GetNormName( npcEnemy )
			end

			if J.IsInRange( bot, npcEnemy, nCastRange + 80 )
				and J.WillMagicKillTarget( bot, npcEnemy, nDamage * 2.38, nCastPoint )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q击杀'..J.Chat.GetNormName( npcEnemy )
			end

		end
	end


	--团战中对战力最强的敌人使用
	if J.IsInTeamFight( bot, 1200 )
	then
		local npcStrongestEnemy = nil
		local npcStrongestEnemyPower = 0

		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
			then
				local npcEnemyPower = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )
				if ( npcEnemyPower > npcStrongestEnemyPower )
				then
					npcStrongestEnemyPower = npcEnemyPower
					npcStrongestEnemy = npcEnemy
				end
			end
		end

		if ( npcStrongestEnemy ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, npcStrongestEnemy, 'Q团战'..J.Chat.GetNormName( npcStrongestEnemy )
		end
	end


	--受到伤害时保护自己
	if bot:WasRecentlyDamagedByAnyHero( 3.0 ) and nLV >= 10
		and bot:GetActiveMode() ~= BOT_MODE_RETREAT
		and #nInRangeEnemyList >= 1
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
				and not npcEnemy:IsDisarmed()
				and bot:IsFacingLocation( npcEnemy:GetLocation(), 60 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q自保'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	--对线期间对线上小兵使用
	if bot:GetActiveMode() == BOT_MODE_LANING
		or ( nLV <= 7 and #hAllyList <= 2 and #hEnemyList == 0 )
	then
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 200, true )
		local keyWord = "ranged"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.IsKeyWordUnit( keyWord, creep )
				and not J.IsOtherAllysTarget( creep )
				and J.WillKillTarget( creep, nDamage, nDamageType, nCastPoint )
				and GetUnitToUnitDistance( creep, bot ) > 280
			then
				return BOT_ACTION_DESIRE_HIGH, creep, 'Q补远'
			end
		end

		if nSkillLV >= 2
			and ( bot:GetMana() > nKeepMana or nMP > 0.9 )
		then
			local keyWord = "melee"
			for _, creep in pairs( nLaneCreeps )
			do
				if J.IsValid( creep )
					and not creep:HasModifier( "modifier_fountain_glyph" )
					and J.IsKeyWordUnit( keyWord, creep )
					and not J.IsOtherAllysTarget( creep )
					and J.WillKillTarget( creep, nDamage, nDamageType, nCastPoint )
					and GetUnitToUnitDistance( creep, bot ) > 350
				then
					return BOT_ACTION_DESIRE_HIGH, creep, 'Q补近'
				end
			end
		end
	end


	--打架时先手
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange + 50 )
			and not J.IsDisabled( botTarget )
			and not botTarget:IsDisarmed()
		then
			if nSkillLV >= 3 or nMP > 0.78 or J.GetHP( botTarget ) < 0.38 or nLV >= 7
			then
				return BOT_ACTION_DESIRE_HIGH, botTarget, 'Q先手'..J.Chat.GetNormName( botTarget )
			end
		end
	end


	--撤退时保护自己
	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q撤退'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	--发育时对野怪输出
	if J.IsFarming( bot )
		and nSkillLV >= 3
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
	then
		local nCreeps = bot:GetNearbyNeutralCreeps( nCastRange + 100 )

		local targetCreep = J.GetMostHpUnit( nCreeps )

		if J.IsValid( targetCreep )
			and not J.IsRoshan( targetCreep )
			and ( #nCreeps >= 2 or GetUnitToUnitDistance( targetCreep, bot ) <= 400 )
			and bot:IsFacingLocation( targetCreep:GetLocation(), 60 )
			and ( targetCreep:GetMagicResist() < 0.3 or nMP > 0.9 )
			and not J.CanKillTarget( targetCreep, bot:GetAttackDamage() * 2.28, DAMAGE_TYPE_PHYSICAL )
			and not J.CanKillTarget( targetCreep, nDamage - 10, nDamageType )
		then
			return BOT_ACTION_DESIRE_HIGH, targetCreep, 'Q打野'
		end
	end


	--推进时对小兵用
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.32 )
		and ( bot:GetAttackDamage() < 200 or nMP > 0.8 )
		and nSkillLV >= 2 and DotaTime() > 6 * 60
		and #hAllyList <= 2 and #hEnemyList == 0
	then
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 50, true )
		local keyWord = "ranged"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and ( J.IsKeyWordUnit( keyWord, creep ) or nMP > 0.6 )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.WillKillTarget( creep, nDamage, nDamageType, nCastPoint )
				and not J.CanKillTarget( creep, bot:GetAttackDamage() * 1.38, DAMAGE_TYPE_PHYSICAL )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, 'Q带线'
			end
		end
	end


	--打肉的时候输出
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and bot:GetMana() >= 400
	then
		if J.IsRoshan( botTarget )
			and not J.IsDisabled( botTarget )
			and not botTarget:IsDisarmed()
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'Q肉山'
		end
	end


	--通用消耗敌人或受到伤害时保护自己
	if ( #hEnemyList > 0 or bot:WasRecentlyDamagedByAnyHero( 3.0 ) )
		and ( bot:GetActiveMode() ~= BOT_MODE_RETREAT or #hAllyList >= 2 )
		and #nInRangeEnemyList >= 1
		and nLV >= 15
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.IsInRange( bot, npcEnemy, 600 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q通用'
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE


end

function X.ConsiderW()


	if not J.CanCastAbility(abilityW) then return 0 end

	local nSkillLV = abilityW:GetLevel()
	local nCastRange = abilityW:GetCastRange() + aetherRange
	local nCastPoint = abilityW:GetCastPoint()
	local nManaCost = abilityW:GetManaCost()
	local nDuration = abilityW:GetSpecialValueInt( "duration" )
	local nDamage = abilityW:GetSpecialValueInt( "burn_damage" ) * nDuration
	local nDamageType = DAMAGE_TYPE_MAGICAL

	local nInRangeEnemyList = bot:GetNearbyHeroes( nCastRange + 32, true, BOT_MODE_NONE )
	local nInBonusEnemyList = bot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE )

	--击杀
	for _, npcEnemy in pairs( nInBonusEnemyList )
	do
		if J.IsValid( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nDuration )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W击杀'..J.Chat.GetNormName( npcEnemy )
		end
	end


	--团战中对血量最多的敌人使用
	if J.IsInTeamFight( bot, 1200 )
	then
		local npcMostHPEnemy = nil
		local npcMostHPEnemyHealth = 0

		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
			then
				local npcEnemyHealth = npcEnemy:GetHealth()
				if ( npcEnemyHealth > npcMostHPEnemyHealth )
				then
					npcMostHPEnemyHealth = npcEnemyHealth
					npcMostHPEnemy = npcEnemy
				end
			end
		end

		if ( npcMostHPEnemy ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, npcMostHPEnemy, 'W团战'..J.Chat.GetNormName( npcMostHPEnemy )
		end
	end


	--受到伤害时保护自己
	if bot:WasRecentlyDamagedByAnyHero( 3.0 ) and nLV >= 10
		and bot:GetActiveMode() ~= BOT_MODE_RETREAT
		and #nInRangeEnemyList >= 1
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetLocation(), 30 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W保护'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	--打架时先手
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'W先手'..J.Chat.GetNormName( botTarget )
		end
	end


	--撤退时保护自己
	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W撤退'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	--发育时对野怪输出
	if J.IsFarming( bot )
		and nSkillLV >= 2 and nLV >= 6
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
	then
		local nCreeps = bot:GetNearbyNeutralCreeps( nCastRange + 100 )

		local targetCreep = J.GetMostHpUnit( nCreeps )

		if J.IsValid( targetCreep )
			and not J.IsRoshan( targetCreep )
			and ( #nCreeps >= 2 or GetUnitToUnitDistance( targetCreep, bot ) <= 400 )
			and bot:IsFacingLocation( targetCreep:GetLocation(), 40 )
			and ( targetCreep:GetMagicResist() < 0.3 or nMP > 0.8 )
			and not J.CanKillTarget( targetCreep, bot:GetAttackDamage() * 2.28, DAMAGE_TYPE_PHYSICAL )
			and not J.CanKillTarget( targetCreep, nDamage * 0.38, nDamageType )
		then
			return BOT_ACTION_DESIRE_HIGH, targetCreep, 'W打野'
		end
	end


	--推进时对远程兵用
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.32 )
		and ( bot:GetAttackDamage() < 200 or nMP > 0.8 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
		and #hAllyList <= 2
	then
		local nLaneCreepsInView = bot:GetNearbyLaneCreeps( 1600, true )
		if #nLaneCreepsInView >= 3
		then
			local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 50, true )
			local nAllyCreeps = bot:GetNearbyLaneCreeps( 1000, false )
			local keyWord = "ranged"
			for _, creep in pairs( nLaneCreeps )
			do
				if J.IsValid( creep )
					and ( J.IsKeyWordUnit( keyWord, creep ) or #nAllyCreeps == 0 )
					and not creep:HasModifier( "modifier_fountain_glyph" )
					and not J.CanKillTarget( creep, bot:GetAttackDamage() * 1.68, DAMAGE_TYPE_PHYSICAL )
				then
					return BOT_ACTION_DESIRE_HIGH, creep, 'W带线'
				end
			end
		end
	end


	--通用消耗敌人或受到伤害时保护自己
	if ( #hEnemyList > 0 or bot:WasRecentlyDamagedByAnyHero( 3.0 ) )
		and ( bot:GetActiveMode() ~= BOT_MODE_RETREAT or #hAllyList >= 2 )
		and #nInRangeEnemyList >= 1
		and nLV >= 18
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W通用'
			end
		end
	end

	return BOT_ACTION_DESIRE_NONE


end

--"modifier_ogre_magi_bloodlust"
function X.ConsiderE()

	if not J.CanCastAbility(abilityE) then return 0 end

	local nSkillLV = abilityE:GetLevel()
	local nCastRange = abilityE:GetCastRange() + aetherRange
	local nCastPoint = abilityE:GetCastPoint()
	local nManaCost = abilityE:GetManaCost()
	local nDamage = bot:GetAttackDamage()
	local nDamageType = DAMAGE_TYPE_MAGICAL

	local nInRangeCreepList = bot:GetNearbyCreeps( nCastRange + 100, false )
	local nInRangeTowerList = bot:GetNearbyTowers( nCastRange + 50, false )
	local nInRangeAllyList = J.GetAlliesNearLoc( bot:GetLocation(), nCastRange + 52 )

	local bestTarget = nil
	local nMaxDamage = 0
	for _, ally in pairs( nInRangeAllyList )
	do
		if J.IsValidHero( ally )
			and not ally:HasModifier( "modifier_ogre_magi_bloodlust" )
			and not J.IsDisabled( ally )
			and not J.IsWithoutTarget( ally )
			and ally:GetAttackDamage() > nMaxDamage
		then
			bestTarget = ally
			nMaxDamage = ally:GetAttackDamage()
		end
	end

	if bot:GetActiveMode() == BOT_MODE_ROSHAN and bestTarget ~= nil
	then
		if J.IsRoshan( botTarget )
			and J.IsInRange( botTarget, bot, 1000 )
			and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, bestTarget, 'E打肉'..J.Chat.GetNormName( bestTarget )
		end
	end

	if J.IsDoingTormentor(bot) and bestTarget ~= nil then
		if J.IsTormentor(botTarget)
        and J.IsInRange( botTarget, bot, 800 )
        and J.IsAttacking(bot)
		then
			return BOT_ACTION_DESIRE_HIGH, bestTarget, ''
		end
	end

	--打架
	if J.IsGoingOnSomeone( bot )
		and J.IsValidHero( botTarget )
		and bestTarget ~= nil
	then
		if bestTarget == bot and J.IsInRange( bot, botTarget, 900 )
		then
			return BOT_ACTION_DESIRE_HIGH, bestTarget, 'E自己'
		end

		if bestTarget ~= bot and J.IsInRange( bot, botTarget, 2000 )
		then
			return BOT_ACTION_DESIRE_HIGH, bestTarget, 'E队友'..J.Chat.GetNormName( bestTarget )
		end
	end

	--撤退
	if #hEnemyList > 0
	then
		local bestAlly = nil
		local maxDist = 300

		for _, ally in pairs( nInRangeAllyList )
		do
			if J.IsValidHero( ally )
				and not ally:HasModifier( "modifier_ogre_magi_bloodlust" )
				and J.IsRetreating( ally )
				and ally:WasRecentlyDamagedByAnyHero( 5.0 )
				and ally:DistanceFromFountain() > maxDist
			then
				bestAlly = ally
				maxDist = ally:DistanceFromFountain()
			end
		end

		if bestAlly ~= nil
		then
			return BOT_ACTION_DESIRE_HIGH, bestAlly, 'E撤退'..J.Chat.GetNormName( bestAlly )
		end
	end

	--打钱推线
	if nLV >= 6
	then
		local bestAlly = nil
		local maxDamage = 108

		for _, ally in pairs( nInRangeAllyList )
		do
			if J.IsValidHero( ally )
				and not ally:HasModifier( "modifier_ogre_magi_bloodlust" )
				and ( J.IsFarming( ally ) or J.IsPushing( ally ) or J.IsDefending( ally ) )
				and ally:GetAttackDamage() > maxDamage
			then
				bestAlly = ally
				nMaxDamage = ally:GetAttackDamage()
			end
		end

		if bestAlly ~= nil
		then
			return BOT_ACTION_DESIRE_HIGH, bestAlly, 'E打钱'..J.Chat.GetNormName( bestAlly )
		end

		--防守塔
		local hTower = nInRangeTowerList[1]
		if J.IsValidBuilding( hTower )
			and not hTower:HasModifier( "modifier_ogre_magi_bloodlust" )
			and not J.IsWithoutTarget( hTower )
			and #hEnemyList >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, hTower, 'E守塔'
		end

		--辅助进攻
		if #nInRangeCreepList > 0
		then
			for _, creep in pairs( nInRangeCreepList )
			do
				if J.IsValid( creep )
					and not creep:HasModifier( "modifier_ogre_magi_bloodlust" )
				then

					--给攻城车
					if J.IsKeyWordUnit( 'siege', creep )
						and not J.IsWithoutTarget( creep )
					then
						local creepTarget = creep:GetAttackTarget()
						if J.IsValidBuilding( creepTarget )
							and creepTarget:GetAttackTarget() ~= creep
						then
							return BOT_ACTION_DESIRE_HIGH, creep, 'E攻城车'
						end
					end

					--给地狱火
					if J.IsKeyWordUnit( 'warlock', creep )
						and #hEnemyList > 0
					then
						return BOT_ACTION_DESIRE_HIGH, creep, 'E地狱火'
					end

					--给远程兵带线
					if J.IsKeyWordUnit( 'ranged', creep )
						and J.GetHP( creep ) > 0.8
						and nLV >= 12
						and #hEnemyList == 0 and #hAllyList == 1
					then
						local nEnemyCreepList = bot:GetNearbyLaneCreeps( 1600, true )
						if #nEnemyCreepList == 0
						then
							return BOT_ACTION_DESIRE_HIGH, creep, 'E远程兵'
						end
					end

				end
			end
		end

	end


	return BOT_ACTION_DESIRE_NONE


end

function X.ConsiderD()


	if J.CanCastAbility(abilityQ) or not J.CanCastAbility(abilityD) or not bot:HasScepter() then return 0 end

	local nSkillLV = abilityD:GetLevel()
	local nCastRange = abilityD:GetCastRange() + aetherRange

	if #hEnemyList <= 1 then nCastRange = nCastRange + 200 end

	local nCastPoint = abilityD:GetCastPoint()
	local nManaCost = abilityD:GetManaCost()
	local nDamage = abilityD:GetSpecialValueInt( "fireblast_damage" )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nInRangeEnemyList = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )

	local nInRangeEnemyList = bot:GetNearbyHeroes( nCastRange + 50, true, BOT_MODE_NONE )
	local nInBonusEnemyList = bot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE )

	if nManaCost/bot:GetMaxMana() > 0.45 and nHP > 0.25 then return 0 end

	--打断和击杀
	for _, npcEnemy in pairs( nInBonusEnemyList )
	do
		if J.IsValid( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
		then
			if npcEnemy:IsChanneling()
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'D打断'..J.Chat.GetNormName( npcEnemy )
			end

			if J.IsInRange( bot, npcEnemy, nCastRange + 80 )
				and J.WillMagicKillTarget( bot, npcEnemy, nDamage * 2.38, nCastPoint )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'D击杀'..J.Chat.GetNormName( npcEnemy )
			end

		end
	end


	--团战中对血量最低的敌人使用
	if J.IsInTeamFight( bot, 1200 )
	then
		local npcWeakestEnemy = nil
		local npcWeakestEnemyHealth = 10000

		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
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
			return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'D团战'..J.Chat.GetNormName( npcWeakestEnemy )
		end
	end


	--受伤
	if bot:WasRecentlyDamagedByAnyHero( 3.0 ) and nLV >= 15
		and bot:GetActiveMode() ~= BOT_MODE_RETREAT
		and #nInRangeEnemyList >= 1
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
				and not npcEnemy:IsDisarmed()
				and bot:IsFacingLocation( npcEnemy:GetLocation(), 45 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'D保护'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	--打架
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange + 50 )
			and not J.IsDisabled( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'D打架'..J.Chat.GetNormName( botTarget )
		end
	end


	--撤退
	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
				and not npcEnemy:IsDisarmed()
				and ( #nInBonusEnemyList <= 2 or bot:IsFacingLocation( npcEnemy:GetLocation(), 30 ) )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'D撤退'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	--打钱
	if J.IsFarming( bot )
		and nManaCost < bot:GetMaxMana() * 0.1
	then
		local nCreeps = bot:GetNearbyNeutralCreeps( nCastRange + 100 )

		local targetCreep = J.GetMostHpUnit( nCreeps )

		if J.IsValid( targetCreep )
			and not J.IsRoshan( targetCreep )
			and ( #nCreeps >= 2 or GetUnitToUnitDistance( targetCreep, bot ) <= 400 )
			and bot:IsFacingLocation( targetCreep:GetLocation(), 40 )
			and ( targetCreep:GetMagicResist() < 0.3 or nMP > 0.9 )
			and not J.CanKillTarget( targetCreep, bot:GetAttackDamage() * 1.88, DAMAGE_TYPE_PHYSICAL )
			and not J.CanKillTarget( targetCreep, nDamage - 10, nDamageType )
		then
			return BOT_ACTION_DESIRE_HIGH, targetCreep, 'D打野'
		end
	end


	--推进
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and nManaCost < 120 and #hAllyList <= 2 and #hEnemyList == 0
	then
		local nLaneCreeps = bot:GetNearbyLaneCreeps( nCastRange + 50, true )
		local keyWord = "ranged"
		for _, creep in pairs( nLaneCreeps )
		do
			if J.IsValid( creep )
				and ( J.IsKeyWordUnit( keyWord, creep ) or nMP > 0.6 )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.WillKillTarget( creep, nDamage, nDamageType, nCastPoint )
				and not J.CanKillTarget( creep, bot:GetAttackDamage() * 1.38, DAMAGE_TYPE_PHYSICAL )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, 'D带线'
			end
		end
	end


	--打肉
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nManaCost < 100
	then
		if J.IsRoshan( botTarget )
			and not J.IsDisabled( botTarget )
			and not botTarget:IsDisarmed()
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'D肉山'
		end
	end


	--通用
	if ( #hEnemyList > 0 or bot:WasRecentlyDamagedByAnyHero( 3.0 ) )
		and ( bot:GetActiveMode() ~= BOT_MODE_RETREAT or #hAllyList >= 2 )
		and #nInRangeEnemyList >= 1
		and nLV >= 15
	then
		for _, npcEnemy in pairs( nInRangeEnemyList )
		do
			if J.IsValid( npcEnemy )
				and J.IsInRange( bot, npcEnemy, 600 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'D通用'
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE


end


function X.ConsiderFireShield()

	if not J.CanCastAbility(FireShield)
	then
		return BOT_ACTION_DESIRE_NONE, 0
	end

	local nRadius = 600
	local nCastRange = FireShield:GetCastRange() + aetherRange
	local nCastPoint = FireShield:GetCastPoint()
	local nManaCost = FireShield:GetManaCost()

	for _, npcEnemy in pairs( hEnemyList )
	do
		if J.IsValidHero( npcEnemy )
		and J.CanCastOnNonMagicImmune( npcEnemy )
		then
			local enemyTarget = npcEnemy:GetAttackTarget()

			if enemyTarget ~= nil
			and J.IsInRange( bot, enemyTarget, nCastRange )
			and not enemyTarget:HasModifier( 'modifier_fountain_glyph' )
			and not enemyTarget:HasModifier( 'modifier_ogre_magi_smash_buff' )
			then
				if enemyTarget:IsTower() and npcEnemy:IsBot()
				then
					return BOT_ACTION_DESIRE_HIGH, enemyTarget, "AS-守塔"
				end

				if enemyTarget:IsHero()
				and not enemyTarget:IsIllusion()
				then
					return BOT_ACTION_DESIRE_HIGH, enemyTarget, "AS-保护队友:"..J.Chat.GetNormName(enemyTarget)
				end
			end
		end	
	end

	return BOT_ACTION_DESIRE_NONE, 0

end


return X