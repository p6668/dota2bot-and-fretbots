-- Methods for the creation / removal of neutral items for the bots.

 -- global debug flag
require 'Debug'
-- Settings 
require 'Settings'
-- Utilities
require 'Utilities'
-- Flags for tracking status
require 'Flags'

-- local debug flag
local thisDebug = true; 
local isDebug = Debug.IsDebug() and thisDebug;
local isDebugChat = isDebug and true

-- Instantiate ourself
if NeutralItems == nil then
  NeutralItems = {}
end

-- Enhancements
local TierEnhancements = {
    [1] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",
    },
    [2] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",

        "item_enhancement_vast",
        "item_enhancement_greedy",
        "item_enhancement_keen_eyed",
        "item_enhancement_vampiric",
    },
    [3] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",

        "item_enhancement_vast",
        "item_enhancement_greedy",
        "item_enhancement_keen_eyed",
        "item_enhancement_vampiric",
    },
    [4] = {
        "item_enhancement_alert",
        "item_enhancement_brawny",
        "item_enhancement_mystical",
        "item_enhancement_quickened",
        "item_enhancement_tough",

        "item_enhancement_vampiric",

        "item_enhancement_timeless",
        "item_enhancement_titanic",
        "item_enhancement_crude",
    },
    [5] = {
        "item_enhancement_timeless",
        "item_enhancement_titanic",
        "item_enhancement_crude",

        "item_enhancement_feverish",
        "item_enhancement_fleetfooted",
        "item_enhancement_audacious",
        "item_enhancement_evolved",
        "item_enhancement_boundless",
        "item_enhancement_wise",
    }
}

-- Gives a neutral item to a unit, returns name of previous item
-- if there was one.
function NeutralItems:GiveToUnit(unit, item)
	if item ~= nil then
		local replacedItem
	  -- determine if the unit already has one (neutrals always in slot 16)
		local currentItem = unit:GetItemInSlot(16)
		-- remove if so
		if currentItem ~= nil then
			isReplaced = true
			replacedItem = currentItem:GetName()
			Debug:Print(unit.stats.name..': Replacing: '..replacedItem)
			unit:RemoveItem(currentItem)
		end

		local sItemName = ''
    	local heroData_neutral = neutrals_data[unit:GetUnitName()]['neutral']
    	if heroData_neutral and heroData_neutral[item.tier] then
        	sItemName = NeutralItems.SelectItem(heroData_neutral[item.tier])
    	else
        	sItemName = item.name
    	end

		NeutralItems:CreateAndInsert(unit, sItemName, item.tier)
		return replacedItem	
	end
	return nil
end

-- Creates a specific item, inserts it into the bot
function NeutralItems:CreateAndInsert(bot, itemName, tier)
  if bot:HasRoomForItem(itemName, true, true) then
  	local item = CreateItem(itemName, bot, bot)
    item:SetPurchaseTime(0)
    bot:AddItem(item)

    -- give enhancement
    if bot then
		local itemEnhancement = bot:GetItemInSlot(17)
    	if itemEnhancement then bot:RemoveItem(itemEnhancement) end
    end
    local eList = TierEnhancements[tier]
    if eList then
        local eName = eList[RandomInt(1, #eList)]
        local heroData_enhancement = neutrals_data[bot:GetUnitName()]['enhancement']
        if heroData_enhancement and heroData_enhancement[tier] then
            eName = NeutralItems.SelectItem(heroData_enhancement[tier])
        end

        if eName ~= nil then
            item = CreateItem(eName, bot, bot)

            -- check if this enhancement is available in lower tiers
            -- if it does, upgrade it n times
            local nCount = 0
            for i = 1, tier - 1 do
                if TierEnhancements[i] then
                    for _, prev in pairs(TierEnhancements[i]) do
                        if prev == eName then
                            nCount = nCount + 1
                        end
                    end
                end
            end

            for _ = 1, nCount do
                item:UpgradeAbility(true)
            end

            item:SetPurchaseTime(0)
            bot:AddItem(item)
        end
    end

    bot.stats.neutralTier = tier
    -- Special handling if it's royal jelly	
    if itemName == "item_royal_jelly" then		
    	Say(bot:GetPlayerOwner(), "Spending royal jelly charge on self.", false)		
    	bot:CastAbilityOnTarget(bot, item, bot:GetPlayerOwnerID())		
    	for _, unit in pairs(Bots) do			
    		if unit.stats.isBot and unit.stats.team == bot.stats.team and unit.stats.name ~= bot.stats.name then	
    			Say(bot:GetPlayerOwner(), "Spending royal jelly charge on "..unit.stats.name..'.', false)				
    			bot:CastAbilityOnTarget(unit, item, bot:GetPlayerOwnerID())				
    			break			
    		end		
    	end	
    -- Since jelly was consumed, set hero to not have an item
    NeutralItems:ClearBotItem(bot)
    end
    return true
  end
  return false
end

-- do a simple weighted random selection
function NeutralItems.SelectItem(hNeutralItemList)
    local items = {}
    local weights = {}
    for item, weight in pairs(hNeutralItemList) do
        table.insert(items,item)
        table.insert(weights,weight)
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

-- Updates a bot's stats so it knows it doesn't have an item
function NeutralItems:ClearBotItem(bot)
		bot.stats.neutralTier = 0
    bot.stats.assignedNeutral = nil
end

-- Returns valid items for a given tier and role
function NeutralItems:GetTableForTierAndRole(tier,unit)
	local items = {}
	local count = 0
	for _,item in ipairs(AllNeutrals) do
		-- Melee / Ranged
		if item.ranged > 0 and not unit.stats.isMelee then
		  if item.tier == tier and item.roles[unit.stats.role] ~= 0 then
		  	table.insert(items,item)
		  	count = count + 1
		  end
		elseif item.melee > 0 and unit.stats.isMelee then
		  if item.tier == tier and item.roles[unit.stats.role] ~= 0 then
		  	table.insert(items,item)
		  	count = count + 1
		  end
		end
	end		
  return items, count
end

-- Returns valid items for a given tier
function NeutralItems:GetTableForTier(tier)
	local items = {}
	local count = 0
	for _,item in ipairs(AllNeutrals) do
	  if item.tier == tier then
	  	table.insert(items,item)
	  	count = count + 1
	  end
	end		
  return items, count
end

-- selects a random item from the list (by tier and role) and returns the item
function NeutralItems:SelectRandomItem(tier, unit)
	-- Get items that qualify
	-- if they didn't pass a unit, go full random
	local items,count
	if unit == nil then
		items,count = NeutralItems:GetTableForTier(tier)
  else
		items,count = NeutralItems:GetTableForTierAndRole(tier,unit)
	end
	if items == nil then return nil end
	-- pick one at random
	local item = items[math.random(count)]
	-- if there was a valid item, remove it from the table (if settings tell us to)
	if item ~= nil and Settings.neutralItems.isRemoveUsedItems then
		-- note that this loop only works because we only want to remove one item
		for i,_ in ipairs(AllNeutrals) do
			if item == AllNeutrals[i] then
		  	table.remove(AllNeutrals,i)
		  	break
			end
		end
  end
  -- return the selected item
  if item ~= nil then
	  return item
	else
		return nil
	end
end

-- returns the pretty item name for a neutral
function NeutralItems:GetLocalizedItemName(dataTable, itemName)
	for _,item in ipairs(dataTable) do
		if item.name == itemName then
			return item.realName
		end
	end
end

-- Returns the bot that wants a new item the most
function NeutralItems:GetNeediestBot(tier)
	local data = {}
  -- ipairs sorts bots by role 1-5
  for i, bot in ipairs(Bots) do
  	local isUpgrade = tier > bot.stats.neutralTier
  	local isSidegrade = (tier == bot.stats.neutralTier) and (not bot.stats.hasSuitableNeutral)
  	-- for our bots, cores are assholes and always want a new item 
  	-- until they get one they like	
  	if i <= 3 and isUpgrade or isSidegrade then
  		return bot
  	-- For 4/5, try to prefer pure upgrades
  	elseif i > 3 and isUpgrade then
  		return bot
  	end
  end
  -- if we made it this far, 
  -- No one found
  return nil
end

-- Returns the 'goodness' of an item for a bot, higher is better
function NeutralItems:GetBotDesireForItem(bot, item)
  local attackTypeScore = 0
  -- Bots are never willing to take an item of the wrong attack type
  if not bot.stats.isMelee then
  	attackTypeScore = item.ranged
  elseif bot.stats.isMelee then
  	attackTypeScore = item.melee
  end
	if attackTypeScore <= 0 then return 0 end
  -- Get validity from role
  local roleScore = item.roles[bot.stats.role]
  -- ##TODO: Make this less arbitrary
  -- for now we'll just say each tier is worth 10 points
  local tierScore = item.tier * 10
  return attackTypeScore + roleScore + tierScore
end

-- Returns  true if the bot would prefer a specific item 
-- over what it has
function NeutralItems:DoesBotPreferItem(bot, item)
	local currentItemDesire
	if bot.stats.assignedNeutral ~= nil then
  	currentItemDesire = NeutralItems:GetBotDesireForItem(bot, bot.stats.assignedNeutral)
  else
  	currentItemDesire = 0
  end
  local newItemDesire = NeutralItems:GetBotDesireForItem(bot, item)
  return newItemDesire > currentItemDesire, newItemDesire, currentItemDesire
end

-- ensures that all bots are set to find the proper tier when one
-- has had all of its items found
-- Yes, there's probably an edge case bug where a bot is somehow
-- two tiers behind.  
-- This method preserves the previous tier's variance and neutral 
-- award subtractions.
function NeutralItems:CloseBotFindTier(tier)
	for _, bot in ipairs(Bots) do
		-- if this is the case, the bot is behind and needs to be updated to new tier.
	  if bot.stats.neutralsFound < tier then
	  	NeutralItems:SetBotFindTier(bot, tier + 1)
	  end
	end
end

-- Sets all bots to find tier 1 items.
function NeutralItems:InitializeFindTimings()
	for _, bot in ipairs(Bots) do
		local variance = Utilities:GetIntegerVariance(Settings.neutralItems.variance)
		local difficultyShift = NeutralItems:GetTimingDifficultyScaleShift(1)
  		bot.stats.neutralsFound = 0
  		bot.stats.neutralTiming = Settings.neutralItems.timings[1] + variance + difficultyShift
		if bot.stats.neutralTiming < 0 then bot.stats.neutralTiming = 0 end
		local msg = bot.stats.name..': Initialized Neutral Timing for Tier 1: '..bot.stats.neutralTiming..' (shift: '..difficultyShift..', var: '..variance..')'
		Debug:Print(msg)
	end
end

-- sets a particular bot for a timing to find a specific tier
function NeutralItems:SetBotFindTier(bot, tier)
	-- Is this a valid tier tier?
	local nextTiming = Settings.neutralItems.timings[tier]
	if nextTiming ~= nil then
		nextTiming = nextTiming + NeutralItems:GetTimingDifficultyScaleShift(tier)
		if nextTiming < 0 then nextTiming = 0 end -- clamp
		local previousTiming = 0
		-- this should normally be the case
		if Settings.neutralItems.timings[tier - 1] ~= nil then
			previousTiming = Settings.neutralItems.timings[tier - 1] + NeutralItems:GetTimingDifficultyScaleShift(tier)
		end
		if previousTiming < 0 then previousTiming = 0 end

		-- normal case: bot has found an item one tier below what we're setting it to
		-- meaning we called this function immediately after finding it.  Get new
		-- variance, don't preserve neutral awards (might change that via setting someday)
		if bot.stats.neutralsFound == tier - 1 then		
			bot.stats.neutralTiming = Settings.neutralItems.timings[tier]
									   + Utilities:GetIntegerVariance(Settings.neutralItems.variance)
									   + NeutralItems:GetTimingDifficultyScaleShift(tier)
			if bot.stats.neutralTiming < 0 then bot.stats.neutralTiming = 0 end
		-- if we're further behind, the bot never found an item.  We want to preserve
		-- the existing randomness for the timing (including neutral awards), so we just 
		-- add the difference
		else
			bot.stats.neutralTiming = bot.stats.neutralTiming + nextTiming - previousTiming
			-- flag them as having found the proper tier of item
			bot.stats.neutralsFound = tier - 1
		end
		-- Sanity check
		if bot.stats.neutralTiming < 0 then bot.stats.neutralTiming = 0 end
	-- no next timing: disable the timer.
	else
		bot.stats.neutralTiming = -1
	end
	local msg = bot.stats.name..': Next Neutral Timing for Tier '..tier..': '..bot.stats.neutralTiming
	Debug:Print(msg)
end

-- Computes the neutral item timing offset using the difficulty scale
-- The value is a linear interpolation of target value at baseline difficulty of 1.0 vs. game default value
--[[ At baseline of 0 seconds for tier 1 and...
-            difficulty 0, we'd have (420-0)*(1-0) resulting in a shift of 420 seconds (neutral matching game default)
			difficulty 0.7, we'd have (420-0)*(1-0.7) resulting in a shift of 126 seconds (first neutral at 2 minutes)
			difficulty 1.0, we'd have (420-0)*(1-1) resulting in a shift of 0 seconds
		At baseline of 3600 for tier 3 and ...
-            difficulty 0, we'd have (1620-1020)*(1-0) resulting in a shift of 600 seconds (600+1020=1620=game default)
			difficulty 0.7, we'd have (1620-1020)*(1-0.7) resulting in a shift of 180 seconds (180+1020=1200)

	Rough reference using timings = {0, 420, 1020, 2020, 3600}:
	| Tier          | 1         | 2    | 3    | 4    | 5    |
	|---------------|-----------|------|------|------|------|
	| 0 (base game) | 420       | 1020 | 1620 | 2020 | 3600 |
	| 0.5           | 210       | 720  | 1320 | 2020 | 3600 |
	| 0.7           | 126       | 600  | 1200 | 2020 | 3600 |
	| 1             | 0         | 420  | 1020 | 2020 | 3600 |
	| 1.5           | 0 (clamp) | 120  | 720  | 2020 | 3600 |

	If we made the timing even more lenient than game default (e.g. tier 1 at 600 seconds), then the scaling
	becomes inverted where higher difficulty the closer we are to our target timing.
		at difficulty 0 we'd have (420-600)*(1-0) = -180 second shift resulting in tier 1 at 420 seconds
		at difficulty 0.7 we'd have -180*0.3 = -54 seconds resulting in tier 1 at 546 seconds
		at difficulty 1.0 we'd have -180*0 = 0 seconds resulting in tier 1 at 600 seconds
		at difficulty 1.5 we'd have -180*-0.5 = 90 seconds resulting in tier 1 at 690 seconds
--]]
function NeutralItems:GetTimingDifficultyScaleShift(tier)
	local timingDifficultyShift = (Settings.neutralItems.timingsDefault[tier] - Settings.neutralItems.timings[tier]) * (1 - Settings.difficultyScale)
	return timingDifficultyShift
end