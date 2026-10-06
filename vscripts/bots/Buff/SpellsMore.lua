--[[
Banned:
    - abilities with sub-abilities (eg Sharpshooter).
    - shard/scepter that requires a native ability (eg Wolf Bite).
    - hero specific (eg Life Break)
    - summons
    - auto-cast
    - weak
    - etc
]]

local SM = {}
local Role = require('bots/FunLib/aba_role')
local SPL = require('bots/FunLib/aba_spell_list')

require('bots/Buff/Helper')

local PrecacheUnit = {}
local AbilityPickedList = {}
local AbilityIncompatibility = {}

local function shuffle(t)
    for i = #t, 2, -1 do
        local j = math.random(1, i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

local function HasFlag(val, flag)
    return math.floor(val / flag) % 2 == 1
end

local function AddIncompatible(...)
    local nList = {...}
    for i = 1, #nList do
        for j = i + 1, #nList do
            local a, b = nList[i], nList[j]
            AbilityIncompatibility[a] = AbilityIncompatibility[a] or {}
            AbilityIncompatibility[b] = AbilityIncompatibility[b] or {}
            AbilityIncompatibility[a][b] = true
            AbilityIncompatibility[b][a] = true
        end
    end
end

AddIncompatible('earth_spirit_rolling_boulder',
                'rattletrap_hookshot',
                'slardar_sprint',
                'shredder_timber_chain',
                'antimage_blink',
                'ember_spirit_fire_remnant',
                'faceless_void_time_walk',
                'kez_grappling_claw',
                'mirana_leap',
                'morphling_waveform',
                'phantom_assassin_phantom_strike',
                'riki_blink_strike',
                'slark_pounce',
                'ursa_earthshock',
                'queenofpain_blink',
                'storm_spirit_ball_lightning',
                'zuus_heavenly_jump',
                'magnataur_skewer',
                'furion_teleportation',
                'void_spirit_astral_step'
            )
AddIncompatible('bounty_hunter_wind_walk',
                'clinkz_wind_walk',
                'mirana_invis',
                'riki_backstab',
                'slark_shadow_dance',
                'templar_assassin_meld',
                'weaver_shukuchi',
                'invoker_ghost_walk',
                'nyx_assassin_vendetta',
                'sandking_sand_storm',
                'visage_silent_as_the_grave'
            )
AddIncompatible('sven_great_cleave',
                'tiny_tree_grab',
                'luna_moon_glaive',
                'medusa_split_shot',
                'templar_assassin_psi_blades',
                'magnataur_empower'
            )
AddIncompatible('slardar_bash',
                'spirit_breaker_greater_bash',
                'faceless_void_time_lock'
            )
AddIncompatible('chaos_knight_chaos_strike',
                'dawnbreaker_luminosity',
                'skeleton_king_mortal_strike',
                'juggernaut_blade_dance',
                'phantom_assassin_coup_de_grace'
            )
AddIncompatible('obsidian_destroyer_astral_imprisonment',
                'shadow_demon_disruption'
            )
AddIncompatible('necrolyte_ghost_shroud',
                'leshrac_greater_lightning_storm'
            )
AddIncompatible('muerta_spectral_slug',
                'pugna_decrepify'
            )
AddIncompatible('life_stealer_rage',
                'juggernaut_blade_fury'
            )

local function IsIncompatible(sAbilityName1, sAbilityName2)
    return AbilityIncompatibility[sAbilityName1] ~= nil and AbilityIncompatibility[sAbilityName1][sAbilityName2] == true
end

-- build the set of hero levels an ult can be leveled at
local function UltLevelSlots(nStartLevel, nCooldown, nMaxLevel, nHeroLevelMax)
    local slots = {}
    local nLevel = nStartLevel
    while nLevel <= nHeroLevelMax and #slots < nMaxLevel do
        table.insert(slots, nLevel)
        nLevel = nLevel + nCooldown
    end
    return slots
end

-- greedy
local function AssignAbilities(slots, defs)
    local remaining = {}
    local nextAllowed = {}
    local cooldownOf = {}

    for _, d in ipairs(defs) do
        remaining[d.name] = d.maxLevel
        nextAllowed[d.name] = d.startLevel
        cooldownOf[d.name] = d.cooldown
    end

    local result = {}

    for _, heroLevel in ipairs(slots) do
        local eligible = {}
        for _, d in ipairs(defs) do
            if remaining[d.name] > 0 and nextAllowed[d.name] <= heroLevel then
                table.insert(eligible, d.name)
            end
        end

        if #eligible > 0 then
            local pick = eligible[math.random(1, #eligible)]
            table.insert(result, { level = heroLevel, ability = pick })
            remaining[pick] = remaining[pick] - 1
            nextAllowed[pick] = heroLevel + cooldownOf[pick]
        end
    end

    for _, d in ipairs(defs) do
        if remaining[d.name] > 0 then return nil end
    end

    return result
end

-- build the level up list
local function BuildAbilityLevelUpList(nBasicNames, nUltNames, rules)
    local maxLvl = rules.heroLevelMax or 30

    -- according to set rules
    local function BindNames(names, ruleset)
        assert(#names == #ruleset, string.format('mismatch: %d names but %d rule entries', #names, #ruleset))
        local defs = {}
        for i, name in ipairs(names) do
            local maxLevel = ruleset[i].maxLevel
            local startLevel = ruleset[i].startLevel
            local cooldown = ruleset[i].cooldown

            -- cases; override
            if string.find(name, 'invoker_') then
                maxLevel = 8 -- max is 9, but they already start at 1
                cooldown = 1
            end

            for _, spell in pairs(SPL['SpellsMap']) do
                if spell and not spell.banned and spell.name == name then
                    if HasFlag(spell.type, SPL.SPELL_AGHANIMS_SHARD) or HasFlag(spell.type, SPL.SPELL_AGHANIMS_SCEPTER) then
                        maxLevel = 1 -- they are 1 point level ups
                    end
                end
            end

            defs[i] = {
                name       = name,
                maxLevel   = maxLevel,
                startLevel = startLevel,
                cooldown   = cooldown,
            }
        end
        return defs
    end

    local nUltDefs = BindNames(nUltNames,   rules.ults   or {})
    local nBasicDefs = BindNames(nBasicNames, rules.basics or {})

    -- union of all valid ult hero levels across every ult def, then deduplicate and sort.
    -- each ult still enforces its own cooldown internally via nextAllowed; opens up slots for any ult.
    local nUltSlotSet = {}
    for _, d in ipairs(nUltDefs) do
        for _, lvl in ipairs(UltLevelSlots(d.startLevel, d.cooldown, d.maxLevel, maxLvl)) do
            nUltSlotSet[lvl] = true
        end
    end

    local nUltSlots = {}
    for lvl in pairs(nUltSlotSet) do table.insert(nUltSlots, lvl) end
    table.sort(nUltSlots)

    -- assign ults
    local nUltEntries = {}
    if #nUltDefs > 0 then
        local assigned
        for _ = 1, 500 do
            local order = {}
            for _, d in ipairs(nUltDefs) do table.insert(order, d) end
            shuffle(order)
            assigned = AssignAbilities(nUltSlots, order)
            if assigned then break end
        end
        assert(assigned,
            'could not assign ultimates after 500 attempts. ' ..
            'check that startLevel + cooldown fit within heroLevelMax.')
        nUltEntries = assigned
    end

    -- basics, every hero level not occupied by an ult upgrade
    local nUltLevelSet = {}
    for _, e in ipairs(nUltEntries) do nUltLevelSet[e.level] = true end

    local nBasicSlots = {}
    for lvl = 1, maxLvl do
        if not nUltLevelSet[lvl] then table.insert(nBasicSlots, lvl) end
    end

    local nBasicEntries = {}
    if #nBasicDefs > 0 then
        local assigned
        for _ = 1, 500 do
            local order = {}
            for _, d in ipairs(nBasicDefs) do table.insert(order, d) end
            shuffle(order)
            assigned = AssignAbilities(nBasicSlots, order)
            if assigned then break end
        end
        assert(assigned,
            'could not assign basic abilities after 500 attempts. ' ..
            'check that startLevel, cooldown, and maxLevel fit within available hero levels.')
        nBasicEntries = assigned
    end

    -- merge and sort
    local slotted = {}
    for _, e in ipairs(nUltEntries)   do table.insert(slotted, e) end
    for _, e in ipairs(nBasicEntries) do table.insert(slotted, e) end
    table.sort(slotted, function(a, b) return a.level < b.level end)

    return slotted
end

local function PrecacheUnits(nTeams, nAbilitiesBasic, nAbilitiesUltimate)
    for _, team in pairs({DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS}) do
        for _, hero in pairs(nTeams[team]) do
            local sHeroName = hero:GetUnitName()
            if PrecacheUnit[sHeroName] == nil then PrecacheUnit[sHeroName] = true end
        end
    end

    for sHeroName, _ in pairs(Role['hero_roles']) do
        local sHeroNameStripped = string.gsub(sHeroName, 'npc_dota_hero_', '')
        for i = 1, #nAbilitiesBasic do
            if string.find(nAbilitiesBasic[i].name, sHeroNameStripped) then
                if PrecacheUnit[sHeroName] == nil then
                    PrecacheUnitByNameAsync(sHeroName, function () print(sHeroName .. ' is cached!') end)
                    PrecacheUnit[sHeroName] = true
                end
            end
        end

        for i = 1, #nAbilitiesUltimate do
            if string.find(nAbilitiesUltimate[i].name, sHeroNameStripped) then
                if PrecacheUnit[sHeroName] == nil then
                    PrecacheUnitByNameAsync(sHeroName, function () print(sHeroName .. ' is cached!') end)
                    PrecacheUnit[sHeroName] = true
                end
            end
        end
    end
end

-- having spells from a lobby hero is allowed; too much ban shrinks the pool
local function GetAbilityBuild(hero, nAbilityCount, hAbilityList, bAllowDuplicate)
    local abilityList = {}
    local total = 0
    for spell, value in pairs(hAbilityList) do
        if bAllowDuplicate or not AbilityPickedList[spell] then
            total = total + value
        end
    end

    if total <= 0 then return abilityList end

    local MAX_ATTEMPTS = 10000
    local nAttempts = 0

    while #abilityList < nAbilityCount do
        nAttempts = nAttempts + 1
        if nAttempts > MAX_ATTEMPTS then
            print('GetAbilityBuild: giving up, no eligible candidates left for ' .. hero:GetUnitName())
            break
        end

        local pAccum = 0
        local pRoll = RandomFloat(0, 1)

        for spell, value in pairs(hAbilityList) do
            local bSkip = false
            for i = 0, hero:GetAbilityCount() - 1 do
                local hAbility = hero:GetAbilityByIndex(i)
                if hAbility and IsIncompatible(hAbility:GetAbilityName(), spell.name) then
                    bSkip = true
                    break
                end
            end

            if not bSkip then
                for s, _ in pairs(AbilityPickedList) do
                    if IsIncompatible(s.name, spell.name) then
                        bSkip = true
                        break
                    end
                end
            end

            -- never pick the same spell twice for one hero (bAllowDuplicate only lets different heroes share a spell);
            -- a repeated pick used to be dropped later by HasAbility, leaving the hero with fewer new spells
            if not bSkip then
                for i = 1, #abilityList do
                    if abilityList[i] == spell then bSkip = true break end
                end
            end

            if not bSkip and (bAllowDuplicate or not AbilityPickedList[spell]) then
                pAccum = pAccum + (value / total)
                if pRoll <= pAccum then
                    table.insert(abilityList, spell)
                    if not AbilityPickedList[spell] then AbilityPickedList[spell] = true end
                    break
                end
            end

            if #abilityList == nAbilityCount then break end
        end
    end

    return abilityList
end

-- pos-to-role relevance: which roles matter when picking for this pos
local posRoleRelevance = {
    [1] = { carry = 1.2, disabler = 0.5, durable = 0.5, escape = 0.5, initiator = 0.6, jungler = 0.4, nuker = 0.8, support = 0.2, pusher = 0.8, healer = 0.0 },
    [2] = { carry = 0.7, disabler = 0.6, durable = 0.3, escape = 0.6, initiator = 0.8, jungler = 0.2, nuker = 1.0, support = 0.3, pusher = 0.5, healer = 0.2 },
    [3] = { carry = 0.4, disabler = 0.8, durable = 1.0, escape = 0.5, initiator = 0.9, jungler = 0.2, nuker = 0.5, support = 0.5, pusher = 0.4, healer = 0.2 },
    [4] = { carry = 0.2, disabler = 1.3, durable = 0.3, escape = 0.4, initiator = 0.6, jungler = 0.1, nuker = 0.6, support = 1.3, pusher = 0.3, healer = 0.4 },
    [5] = { carry = 0.2, disabler = 1.3, durable = 0.3, escape = 0.4, initiator = 0.5, jungler = 0.1, nuker = 0.6, support = 1.3, pusher = 0.3, healer = 0.6 },
}
local function GetSpellScore(spell, hero, nTeam)
    if not hero then return 0 end
    if not spell or spell == '' then return 0 end

    local sHeroName = hero:GetUnitName()
    local nPos = Helper.GetPosition(hero, nTeam)

    local totalRole = {}
    local score = 0

    if Role['hero_roles'] and Role['hero_roles'][sHeroName] then
        for role1, v1 in pairs(Role['hero_roles'][sHeroName]) do
            if type(v1) == 'number' then
                if totalRole[role1] == nil then totalRole[role1] = 0 end
                totalRole[role1] = totalRole[role1] + v1
                for role2, v2 in pairs(spell.tags) do
                    if type(v2) == 'number' then
                        if role1 == role2 then totalRole[role1] = totalRole[role1] + v2 end
                    end
                end
            end
        end

        for r, v in pairs(posRoleRelevance[nPos]) do
            local heroVal = totalRole[r] or 0
            score = score + heroVal * v
        end

        local tagSum = 0
        for _, v in pairs(totalRole) do tagSum = tagSum + v end
        score = score^2 / math.max(tagSum, 1)
    end

    return score
end

local function IsRangedAttacker(hUnit)
    if hUnit:Script_GetAttackRange() <= 300 and hUnit:GetUnitName() ~= 'npc_dota_hero_templar_assassin' then
        return false
    end
    return true
end

local function SetAbilityLevel(hUnit, sAbilityName, nLevel)
    local abilityCount = hUnit:GetAbilityCount()
    for i = abilityCount - 1, 0, -1 do
        local hAbility = hUnit:GetAbilityByIndex(i)
        if hAbility and hAbility:GetAbilityName() == sAbilityName then
            hAbility:SetLevel(nLevel)
        end
    end
end

local function SetAbilityActivated(hUnit, sAbilityName, bActivate)
    local abilityCount = hUnit:GetAbilityCount()
    for i = abilityCount - 1, 0, -1 do
        local hAbility = hUnit:GetAbilityByIndex(i)
        if hAbility and hAbility:GetAbilityName() == sAbilityName then
            hAbility:SetActivated(bActivate)
        end
    end
end

local function SetAbilityHidden(hUnit, sAbilityName, bHidden)
    local abilityCount = hUnit:GetAbilityCount()
    for i = abilityCount - 1, 0, -1 do
        local hAbility = hUnit:GetAbilityByIndex(i)
        if hAbility and hAbility:GetAbilityName() == sAbilityName then
            hAbility:SetHidden(bHidden)
        end
    end
end

-- Dota only binds hotkeys (Q W E D F R) to ability slots 0-5.
-- AddAbility puts the new spell after the hero's talents, so it has no hotkey (click only).
-- To give it one, swap it into a slot in 0-5 that is not really used for casting:
--   1) a 'generic_hidden' placeholder (heroes with fewer than 6 abilities, usually D/F)
--   2) a hidden Aghanim's Shard/Scepter ability
--   3) a passive hero ability (innates like Lion's to_hell_and_back, Counter Helix, ...); a passive can't be
--      cast, so its hotkey is passed to the new active spell. Passive NEW spells get no slot at all.
--   New BASIC spells prefer the passive slots on Q/W/E; the ultimate takes what is left (D/F first).
--   The hero's own active abilities always keep their original hotkeys (e.g. Take Aim stays on E);
--   only passive slots are handed to new spells.
-- The displaced ability keeps its hidden/activated state and keeps working (passives and
-- upgrades don't need a slot); it just moves to the end of the list with no hotkey.
-- Hero sub-abilities that the game shows/hides itself (e.g. Morphling) are never touched.
-- set to true to print what sits in each hotkey slot (D/F = slots 3/4) to the console
local DEBUG_HOTKEY_SLOTS = false

local function IsHumanHero(hero)
    local nPlayerID = hero:GetPlayerOwnerID()
    return nPlayerID ~= nil and nPlayerID >= 0 and not PlayerResource:IsFakeClient(nPlayerID)
end

-- prints to the console, and also to the in-game chat for human players (no console needed)
local function DebugSay(hero, sMsg)
    if not DEBUG_HOTKEY_SLOTS then return end
    print('[SpellsMore] ' .. sMsg)
    local nPlayerID = hero:GetPlayerOwnerID()
    if nPlayerID and nPlayerID >= 0 and not PlayerResource:IsFakeClient(nPlayerID) then
        GameRules:SendCustomMessage('[SpellsMore] ' .. sMsg, 0, 0)
    end
end

local function PrintHotkeySlots(hero, sLabel)
    if not DEBUG_HOTKEY_SLOTS then return end
    local t = {}
    for i = 0, 5 do
        local hAbility = hero:GetAbilityByIndex(i)
        if hAbility then
            local sName = string.gsub(hAbility:GetAbilityName(), '^' .. string.gsub(string.gsub(hero:GetUnitName(), 'npc_dota_hero_', ''), '%-', '%%-') .. '_', '')
            t[#t + 1] = string.format('[%d]%s%s%s', i, sName, hAbility:IsHidden() and '(h)' or '', hAbility:IsPassive() and '(p)' or '')
        else
            t[#t + 1] = string.format('[%d]nil', i)
        end
    end
    DebugSay(hero, string.format('%s %s: %s', string.gsub(hero:GetUnitName(), 'npc_dota_hero_', ''), sLabel, table.concat(t, ' ')))
end

local function IsShardOrScepterAbility(sAbilityName)
    for _, spell in pairs(SPL['SpellsMap']) do
        if spell and spell.name == sAbilityName
        and (HasFlag(spell.type, SPL.SPELL_AGHANIMS_SHARD) or HasFlag(spell.type, SPL.SPELL_AGHANIMS_SCEPTER))
        then
            return true
        end
    end
    return false
end

-- a passive can't be cast, so it never needs a hotkey: visible ones (innates, Counter Helix, ...) waste it,
-- and hidden ones waiting for a Shard/Scepter (e.g. Nyx's Neuro-Sting) won't need one once unlocked
local function IsPassiveSlotAbility(hAbility)
    return hAbility:GetAbilityName() ~= 'generic_hidden' and hAbility:IsPassive()
end

local function GetAbilityIndex(hero, sName)
    for i = 0, hero:GetAbilityCount() - 1 do
        local hAbility = hero:GetAbilityByIndex(i)
        if hAbility and hAbility:GetAbilityName() == sName then return i end
    end
    return -1
end

-- names of abilities that can be swapped out of a hotkey slot, best first
-- tTaken: spells we already moved into a hotkey slot (never displaced) + the '__ghBlocked' flag
-- bPreferQWE: new BASIC spells take the passive slots on Q/W/E first (the easiest keys), then the rest
local function GetFreeHotkeySlotNames(hero, tTaken, bPreferQWE)
    local tNames, tSeen = {}, {}

    local function AddPassiveSlots(tSlots)
        for _, i in ipairs(tSlots) do
            local hSlot = hero:GetAbilityByIndex(i)
            if hSlot then
                local sSlotName = hSlot:GetAbilityName()
                if not tSeen[sSlotName] and not tTaken[sSlotName] and IsPassiveSlotAbility(hSlot) then
                    tSeen[sSlotName] = true
                    tNames[#tNames + 1] = sSlotName
                end
            end
        end
    end

    -- 1) basics: passives on Q/W/E
    if bPreferQWE then AddPassiveSlots({0, 1, 2}) end

    -- 2) empty placeholders. SwapAbilities finds abilities BY NAME, and a hero can have several
    --    'generic_hidden' (Earthshaker: D and F), so only one of them can be reached reliably.
    --    GiveHotkeySlot verifies the swap and sets '__ghBlocked' when it hits the wrong one.
    if not tTaken['__ghBlocked'] then
        for i = 0, 5 do
            local hSlot = hero:GetAbilityByIndex(i)
            if hSlot and hSlot:GetAbilityName() == 'generic_hidden' then
                tNames[#tNames + 1] = 'generic_hidden'
                break
            end
        end
    end

    -- 3) remaining passive abilities (innates, passive spells); D/F before Q/W/E/R for the ultimate
    if bPreferQWE then
        AddPassiveSlots({3, 4, 5, 0, 1, 2})
    else
        AddPassiveSlots({3, 4, 0, 1, 2, 5})
    end

    -- 4) hidden shard/scepter abilities (last resort: they are real spells once the upgrade is bought)
    for i = 0, 5 do
        local hSlot = hero:GetAbilityByIndex(i)
        if hSlot and hSlot:IsHidden() then
            local sSlotName = hSlot:GetAbilityName()
            if sSlotName ~= 'generic_hidden' and not tTaken[sSlotName] and IsShardOrScepterAbility(sSlotName) then
                tNames[#tNames + 1] = sSlotName
            end
        end
    end

    return tNames
end

-- returns 'OK', 'NO-SLOT' (stays click-only), 'PASSIVE' (no hotkey needed) or 'MISSING'
local function GiveHotkeySlot(hero, sAbilityName, tTaken, bPreferQWE)
    local hNew = hero:FindAbilityByName(sAbilityName)
    if not hNew then return 'MISSING' end

    -- a passive spell can't be cast, so don't spend a hotkey slot on it
    if hNew:IsPassive() then return 'PASSIVE' end

    -- AddAbility may already have put it into a freed placeholder slot
    local nIdx = GetAbilityIndex(hero, sAbilityName)
    if nIdx <= 5 then
        -- a basic spell sitting on D/F moves onto a passive's Q/W/E key if there is one (both stay in the bar)
        if bPreferQWE and nIdx > 2 then
            for _, i in ipairs({0, 1, 2}) do
                local hSlot = hero:GetAbilityByIndex(i)
                if hSlot and not tTaken[hSlot:GetAbilityName()] and IsPassiveSlotAbility(hSlot) then
                    local sSlotName = hSlot:GetAbilityName()
                    local bSlotHidden, bSlotActivated = hSlot:IsHidden(), hSlot:IsActivated()
                    local bNewHidden, bNewActivated = hNew:IsHidden(), hNew:IsActivated()
                    hero:SwapAbilities(sSlotName, sAbilityName, true, true)
                    hSlot:SetHidden(bSlotHidden); hSlot:SetActivated(bSlotActivated)
                    hNew:SetHidden(bNewHidden);   hNew:SetActivated(bNewActivated)
                    break
                end
            end
        end
        tTaken[sAbilityName] = true
        return 'OK'
    end

    for _, sSlotName in ipairs(GetFreeHotkeySlotNames(hero, tTaken, bPreferQWE)) do
        local hDisplaced = hero:FindAbilityByName(sSlotName)
        local bDisplacedHidden = hDisplaced and hDisplaced:IsHidden()
        local bDisplacedActivated = hDisplaced and hDisplaced:IsActivated()

        hero:SwapAbilities(sSlotName, sAbilityName, false, true)

        -- SwapAbilities toggles enable state; put the displaced ability back how it was
        if sSlotName ~= 'generic_hidden' and hDisplaced then
            hDisplaced:SetHidden(bDisplacedHidden)
            hDisplaced:SetActivated(bDisplacedActivated)
        end

        -- verify: the new spell must really be in a hotkey slot now
        if GetAbilityIndex(hero, sAbilityName) <= 5 then
            if DEBUG_HOTKEY_SLOTS and hDisplaced and sSlotName ~= 'generic_hidden' then
                DebugSay(hero, string.format('displaced %s: level=%d hidden=%s activated=%s',
                    sSlotName, hDisplaced:GetLevel(), tostring(hDisplaced:IsHidden()), tostring(hDisplaced:IsActivated())))
            end

            -- keep invoker spells locked until they are leveled
            if string.find(sAbilityName, 'invoker_') then
                SetAbilityActivated(hero, sAbilityName, false)
            end

            tTaken[sAbilityName] = true
            return 'OK'
        end

        -- the swap hit another 'generic_hidden' outside the hotkey slots; stop using placeholders
        if sSlotName == 'generic_hidden' then
            tTaken['__ghBlocked'] = true
        end
    end

    return 'NO-SLOT'
end

-- how many basic/ultimate (kim level 30 ceiling, cooldown, lag, memory)
local COUNT_BASIC    = 2
local COUNT_ULTIMATE = 1
-- should match above count
local rules = {
    heroLevelMax = 30,
    basics = {
        { maxLevel = 4, startLevel = 4, cooldown = 2 },
        { maxLevel = 4, startLevel = 7, cooldown = 2 },
    },
    ults = {
        { maxLevel = 3, startLevel = 11, cooldown = 4 },
    },
}

local fPreviousTime = -math.huge

function SM.InitMoreSpells(hero, nTeams)
    if not hero then return end

    local fDotaTime = GameRules:GetDOTATime(false, true)

    if hero.spellLevelPrev   == nil then hero.spellLevelPrev   = 0 end
    if hero.spellLevelUpList == nil then hero.spellLevelUpList = {} end

    if not hero.spellInitDone and fDotaTime >= fPreviousTime + 0.65 then
        local abilities = { basic = {}, ult = {} }
        local sHeroName = hero:GetUnitName()
        local nHeroPosition = Helper.GetPosition(hero, nTeams[hero:GetTeam()])
        local sHeroNameStripped = string.gsub(sHeroName, 'npc_dota_hero_', '')

        for _, spell in pairs(SPL['SpellsMap']) do
            if  spell
            and not spell.banned
            and not string.find(spell.name, sHeroNameStripped)
            and spell.roles[IsRangedAttacker(hero) and 'range' or 'melee'] == 1
            then
                local nClickerRole = Role['hero_roles'][sHeroName]['clicker'][nHeroPosition]
                local bHasProperClickerRole = (nClickerRole.r == 1 and spell.roles.rightclicker == 1) or (nClickerRole.c == 1 and spell.roles.caster == 1)

                if bHasProperClickerRole or (nClickerRole.r == 0 and nClickerRole.c == 0) then -- if doesn't have the same pos assignment as current/(this script)
                    local spellScore = GetSpellScore(spell, hero, nTeams[hero:GetTeam()])
                    if HasFlag(spell.type, SPL.SPELL_TYPE_BASIC)
                    or HasFlag(spell.type, SPL.SPELL_AGHANIMS_SHARD)
                    then
                        abilities.basic[spell] = spellScore
                    end

                    if HasFlag(spell.type, SPL.SPELL_TYPE_ULTIMATE) then
                        abilities.ult[spell] = spellScore
                    end
                end
            end
        end

        local basicAbilities    = GetAbilityBuild(hero, COUNT_BASIC, abilities.basic, true)
        local ultimateAbilities = GetAbilityBuild(hero, COUNT_ULTIMATE, abilities.ult, false)

        PrecacheUnits(nTeams, basicAbilities, ultimateAbilities)

        -- assign spells
        -- some abilities needs other abilities, i.e.
        -- eclipse (req. lucent beam, always at max level already, not activated)
        -- ^ for non-shards/ults only
        -- etc

        -- Heroes like Earthshaker have several 'generic_hidden' placeholders in the D/F slots. SwapAbilities
        -- finds abilities by NAME, so it can only ever reach one of them. Remove all but the last one (humans
        -- only); AddAbility then fills the freed slots, so the first added spells land on those hotkeys.
        if IsHumanHero(hero) then
            local tPlaceholders = {}
            for i = 0, 5 do
                local hSlot = hero:GetAbilityByIndex(i)
                if hSlot and hSlot:GetAbilityName() == 'generic_hidden' then
                    tPlaceholders[#tPlaceholders + 1] = hSlot
                end
            end
            for i = 1, #tPlaceholders - 1 do
                hero:RemoveAbilityByHandle(tPlaceholders[i])
            end

        end

        -- helper abilities some spells need are added after all spells, so they don't take a hotkey slot
        local tHelpers = {}

        for i = 1, #basicAbilities do
            local sAbilityName = basicAbilities[i].name
            if not hero:HasAbility(sAbilityName) then
                hero:AddAbility(sAbilityName)

                -- invoker spells start at level 1, de-activate it first
                if string.find(sAbilityName, 'invoker_') then
                    SetAbilityHidden(hero, sAbilityName, false)
                    SetAbilityActivated(hero, sAbilityName, false)
                end

                -- un-hide; shards/scepters
                for _, spell in pairs(SPL['SpellsMap']) do
                    if spell and spell.name == sAbilityName then
                        if HasFlag(spell.type, SPL.SPELL_AGHANIMS_SHARD)
                        or HasFlag(spell.type, SPL.SPELL_AGHANIMS_SCEPTER)
                        then
                            SetAbilityHidden(hero, sAbilityName, false)
                        end
                    end
                end

                if sAbilityName == 'bristleback_bristleback' then
                    tHelpers[#tHelpers + 1] = 'bristleback_quill_spray'
                elseif sAbilityName == 'drow_ranger_multishot' then
                    tHelpers[#tHelpers + 1] = 'drow_ranger_frost_arrows'
                elseif sAbilityName == 'zuus_lightning_hands' then
                    tHelpers[#tHelpers + 1] = 'zuus_arc_lightning'
                end
            end
        end

        for i = 1, #ultimateAbilities do
            if not hero:HasAbility(ultimateAbilities[i].name) then
                hero:AddAbility(ultimateAbilities[i].name)
                if ultimateAbilities[i].name == 'luna_eclipse' then
                    tHelpers[#tHelpers + 1] = 'luna_lucent_beam'
                end
            end
        end

        for _, sHelper in ipairs(tHelpers) do
            hero:AddAbility(sHelper)
            SetAbilityLevel(hero, sHelper, 4)
            SetAbilityActivated(hero, sHelper, false)
        end

        -- move new spells into hotkey slots
        PrintHotkeySlots(hero, 'before')
        local tHotkeyResults = {}
        local tTaken = {}

        -- a passive new spell that landed in a hotkey slot wastes it: swap it with an active new spell
        -- that is still outside the hotkey slots (unique names, so the swap is reliable)
        local tAddedNames = {}
        for i = 1, #basicAbilities do tAddedNames[#tAddedNames + 1] = basicAbilities[i].name end
        for i = 1, #ultimateAbilities do tAddedNames[#tAddedNames + 1] = ultimateAbilities[i].name end
        for _, sPassive in ipairs(tAddedNames) do
            local hPassive = hero:FindAbilityByName(sPassive)
            if hPassive and hPassive:IsPassive() and GetAbilityIndex(hero, sPassive) <= 5 then
                for _, sActive in ipairs(tAddedNames) do
                    local hActive = hero:FindAbilityByName(sActive)
                    if hActive and not hActive:IsPassive() and GetAbilityIndex(hero, sActive) > 5 then
                        hero:SwapAbilities(sPassive, sActive, false, true)
                        hPassive:SetHidden(false) -- keep it visible so it still gets leveled
                        break
                    end
                end
            end
        end
        -- basics first: they are cast far more often than the ultimate, which gets any leftover slot
        for i = 1, #basicAbilities do
            local sResult = GiveHotkeySlot(hero, basicAbilities[i].name, tTaken, true)
            tHotkeyResults[#tHotkeyResults + 1] = basicAbilities[i].name .. ' ' .. sResult
        end
        for i = 1, #ultimateAbilities do
            local sResult = GiveHotkeySlot(hero, ultimateAbilities[i].name, tTaken, false)
            tHotkeyResults[#tHotkeyResults + 1] = ultimateAbilities[i].name .. ' ' .. sResult
        end
        PrintHotkeySlots(hero, 'after')
        DebugSay(hero, table.concat(tHotkeyResults, ', '))

        abilities = { basic = {}, ult = {} }
        for i = 1, #basicAbilities do abilities.basic[#abilities.basic+1] = basicAbilities[i].name end
        for i = 1, #ultimateAbilities do abilities.ult[#abilities.ult+1] = ultimateAbilities[i].name end

        hero.spellLevelUpList = BuildAbilityLevelUpList(abilities.basic, abilities.ult , rules)

        hero.spellInitDone = true
        fPreviousTime = fDotaTime
    end

    -- level up
    if hero:GetLevel() > hero.spellLevelPrev and #hero.spellLevelUpList > 0 then
        hero.spellLevelPrev = hero.spellLevelPrev + 1
        for _, w in ipairs(hero.spellLevelUpList) do
            if w.level == hero.spellLevelPrev then
                for i = 0, hero:GetAbilityCount() - 1 do
                    local ability = hero:GetAbilityByIndex(i)
                    if ability and not ability:IsHidden() then
                        local sAbilityName = ability:GetAbilityName()
                        if sAbilityName == w.ability then
                            if string.find(sAbilityName, 'invoker_') and not ability:IsActivated() then
                                ability:SetActivated(true)
                            end

                            ability:UpgradeAbility(true)
                        end
                    end
                end
            end
        end
    end
end

return SM