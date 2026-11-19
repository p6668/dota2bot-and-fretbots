local neutrals_data = require('bots/Buff/script/neutrals_data')

if NeutralItems == nil
then
    NeutralItems = {}
end

local isTierOneDone   = false
local isTierTwoDone   = false
local isTierThreeDone = false
local isTierFourDone  = false
local isTierFiveDone  = false

-- Neutrals

local Tier1NeutralItems = {
    --[[Seeds of Serenity]]   "item_seeds_of_serenity",
    --[[Polliwog Charm]]      "item_polliwog_charm",
    --[[Chipped Vest]]        "item_chipped_vest",
    --[[Dormant Curio]]       "item_dormant_curio",
    --[[Red Ledger]]          "item_red_ledger",
    --[[Kobold Cup]]          "item_kobold_cup",
    --[[Ash Legion Shield]]   "item_ash_legion_shield",
    --[[Weighted Dice]]       "item_weighted_dice",
    --[[Forager's Kit]]       "item_foragers_kit",
    --[[Possessed Mask]]      "item_possessed_mask",
    --[[Stonefeather Satchel]] "item_stonefeather_satchel",
    --[[Tumbler's Toy]]       "item_pogo_stick",
}

local Tier2NeutralItems = {
    --[[Mana Draught]]        "item_mana_draught",
    --[[Defiant Shell]]       "item_defiant_shell",
    --[[Crippling Crossbow]]  "item_crippling_crossbow",
    --[[Brick]]               "item_brick",
    --[[Imp Claw]]            "item_imp_claw",
    --[[Safety Bubble]]       "item_safety_bubble",
    --[[Gunpowder Gauntlet]]  "item_gunpowder_gauntlets",
    --[[Jidi Pollen Bag]]     "item_jidi_pollen_bag",
    --[[Metamorphic Mandible]] "item_metamorphic_mandible",
    --[[Partisan's Brand]]    "item_partisans_brand",
    --[[Psychic Headband]]    "item_psychic_headband",
    --[[Spellslinger]]        "item_spellslinger",
}

local Tier3NeutralItems = {
    --[[Dandelion Amulet]]    "item_dandelion_amulet",
    --[[Ceremonial Robe]]     "item_ceremonial_robe",
    --[[Serrrated Shiv]]      "item_serrated_shiv",
    --[[Stormcrafter]]        "item_stormcrafter",
    --[[Balmhook]]            "item_balmhook",
    --[[Revenant's Brooch]]   "item_revenants_brooch",
    --[[Vile Phial]]          "item_vile_phial",
    --[[Enchanter's Bauble]]  "item_enchanters_bauble",
    --[[Harmonizer]]          "item_harmonizer",
    --[[Idol of Scree'Auk]]   "item_idol_of_screeauk",
    --[[Prophet's Pendulum]]  "item_prophets_pendulum",
    --[[Rattlecage]]          "item_rattlecage",
}

local Tier4NeutralItems = {
    --[[Mind Breaker]]        "item_mind_breaker",
    --[[Dezun Bloodrite]]     "item_dezun_bloodrite",
    --[[Conjurer's Catalyst]] "item_conjurers_catalyst",
    --[[Flicker]]             "item_flicker",
    --[[Giant's Ring]]        "item_giants_ring",
    --[[Helm of the Hivemind]] "item_helm_of_the_hivemind",
    -- --[[Book of the Dead]]    "item_demonicon",  // removed to save some FPS on host PC
    --[[Divine Regalia]]      "item_divine_regalia",
    --[[Fallen Sky]]          "item_fallen_sky",
    --[[Minotaur Horn]]       "item_minotaur_horn",
    --[[Riftshadow Prism]]    "item_riftshadow_prism",
    --[[Witchbane]]           "item_heavy_blade",
}

local hNeutralItemsList = {
    [1] = Tier1NeutralItems,
    [2] = Tier2NeutralItems,
    [3] = Tier3NeutralItems,
    [4] = Tier4NeutralItems,
}

-- Enhancements

local TierEnhancements = {
    [1] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",
        "item_enhancement_vital",
    },
    [2] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",
        "item_enhancement_vital",

        -- "item_enhancement_vast",
        "item_enhancement_keen_eyed",
        "item_enhancement_crude",
        "item_enhancement_nimble",
        "item_enhancement_titanic",
    },
    [3] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",

        -- "item_enhancement_vast",
        "item_enhancement_greedy",
        "item_enhancement_keen_eyed",
        "item_enhancement_crude",
        "item_enhancement_nimble",
        "item_enhancement_titanic",
    },
    [4] = {
        "item_enhancement_timeless",
        -- "item_enhancement_titanic",

        "item_enhancement_feverish",
        "item_enhancement_fleetfooted",
        "item_enhancement_audacious",
        "item_enhancement_evolved",
        -- "item_enhancement_boundless",
        -- "item_enhancement_wise",
        "item_enhancement_vampiric",
        "item_enhancement_hulking",
        "item_enhancement_manic",
    }
}

local function DoGive(hero, nTier)
    local sItemName = ''
    local heroData = neutrals_data[hero:GetUnitName()]['neutral']
    if heroData and heroData[nTier] then
        sItemName = NeutralItems.SelectItem(heroData[nTier])
    else
        sItemName = hNeutralItemsList[nTier][RandomInt(1, #hNeutralItemsList[nTier])]
    end

    if sItemName ~= '' then
        NeutralItems.GiveItem(sItemName, hero, nTier, true, true)
        -- something green
        GameRules:SendCustomMessage("<font color='#70EA71'>"..string.gsub(hero:GetUnitName(), 'npc_dota_hero_', '').."</font>"..' recieved a Tier '..tostring(nTier)..' neutral item!', -1, 0)
        hero.neutral_items[nTier].assigned = true
    end
end

-- with 11/10/25 update, this will override (or get overriden), since valve made bots craft items
local bInitTimes = false
function NeutralItems.GiveNeutralItems(hHeroList)
    local bTurboMode = Helper.IsTurboMode()
    local fCurrentTime = Helper.DotaTime()
    local nCurrentTierWindow = NeutralItems.GetCurrentTierWindow(bTurboMode, fCurrentTime)

    if not bInitTimes and #hHeroList > 0 then
        for _, hero in pairs(hHeroList) do
            if hero.neutral_items == nil then
                hero.neutral_items = {
                    [1] = { assign_time = 0, assigned = false, items = { neutral = '', enhancement = '' } },
                    [2] = { assign_time = 0, assigned = false, items = { neutral = '', enhancement = '' } },
                    [3] = { assign_time = 0, assigned = false, items = { neutral = '', enhancement = '' } },
                    [4] = { assign_time = 0, assigned = false, items = { neutral = '', enhancement = '' } },
                }
            end

            if hero.neutral_items then
                -- range; to feel more natural
                if bTurboMode then
                    hero.neutral_items[1].assign_time = RandomFloat( 0.0,  1.5)
                    hero.neutral_items[2].assign_time = RandomFloat( 7.5,  9.5)
                    hero.neutral_items[3].assign_time = RandomFloat(12.5, 14.5)
                    hero.neutral_items[4].assign_time = RandomFloat(17.5, 19.5)
                else
                    hero.neutral_items[1].assign_time = 2
                    hero.neutral_items[2].assign_time = 9
                    hero.neutral_items[3].assign_time = 18
                    hero.neutral_items[4].assign_time = 27
                end
            end
        end

        bInitTimes = true
    end

    -- Give Neutral Items
    for _, hero in pairs(hHeroList) do
        if hero.neutral_items then
            if hero.neutral_items[nCurrentTierWindow].assigned == false and fCurrentTime >= hero.neutral_items[nCurrentTierWindow].assign_time * 60 then
                DoGive(hero, nCurrentTierWindow)
            end

            -- change back to ^ Buff item; valve's default is too random
            if hero.neutral_items[nCurrentTierWindow].assigned == true  and fCurrentTime >= hero.neutral_items[nCurrentTierWindow].assign_time * 60 then
                local hItem1 = hero:GetItemInSlot(16)
                local hItem2 = hero:GetItemInSlot(17)
                if hItem1 and hItem2 then
                    local sItemName1 = hItem1:GetName()
                    local sItemName2 = hItem2:GetName()

                    if sItemName1 ~= 'item_divine_regalia_broken' then
                        local sNeutralName = hero.neutral_items[nCurrentTierWindow].items.neutral
                        local sEnhancementName = hero.neutral_items[nCurrentTierWindow].items.enhancement

                        if sItemName1 ~= sNeutralName or sItemName2 ~= sEnhancementName then
                            NeutralItems.GiveItem(sNeutralName, hero, nCurrentTierWindow, true, false)
                            NeutralItems.GiveItem(sEnhancementName, hero, nCurrentTierWindow, false, true)
                            -- GameRules:SendCustomMessage("<font color='#70EA71'>"..string.gsub(hero:GetUnitName(), 'npc_dota_hero_', '').."</font>"..' changed back its neutral item!', -1, 0)
                        end
                    end
                end
            end
        end
    end

    -- replace 'item_divine_regalia_broken'
    for _, h in pairs(hHeroList) do
        if h and h:HasItemInInventory('item_divine_regalia_broken') then
            local sItemName = ''
            local heroData = neutrals_data[h:GetUnitName()]['neutral']
            if heroData and heroData[4] then
                sItemName = NeutralItems.SelectItem(heroData[4])
            else
                sItemName = Tier4NeutralItems[RandomInt(1, #Tier4NeutralItems)]
            end

            if sItemName ~= '' then
                NeutralItems.GiveItem(sItemName, h, 4, true, true)
            end
        end
    end
end

function NeutralItems.GiveItem(sItemName, hero, nTier, bNeutral, bEnhancement)
    if hero:HasRoomForItem(sItemName, true, true) then
        local item = CreateItem(sItemName, hero, hero)
        item:SetPurchaseTime(0)

        if bNeutral then
            -- neutral item
            hero:RemoveItem(hero:GetItemInSlot(16))
            hero:AddItem(item)
        end

        if (bNeutral and bEnhancement)
        or (not bNeutral and bEnhancement)
        then
            -- remove so they don't stick to the next item
            if hero then
                local itemEnhancement = hero:GetItemInSlot(17)
                if itemEnhancement then hero:RemoveItem(itemEnhancement) end
            end

            -- give some enhancement
            local eList = TierEnhancements[nTier]
            if eList then
                local e = eList[RandomInt(1, #eList)]
                local heroData = neutrals_data[hero:GetUnitName()]['enhancement']
                if heroData and heroData[nTier] then
                    e = NeutralItems.SelectItem(heroData[nTier])
                end

                if (not bNeutral and bEnhancement) then
                    e = sItemName
                end

                if e ~= nil then
                    item = CreateItem(e, hero, hero)

                    -- check if this enhancement is available in lower tiers
                    -- if it does, upgrade it n times
                    local nCount = 0
                    for i = 1, nTier - 1 do
                        if TierEnhancements[i] then
                            for _, prev in pairs(TierEnhancements[i]) do
                                if prev == e then
                                    nCount = nCount + 1
                                end
                            end
                        end
                    end

                    for _ = 1, nCount do
                        item:UpgradeAbility(true)
                    end

                    item:SetPurchaseTime(0)
                    hero:AddItem(item)

                    if (bNeutral and bEnhancement) then
                        hero.neutral_items[nTier].items.neutral = sItemName
                        hero.neutral_items[nTier].items.enhancement = e
                    end
                end
            end
        end
    end
end

-- do a simple weighted random selection
function NeutralItems.SelectItem(hNeutralItemList)
    local items = {}
    local weights = {}
    for item, weight in pairs(hNeutralItemList) do
        if  item ~= 'item_enhancement_wise'
        and item ~= 'item_dormant_curio'
        and item ~= 'item_enchanters_bauble'
        then
            table.insert(items,item)
            table.insert(weights,weight)
        end
    end

    local totalWeight = 0
    for _, weight in pairs(weights) do
        totalWeight = totalWeight + weight
    end

    local randVal = (RandomInt(0, 100) / 100) * totalWeight
    local accumWeight = 0
    local selectedItem = ''

    for i, weight in ipairs(weights) do
        accumWeight = accumWeight + weight
        if randVal <= accumWeight then
            selectedItem = items[i]
            break
        end
    end

    return selectedItem
end

function NeutralItems.GetCurrentTierWindow(bTurboMode, fCurrentTime)
    local thresholds = bTurboMode and {2.5, 7.5, 12.5, 17.5} or {2, 9, 18, 27}
    for i = #thresholds, 1, -1 do
        if fCurrentTime >= thresholds[i] * 60 then return i end
    end

    return 1
end

function NeutralItems.GetItemTier(sItemName)
    local itemList = { Tier1NeutralItems, Tier2NeutralItems, Tier3NeutralItems, Tier4NeutralItems }
    for tier, items in pairs(itemList) do
        for _, item in pairs(items) do
            if item == sItemName then
                return tier
            end
        end
    end

    return -1
end

return NeutralItems