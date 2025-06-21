local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_nyx_assassin'
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
                    ['t25'] = {10, 0},
                    ['t20'] = {10, 0},
                    ['t15'] = {10, 0},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_magic_stick",
                "item_blood_grenade",
                "item_enchanted_mango",
            
                "item_tranquil_boots",
                "item_magic_wand",
                "item_dagon",
                "item_cyclone",
                "item_ancient_janggo",
                "item_aghanims_shard",
                "item_blink",
                "item_boots_of_bearing",--
                "item_lotus_orb",--
                "item_ultimate_scepter",
                "item_dagon_5",--
                "item_wind_waker",--
                "item_octarine_core",--
                "item_ultimate_scepter_2",
                "item_moon_shard",
                "item_arcane_blink",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_ultimate_scepter",
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
                [1] = {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_magic_stick",
                "item_blood_grenade",
                "item_enchanted_mango",
            
                "item_arcane_boots",
                "item_magic_wand",
                "item_dagon",
                "item_cyclone",
                "item_mekansm",
                "item_aghanims_shard",
                "item_blink",
                "item_guardian_greaves",--
                "item_lotus_orb",--
                "item_ultimate_scepter",
                "item_dagon_5",--
                "item_wind_waker",--
                "item_octarine_core",--
                "item_ultimate_scepter_2",
                "item_moon_shard",
                "item_arcane_blink",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_ultimate_scepter",
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

local Impale            = bot:GetAbilityByName('nyx_assassin_impale')
local Mindflare         = bot:GetAbilityByName('nyx_assassin_jolt')
local SpikedCarapace    = bot:GetAbilityByName('nyx_assassin_spiked_carapace')
local Burrow            = bot:GetAbilityByName('nyx_assassin_burrow')
local UnBurrow          = bot:GetAbilityByName('nyx_assassin_unburrow')
local Vendetta          = bot:GetAbilityByName('nyx_assassin_vendetta')

local ImpaleDesire, ImpaleLocation
local MindflareDesire, MindflareTarget
local SpikedCarapaceDesire
local BurrowDesire
local UnBurrowDesire
local VendettaDesire

if bot.canVendettaKill == nil then bot.canVendettaKill = false end
if bot.vendettaTarget == nil then bot.vendettaTarget = nil end

function X.SkillsComplement()
	if J.CanNotUseAbility(bot) then return end

    Impale            = bot:GetAbilityByName('nyx_assassin_impale')
    Mindflare         = bot:GetAbilityByName('nyx_assassin_jolt')
    SpikedCarapace    = bot:GetAbilityByName('nyx_assassin_spiked_carapace')
    Burrow            = bot:GetAbilityByName('nyx_assassin_burrow')
    UnBurrow          = bot:GetAbilityByName('nyx_assassin_unburrow')
    Vendetta          = bot:GetAbilityByName('nyx_assassin_vendetta')

    VendettaDesire = X.ConsiderVendetta()
    if VendettaDesire > 0
    then
        bot:Action_UseAbility(Vendetta)
        return
    end

    SpikedCarapaceDesire = X.ConsiderSpikedCarapace()
    if SpikedCarapaceDesire > 0
    then
        bot:Action_UseAbility(SpikedCarapace)
        return
    end

    ImpaleDesire, ImpaleLocation = X.ConsiderImpale()
    if ImpaleDesire > 0
    then
        bot:Action_UseAbilityOnLocation(Impale, ImpaleLocation)
        return
    end

    MindflareDesire, MindflareTarget = X.ConsiderMindflare()
    if MindflareDesire > 0
    then
        bot:Action_UseAbilityOnEntity(Mindflare, MindflareTarget)
        return
    end

    UnBurrowDesire = X.ConsiderUnborrow()
    if UnBurrowDesire > 0
    then
        bot:Action_UseAbility(UnBurrow)
        return
    end

    BurrowDesire = X.ConsiderBurrow()
    if BurrowDesire > 0
    then
        bot:Action_UseAbility(Burrow)
        return
    end
end

function X.ConsiderImpale()
    if not J.CanCastAbility(Impale)
    or bot:HasModifier('modifier_nyx_assassin_vendetta')
    then
        return BOT_ACTION_DESIRE_NONE, 0
    end

    local nCastRange = J.GetProperCastRange(false, bot, Impale:GetCastRange())
    local nCastPoint = Impale:GetCastPoint()
    local nStunDuration = Impale:GetSpecialValueInt('duration')
    local nDamage = Impale:GetSpecialValueInt('impale_damage')
    local botTarget = J.GetProperTarget(bot)

    local nEnemyHeroes = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and not J.IsSuspiciousIllusion(enemyHero)
        then
            if enemyHero:IsChanneling() or J.IsCastingUltimateAbility(enemyHero)
            then
                return BOT_ACTION_DESIRE_HIGH, enemyHero:GetLocation()
            end

            if  J.CanKillTarget(enemyHero, nDamage, DAMAGE_TYPE_MAGICAL)
            and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
            and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
            and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
            and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
            then
                return BOT_ACTION_DESIRE_HIGH, enemyHero:GetExtrapolatedLocation(nCastPoint)
            end
        end
    end

    local nAllyHeroes = bot:GetNearbyHeroes(nCastRange, false, BOT_MODE_NONE)
    for _, allyHero in pairs(nAllyHeroes)
    do
        local nAllyInRangeEnemy = allyHero:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)

        if  J.IsRetreating(allyHero)
        and allyHero:WasRecentlyDamagedByAnyHero(2.1)
        and not allyHero:IsIllusion()
        and J.GetMP(bot) > 0.31
        then
            if  nAllyInRangeEnemy ~= nil and #nAllyInRangeEnemy >= 1
            and J.IsValidHero(nAllyInRangeEnemy[1])
            and J.CanCastOnNonMagicImmune(nAllyInRangeEnemy[1])
            and J.IsInRange(allyHero, nAllyInRangeEnemy[1], 400)
            and J.IsInRange(bot, nAllyInRangeEnemy[1], nCastRange)
            and J.IsRunning(allyHero)
            and nAllyInRangeEnemy[1]:IsFacingLocation(allyHero:GetLocation(), 30)
            and not J.IsDisabled(nAllyInRangeEnemy[1])
            and not J.IsTaunted(nAllyInRangeEnemy[1])
            and not J.IsSuspiciousIllusion(nAllyInRangeEnemy[1])
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_enigma_black_hole_pull')
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_faceless_void_chronosphere_freeze')
            and not nAllyInRangeEnemy[1]:HasModifier('modifier_necrolyte_reapers_scythe')
            then
                return BOT_ACTION_DESIRE_HIGH, nAllyInRangeEnemy[1]:GetExtrapolatedLocation(nCastPoint)
            end
        end
    end

    if J.IsGoingOnSomeone(bot)
	then
        local strongestTarget = J.GetStrongestUnit(nCastRange, bot, true, false, nStunDuration)
        local nInRangeAlly = bot:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

        if strongestTarget == nil
        then
            strongestTarget = J.GetStrongestUnit(nCastRange, bot, true, true, nStunDuration)
        end

		if  J.IsValidTarget(strongestTarget)
        and J.IsInRange(bot, strongestTarget, nCastRange)
        and not J.IsSuspiciousIllusion(strongestTarget)
        and not J.IsDisabled(strongestTarget)
        and not J.IsTaunted(strongestTarget)
        and not strongestTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not strongestTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not strongestTarget:HasModifier('modifier_enigma_black_hole_pull')
        and not strongestTarget:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not strongestTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not strongestTarget:HasModifier('modifier_templar_assassin_refraction_absorb')
		then
            local nTargetInRangeAlly = strongestTarget:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            then
                return BOT_ACTION_DESIRE_HIGH, strongestTarget:GetExtrapolatedLocation(nCastPoint)
            end
		end
	end

    if J.IsRetreating(bot)
    then
        local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)
        local nInRangeEnemy = bot:GetNearbyHeroes(800, true, BOT_MODE_NONE)

        if  nInRangeAlly ~= nil and nInRangeEnemy
        and J.IsValidHero(nInRangeEnemy[1])
        and J.CanCastOnNonMagicImmune(nInRangeEnemy[1])
        and J.IsInRange(bot, nInRangeEnemy[1], nCastRange)
        and J.IsRunning(nInRangeEnemy[1])
        and nInRangeEnemy[1]:IsFacingLocation(bot:GetLocation(), 30)
        and not J.IsSuspiciousIllusion(nInRangeEnemy[1])
        then
            local nTargetInRangeAlly = nInRangeEnemy[1]:GetNearbyHeroes(800, false, BOT_MODE_NONE)

            if  nTargetInRangeAlly ~= nil
            and ((#nTargetInRangeAlly > #nInRangeAlly)
                or (J.GetHP(bot) < 0.82 and bot:WasRecentlyDamagedByAnyHero(1.5)))
            then
                return BOT_ACTION_DESIRE_HIGH, nInRangeEnemy[1]:GetExtrapolatedLocation(nCastPoint)
            end
        end
    end

    if  J.IsLaning(bot)
    and not J.IsThereCoreNearby(1200)
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
                and J.GetMP(bot) > 0.41
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
	end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        and not J.IsDisabled(botTarget)
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

function X.ConsiderMindflare()
    if not J.CanCastAbility(Mindflare)
    or bot:HasModifier('modifier_nyx_assassin_vendetta')
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, Mindflare:GetCastRange())
	local nDmgPct = Mindflare:GetSpecialValueInt('max_mana_as_damage_pct')

    local nEnemyHeroes = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and J.CanKillTarget(enemyHero, enemyHero:GetMaxMana() * (nDmgPct / 100), DAMAGE_TYPE_MAGICAL)
        and not J.IsSuspiciousIllusion(enemyHero)
        and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
        and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
        and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
        and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            return BOT_ACTION_DESIRE_HIGH, enemyHero
        end
    end

    if J.IsGoingOnSomeone(bot)
	then
        local weakestTarget = J.GetVulnerableWeakestUnit(bot, true, true, nCastRange)
        local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)

		if  J.IsValidTarget(weakestTarget)
        and not J.IsSuspiciousIllusion(weakestTarget)
        and not weakestTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not weakestTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not weakestTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not weakestTarget:HasModifier('modifier_templar_assassin_refraction_absorb')
		then
            local nTargetInRangeAlly = weakestTarget:GetNearbyHeroes(800, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            then
                return BOT_ACTION_DESIRE_HIGH, weakestTarget
            end
		end
	end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderSpikedCarapace()
    if not J.CanCastAbility(SpikedCarapace)
    or bot:HasModifier('modifier_nyx_assassin_vendetta')
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

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderBurrow()
    if not J.CanCastAbility(Burrow)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nCarapaceRadius = Burrow:GetSpecialValueInt('carapace_radius')

    if J.IsInTeamFight(bot, 1200)
    then
        local realEnemyCount = J.GetEnemiesNearLoc(bot:GetLocation(), nCarapaceRadius)

        if  realEnemyCount ~= nil and #realEnemyCount >= 2
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderUnborrow()
    if not J.CanCastAbility(UnBurrow)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nInRangeEnemy = J.GetEnemiesNearLoc(bot:GetLocation(), 777)
    if #nInRangeEnemy == 0
    or #nInRangeEnemy <= 1 and (J.IsInRange(bot, GetAncient(GetTeam()), 2000) or J.IsInRange(bot, GetAncient(GetOpposingTeam()), 2000))
    then
        return BOT_ACTION_DESIRE_HIGH
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderVendetta()
    if not J.CanCastAbility(Vendetta)
    or bot:HasModifier('modifier_nyx_assassin_burrow')
    or J.IsRealInvisible(bot)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nDamage = Vendetta:GetSpecialValueInt('bonus_damage')
    local botTarget = J.GetProperTarget(bot)

    local nEnemyHeroes = bot:GetNearbyHeroes(800, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.CanKillTarget(enemyHero, nDamage, DAMAGE_TYPE_PURE)
        and not J.IsSuspiciousIllusion(enemyHero)
        and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
        and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
        and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
        and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            local nInRangeAlly = bot:GetNearbyHeroes(800, false, BOT_MODE_NONE)
            local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(800, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil
            and nInRangeAlly >= nTargetInRangeAlly
            then
                bot.canVendettaKill = true
                bot.vendettaTarget = enemyHero
                return BOT_ACTION_DESIRE_HIGH
            else
                bot.canVendettaKill = false
                bot.vendettaTarget = nil
            end
        end
    end

    if  J.IsRetreating(bot)
    and not J.IsRealInvisible(bot)
    then
        return BOT_ACTION_DESIRE_HIGH
    end

    if J.IsGoingOnSomeone(bot)
	then
        local nInRangeAlly = bot:GetNearbyHeroes(1600, false, BOT_MODE_NONE)

		if  J.IsValidTarget(botTarget)
        and J.IsInRange(bot, botTarget, 2200)
        and not J.IsSuspiciousIllusion(botTarget)
        and not J.IsDisabled(botTarget)
        and not J.IsTaunted(botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_enigma_black_hole_pull')
        and not botTarget:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        and not botTarget:HasModifier('modifier_templar_assassin_refraction_absorb')
		then
            local nTargetInRangeAlly = botTarget:GetNearbyHeroes(1600, false, BOT_MODE_NONE)

            if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
            and #nInRangeAlly >= #nTargetInRangeAlly
            then
                return BOT_ACTION_DESIRE_HIGH
            end
		end
	end

    return BOT_ACTION_DESIRE_NONE
end

return X