local X = {}
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sRole = J.Item.GetRoleItemsBuyList( bot )

if GetBot():GetUnitName() == 'npc_dota_hero_marci'
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
					['t15'] = {0, 10},
					['t10'] = {0, 10},
                },
            },
            ['ability'] = {
                [1] = {1,3,3,2,3,6,3,2,2,2,6,1,1,1,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_magic_wand",
                "item_faerie_fire",

                "item_phase_boots",
                "item_bfury",--
                "item_black_king_bar",--
                "item_lesser_crit",
                "item_basher",
                "item_greater_crit",--
                "item_satanic",--
                "item_abyssal_blade",--
                "item_ultimate_scepter_2",
                "item_moon_shard",
                "item_aghanims_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_satanic",
            },
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
                [1] = {1,3,3,2,3,6,3,2,2,2,6,1,1,1,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_magic_wand",
                "item_faerie_fire",

                "item_bottle",
                "item_phase_boots",
                "item_bfury",--
                "item_black_king_bar",--
                "item_lesser_crit",
                "item_basher",
                "item_greater_crit",--
                "item_satanic",--
                "item_abyssal_blade",--
                "item_ultimate_scepter_2",
                "item_moon_shard",
                "item_aghanims_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_basher",
                "item_bottle", "item_satanic",
            },
        },
    },
    ['pos_3'] = {
        [1] = {
            ['talent'] = {
                [1] = {
                    ['t25'] = {10, 0},
					['t20'] = {10, 0},
					['t15'] = {0, 10},
					['t10'] = {10, 0},
                },
            },
            ['ability'] = {
                [1] = {1,3,3,2,3,6,3,2,2,2,6,1,1,1,6},
            },
            ['buy_list'] = {
                "item_tango",
                "item_magic_wand",
                "item_faerie_fire",

                "item_phase_boots",
                "item_bfury",--
                "item_heavens_halberd",--
                "item_black_king_bar",--
                "item_assault",--
                "item_nullifier",--
                "item_moon_shard",
                "item_ultimate_scepter_2",
                "item_aghanims_shard",
                "item_travel_boots_2",--
            },
            ['sell_list'] = {
                "item_magic_wand", "item_nullifier",
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

function X.MinionThink(hMinionUnit)
    Minion.MinionThink(hMinionUnit)
end

end

local Dispose   = bot:GetAbilityByName('marci_grapple')
local Rebound   = bot:GetAbilityByName('marci_companion_run')
local Sidekick  = bot:GetAbilityByName('marci_guardian')
local Bodyguard  = bot:GetAbilityByName('marci_bodyguard')
local SpecialDelivery  = bot:GetAbilityByName('marci_special_delivery')
local Unleash   = bot:GetAbilityByName('marci_unleash')

local DisposeDesire, DisposeTaret
local ReboundDesire, ReboundTarget
local SidekickDesire, SidekickTarget
local BodyguardDesire, BodyguardTarget
local SpecialDeliveryDesire
local UnleashDesire

function X.SkillsComplement()
    Dispose   = bot:GetAbilityByName('marci_grapple')
    Rebound   = bot:GetAbilityByName('marci_companion_run')
    Sidekick  = bot:GetAbilityByName('marci_guardian')
    Unleash   = bot:GetAbilityByName('marci_unleash')

    if J.CanNotUseAbility(bot) then return end

    UnleashDesire = X.ConsiderUnleash()
    if UnleashDesire > 0 then
        bot:Action_UseAbility(Unleash)
        return
    end

    DisposeDesire, DisposeTaret = X.ConsiderDispose()
    if DisposeDesire > 0 then
        J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnEntity(Dispose, DisposeTaret)
        return
    end

    ReboundDesire, ReboundTarget = X.ConsiderRebound()
    if ReboundDesire > 0 then
        J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnEntity(Rebound, ReboundTarget)
        return
    end

    SidekickDesire, SidekickTarget = X.ConsiderSidekick()
    if SidekickDesire > 0 then
        J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnEntity(Sidekick, SidekickTarget)
        return
    end

    BodyguardDesire, BodyguardTarget = X.ConsiderBodyguard()
    if BodyguardDesire > 0 then
        J.SetQueuePtToINT(bot, false)
        bot:ActionQueue_UseAbilityOnEntity(Bodyguard, BodyguardTarget)
        return
    end

    -- SpecialDeliveryDesire = X.ConsiderSpecialDelivery()
end

function X.ConsiderDispose()
    if not J.CanCastAbility(Dispose)
    then
        return BOT_ACTION_DESIRE_NONE
    end

    local nCastRange = J.GetProperCastRange(false, bot, Dispose:GetCastRange())
    local nDamage = Dispose:GetSpecialValueInt('impact_damage')
    local botTarget = J.GetProperTarget(bot)

    local nAllyHeroes = bot:GetNearbyHeroes(1600, false, BOT_MODE_NONE)
    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

    for _, enemyHero in pairs(nEnemyHeroes)
    do
        if  J.IsValidHero(enemyHero)
        and J.IsInRange(bot, enemyHero, nCastRange)
        and J.CanCastOnNonMagicImmune(enemyHero)
        and J.CanCastOnTargetAdvanced(enemyHero)
        then
            if enemyHero:HasModifier('modifier_teleporting') then
                return BOT_ACTION_DESIRE_HIGH, enemyHero
            end

            if J.CanKillTarget(enemyHero, nDamage, DAMAGE_TYPE_MAGICAL)
            and not enemyHero:HasModifier('modifier_abaddon_borrowed_time')
            and not enemyHero:HasModifier('modifier_dazzle_shallow_grave')
            and not enemyHero:HasModifier('modifier_enigma_black_hole_pull')
            and not enemyHero:HasModifier('modifier_faceless_void_chronosphere_freeze')
            and not enemyHero:HasModifier('modifier_necrolyte_reapers_scythe')
            and not enemyHero:HasModifier('modifier_oracle_false_promise_timer')
            then
                return BOT_ACTION_DESIRE_HIGH, enemyHero
            end
        end
    end

	if J.IsGoingOnSomeone(bot)
	then
        if J.IsValidTarget(botTarget)
        and J.CanCastOnNonMagicImmune(botTarget)
        and J.CanCastOnTargetAdvanced(botTarget)
        and J.IsInRange(bot, botTarget, nCastRange)
        and not J.IsDisabled(botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_enigma_black_hole_pull')
        and not botTarget:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
        then
            if GetUnitToLocationDistance(bot, J.GetEnemyFountain()) > GetUnitToLocationDistance(botTarget, J.GetEnemyFountain()) then
                return BOT_ACTION_DESIRE_HIGH, botTarget
            end
        end
	end

    if J.IsRetreating(bot)
    and not J.IsRealInvisible(bot)
    and bot:WasRecentlyDamagedByAnyHero(3.0)
	then
        for _, enemyHero in pairs(nEnemyHeroes) do
            if  J.IsValidHero(enemyHero)
            and J.IsInRange(bot, enemyHero, nCastRange)
            and J.CanCastOnNonMagicImmune(enemyHero)
            and J.CanCastOnTargetAdvanced(enemyHero)
            and bot:IsFacingLocation(J.GetTeamFountain(), 30)
            and bot:IsFacingLocation(enemyHero:GetLocation(), 30)
            and enemyHero:GetAttackTarget() == bot
            and not enemyHero:HasModifier('modifier_enigma_black_hole_pull')
            and not enemyHero:HasModifier('modifier_faceless_void_chronosphere_freeze')
            then
                return BOT_ACTION_DESIRE_HIGH, enemyHero
            end
        end
	end

    -- ally save ..

    return BOT_ACTION_DESIRE_NONE
end

-- vector targeted; not reliable
function X.ConsiderRebound()
    if not J.CanCastAbility(Rebound)
    or bot:IsRooted()
    or (bot:HasModifier('modifier_marci_unleash') and not J.IsRetreating(bot))
    then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nDamage = Rebound:GetSpecialValueInt('impact_damage')
    local nRadius = Rebound:GetSpecialValueInt('landing_radius')
    local nJumpDistance = Rebound:GetSpecialValueInt('max_jump_distance')
    local botTarget = J.GetProperTarget(bot)
    local nManaAfter = J.GetManaAfter(Rebound:GetManaCost())

    local nAllyHeroes = bot:GetNearbyHeroes(1600, false, BOT_MODE_NONE)
    local nEnemyHeroes = bot:GetNearbyHeroes(1600, true, BOT_MODE_NONE)

    for _, ally in pairs(GetUnitList(UNIT_LIST_ALLIES)) do
        if J.IsValid(ally)
        and bot ~= ally
        and J.IsInRange(bot, ally, nJumpDistance)
        and (ally:IsHero() or ally:IsCreep())
        and not ally:HasModifier('modifier_enigma_black_hole_pull')
        and not ally:HasModifier('modifier_faceless_void_chronosphere_freeze')
        then
            if J.IsGoingOnSomeone(bot) and not J.IsInTeamFight(bot, 1600) then -- don't go jumping around teamfights
                if J.IsValidHero(botTarget)
                and J.CanBeAttacked(botTarget)
                and J.IsInRange(bot, ally, nRadius)
                and J.CanCastOnNonMagicImmune(botTarget)
                and not botTarget:HasModifier('modifier_enigma_black_hole_pull')
                and not botTarget:HasModifier('modifier_faceless_void_chronosphere_freeze')
                and not botTarget:HasModifier('modifier_necrolyte_reapers_scythe')
                then
                    return BOT_ACTION_DESIRE_HIGH, ally
                end
            end

            if J.IsRetreating(bot)
            and not J.IsRealInvisible(bot)
            and bot:WasRecentlyDamagedByAnyHero(3.0)
            and GetUnitToUnitDistance(bot, ally) >= nJumpDistance - 300
            and ally:DistanceFromFountain() < bot:DistanceFromFountain()
            then
                local vAllyToFountain = (J.GetTeamFountain() - ally:GetLocation()):Normalized()
                local vBotToFountain = (J.GetTeamFountain() - bot:GetLocation()):Normalized()
                if J.DotProduct(vAllyToFountain, vBotToFountain) >= 0.5 then -- at least 45*
                    if #nEnemyHeroes > #nAllyHeroes + 1 and J.GetHP(bot) < 0.6 then
                        return BOT_ACTION_DESIRE_HIGH, ally
                    end

                    for _, enemy in pairs(nEnemyHeroes) do
                        if J.IsValidHero(enemy)
                        and J.IsChasingTarget(enemy, bot)
                        and not J.IsSuspiciousIllusion(enemy)
                        then
                            return BOT_ACTION_DESIRE_HIGH, ally
                        end
                    end
                end
            end

            if ally:IsHero() then
                local tEnemyLaneCreeps = ally:GetNearbyLaneCreeps(nRadius, true)

                if J.IsPushing(bot) and nManaAfter > 0.3 then
                    if #tEnemyLaneCreeps >= 4
                    and J.CanBeAttacked(tEnemyLaneCreeps[1])
                    and not J.IsRunning(tEnemyLaneCreeps[1])
                    then
                        return BOT_ACTION_DESIRE_HIGH, ally
                    end
                end
    
                if J.IsDefending(bot) and nManaAfter > 0.3 then
                    if #tEnemyLaneCreeps >= 3
                    and J.CanBeAttacked(tEnemyLaneCreeps[1])
                    and not J.IsRunning(tEnemyLaneCreeps[1])
                    then
                        return BOT_ACTION_DESIRE_HIGH, ally
                    end
                end
    
                local tCreeps = ally:GetNearbyCreeps(nRadius, true)
    
                if J.IsFarming(bot) and nManaAfter > 0.25 then
                    if (#tCreeps >= 3 or #tCreeps >= 2 and tCreeps[1]:IsAncientCreep())
                    and J.CanBeAttacked(tCreeps[1])
                    and not J.IsRunning(tCreeps[1])
                    then
                        return BOT_ACTION_DESIRE_HIGH, ally
                    end
                end
    
                if J.IsLaning(bot) and nManaAfter > 0.25 then
                    local nCanKillCreeps = 0
                    if J.IsCore(bot) or (not J.IsCore(bot) and not J.IsThereCoreNearby(1200)) then
                        for _, creep in pairs(tCreeps) do
                            if J.IsValid(creep)
                            and J.CanBeAttacked(creep)
                            and not J.IsRunning(creep)
                            and J.CanKillTarget(creep, nDamage, DAMAGE_TYPE_MAGICAL) then
                                nCanKillCreeps = nCanKillCreeps + 1
                            end
                        end
    
                        if nCanKillCreeps >= 3 then
                            return BOT_ACTION_DESIRE_HIGH, ally
                        end
                    end
                end
            end

            if J.IsDoingRoshan(bot) or J.IsDoingTormentor(bot) then
                if (J.IsRoshan(botTarget) or J.IsTormentor(botTarget))
                and J.CanBeAttacked(botTarget)
                and J.IsInRange(ally, botTarget, nRadius)
                and J.IsAttacking(bot)
                then
                    return BOT_ACTION_DESIRE_HIGH, ally
                end
            end

            local tAllyEnemy = J.GetEnemiesNearLoc(ally:GetLocation(), nRadius)
            for _, enemy in pairs(tAllyEnemy) do
                if J.IsValidHero(enemy)
                and J.CanCastOnNonMagicImmune(enemy)
                then
                    if enemy:HasModifier('modifier_teleporting') then
                        return BOT_ACTION_DESIRE_HIGH, ally
                    end

                    if J.CanKillTarget(enemy, nDamage, DAMAGE_TYPE_MAGICAL)
                    and not enemy:HasModifier('modifier_abaddon_borrowed_time')
                    and not enemy:HasModifier('modifier_dazzle_shallow_grave')
                    and not enemy:HasModifier('modifier_enigma_black_hole_pull')
                    and not enemy:HasModifier('modifier_faceless_void_chronosphere_freeze')
                    and not enemy:HasModifier('modifier_necrolyte_reapers_scythe')
                    and not enemy:HasModifier('modifier_oracle_false_promise_timer')
                    then
                        return BOT_ACTION_DESIRE_HIGH, ally
                    end
                end
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderSidekick()
    if not J.CanCastAbility(Sidekick) then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, Sidekick:GetCastRange())
    local botTarget = J.GetProperTarget(bot)

    local tEnemyLaneCreeps = bot:GetNearbyLaneCreeps(1200, true)

    if J.IsGoingOnSomeone(bot)
    or J.IsPushing(bot)
    or J.IsDefending(bot)
    or (J.IsLaning(bot) and #tEnemyLaneCreeps >= 3)
    or (J.IsDoingRoshan(bot) and J.IsRoshan(botTarget) and J.IsInRange(bot, botTarget, 800) and J.IsAttacking(bot) and J.CanBeAttacked(botTarget))
    or (J.IsDoingTormentor(bot) and J.IsTormentor(botTarget) and J.IsInRange(bot, botTarget, 800) and J.IsAttacking(bot) and J.CanBeAttacked(botTarget))
    then
        local nAllyHeroes = bot:GetNearbyHeroes(nCastRange, false, BOT_MODE_NONE)

        local target = nil
        local targetAttackDamage = 0
        for _, ally in pairs(nAllyHeroes) do
            if J.IsValidHero(ally)
            and bot ~= ally
            and J.IsInRange(bot, ally, nCastRange)
            and not ally:IsIllusion()
            and not J.IsMeepoClone(ally)
            and not ally:HasModifier('modifier_faceless_void_chronosphere_freeze')
            and not ally:HasModifier('modifier_marci_guardian_buff')
            and not ally:HasModifier('modifier_necrolyte_reapers_scythe')
            then
                local allyAttackDamage = ally:GetAttackDamage() * ally:GetAttackSpeed()
                if allyAttackDamage > targetAttackDamage then
                    targetAttackDamage = allyAttackDamage
                    target = ally
                end
            end
        end

        if target ~= nil then
            return BOT_ACTION_DESIRE_HIGH, target
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderBodyguard()
    if not J.CanCastAbility(Bodyguard) then
        return BOT_ACTION_DESIRE_NONE, nil
    end

    local nCastRange = J.GetProperCastRange(false, bot, Bodyguard:GetCastRange())
    local botTarget = J.GetProperTarget(bot)

    local tEnemyLaneCreeps = bot:GetNearbyLaneCreeps(1200, true)

    if J.IsGoingOnSomeone(bot)
    or J.IsPushing(bot)
    or J.IsDefending(bot)
    or (J.IsLaning(bot) and #tEnemyLaneCreeps >= 3)
    or (J.IsDoingRoshan(bot) and J.IsRoshan(botTarget) and J.IsInRange(bot, botTarget, 800) and J.IsAttacking(bot) and J.CanBeAttacked(botTarget))
    or (J.IsDoingTormentor(bot) and J.IsTormentor(botTarget) and J.IsInRange(bot, botTarget, 800) and J.IsAttacking(bot) and J.CanBeAttacked(botTarget))
    then
        local nAllyHeroes = bot:GetNearbyHeroes(nCastRange, false, BOT_MODE_NONE)

        local target = nil
        local targetAttackDamage = 0
        for _, ally in pairs(nAllyHeroes) do
            if J.IsValidHero(ally)
            and bot ~= ally
            and J.IsInRange(bot, ally, nCastRange)
            and not ally:IsIllusion()
            and not J.IsMeepoClone(ally)
            and not ally:HasModifier('modifier_faceless_void_chronosphere_freeze')
            and not ally:HasModifier('modifier_marci_guardian_buff')
            and not ally:HasModifier('modifier_necrolyte_reapers_scythe')
            then
                local allyAttackDamage = ally:GetAttackDamage() * ally:GetAttackSpeed()
                if allyAttackDamage > targetAttackDamage then
                    targetAttackDamage = allyAttackDamage
                    target = ally
                end
            end
        end

        if target ~= nil then
            return BOT_ACTION_DESIRE_HIGH, target
        end
    end

    return BOT_ACTION_DESIRE_NONE, nil
end

function X.ConsiderUnleash()
    if not J.CanCastAbility(Unleash) then
        return BOT_ACTION_DESIRE_NONE
    end

    local nPulseDamage = Unleash:GetSpecialValueInt('pulse_damage')
    local nPunchCount = Unleash:GetSpecialValueInt('charges_per_flurry')
    local botTarget = J.GetProperTarget(bot)

    local nAllyHeroes = J.GetAlliesNearLoc(bot:GetLocation(), 800)
    local nEnemyHeroes = J.GetEnemiesNearLoc(bot:GetLocation(), 800)

    if J.IsInTeamFight(bot, 800) then
        local nInRangeEnemy = J.GetEnemiesNearLoc(bot:GetLocation(), 900)
        local nCoreCount = 0
        for _, enemy in pairs(nInRangeEnemy) do
            if J.IsValidHero(enemy) and J.IsCore(enemy) then
                nCoreCount = nCoreCount + 1
            end
        end

        if nCoreCount > 0 then
            return BOT_ACTION_DESIRE_HIGH
        end
    end

    if J.IsGoingOnSomeone(bot) then
        if J.IsValidHero(botTarget)
        and J.IsInRange(bot, botTarget, 800)
        and J.CanBeAttacked(botTarget)
        and botTarget:GetHealth() > (nPulseDamage + bot:GetAttackDamage() * (nPunchCount + 2))
        and not J.IsChasingTarget(bot, botTarget)
        and not botTarget:HasModifier('modifier_abaddon_borrowed_time')
        and not botTarget:HasModifier('modifier_dazzle_shallow_grave')
        and not botTarget:HasModifier('modifier_faceless_void_chronosphere_freeze')
        and not botTarget:HasModifier('modifier_item_blade_mail_reflect')
        and not botTarget:HasModifier('modifier_item_aeon_disk_buff')
        and not (#nAllyHeroes >= #nEnemyHeroes + 2)
        then
            if J.IsInLaningPhase() and #nAllyHeroes <= 2 and #nEnemyHeroes <= 1 then
                if J.IsCore(botTarget) and botTarget:GetHealth() <= bot:GetEstimatedDamageToTarget(true, botTarget, 8.0, DAMAGE_TYPE_ALL) then -- don't waste it too much
                    return BOT_ACTION_DESIRE_HIGH
                end
            else
                if J.IsCore(botTarget) then
                    return BOT_ACTION_DESIRE_HIGH
                end
            end
        end
    end

    return BOT_ACTION_DESIRE_NONE
end

return X