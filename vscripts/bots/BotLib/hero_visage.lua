local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_visage'
then

local RI = require(GetScriptDirectory()..'/FunLib/util_role_item')

local sUtility = {"item_pipe", "item_crimson_guard"}
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
                -- [1] = {
                --     ['t25'] = {10, 0},
                --     ['t20'] = {10, 0},
                --     ['t15'] = {10, 0},
                --     ['t10'] = {0, 10},
                -- }
                [1] = {
                    ['t25'] = {0, 10},
                    ['t20'] = {0, 10},
                    ['t15'] = {10, 0},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {2,1,1,3,1,6,1,3,3,3,6,2,2,2,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_double_circlet",
                "item_faerie_fire",
            
                "item_bottle",
                "item_magic_wand",
                "item_null_talisman",
                "item_bracer",
                "item_power_treads",
                "item_maelstrom",
                "item_vladmir",
                "item_orchid",
                "item_mjollnir",--
                "item_aghanims_shard",
                "item_black_king_bar",--
                "item_assault",--
                "item_bloodthorn",--
                "item_nullifier",--
                "item_ultimate_scepter_2",
                "item_moon_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_vladmir",
                "item_null_talisman", "item_orchid",
                "item_bracer", "item_black_king_bar",
                "item_bottle", "item_assault",
                "item_vladmir", "item_nullifier",
            },
        },
    },
    ['pos_3'] = {
        [1] = {
            ['talent'] = {
                -- [1] = {
                --     ['t25'] = {10, 0},
                --     ['t20'] = {10, 0},
                --     ['t15'] = {10, 0},
                --     ['t10'] = {0, 10},
                -- }
                [1] = {
                    ['t25'] = {0, 10},
                    ['t20'] = {10, 0},
                    ['t15'] = {10, 0},
                    ['t10'] = {0, 10},
                }
            },
            ['ability'] = {
                [1] = {2,1,1,3,1,6,1,3,3,3,6,2,2,2,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_double_branches",
                "item_double_circlet",
            
                "item_magic_wand",
                "item_double_bracer",
                "item_arcane_boots",
                "item_vladmir",
                sUtilityItem,--
                "item_assault",--
                "item_aghanims_shard",
                "item_black_king_bar",--
                "item_bloodthorn",--
                "item_ultimate_scepter_2",
                "item_shivas_guard",--
                "item_moon_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_assault",
                "item_bracer", "item_black_king_bar",
                "item_bracer", "item_bloodthorn",
                "item_vladmir", "item_shivas_guard",
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

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_antimage' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink(hMinionUnit)
	Minion.MinionThink(hMinionUnit)
end

end

local GraveChill        = bot:GetAbilityByName('visage_grave_chill')
local SoulAssumption    = bot:GetAbilityByName('visage_soul_assumption')
local GravekeepersCloak = bot:GetAbilityByName('visage_gravekeepers_cloak')
local SilentAsTheGrave  = bot:GetAbilityByName('visage_silent_as_the_grave')
local SummonFamiliars   = bot:GetAbilityByName('visage_summon_familiars')

local GraveChillDesire, GraveChillTarget
local SoulAssumptionDesire, SoulAssumptionTarget
local GravekeepersCloakDesire
local SilentAsTheGraveDesire
local SummonFamiliarsDesire

local botTarget

function X.SkillsComplement()
	if J.CanNotUseAbility(bot) then return end

    GraveChill        = bot:GetAbilityByName('visage_grave_chill')
    SoulAssumption    = bot:GetAbilityByName('visage_soul_assumption')
    GravekeepersCloak = bot:GetAbilityByName('visage_gravekeepers_cloak')
    SilentAsTheGrave  = bot:GetAbilityByName('visage_silent_as_the_grave')
    SummonFamiliars   = bot:GetAbilityByName('visage_summon_familiars')

    botTarget = J.GetProperTarget(bot)

    GraveChillDesire, GraveChillTarget = X.ConsiderGraveChill()
    if GraveChillDesire > 0
    then
        bot:Action_UseAbilityOnEntity(GraveChill, GraveChillTarget)
        return
    end

    SoulAssumptionDesire, SoulAssumptionTarget = X.ConsiderSoulAssumption()
    if SoulAssumptionDesire > 0
    then
        bot:Action_UseAbilityOnEntity(SoulAssumption, SoulAssumptionTarget)
        return
    end

    GravekeepersCloakDesire = X.ConsiderGravekeepersCloak()
    if GravekeepersCloakDesire > 0
    then
        bot:Action_UseAbility(GravekeepersCloak)
        return
    end

    SilentAsTheGraveDesire = X.ConsiderSilentAsTheGrave()
    if SilentAsTheGraveDesire > 0
    then
        bot:Action_UseAbility(SilentAsTheGrave)
        return
    end

    -- Bugged...
    -- SummonFamiliarsDesire = X.ConsiderSummonFamiliars()
    -- if SummonFamiliarsDesire > 0
    -- then
    --     bot:Action_UseAbility(SummonFamiliars)
    --     return
    -- end
end

function X.ConsiderGraveChill()
    if not J.CanCastAbility(GraveChill)
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, GraveChill:GetCastRange())

	if J.IsGoingOnSomeone(bot)
	then
        local target = nil
        local atkSpd = 0
        local nInRangeEnemy = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)
        for _, enemyHero in pairs(nInRangeEnemy)
        do
            if  J.IsValidTarget(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and not J.IsSuspiciousIllusion(enemyHero)
            then
                local nInRangeAlly = enemyHero:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
                local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1200, false, BOT_MODE_NONE)
                local currAtkSpd = enemyHero:GetAttackSpeed()

                if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
                and #nInRangeAlly >= #nTargetInRangeAlly
                and currAtkSpd > atkSpd
                then
                    atkSpd = currAtkSpd
                    target = enemyHero
                end
            end
        end

        if target ~= nil
        then
            return BOT_ACTION_DESIRE_HIGH, target
        end
	end

	if J.IsRetreating(bot)
	then
        local nInRangeEnemy = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)
        for _, enemyHero in pairs(nInRangeEnemy)
        do
            if  J.IsValidHero(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.IsChasingTarget(enemyHero, bot)
            and not J.IsSuspiciousIllusion(enemyHero)
            and not J.IsDisabled(enemyHero)
            then
                local nInRangeAlly = enemyHero:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
                local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

                if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
                and ((#nTargetInRangeAlly > #nInRangeAlly)
                    or bot:WasRecentlyDamagedByAnyHero(1.5))
                then
                    return BOT_ACTION_DESIRE_HIGH, enemyHero
                end
            end
        end
	end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderSoulAssumption()
    if not J.CanCastAbility(SoulAssumption)
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local Stacks = 0
	for i = 0, bot:NumModifiers()
	do
		if bot:GetModifierName(i) == 'modifier_visage_soul_assumption'
        then
			Stacks = bot:GetModifierStackCount(i)
			break
		end
	end

	local nCastRange = J.GetProperCastRange(false, bot, SoulAssumption:GetCastRange())
	local nStackLimit = SoulAssumption:GetSpecialValueInt('stack_limit')
	local nBaseDamage = SoulAssumption:GetSpecialValueInt('soul_base_damage')
	local nChargeDamage = SoulAssumption:GetSpecialValueInt('soul_charge_damage')
	local nTotalDamage = nBaseDamage + (Stacks * nChargeDamage)

    local nEnemyHeroes = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)
    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and J.CanCastOnTargetAdvanced(enemyHero)
        and J.CanKillTarget(enemyHero, nTotalDamage, DAMAGE_TYPE_MAGICAL)
        and not J.IsSuspiciousIllusion(enemyHero)
        and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
        and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
        and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
        and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
        and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
        then
            return BOT_ACTION_DESIRE_HIGH, enemyHero
        end
    end

    if J.IsGoingOnSomeone(bot)
	then
        local target = nil
        local hp = 20000
        local nInRangeEnemy = bot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE)
        for _, enemyHero in pairs(nInRangeEnemy)
        do
            if  J.IsValidTarget(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.CanCastOnTargetAdvanced(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and not J.IsSuspiciousIllusion(enemyHero)
            and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
            and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
            and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
            and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
            and not enemyHero:HasModifier('modifier_templar_assassin_refraction_absorb')
            and Stacks == nStackLimit
            then
                local nInRangeAlly = enemyHero:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
                local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1200, false, BOT_MODE_NONE)
                local currHP = enemyHero:GetHealth()

                if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
                and #nInRangeAlly >= #nTargetInRangeAlly
                and hp < currHP
                then
                    hp = currHP
                    target = enemyHero
                end
            end
        end

        if target ~= nil
        then
            return BOT_ACTION_DESIRE_HIGH, target
        end
	end

    if J.IsDoingRoshan(bot)
    then
        if  J.IsRoshan(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.CanCastOnTargetAdvanced(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        and Stacks == nStackLimit
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if  J.IsTormentor(botTarget)
        and J.IsInRange(bot, botTarget, 500)
        and J.IsAttacking(bot)
        and Stacks == nStackLimit
        then
            return BOT_ACTION_DESIRE_HIGH, botTarget
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderGravekeepersCloak()
    if not J.CanCastAbility(GravekeepersCloak)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    if J.GetHP(bot) < 0.49
    then
        return BOT_ACTION_DESIRE_HIGH
    end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderSummonFamiliars()
    if not J.CanCastAbility(SummonFamiliars)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nFamiliarCount = SummonFamiliars:GetSpecialValueInt('familiar_count')
    local nCurrFamiliar = 0

	for _, unit in pairs(GetUnitList(UNIT_LIST_ALLIES))
	do
        if string.find(unit:GetUnitName(), 'npc_dota_visage_familiar')
        then
			nCurrFamiliar = nCurrFamiliar + 1
		end
	end

	if nFamiliarCount > nCurrFamiliar
    then
		return BOT_ACTION_DESIRE_HIGH
	end

    return BOT_ACTION_DESIRE_NONE
end

function X.ConsiderSilentAsTheGrave()
    if not J.CanCastAbility(SilentAsTheGrave)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local roshanLoc = J.GetCurrentRoshanLocation()
    local tormentorLoc = J.GetTormentorLocation(GetTeam())

    if J.IsGoingOnSomeone(bot)
	then
		if  J.IsValidTarget(botTarget)
        and J.IsInRange(bot, botTarget, 1200)
        and not J.IsSuspiciousIllusion(botTarget)
        and not J.IsDisabled(botTarget)
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

	if J.IsRetreating(bot)
	then
        local nInRangeEnemy = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)
        for _, enemyHero in pairs(nInRangeEnemy)
        do
            if  J.IsValidHero(enemyHero)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.CanCastOnTargetAdvanced(enemyHero)
            and J.IsChasingTarget(enemyHero, bot)
            and not J.IsSuspiciousIllusion(enemyHero)
            and not J.IsDisabled(enemyHero)
            then
                local nInRangeAlly = enemyHero:GetNearbyHeroes(1200, true, BOT_MODE_NONE)
                local nTargetInRangeAlly = enemyHero:GetNearbyHeroes(1200, false, BOT_MODE_NONE)

                if  nInRangeAlly ~= nil and nTargetInRangeAlly ~= nil
                and ((#nTargetInRangeAlly > #nInRangeAlly)
                    or bot:WasRecentlyDamagedByAnyHero(2.5))
                then
                    return BOT_ACTION_DESIRE_HIGH, enemyHero
                end
            end
        end
	end

    if J.IsDoingRoshan(bot)
    then
        if GetUnitToLocationDistance(bot, roshanLoc) > 3200
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsDoingTormentor(bot)
    then
        if GetUnitToLocationDistance(bot, tormentorLoc) > 3200
        then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

return X