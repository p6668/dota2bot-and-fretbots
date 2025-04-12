local Item = require( GetScriptDirectory()..'/FunLib/aba_item' )
local Role = require( GetScriptDirectory()..'/FunLib/aba_role' )
local J = require( GetScriptDirectory()..'/FunLib/jmz_func')

local bot = GetBot()

if bot:IsInvulnerable()
	or not bot:IsHero()
	or bot:IsIllusion()
then
	return
end

local BotBuild = require( GetScriptDirectory() .. "/BotLib/" .. string.gsub( bot:GetUnitName(), "npc_dota_", "" ) )

if BotBuild == nil then return end

bot.itemToBuy = {}
bot.currentItemToBuy = nil
bot.currentComponentToBuy = nil
bot.currListItemToBuy = {}
bot.SecretShop = false


local sPurchaseList = BotBuild['sBuyList']
bot.sItemSellList = BotBuild['sSellList']


for i = 1, #sPurchaseList
do
	bot.itemToBuy[i] = sPurchaseList[#sPurchaseList - i + 1]
end



if Role.IsBanShadow()
then

	for i = 1, #bot.itemToBuy
	do 
		if bot.itemToBuy[i] == "item_glimmer_cape"
		then
			bot.itemToBuy[i] = "item_tpscroll"
		end
	end

end


local sell_time = -90
local check_time = -90


local lastItemToBuy = nil
local bPurchaseFromSecret = false
local itemCost = 0
local courier = nil
local t3AlreadyDamaged = false
local t3Check = -90
local hasBuyShard = true
local isBear = false

local function GeneralPurchase()

	
	if lastItemToBuy ~= bot.currentComponentToBuy
	then
		lastItemToBuy = bot.currentComponentToBuy
		bot:SetNextItemPurchaseValue( GetItemCost( bot.currentComponentToBuy ) )
		bPurchaseFromSecret = IsItemPurchasedFromSecretShop( bot.currentComponentToBuy )
		itemCost = GetItemCost( bot.currentComponentToBuy )
	end

	local cost = itemCost


	if lastItemToBuy == 'item_boots'
		and bot.currentItemToBuy == 'item_travel_boots'
		and Item.HasBootsInMainSolt( bot )
	then
		cost = GetItemCost( 'item_travel_boots' )
	end
	


	if bot:GetLevel() >= 18
		and t3AlreadyDamaged == false
		and DotaTime() > t3Check + 1.0
	then

		for i = 2, 8, 3
		do
			local tower = GetTower( GetTeam(), i )
			if tower == nil or tower:GetHealth() / tower:GetMaxHealth() < 0.3
			then
				t3AlreadyDamaged = true
				break
			end
		end


		for i = 1, 7, 3
		do
			local tower = GetTower( GetTeam(), i )
			if tower ~= nil
				and tower:IsAlive()
			then
				t3AlreadyDamaged = false
				break
			end
		end


		for i = 9, 10, 1
		do
			local tower = GetTower( GetTeam(), i )
			if tower == nil
				or tower:GetHealth() / tower:GetMaxHealth() < 0.9
			then
				t3AlreadyDamaged = true
				break
			end
		end


		if DotaTime() >= 54 * 60 then t3AlreadyDamaged = true end

		t3Check = DotaTime()

	elseif t3AlreadyDamaged == true
			and bot:GetBuybackCooldown() <= 10
	then
		cost = itemCost + bot:GetBuybackCost() + bot:GetNetWorth() / 40 - 300
	end

	--如果只剩下一个小配件则不留
	if #bot.currListItemToBuy == 1
		or Role.IsPvNMode()
	then
		cost = itemCost
	end
	
	
	--从第12分钟起存钱买魔晶
	if not hasBuyShard
		and DotaTime() > 12 * 60
	then
		local shardCDTime = 15 * 60 - DotaTime()
		if shardCDTime < 0
		then
			cost = cost + 1400
		else
			cost = cost + 1400 * ( 1 - shardCDTime / 300 )
		end		
	end
	
	
	--开始购买魔晶
	if bot.currentComponentToBuy == "item_aghanims_shard"
	then
		hasBuyShard = false
		bot.currentComponentToBuy = nil
		bot.currListItemToBuy[#bot.currListItemToBuy] = nil
		return	
	end
	

	--达到金钱需要时购物
	if bot:GetGold() >= cost
		and bot:GetItemInSlot( 14 ) == nil
		and not isBear
	then

		if courier == nil
		then
			courier = bot.theCourier
		end

		--当信使购买神秘商店物品后
		if bot.SecretShop
			and courier ~= nil
			and GetCourierState( courier ) == COURIER_STATE_IDLE
			and courier:DistanceFromSecretShop() == 0
		then
			if courier:ActionImmediate_PurchaseItem( bot.currentComponentToBuy ) == PURCHASE_ITEM_SUCCESS
			then
				bot.currentComponentToBuy = nil
				bot.currListItemToBuy[#bot.currListItemToBuy] = nil
				bot.SecretShop = false
				return
			end
		end

		--决定是否在神秘购物
		if bPurchaseFromSecret
			and bot:DistanceFromSecretShop() > 0
		then
			bot.SecretShop = true
		else
			if bot:ActionImmediate_PurchaseItem( bot.currentComponentToBuy ) == PURCHASE_ITEM_SUCCESS
			then
				bot.currentComponentToBuy = nil
				bot.currListItemToBuy[#bot.currListItemToBuy] = nil
				bot.SecretShop = false
				return
			else
				print( bot:GetUnitName().." 未能购买物品 "..bot.currentComponentToBuy.." : "..tostring( bot:ActionImmediate_PurchaseItem( bot.currentComponentToBuy ) ) )
			end
		end
	else
		bot.SecretShop = false
	end
end


--加速模式购物逻辑
local function TurboModeGeneralPurchase()

	if lastItemToBuy ~= bot.currentComponentToBuy
	then
		lastItemToBuy = bot.currentComponentToBuy
		bot:SetNextItemPurchaseValue( GetItemCost( bot.currentComponentToBuy ) )
		itemCost = GetItemCost( bot.currentComponentToBuy )
		lastItemToBuy = bot.currentComponentToBuy
	end

	local cost = itemCost

	if lastItemToBuy == 'item_boots'
		and bot.currentItemToBuy == 'item_travel_boots'
		and Item.HasBootsInMainSolt( bot )
	then
		cost = GetItemCost( 'item_travel_boots' )
	end
	

	if not hasBuyShard
		and DotaTime() > 6 * 60
	then
		local shardCDTime = 10 * 60 - DotaTime()
		if shardCDTime < 0
		then
			cost = cost + 1400
		else
			cost = cost + 1400 * ( 1 - shardCDTime / 180 )
		end		
	end
	
	

	if bot.currentComponentToBuy == "item_aghanims_shard"
	then
		hasBuyShard = false
		bot.currentComponentToBuy = nil
		bot.currListItemToBuy[#bot.currListItemToBuy] = nil
		return	
	end
	


	if bot:GetGold() >= cost
		and bot:GetItemInSlot( 14 ) == nil
		and not isBear
	then
		if bot:ActionImmediate_PurchaseItem( bot.currentComponentToBuy ) == PURCHASE_ITEM_SUCCESS
		then
			bot.currentComponentToBuy = nil
			bot.currListItemToBuy[#bot.currListItemToBuy] = nil
			return
		else
			print( bot:GetUnitName().." 未能购买物品 "..bot.currentComponentToBuy.." : "..tostring( bot:ActionImmediate_PurchaseItem( bot.currentComponentToBuy ) ) )
		end
	end
end


local lastInvCheck = -90
local fullInvCheck = -90
local lastBootsCheck = -90
local buyBootsStatus = false
local buyRD = false
local buyTP = false

local switchTime = 0
local buyWardTime = -999

local buyTPtime = 0
local buyBookTime = 0
local hasBuyClarity = false

local initSmoke = false

function ItemPurchaseThink()

	if ( GetGameState() ~= GAME_STATE_PRE_GAME and GetGameState() ~= GAME_STATE_GAME_IN_PROGRESS )
	then return	end

	if bot:HasModifier('modifier_arc_warden_tempest_double')
	or (DotaTime() > 0 and J.IsMeepoClone(bot))
	or bot:HasModifier('modifier_dazzle_nothl_projection_soul_debuff')
	then
		bot.itemToBuy = {}
		return
	end

	isBear = bot:GetUnitName() == 'npc_dota_hero_lone_druid_bear'
	if isBear and math.floor(DotaTime()) % 5 == 0 then
		for i = 1, 5 do
			local member = GetTeamMember(i)
			if member ~= nil and member:GetUnitName() == 'npc_dota_hero_lone_druid' then
				if member.bearItems == nil then member.bearItems = {[0]='',[1]='',[2]='',[3]='',[4]='',[5]='',[6]='',[7]='',[8]=''} end
				for j = 0, 8 do
					local hItem = bot:GetItemInSlot(j)
					if hItem ~= nil then
						member.bearItems[j] = hItem:GetName()
					end
				end
				break
			end
		end
	end

	if bot.currentComponentToBuy == "item_infused_raindrop"
		or bot.currentComponentToBuy == "item_tome_of_knowledge"
		or bot.currentComponentToBuy == "item_flask"
		or bot.currentComponentToBuy == "item_enchanted_mango"
		or bot.currentComponentToBuy == "item_ward_observer"
		or bot.currentComponentToBuy == "item_ward_sentry"
		or bot.currentComponentToBuy == "item_blood_grenade"
		or bot.currentComponentToBuy == "item_clarity"
		or bot.currentComponentToBuy == "item_smoke_of_deceit"
		or bot.currentComponentToBuy == "item_tango"
		or bot.currentComponentToBuy == "item_dust"
	then
		if GetItemStockCount( bot.currentComponentToBuy ) <= 0
		then
			return
		end
	end

	--------*******----------------*******----------------*******--------
	local currentTime = DotaTime()
	local botName = bot:GetUnitName()
	local botLevel = bot:GetLevel()
	local botGold = bot:GetGold()
	local botWorth = bot:GetNetWorth()
	local botMode = bot:GetActiveMode()
	local botHP	= bot:GetHealth() / bot:GetMaxHealth()
	--------*******----------------*******----------------*******--------

	--更新敌方是否有隐身英雄或道具的状态
	if Role['invisEnemyExist'] == false then Role.UpdateInvisEnemyStatus( bot ) end

	--更新是否出鞋的状态
	if buyBootsStatus == false
		and currentTime > lastBootsCheck + 2.0
	then
		buyBootsStatus = Item.HasBuyBoots( bot )
		lastBootsCheck = currentTime
	end

	--辅助定位英雄购买辅助物品
	if not J.IsCore(bot) and not isBear
	then
		if currentTime > 30 and not hasBuyClarity
			and botGold >= GetItemCost( "item_clarity" )
			and not Role.IsPvNMode()
		then
			hasBuyClarity = true
			bot:ActionImmediate_PurchaseItem( "item_clarity" )
			return
		elseif botLevel >= 5
			and not J.HasItemInInventory('item_ward_sentry')
			and not J.HasItemInInventory('item_gem')
			and Role['invisEnemyExist'] == true
			and buyBootsStatus == true
			and botGold >= GetItemCost( "item_dust" )
			and Item.GetEmptyInventoryAmount( bot ) >= 2
			and Item.GetItemCharges( bot, "item_dust" ) <= 0
			and bot:GetCourierValue() == 0
		then
			bot:ActionImmediate_PurchaseItem( "item_dust" )
			return
		end
	end

	-- Init Healing Items in Lane; works for now
	if J.IsInLaningPhase() and not isBear
	then
		if  botLevel < 6
		and bot:IsAlive()
		and bot:FindItemSlot('item_flask') < 0
		and bot:FindItemSlot('item_tango') < 0
		and botGold > GetItemCost( "item_flask" )
		and bot:DistanceFromFountain() > 3800
		and bot:GetStashValue() > 0
		and not bot:HasModifier('modifier_elixer_healing')
		and not bot:HasModifier('modifier_filler_heal')
		and not bot:HasModifier('modifier_flask_healing')
		and not bot:HasModifier('modifier_fountain_aura_buff')
		and not bot:HasModifier('modifier_juggernaut_healing_ward_heal')
		and not bot:HasModifier('modifier_warlock_shadow_word')
		and not IsThereHealingInStash(bot)
		and Item.GetEmptyInventoryAmount(bot) >= 1
		and J.GetHP(bot) < 0.35
		then
			local partner = J.GetLanePartner(bot)

			if bot:GetHealthRegen() <= 5
			then
				if J.IsCore(bot)
				then
					if partner ~= nil
					then
						if  partner:FindItemSlot('item_flask') < 0
						and partner:FindItemSlot('item_tango') < 0
						and Item.GetItemCharges(bot, 'item_flask') <= 0
						then
							bot:ActionImmediate_PurchaseItem('item_flask')
							return
						end
					else
						if  Item.GetItemCharges(bot, 'item_flask') <= 0
						and (not J.HasItem(bot, 'item_bottle')
							or (J.HasItem(bot, 'item_bottle') and Item.GetItemCharges(bot, 'item_bottle') <= 0))
						then
							bot:ActionImmediate_PurchaseItem('item_flask')
							return
						end
					end
				else
					if Item.GetItemCharges(bot, 'item_flask') <= 0
					then
						bot:ActionImmediate_PurchaseItem('item_flask')
						return
					end
				end
			else
				if J.IsCore(bot)
				then
					if partner ~= nil
					then
						if  partner:FindItemSlot('item_flask') < 0
						and partner:FindItemSlot('item_tango') < 0
						and partner ~= nil
						and Item.GetItemCharges(bot, 'item_tango') <= 0
						then
							bot:ActionImmediate_PurchaseItem('item_tango')
							return
						end
					else
						if  Item.GetItemCharges(bot, 'item_flask') <= 0
						and (not J.HasItem(bot, 'item_bottle')
							or (J.HasItem(bot, 'item_bottle') and Item.GetItemCharges(bot, 'item_bottle') <= 0))
						then
							bot:ActionImmediate_PurchaseItem('item_flask')
							return
						end
					end
				else
					if Item.GetItemCharges(bot, 'item_tango') <= 0
					then
						bot:ActionImmediate_PurchaseItem('item_tango')
						return
					end
				end
			end
		end
	end

	-- don't buy in late game to avoid clutter, since there's no inventory management currently

	-- Observer and Sentry Wards
	if (J.GetPosition(bot) == 4) and not J.IsLateGame() and not isBear then
		local wardType = 'item_ward_sentry'

		if not J.HasItemInInventory('item_dust')
		and not J.HasItemInInventory('item_gem')
		and GetItemStockCount(wardType) > 0
		and botGold >= GetItemCost(wardType)
		and Item.GetEmptyInventoryAmount(bot) >= 1
		and Item.GetItemCharges(bot, wardType) < 2
		and bot:GetCourierValue() == 0
		then
			bot:ActionImmediate_PurchaseItem(wardType)
			return
		end
	end

	if (J.GetPosition(bot) == 5) and not isBear
	then
		local wardType = 'item_ward_observer'

		if  GetItemStockCount(wardType) > 0
		and botGold >= GetItemCost(wardType)
		and Item.GetEmptyInventoryAmount(bot) >= 1
		and Item.GetItemCharges(bot, wardType) < 2
		and bot:GetCourierValue() == 0
		then
			bot:ActionImmediate_PurchaseItem(wardType)
			return
		end
	end

	-- Smoke of Deceit
	if  (J.GetPosition(bot) == 4 or J.GetPosition(bot) == 5)
	and not isBear
	and not J.IsLateGame()
	and GetItemStockCount('item_smoke_of_deceit') > 1
	and botGold >= GetItemCost('item_smoke_of_deceit')
	and Item.GetEmptyInventoryAmount(bot) >= 3
	and Item.GetItemCharges(bot, 'item_smoke_of_deceit') == 0
	and bot:GetCourierValue() == 0
	then
		if  DotaTime() < 0
		and not initSmoke
		then
			local hasSmoke = false
			for _, allyHero in pairs(GetUnitList(UNIT_LIST_ALLIED_HEROES))
			do
				if  J.IsValidHero(allyHero)
				and J.IsNotSelf(bot, allyHero)
				and J.HasItem(allyHero, 'item_smoke_of_deceit')
				then
					hasSmoke = true
					break
				end
			end

			if not hasSmoke
			then
				bot:ActionImmediate_PurchaseItem('item_smoke_of_deceit')
				return
			end
		else
			if not J.IsInLaningPhase()
			and not J.DoesTeamHaveItem('item_smoke_of_deceit')
			then
				bot:ActionImmediate_PurchaseItem('item_smoke_of_deceit')
				return
			end
		end
	end

	-- Blood Grenade
	if  J.IsInLaningPhase()
	and not isBear
	and (J.GetPosition(bot) == 4 or J.GetPosition(bot) == 5)
	and GetItemStockCount('item_blood_grenade') > 0
	and botLevel < 6
	and botGold >= GetItemCost('item_blood_grenade')
	and Item.GetEmptyInventoryAmount(bot) >= 3
	and Item.GetItemCharges(bot, 'item_blood_grenade') == 0
	and bot:GetStashValue() > 0
	then
		bot:ActionImmediate_PurchaseItem('item_blood_grenade')
		return
	end

	--为自己购买魔晶
	if not hasBuyShard
	and not isBear
		and GetItemStockCount( "item_aghanims_shard" ) > 0
		and botGold >= 1400
	then
		hasBuyShard = true

		bot:ActionImmediate_PurchaseItem( "item_aghanims_shard" )

		return
	end


	--防止非辅助购买魂泪
	if buyRD == false
		and currentTime < 0
		and not J.IsCore(bot)
	then
		buyRD = true
	end


	--死前如果会损失金钱则购买额外TP
	if not isBear
		and botGold >= GetItemCost( "item_tpscroll" )
		and bot:IsAlive()
		and not J.IsMeepoClone(bot)
		and botGold < ( GetItemCost( "item_tpscroll" ) + botWorth / 40 )
		and botHP < 0.08
		and GetGameMode() ~= 23
		and bot:GetHealth() >= 1
		and bot:WasRecentlyDamagedByAnyHero( 3.1 )
		and not Item.HasItem( bot, 'item_travel_boots' )
		and not Item.HasItem( bot, 'item_travel_boots_2' )
		and Item.GetItemCharges( bot, 'item_tpscroll' ) <= 2
	then
		bot:ActionImmediate_PurchaseItem( "item_tpscroll" )
		return
	end


	-- --辅助死前如果会损失金钱则购买粉
	-- if botGold >= GetItemCost( "item_dust" )
	-- 	and bot:IsAlive()
	-- 	and GetGameMode() ~= 23
	-- 	and botLevel > 6
	-- 	and not J.IsCore(bot)
	-- 	and botGold < ( GetItemCost( "item_dust" )  + botWorth / 40 )
	-- 	and botHP < 0.06
	-- 	and bot:WasRecentlyDamagedByAnyHero( 3.1 )
	-- 	and Item.GetItemCharges( bot, 'item_dust' ) <= 1
	-- 	and not J.HasItem(bot, 'item_ward_sentry')
	-- then
	-- 	bot:ActionImmediate_PurchaseItem( "item_dust" )
	-- 	return
	-- end

	--交换魂泪的位置避免过早被破坏
	if currentTime > 180
		and currentTime < 1800
		and switchTime < currentTime - 5.6
	then
		local raindrop = bot:FindItemSlot( "item_infused_raindrop" )
		local raindropCharge = Item.GetItemCharges( bot, "item_infused_raindrop" )
		local nEnemyHeroes = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
		if ( raindrop >= 0 and raindrop <= 5 )
			and ( nEnemyHeroes[1] ~= nil
				or botMode == BOT_MODE_ROSHAN
				or bot:WasRecentlyDamagedByAnyHero( 3.1 ) )
			and ( raindropCharge == 1 or raindropCharge >= 7 )
		then
			switchTime = currentTime
			bot:ActionImmediate_SwapItems( raindrop, 6 )
			return
		end
	end



	if ( GetGameMode() ~= 23 and botLevel >= 6 and currentTime > fullInvCheck + 1.0
		and (bot:DistanceFromFountain() <= 200 or bot:DistanceFromSecretShop() <= 200 ))
		or ( GetGameMode() == 23 and botLevel >= 6 and currentTime > fullInvCheck + 1.0 )
	then
		local emptySlot = Item.GetEmptyInventoryAmount( bot )
		local slotToSell = nil

		local preEmpty = 2
		if botLevel <= 17 then preEmpty = 1 end
		if emptySlot <= preEmpty - 1
		then
			for i = 1, #Item['tEarlyItem']
			do
				local itemName = Item['tEarlyItem'][i]
				local itemSlot = bot:FindItemSlot( itemName )
				if itemSlot >= 0 and itemSlot <= 8
				then
					slotToSell = itemSlot
					break
				end
			end
		end

		if slotToSell == nil and GetGameMode() == 23 and not J.IsInLaningPhase() then
			for i = 1, #Item['tEarlyItem']
			do
				local itemName = Item['tEarlyItem'][i]
				local itemSlot = bot:FindItemSlot( itemName )
				if itemSlot >= 6 and itemSlot <= 8
				then
					slotToSell = itemSlot
					break
				end
			end
		end

		if slotToSell ~= nil
		then
			bot:ActionImmediate_SellItem( bot:GetItemInSlot( slotToSell ) )
			return
		end

		fullInvCheck = currentTime
	end

	if currentTime > sell_time + 0.5
	and ((( bot:GetItemInSlot( 6 ) ~= nil or bot:GetItemInSlot( 7 ) ~= nil or bot:GetItemInSlot( 8 ) ~= nil or (not J.IsModeTurbo() and bot:GetUnitName() == 'npc_dota_hero_lone_druid'))
			and (bot:DistanceFromFountain() <= 100 or bot:DistanceFromSecretShop() <= 100 ))
		or J.IsModeTurbo()
		)
	then
		sell_time = currentTime

		if bot.sItemSellList ~= nil then
			for i = #bot.sItemSellList , 2, -2 do
				local nItemToSellSlot = bot:FindItemSlot( bot.sItemSellList[i - 1] )
				local nItemToCheckSlot = bot:FindItemSlot( bot.sItemSellList[i] )

				local nItemToCheckSlot_lastComponent = -1
				local tItemComponent = GetItemComponents(bot.sItemSellList[i])[1]
				if tItemComponent ~= nil then
					nItemToCheckSlot_lastComponent = bot:FindItemSlot(tItemComponent[#tItemComponent])
				end

				if (nItemToCheckSlot >= 0 or nItemToCheckSlot_lastComponent >= 0) and nItemToSellSlot >= 0
				then
					bot:ActionImmediate_SellItem( bot:GetItemInSlot( nItemToSellSlot ) )
					table.remove(bot.sItemSellList, i)
					table.remove(bot.sItemSellList, i - 1)
					return
				end
			end
		end

		if ( Item.HasItem( bot, "item_travel_boots" ) or Item.HasItem( bot, "item_travel_boots_2" ) )
		then
			for i = 1, #Item['tEarlyBoots']
			do
				local bootsSlot = bot:FindItemSlot( Item['tEarlyBoots'][i] )
				if bootsSlot >= 0
				then
					bot:ActionImmediate_SellItem( bot:GetItemInSlot( bootsSlot ) )
					return
				end
			end
		end

		if  Item.HasItem(bot, 'item_mask_of_madness')
		and Item.HasItem(bot, 'item_satanic')
		then
			local slot = bot:FindItemSlot('item_mask_of_madness')
			bot:ActionImmediate_SellItem(bot:GetItemInSlot(slot))
			return
		end

		if J.IsLateGame() then
			local smokeSlot = bot:FindItemSlot('item_smoke_of_deceit')
			if smokeSlot >= 6 then
				bot:ActionImmediate_SellItem(bot:GetItemInSlot(smokeSlot))
				return
			end
		end
	end

	if bot:GetLevel() >= 6 and not isBear
	then
		if botGold >= GetItemCost( "item_tpscroll" )
		and bot:IsAlive()
		and not J.IsMeepoClone(bot)
		and Item.GetItemCharges( bot, 'item_tpscroll' ) <= 1
		then
			bot:ActionImmediate_PurchaseItem( "item_tpscroll" )
			return
		end
	end

	if currentTime > 4 * 60
		and buyTP == false
		and bot:GetCourierValue() == 0
		and botGold >= GetItemCost( "item_tpscroll" )
		and not J.IsMeepoClone(bot)
		and not Item.HasItem( bot, 'item_travel_boots' )
		and not Item.HasItem( bot, 'item_travel_boots_2' )
	then
		local tCharges = Item.GetItemCharges( bot, 'item_tpscroll' )		
		if bot:HasModifier("modifier_teleporting") then tCharges = tCharges - 1 end
		
		if tCharges <= 0
			or ( botLevel >= 18 and tCharges <= 1 )
		then

			if botLevel < 18 or ( botLevel >= 18 and tCharges == 1 )
			then
				buyTP = true
				buyTPtime = currentTime
				bot.currentComponentToBuy = nil
				bot.currListItemToBuy[#bot.currListItemToBuy+1] = 'item_tpscroll'
				if #bot.itemToBuy == 0
				then
					bot.itemToBuy = { 'item_tpscroll' }
					if bot.currentItemToBuy == nil
					then
						bot.currentItemToBuy = 'item_tpscroll'
					end
				end
				return
			end

			if botLevel >= 18 and tCharges == 0 and botGold >= GetItemCost( "item_tpscroll" ) * 2
			then
				buyTP = true
				buyTPtime = currentTime
				bot.currentComponentToBuy = nil
				bot.currListItemToBuy[#bot.currListItemToBuy+1] = 'item_tpscroll'
				bot.currListItemToBuy[#bot.currListItemToBuy+1] = 'item_tpscroll'
				if #bot.itemToBuy == 0
				then
					bot.itemToBuy = { 'item_tpscroll' }
					if bot.currentItemToBuy == nil
					then
						bot.currentItemToBuy = 'item_tpscroll'
					end
				end
				return
			end
			
		end
	end

	
	if buyTP == true and buyTPtime < currentTime - 70
	then
		buyTP = false
		return
	end
	
	


	if #bot.itemToBuy == 0 then bot:SetNextItemPurchaseValue( 0 ) return end

	
	if bot.currentItemToBuy == nil
		and #bot.currListItemToBuy == 0
	then
		bot.currentItemToBuy = bot.itemToBuy[#bot.itemToBuy]
		local tempTable = Item.GetBasicItems( { bot.currentItemToBuy } )
		for i = 1, math.ceil( #tempTable / 2 )
		do
			bot.currListItemToBuy[i] = tempTable[#tempTable-i+1]
			bot.currListItemToBuy[#tempTable-i+1] = tempTable[i]
		end
	end
	
	
	
	if #bot.currListItemToBuy == 0 and currentTime > lastInvCheck + 1.0
	then
		if Item.IsItemInHero( bot.currentItemToBuy )
			or bot.currentItemToBuy == "item_aghanims_shard"
		then
			bot.currentItemToBuy = nil
			bot.itemToBuy[#bot.itemToBuy] = nil
		else
			lastInvCheck = currentTime
		end
	elseif #bot.currListItemToBuy > 0
	then
		if bot.currentComponentToBuy == nil
		then
			bot.currentComponentToBuy = bot.currListItemToBuy[#bot.currListItemToBuy]
		else
			if GetGameMode() == 23
			then
				TurboModeGeneralPurchase()
			else
				GeneralPurchase()
			end
		end
	end

end

function IsThereHealingInStash(unit)
	local amount = 0

	for i = 9, 14
	do
		local item = unit:GetItemInSlot(i)
		if item ~= nil
		then
			if string.find(item:GetName(), 'item_flask')
			or string.find(item:GetName(), 'item_tango')
			or string.find(item:GetName(), 'item_bottle')
			then
				amount = amount + 1
			end
		end
	end

	return amount > 0
end