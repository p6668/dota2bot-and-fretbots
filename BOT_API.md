{{lang|Dota Bot Scripting}}
== Overview ==

Bot scripting in Dota is done via lua scripting.  This is done at the server level, so there's no need to do things like examine screen pixels or simulate mouse clicks; instead scripts can query the game state and issue orders directly to units.  Scripts have full access to all the entity locations, cooldowns, mana values, etc that a player on that team would expect to.  The API is restricted such that scripts can't cheat -- units in FoW can't be queried, commands can't be issued to units the script doesn't control, etc.

There is a [http://dev.dota2.com/forumdisplay.php?f=497 dev subforum] for bot scripting now.

In addition to lua scripting, the underlying C++ bot code still exists, and scripts can decide how much or little of the underlying bot structure to use.

Bots are organized into three levels of evaluation and decisionmaking:

==== Team Level ====
This is code that determines how much the overall team wants to push each lane, defend each lane, farm each lane, or kill Roshan.  These desires exist independent of the state of any of the bots.  They are not authoritative; that is, they do not dictate any actions taken by any of the bots.  They are instead just desires that the bots can use for decisionmaking.

==== Mode Level ====
Modes are the high-level desires that individual bots are constantly evaluating, with the highest-scoring mode being their currently active mode.  Examples of modes are laning, trying to kill a unit, farming, retreating, and pushing a tower.  

==== Action Level ====
Actions are the individual things that bots are actively doing on a moment-to-moment basis.  These loosely correspond to mouse clicks or button presses -- things like moving to a location, or attacking a unit, or using an ability, or purchasing an item.

The overall flow is that the team level is providing top-level guidance on the current strategy of the team.  Each bot is then evaluating their desire score for each of its modes, which are taking into account both the team-level desires as well as bot-level desires.  The highest scoring mode becomes the active mode, which is solely responsible for issuing actions for the bot to perform.

== Directory Structure ==

All in-development bot scripts  live in the game/dota/scripts/vscripts/bots directory within your Dota 2 install.  When you upload your bot script to the workshop, it will upload the contents of this directory.  Downloaded scripts live in their own location within your Steam install.

The bot scripting API is structured such that there are multiple elements that can be independently implemented by bot scripts.  What logic is overriden is determined by which functions you implement and the files in which they are implemented.  

Each of the following scripting elements has its own script scope. 

==== Complete takeover  ====
If you'd like to completely take over control of a hero, you can implement a Think() function in a file called bot_generic.lua, which is called every frame in lieu of the normal bot thinking code.  This will completely take over all bots -- no team-level or mode-level thinking will happen.  You will be responsible for issuing all action-level commands to all bots.  If you'd like to just take over a specific hero's bot, for example Lina, you can implement a Think() function in a file called bot_lina.lua.

Bots that have been completely taken over still respect the difficulty modifiers (see Appendix B), and still calculate their estimated damage.

==== Mode Override ====
If you'd like to work within the existing mode architecture but override the logic for mode desire and behavior, for example the Laning mode, you can implement the following functions in a mode_laning_generic.lua file:

* GetDesire() - Called every ~300ms, and needs to return a floating-point value between 0 and 1 that indicates how much this mode wants to be the active mode.
* OnStart() - Called when a mode takes control as the active mode.
* OnEnd() - Called when a mode relinquishes control to another active mode.
* Think() - Called every frame while this is the active mode.  Responsible for issuing actions for the bot to take.

You can additionally just override the mode logic for a specific hero, such as Lina, with a mode_laning_lina.lua file.  Please see Appendix A for implementation details if you'd like to chain calls from a hero-specific mode override back to a generic mode override.

The list of valid bot modes to override are:
* laning
* attack
* roam
* retreat
* secret_shop
* side_shop
* rune
* push_tower_top
* push_tower_mid
* push_tower_bot
* defend_tower_top
* defend_tower_mid
* defend_tower_bot
* assemble
* team_roam
* farm
* defend_ally
* evasive_maneuvers
* roshan
* item
* ward

==== Ability and Item usage ====
If you'd like to just override decisionmaking around ability and item usage, you can implement the following functions in an ability_item_usage_generic.lua file:

* ItemUsageThink() - Called every frame.  Responsible for issuing item usage actions.
* AbilityUsageThink() - Called every frame.  Responsible for issuing ability usage actions.
* CourierUsageThink() - Called every frame.  Responsible for issuing commands to the courier.
* BuybackUsageThink() - Called every frame.  Responsible for issuing a command to buyback.
* AbilityLevelUpThink() - Called every frame.  Responsible for managing ability leveling.

If any of these functions are not implemented, it will fall back to the default C++ implementation.  

You can additionally just override the ability/item usage logic for a single hero, such as Lina, with an ability_item_usage_lina.lua file.  Please see Appendix A for implementation details if you'd like to chain calls from a hero-specific item/ability implementation back to a generic item/ability implementation.

==== Minion Control ====
If you would like to override minions, which are illusions, summoned units, dominated units, etc. Basically anything that's under control of your hero. But not couriers. Then you can override the think function inside your hero file.

* MinionThink( hMinionUnit )

This function will be called once per frame for every minion under control by a bot. For example, if you implemented it in bot_beastmaster.lua, it would constantly get called both for your boar and hawk while they're summoned and alive.  The handle to the bear/hawk unit is passed in as hMinionUnit.  Action commands that are usable on your hero are usable on the passed-in hMinionUnit.

==== Item Purchasing ====
If you'd like to just override decisionmaking around item purchasing, you can implement the following function in an item_purchase_generic.lua file:

* ItemPurchaseThink() - Called every frame.  Responsible for purchasing items.

You can additionally just override the item purchasing logic for a single hero, such as Lina, with an item_purchase_lina.lua file.

==== Team Level Desires ====
If you'd like to supply team-level desires, you can implement the following functions in a team_desires.lua file:

* TeamThink() - Called every frame.  Provides a single think call for your entire team.
* UpdatePushLaneDesires() - Called every frame.  Returns floating point values between 0 and 1 that represent the desires for pushing the top, middle, and bottom lanes, respectively.
* UpdateDefendLaneDesires() - Called every frame.  Returns floating point values between 0 and 1 that represent the desires for defending the top, middle, and bottom lanes, respectively.
* UpdateFarmLaneDesires() - Called every frame.  Returns floating point values between 0 and 1 that represent the desires for farming the top, middle, and bottom lanes, respectively.
* UpdateRoamDesire() - Called every frame.  Returns a floating point value between 0 and 1 and a unit handle that represents the desire for someone to roam and gank a specified target.
* UpdateRoshanDesire() - Called every frame.  Returns a floating point value between 0 and 1 that represents the desire for the team to kill Roshan.

If any of these functions are not implemented, it will fall back to the default C++ implementation.

==== Hero Selection ====
If you'd like to handle hero picking and lane assignment, you can  implement the following functions in a hero_selection.lua file:

* Think() - Called every frame.  Responsible for selecting heroes for bots.
* UpdateLaneAssignments() - Called every frame prior to the game starting.  Returns ten PlayerID-Lane pairs.
* GetBotNames() - Called once, returns a table of player names.

== Uploading scripts to the Workshop ==

Scripts can be uploaded to the workshop using the Workshop Tools DLC.  You will need to make sure that this option is selected in the DLC section of Dota 2 in Steam.

Once installed, when launching Dota 2 you will see a "Launch Dota 2 - Tools" option.  This will launch the workshop tools, which now has a section for uploading your bot scripts.  This will upload the entire contents of your scripts/bots directory, under a specific name and description.  The description can be updated, but the title cannot!  Once uploaded, your scripts will show up to all Dota 2 users in the dialog that appears when they select Browse On Workshop when selecting bots in a private lobby.  They will be able to upvote and subscribe to your bot scripting, and select it for their games.

== API Reference ==

There are few useful files located in the game\dota\scripts\npc folder inside your Dota 2 install directory:
* npc_abilities.txt - all the abilities in the game, and their parameters
* npc_heroes.txt - all the heroes in the game
* npc_units.txt - all the non-hero units in the game
<br/>

Note: In the following documentation, ''hUnit'' indicates a handle to a unit, and ''hAbility'' indicates a handle to an ability.  ''hItem'' is used interchangably with ''hAbility'' -- under the hood abilities and items are largely the same.

<br>
==== <u>GLOBAL FUNCTIONS</u> ====
<br>

''hUnit'' '''GetBot'''()
:<small>Returns a handle to the bot on which the script is currently being run (if applicable).</small>

''int'' '''GetTeam'''()
:<small>Returns the team for which the script is currently being run.  If it's being run on a bot, returns the team of that bot.</small>

''{int, ...}'' '''GetTeamPlayers'''( ''[[#Teams|nTeam]]'' )
:<small>Returns a table of the Player IDs on the specified team</small>

''hUnit'' '''GetTeamMember'''( ''nPlayerNumberOnTeam'' )
:<small>Returns a handle to the Nth player on the team.</small>

''bool'' '''IsTeamPlayer'''( ''nPlayerID'' )
:<small>Returns whether the player is on Radiant or Dire</small>

''bool'' '''IsPlayerBot'''( ''nPlayerID'' )
:<small>Returns whether the specified playerID is a bot.</small>

''int'' '''GetTeamForPlayer'''( ''nPlayerID'' )
:<small>Returns the team for the specified playerID</small>


''{ hUnit, ... }'' '''GetUnitList'''( ''[[#Unit_Types|nUnitType]]'' )
:<small>Returns a list of units matching the specified unit type. ''Please keep in mind performance considerations when using GetUnitList(). The function itself is reasonably fast because it will build the lists on-demand and no more than once per frame, but the lists can be long and performing logic on all units (or even all creeps) can easily get pretty slow.''</small>


''float'' '''DotaTime'''()
:<small>Returns the game time.  Matches game clock.  Pauses with game pause.</small>

''float'' '''GameTime'''()
:<small>Returns the time since the hero picking phase started.  Pauses with game pause.</small>

''float'' '''RealTime'''()
:<small>Returns the real-world time since the app has started.  Does not pause with game pause.</small>


''float'' '''GetUnitToUnitDistance'''( ''hUnit1'', ''hUnit2'' )
:<small>Returns the distance between two units.</small>

''float'' '''GetUnitToUnitDistanceSqr'''( ''hUnit1'', ''hUnit2'' )
:<small>Returns the squared distance between two units.</small>

''float'' '''GetUnitToLocationDistance'''( ''hUnit'', ''vLocation'' )
:<small>Returns the distance between a unit and a location.</small>

''float'' '''GetUnitToLocationDistanceSqr'''( ''hUnit'', ''vLocation'' )
:<small>Returns the squared distance between a unit and a location.</small>

''{ distance, closest_point, within }'' '''PointToLineDistance'''( ''vStart'', ''vEnd'', ''vPoint'' )
:<small>Returns a table containing the distance to the line segment, the closest point on the line segment, and whether the point is "within" the line segment (that is, the closest point is not one of the endpoints).</small>


''{ float, float, float, float }'' '''GetWorldBounds'''()
:<small>Returns a table containing the min X, min Y, max X, and max Y bounds of the world.</small>

''bool'' '''IsLocationPassable'''( ''vLocation'' )
:<small>Returns whether the specified location is passable.</small>

''bool'' '''IsRadiusVisible'''( ''vLocation'', ''fRadius'' )
:<small>Returns whether a circle of the specified radius at the specified location is visible.</small>

''bool'' '''IsLocationVisible'''( ''vLocation'' )
:<small>Returns whether the specified location is visible.</small>

''int'' '''GetHeightLevel'''( ''vLocation'' )
:<small>Returns the height value (1 through 5) of the specified location.</small>

''{ { string, vector }, ... }'' '''GetNeutralSpawners'''()
:<small>Returns a table containing a list of camp-type and location pairs.  Camp types are one of "basic_N", "ancient_N", "basic_enemy_N", "ancient_enemy_N", where N counts up from 0.</small>


''int'' '''GetItemCost'''( ''sItemName'' )
:<small>Returns the cost of the specified item.</small>

''bool'' '''IsItemPurchasedFromSecretShop'''( ''sItemName'' )
:<small>Returns if the specified item is purchased from the secret shops.</small>

''bool'' '''IsItemPurchasedFromSideShop'''( ''sItemName'' )
:<small>Returns if the specified item can be purchased from the side shops.</small>

''int'' '''GetItemStockCount'''( ''sItemName'' )
:<small>Returns the current stock count of the specified item.</small>

''{ { hItem, hOwner, nPlayer, vLocation }, ...}'' '''GetDroppedItemList'''()
:<small>Returns a table of tables that list the item, owner, and location of items that have been dropped on the ground.</small>


''float'' '''GetPushLaneDesire'''( ''[[#Lanes|nLane]]'' )
:<small>Returns the team's current desire to push the specified lane.</small>

''float'' '''GetDefendLaneDesire'''( ''[[#Lanes|nLane]]'' )
:<small>Returns the team's current desire to defend the specified lane.</small>

''float'' '''GetFarmLaneDesire'''( ''[[#Lanes|nLane]]'' )
:<small>Returns the team's current desire to farm the specified lane.</small>

''float'' '''GetRoamDesire'''()
:<small>Returns the team's current desire to roam to a target.</small>

''hUnit'' '''GetRoamTarget'''()
:<small>Returns the team's current roam target.</small>

''float'' '''GetRoshanDesire'''()
:<small>Returns the team's current desire to kill Roshan.</small>


''[[#Game_States|int]]'' '''GetGameState'''()
:<small>Returns the current game state.</small>

''float'' '''GetGameStateTimeRemaining'''()
:<small>Returns how much time is remaining in the current game state, if applicable.</small>


''[[#Game_Modes|int]]'' '''GetGameMode'''()
:<small>Returns the current game mode.</small>


''[[#Hero_Pick_States|int]]'' '''GetHeroPickState'''()
:<small>Returns the current hero pick state.</small>

''bool'' '''IsPlayerInHeroSelectionControl'''( ''nPlayerID'' )
:<small>Returns whether the specified player is in selection control when picking a hero.</small>

'''SelectHero'''( ''nPlayerID'', ''sHeroName'' )
:<small>Selects a hero for the specified player.</small>

''string'' '''GetSelectedHeroName'''( ''nPlayerID'' )
:<small>Returns the name of the hero the specified player has selected.</small>


''bool'' '''IsInCMBanPhase'''()
:<small>Returns whether we're in a Captains Mode ban phase.</small>

''bool'' '''IsInCMPickPhase'''()
:<small>Returns whether we're in a Captains Mode pick phase.</small>

''float'' '''GetCMPhaseTimeRemaining'''()
:<small>Gets the time remaining in the current Captains Mode phase.</small>

''int'' '''GetCMCaptain'''()
:<small>Gets the Player ID of the Captains Mode Captain.</small>

'''SetCMCaptain'''( ''nPlayerID'' )
:<small>Gets the Captains Mode Captain to the specified Player ID.</small>

''bool'' '''IsCMBannedHero'''( ''sHeroName'' )
:<small>Returns whether the specified hero has been banned in a Captains Mode game.</small>

''bool'' '''IsCMPickedHero'''( ''[[#Teams|nTeam]]'', ''sHeroName'' )
:<small>Returns whether the specified hero has been picked in a Captains Mode game.</small>

'''CMBanHero'''( ''sHeroName'' )
:<small>Bans the specified hero in a Captains Mode game.</small>

'''CMPickHero'''( ''sHeroName'' )
:<small>Picks the specified hero in a Captains Mode game.</small>


''int'' '''RandomInt'''( ''nMin'', ''nMax'' )
:<small>Returns a random integer between nMin and nMax, inclusive.</small>

''float'' '''RandomFloat'''( ''fMin'', ''fMax'' )
:<small>Returns a random float between nMin and nMax, inclusive.</small>

''vector'' '''RandomVector'''( ''fLength'' )
:<small>Returns a vector of fLength pointing in a random direction in the X/Y axis.</small>

''bool'' '''RollPercentage'''( ''nChance'' )
:<small>Rolls a numbmer from 1 to 100 and returns whether it is less than or equal to the specified number.</small>


''float''  '''Min'''( ''fOption1'', ''fOption2'' )
:<small>Returns the smaller of fOption1 and fOption2.</small>

''float'' '''Max'''( ''fOption1'', ''fOption2'' )
:<small>Returns the larger of fOption1 and fOption2.</small>

''float'' '''Clamp'''( ''fValue'', ''fMin'', ''fMax'' )
:<small>Returns fValue clamped within the bounds of fMin and fMax.</small>


''float'' '''RemapVal'''( ''fValue'', ''fFromMin'', ''fFromMax'', ''fToMin'', ''fToMax'' )
:<small>Returns fValue linearly remapped onto fFrom to fTo.</small>

''float'' '''RemapValClamped'''( ''fValue'', ''fFromMin'', ''fFromMax'', ''fToMin'', ''fToMax'' )
:<small>Returns fValue linearly remapped onto fFrom to fTo, while also clamping within their bounds.</small>


''int'' '''GetUnitPotentialValue'''( ''hUnit'', ''vLocation'', ''fRadius'' )
:<small>Gets the 0-255 potential location value of a hero at the specified location and radius.</small>


''bool'' '''IsCourierAvailable'''()
:<small>Returns if the courier is available to use.</small>

''int'' '''GetNumCouriers'''()
:<small>Returns the number of team couriers</small>

''hCourier'' '''GetCourier'''( ''nCourier'' )
:<small>Returns a handle to the specified courier (zero based index)</small>

''[[#Courier_Actions_and_States|int]]'' '''GetCourierState'''( ''hCourier'' )
:<small>Returns the current state of the specified courier.</small>


''vector'' '''GetTreeLocation'''( ''nTree'' )
:<small>Returns the specified tree location.</small>

''vector'' '''GetRuneSpawnLocation'''( ''[[#Rune_Locations|nRuneLoc]]'' )
:<small>Returns the location of the specified rune spawner.</small>

''vector'' '''GetShopLocation'''( ''[[#Teams|nTeam]]'', ''nShop'' )
:<small>Returns the location of the specified shop.</small>


''float'' '''GetTimeOfDay'''()
:<small>Returns the time of day -- 0.0 is midnight, 0.5 is noon.</small>


''hUnit'' '''GetTower'''( ''[[#Teams|nTeam]]'', ''[[#Towers|nTower]]'' )
:<small>Returns the specified tower.</small>

''hUnit'' '''GetBarracks'''( ''[[#Teams|nTeam]]'', ''[[#Barracks|nBarracks]]'' )
:<small>Returns the specified barracks.</small>

''hUnit'' '''GetShrine'''( ''[[#Teams|nTeam]]'', ''[[#Shrines|nShrine]]'' )
:<small>Returns the specified shrine.</small>

''hUnit'' '''GetAncient'''( ''[[#Teams|nTeam]]'' )
:<small>Returns the specified ancient.</small>


''float'' '''GetGlyphCooldown'''()
:<small>Get the current Glyph cooldown in seconds.  Will return 0 if it is off cooldown.</small>


''float'' '''GetRoshanKillTime'''()
:<small>Get the last time that Roshan was killed.</small>


''float'' '''GetLaneFrontAmount'''( ''[[#Teams|nTeam]]'', ''[[#Lanes|nLane]]'', ''bIgnoreTowers'' )
:<small>Return the lane front amount (0.0 - 1.0) of the specified team's creeps along the specified lane.  Optionally can ignore towers.</small>

''vector'' '''GetLaneFrontLocation'''( ''[[#Teams|nTeam]]'', ''[[#Lanes|nLane]]'', ''fDeltaFromFront'' )
:<small>Returns the location of the lane front for the specified team and lane.  Always ignores towers.  Has a third parameter for a distance delta from the front.</small>

''vector'' '''GetLocationAlongLane'''( ''[[#Lanes|nLane]]'', ''fAmount'' )
:<small>Returns the location the specified amount (0.0 - 1.0) along the specified lane.</small>

''{ amount, distance }'' '''GetAmountAlongLane'''( ''[[#Lanes|nLane]]'', ''vLocation'' )
:<small>Returns the amount (0.0 - 1.0) along a lane, and distance from the lane of the specified location.</small>


''[[#Teams|int]]'' '''GetOpposingTeam'''()
:<small>Returns the opposing Team ID.</small>


''bool'' '''IsHeroAlive'''( ''nPlayerID'' )
:<small>Returns whether the specified PlayerID's hero is alive.</small>

''int'' '''GetHeroLevel'''( ''nPlayerID'' )
:<small>Returns the specified PlayerID's hero's level.</small>

''int'' '''GetHeroKills'''( ''nPlayerID'' )
:<small>Returns the specified PlayerID's hero's kill count.</small>

''int'' '''GetHeroDeaths'''( ''nPlayerID'' )
:<small>Returns the specified PlayerID's hero's death count.</small>

''int'' '''GetHeroAssists'''( ''nPlayerID'' )
:<small>Returns the specified PlayerID's hero's assists count.</small>


''{ {location, time_since_seen}, ...}'' '''GetHeroLastSeenInfo'''( ''nPlayerID'' )
:<small>Returns a table containing a list of locations and time_since_seen members, each representing the last seen location of a hero that player controls.</small>


''{ {location, caster, player, ability, velocity, radius, handle }, ... }'' '''GetLinearProjectiles'''()
:<small>Returns a table containing info about all visible linear projectiles.</small>

''{ location, caster, player, ability, velocity, radius }'' '''GetLinearProjectileByHandle'''( ''nProjectileHandle'' )
:<small>Returns a table containing info about the specified linear projectile.</small>


''{ {location, ability, caster, radius }, ... }'' '''GetAvoidanceZones'''()
:<small>Returns a table containing info about all visible avoidance zones.</small>


''[[#Rune_Types|int]]'' '''GetRuneType'''( ''[[#Rune_Locations|nRuneLoc]]'' )
:<small>Returns the rune type of the rune at the specified location, if known.</small>

''[[#Rune_Status|int]]'' '''GetRuneStatus'''( ''[[#Rune_Locations|nRuneLoc]]'' )
:<small>Returns the status of the rune at the specified location.</small>

''float'' '''GetRuneTimeSinceSeen'''( ''[[#Rune_Locations|nRuneLoc]]'' )
:<small>Returns how long it's been since we've seen the rune at the specified location.</small>


''float'' '''GetShrineCooldown'''( ''hShrine'' )
:<small>Returns the current cooldown of the specified Shrine.</small>

''bool'' '''IsShrineHealing'''( ''hShrine'' )
:<small>Returns whether the specified shrine is currently healing.</small>


''int'' '''AddAvoidanceZone'''( ''vLocationAndRadius'' )
:<small>Adds an avoidance zone for use with GeneratePath(). Takes a Vector with x and y as a 2D location, and z as as radius. Returns a handle to the avoidance zone.</small>

'''RemoveAvoidanceZone'''( ''hAvoidanceZone'' )
:<small>Removes the specified avoidance zone.</small>

'''GeneratePath( ''vStart'', ''vEnd'', ''tAvoidanceZones'', ''funcCompletion'' )'''
:<small>Pathfinds from vStar to vEnd, avoiding all the specified avoidance zones and the ones specified with AddAvoidanceZone.  Will call funcCompltion when done, which is a function that has two parameters: a distance of the path, and a table that contains all the waypoints of the path. If the pathfind fails, it will call that function with a distance of 0 and an empty waypoint table.</small>


'''DebugDrawLine'''( ''vStart'', ''vEnd'', ''nRed'', ''nGreen'', ''nBlue'' )
:<small>Draws a line from vStar to vEnd in the specified color for one frame.</small>

'''DebugDrawCircle'''( ''vCenter'', ''fRadius'', ''nRed'', ''nGreen'', ''nBlue'' )
:<small>Draws a circle at vCenter with radius fRadius in the specified color for one frame.</small>

'''DebugDrawText'''( ''fScreenX'', ''fScreenY'', ''sText'', ''nRed'', ''nGreen'', ''nBlue'' )
:<small>Draws the specified text at fScreenX, fScreenY on the screen in the specified color for one frame.</small>

<br>

==== <u>UNIT SCOPED FUNCTIONS</u> ====
<br>
'''Action_ClearActions'''( ''bStop'' )
:<small>Clear action queue and return to idle and optionally stop in place with bStop true</small>


'''Action_MoveToLocation'''( ''vLocation'' )<br>
'''ActionPush_MoveToLocation'''( ''vLocation'' )<br>
'''ActionQueue_MoveToLocation'''( ''vLocation'' )
:<small>Command a bot to move to the specified location, this is not a precision move</small>

'''Action_MoveDirectly'''( ''vLocation'' )<br>
'''ActionPush_MoveDirectly'''( ''vLocation'' )<br>
'''ActionQueue_MoveDirectly'''( ''vLocation'' )
:<small>Command a bot to move to the specified location, bypassing the bot pathfinder.  Identical to a user's right-click.</small>

'''Action_MovePath'''( ''tWaypoints'' )<br>
'''ActionPush_MovePath'''( ''tWaypoints'' )<br>
'''ActionQueue_MovePath'''( ''tWaypoints'' )
:<small>Command a bot to move along the specified path.</small>

'''Action_MoveToUnit'''( ''hUnit'' )<br>
'''ActionPush_MoveToUnit'''( ''hUnit'' )<br>
'''ActionQueue_MoveToUnit'''( ''hUnit'' )
:<small>Command a bot to move to the specified unit, this will continue to follow the unit</small>

'''Action_AttackUnit'''( ''hUnit, bOnce'' )<br>
'''ActionPush_AttackUnit'''( ''hUnit, bOnce'' )<br>
'''ActionQueue_AttackUnit'''( ''hUnit, bOnce'' )
:<small>Tell a unit to attack a unit with an option bool to stop after one attack if true</small>

'''Action_AttackMove'''( ''vLocation'' )<br>
'''ActionPush_AttackMove'''( ''vLocation'' )<br>
'''ActionQueue_AttackMove'''( ''vLocation'' )
:<small>Tell a unit to attack-move a location.</small>

'''Action_UseAbility'''( ''hAbility'' )<br>
'''ActionPush_UseAbility'''( ''hAbility'' )<br>
'''ActionQueue_UseAbility'''( ''hAbility'' )
:<small>Command a bot to use a non-targeted ability or item</small>

'''Action_UseAbilityOnEntity'''( ''hAbility'', ''hTarget'' )<br>
'''ActionPush_UseAbilityOnEntity'''( ''hAbility'', ''hTarget'' )<br>
'''ActionQueue_UseAbilityOnEntity'''( ''hAbility'', ''hTarget'' )
:<small>Command a bot to use a unit targeted ability or item on the specified target unit</small>

'''Action_UseAbilityOnLocation'''( ''hAbility'', ''vLocation'' )<br>
'''ActionPush_UseAbilityOnLocation'''( ''hAbility'', ''vLocation'' )<br>
'''ActionQueue_UseAbilityOnLocation'''( ''hAbility'', ''vLocation'' )
:<small>Command a bot to use a ground targeted ability or item on the specified location</small>

'''Action_UseAbilityOnTree'''( ''hAbility'', ''iTree'' )<br>
'''ActionPush_UseAbilityOnTree'''( ''hAbility'', ''iTree'' )<br>
'''ActionQueue_UseAbilityOnTree'''( ''hAbility'', ''iTree'' )
:<small>Command a bot to use a tree targeted ability or item on the specified tree</small>

'''Action_PickUpRune'''( ''[[#Rune_Locations|nRune]]'' )<br>
'''ActionPush_PickUpRune'''( ''[[#Rune_Locations|nRune]]'' )<br>
'''ActionQueue_PickUpRune'''( ''[[#Rune_Locations|nRune]]'' )
:<small>Command a hero to pick up the rune at the specified rune location.</small>

'''Action_PickUpItem'''( ''hItem'' )<br>
'''ActionPush_PickUpItem'''( ''hItem'' )<br>
'''ActionQueue_PickUpItem'''( ''hItem'' )
:<small>Command a bot to pick up the specified item</small>

'''Action_DropItem'''( ''hItem, vLocation'' )<br>
'''ActionPush_DropItem'''( ''hItem, vLocation'' )<br>
'''ActionQueue_DropItem'''( ''hItem, vLocation'' )
:<small>Command a bot to drop the specified item and the provided location</small>

'''Action_UseShrine'''( ''hShrine'' )<br>
'''ActionPush_UseShrine'''( ''hShrine'' )<br>
'''ActionQueue_UseShrine'''( ''hShrine'' )
:<small>Command a bot to use the specified shrine</small>

'''Action_Delay'''( ''fDelay'' )<br>
'''ActionPush_Delay'''( ''fDelay'' )<br>
'''ActionQueue_Delay'''( ''fDelay'' )
:<small>Command a bot to delay for the specified amount of time.</small>


''[[#Item_Purchase_Results|int]]'' '''ActionImmediate_PurchaseItem '''( ''sItemName'' )
:<small>Command a bot to purchase the specified item.  Item names can be found [https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Item_Names here].</small>

'''ActionImmediate_SellItem'''( ''hItem'' )
:<small>Command a bot to sell the specified item</small>

'''ActionImmediate_DisassembleItem'''( ''hItem'' )
:<small>Command a bot to disassemble the specified item</small>

'''ActionImmediate_SetItemCombineLock'''( ''hItem'', ''bLocked'' )
:<small>Command a bot to lock or unlock combining of the specified item</small>

'''ActionImmediate_SwapItems'''( ''index1'', ''index2'' )
:<small>Command a bot to swap the items in index1 and index2 in their inventory.  Indices are zero based with 0-5 corresponding to inventory, 6-8 are backpack and 9-15 are stash</small>

'''ActionImmediate_Courier'''( ''hCourier'', ''[[#Courier_Actions_and_States|nAction]]'' )
:<small>Command the courier specified by hCourier to perform one of the courier Actions.</small>

'''ActionImmediate_Buyback'''()
:<small>Tell a hero to buy back from death.</small>

'''ActionImmediate_Glyph'''()
:<small>Tell a hero to use Glyph.</small>

'''ActionImmediate_LevelAbility '''( ''sAbilityName'' )
:<small>Command a bot to level an ability or a talent.  Ability and talent names can be found [https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Ability_Names here]</small>

'''ActionImmediate_Chat'''( ''sMessage, bAllChat'' )
:<small>Have a bot say something in team chat, bAllChat true to say to all chat instead</small>

'''ActionImmediate_Ping'''( ''fXCoord, fYCoord, bNormalPing'' )
:<small>Command a bot to ping the specified coordinates with bNormalPing setting the ping type</small>


''[[#Action_Types|int]]'' '''GetCurrentActionType '''()
:<small>Get the type of the currently active Action.</small>

''int'' '''NumQueuedActions'''()
:<small>Get number of actions in the action queue.</small>

''[[#Action_Types|int]]'' '''GetQueuedActionType'''( ''nAction'' )
:<small>Get the type of the specified queued action.</small>


''bool'' '''IsBot'''()
:<small>Returns whether the unit is a bot (otherwise they are a human).</small>

''[[#Difficulties|int]]'' '''GetDifficulty'''()
:<small>Gets the difficulty level of this bot.</small>

''string'' '''GetUnitName'''()
:<small>Gets the name of the unit.  Note that this is the under-the-hood name, not the normal (localized) name that you'd see for the unit.</small>

''int'' '''GetPlayerID'''()
:<small>Gets the Player ID of the unit, used in functions that refer to a player rather than a specific unit.</small>

''[[#Teams|int]]'' '''GetTeam'''()
:<small>Gets team to which this unit belongs.</small>

''bool'' '''IsHero'''()
:<small>Returns whether the unit is a hero.</small>

''bool'' '''IsIllusion'''()
:<small>Returns whether the unit is an illusion.  Always returns false on enemies.</small>

''bool'' '''IsCreep'''()
:<small>Returns whether the unit is a creep.</small>

''bool'' '''IsAncientCreep'''()
:<small>Returns whether the unit is an ancient creep.</small>

''bool'' '''IsBuilding'''()
:<small>Returns whether the unit is a building.  This includes towers, barracks, filler buildings, and the ancient.</small>

''bool'' '''IsTower'''()
:<small>Returns whether the unit is a tower.</small>

''bool'' '''IsFort'''()
:<small>Returns whether the unit is the ancient.</small>


''bool'' '''CanBeSeen'''()
:<small>Check if a unit can currently be seen by your team.  </small>


''[[#Bot_Modes|int]]'' '''GetActiveMode'''()
:<small>Get the bots currently active mode.  This may not track modes in complete takeover bots.</small>

''float'' '''GetActiveModeDesire'''()
:<small>Gets the desire of the currently active mode.</small>


''int'' '''GetHealth'''()
:<small>Gets the health of the unit.</small>

''int'' '''GetMaxHealth'''()
:<small>Gets the maximum health of the specified unit.</small>

''int'' '''GetHealthRegen'''()
:<small>Gets the current health regen per second of the unit.</small>

''int'' '''GetMana'''()
:<small>Gets the current mana of the unit.</small>

''int'' '''GetMaxMana'''()
:<small>Gets the maximum mana of the unit.</small>

''int'' '''GetManaRegen'''()
:<small>Gets the current mana regen of the unit.</small>


''int'' '''GetBaseMovementSpeed'''()
:<small>Gets the base movement speed of the unit.</small>

''int'' '''GetCurrentMovementSpeed'''()
:<small>Gets the current movement speed (base + modifiers) of the unit.</small>


''bool'' '''IsAlive'''()
:<small>Returns true if the unit is alive.</small>

''float'' '''GetRespawnTime'''()
:<small>Returns the number of seconds remaining for the unit to respawn.  Returns -1.0 for non-heroes.</small>

''bool'' '''HasBuyback'''()
:<small>Returns true if the unit has buyback available.  Will return false for enemies or non-heroes.</small>

''int'' '''GetBuybackCost'''()
:<small>Returns the current gold cost of buyback.  Will return -1 for enemies or non-heroes.</small>

''float'' '''GetBuybackCooldown'''()
:<small>Returns the current cooldown for buyback.  Will return -1.0 for enemies or non-heroes.</small>

''float'' '''GetRemainingLifespan'''()
:<small>Returns the remaining lifespan in seconds of units with limited lifespans.</small>



''float'' '''GetBaseDamage'''()
:<small>Returns the average base damage of the unit.</small>

''float'' '''GetBaseDamageVariance'''()
:<small>Returns the +/- variance in the base damage of the unit.</small>

''float'' '''GetAttackDamage'''()
:<small>Returns actual attack damage (with bonuses) of the unit.</small>

''int'' '''GetAttackRange'''()
:<small>Returns the range at which the unit can attack another unit.</small>

''int'' '''GetAttackSpeed'''()
:<small>Returns the attack speed value of the unit.</small>

''float'' '''GetSecondsPerAttack'''()
:<small>Returns the number of seconds per attack (including backswing) of the unit.</small>

''float'' '''GetAttackPoint'''()
:<small>Returns the point in the animation where a unit will execute the attack.</small>

''float'' '''GetLastAttackTime'''()
:<small>Returns the time that the unit last executed an attack.</small>

''hUnit'' '''GetAttackTarget'''()
:<small>Returns a the attack target of the unit.</small>

''int'' '''GetAcquisitionRange'''()
:<small>Returns the range at which this unit will attack a target.</small>

''int'' '''GetAttackProjectileSpeed'''()
:<small>Returns the speed of the unit's attack projectile.</small>


''float'' '''GetActualIncomingDamage'''( ''nDamage, [[#Damage_Types|nDamageType]]'' )
:<small>Gets the incoming damage value after reductions depending on damage type.</small>

''float'' '''GetAttackCombatProficiency'''( ''hTarget'' )
:<small>Gets the damage multiplier when attacking the specified target.</small>

''float'' '''GetDefendCombatProficiency'''( ''hAttacker'' )
:<small>Gets the damage multiplier when being attacked by the specified attacker.</small>


''float'' '''GetSpellAmp'''()
:<small>Gets the spell amplification debuff percentage of this unit.</small>

''float'' '''GetArmor'''()
:<small>Gets the armor of this unit.</small>

''float'' '''GetMagicResist'''()
:<small>Gets the magic resist value of this unit.</small>

''float'' '''GetEvasion'''()
:<small>Gets the evasion percentage of this unit.</small>


''[[#Attribute_Types|int]]'' '''GetPrimaryAttribute'''()
:<small>Gets the primary stat of this unit.</small>

''int'' '''GetAttributeValue'''( ''[[#Attribute_Types|nAttrib]]'' )
:<small>Gets the value of the specified stat.  Returns -1 for non-heroes.</small>


''int'' '''GetBountyXP'''()
:<small>Gets the XP bounty value for killing this unit.</small>

''int'' '''GetBountyGoldMin'''()
:<small>Gets the minimum gold bounty value for killing this unit.</small>

''int'' '''GetBountyGoldMax'''()
:<small>Gets the maximum gold bounty value for killing this unit.</small>


''int'' '''GetXPNeededToLevel'''()
:<small>Gets the amount of XP needed for this unit to gain a level.  Returns -1 for non-heroes.</small>

''int'' '''GetAbilityPoints'''()
:<small>Get the number of ability points available to this bot.</small>

''int'' '''GetLevel'''()
:<small>Gets the level of this unit.</small>


''int'' '''GetGold'''()
:<small>Gets the current gold amount for this unit.</small>

''int'' '''GetNetWorth'''()
:<small>Gets the current total net worth for this unit.</small>

''int'' '''GetStashValue'''()
:<small>Gets the current value of all items in this unit's stash.</small>

''int'' '''GetCourierValue'''()
:<small>Gets the current value of all items on couriers that this unit owns.</small>


''int'' '''GetLastHits'''()
:<small>Gets the current last hit count for this unit.</small>

''int'' '''GetDenies'''()
:<small>Gets the current deny count for this unit.</small>


''float'' '''GetBoundingRadius'''()
:<small>Gets the bounding radius of this unit.  Used for attack ranges and collision.</small>

''vector'' '''GetLocation'''()
:<small>Gets the location of this unit.</small>

''int'' '''GetFacing'''()
:<small>Gets the facing of this unit on a 360 degree rotation. (0 - 359). Facing East is 0, North is 90, West is 180, South is 270.</small>

''bool'' '''IsFacingLocation'''( ''vLocation'', ''nDegrees'' )
:<small>Returns if the unit is facing the specified location, within an nDegrees cone.</small>

''float'' '''GetGroundHeight'''()
:<small>Gets ground height of the location of this unit.  Note: This call can be very expensive!  Use sparingly.</small>

''vector'' '''GetVelocity'''()
:<small>Gets the unit's current velocity.</small>


''int'' '''GetDayTimeVisionRange'''()
:<small>Gets the unit's vision range during the day.</small>

''int'' '''GetNightTimeVisionRange'''()
:<small>Gets the unit's vision range during the night.</small>

''int'' '''GetCurrentVisionRange'''()
:<small>Gets the unit's current vision range.</small>


''int'' '''GetHealthRegenPerStr'''()
:<small>Returns the health regen per second per point in strength.</small>

''int'' '''GetManaRegenPerInt'''()
:<small>Returns the mana regen per second per point in intellect.</small>


''[[#Animation Activities|int]]'' '''GetAnimActivity'''()
:<small>Returns the current animation activity the unit is playing.</small>

''float'' '''GetAnimCycle'''()
:<small>Returns the amount through the current animation (0.0 - 1.0)</small>


''hAbility'' '''GetAbilityByName'''( ''sAbilityName'' )
:<small>Gets a handle to the named ability.  Ability names can be found in [https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Ability_Names here]</small>

''hAbility'' '''GetAbilityInSlot'''( ''nAbilitySlot'' )
:<small>Gets a handle to ability in the specified slot.  Slots range from 0 to 23.</small>

''hItem'' '''GetItemInSlot'''( ''nIventorySlot'' )
:<small>Gets a handle to item in the specified inventory slot.  Slots range from 0 to 16.</small>

''int'' '''FindItemSlot'''( ''sItemName'' )
:<small>Gets the inventory slot the named item is in. Item names can be found [https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Item_Names here].</small>

''[[#Item_Slot_Types|int]] GetItemSlotType( ''nIventorySlot'' )
:<small>Gets the type of the specified inventory slot.</small>


''bool'' '''IsChanneling'''()
:<small>Returns whether the unit is currently channeling an ability or item.</small>

''bool'' '''IsUsingAbility'''()
:<small>Returns whether the unit's active ability is a UseAbility action.  Note that this will be true while a is currently using an ability or item.</small>

''bool'' '''IsCastingAbility'''()
:<small>Returns whether the unit is actively casting an ability or item.  Does not include movement or backswing.</small>

''hAbility'' '''GetCurrentActiveAbility'''()
:<small>Gets a handle to ability that's currently being used.</small>


''bool'' '''IsAttackImmune'''()
:<small>Returns whether the unit is immune to attacks.</small>

''bool'' '''IsBlind'''()
:<small>Returns whether the unit is blind and will miss all of its attacks.</small>

''bool'' '''IsBlockDisabled'''()
:<small>Returns whether the unit is disabled from blocking attacks.</small>

''bool'' '''IsDisarmed'''()
:<small>Returns whether the unit is disarmed and unable to attack.</small>

''bool'' '''IsDominated'''()
:<small>Returns whether the unit has been dominated.</small>

''bool'' '''IsEvadeDisabled'''()
:<small>Returns whether the unit is unable to evade attacks.</small>

''bool'' '''IsHexed'''()
:<small>Returns whether the unit is hexed into an adorable animal.</small>

''bool'' '''IsInvisible'''()
:<small>Returns whether the unit has an invisibility effect.  Note that this does NOT guarantee invisibility to the other team -- if they have detection, they can see you even if IsInvisible() returns true.</small>

''bool'' '''IsInvulnerable'''()
:<small>Returns whether the unit is invulnerable to damage.</small>

''bool'' '''IsMagicImmune'''()
:<small>Returns whether the unit is magic immune.</small>

''bool'' '''IsMuted'''()
:<small>Returns whether the unit is item muted.</small>

''bool'' '''IsNightmared'''()
:<small>Returns whether the unit is having bad dreams.</small>

''bool'' '''IsRooted'''()
:<small>Returns whether the unit is rooted in place.</small>

''bool'' '''IsSilenced'''()
:<small>Returns whether the unit is silenced and unable to use abilities.</small>

''bool'' '''IsSpeciallyDeniable'''()
:<small>Returns whether the unit is deniable by allies due to a debuff.</small>

''bool'' '''IsStunned'''()
:<small>Returns whether the unit is stunned.</small>

''bool'' '''IsUnableToMiss'''()
:<small>Returns whether the unit will not miss due to evasion or attacking uphill.</small>

''bool'' '''HasScepter'''()
:<small>Returns whether the unit has ultimate scepter upgrades.</small>


''bool'' '''WasRecentlyDamagedByAnyHero'''( ''fInterval'' )
:<small>Returns whether the unit has been damaged by a hero in the specified interval.</small>

''float'' '''TimeSinceDamagedByAnyHero'''()
:<small>Returns whether the amount of time passed the unit has been damaged by a hero.</small>

''bool'' '''WasRecentlyDamagedByHero'''( ''hUnit'',  ''fInterval'' )
:<small>Returns whether the unit has been damaged by the specified hero in the specified interval.</small>

''float'' '''TimeSinceDamagedByHero'''( ''hUnit'' )
:<small>Returns whether the amount of time passed the unit has been damaged by the specified hero.</small>

''bool'' '''WasRecentlyDamagedByPlayer'''( ''nPlayerID'',  ''fInterval'' )
:<small>Returns whether the unit has been damaged by the specified player in the specified interval.</small>

''float'' '''TimeSinceDamagedByPlayer'''( ''nPlayerID'' )
:<small>Returns whether the amount of time passed the unit has been damaged by the specified hero.</small>

''bool'' '''WasRecentlyDamagedByCreep'''( ''fInterval'' )
:<small>Returns whether the unit has been damaged by a creep in the specified interval.</small>

''float'' '''TimeSinceDamagedByCreep'''()
:<small>Returns whether the amount of time passed the unit has been damaged by a creep.</small>

''bool'' '''WasRecentlyDamagedByTower'''( ''fInterval'' )
:<small>Returns whether the unit has been damaged by a tower in the specified interval.</small>

''float'' '''TimeSinceDamagedByTower'''()
:<small>Returns whether the amount of time passed the unit has been damaged by a tower.</small>


''int'' '''DistanceFromFountain'''()
:<small>Gets the unit’s straight-line distance from the team’s fountain (0 is in the fountain).</small>

''int'' '''DistanceFromSecretShop'''()
:<small>Gets the unit’s straight-line distance from the closest secret shop (0 is in a secret shop).</small>

''int'' '''DistanceFromSideShop'''()
:<small>Gets the unit’s straight-line distance from the closest side shop (0 is in a side shop).</small>


'''SetTarget'''( ''hUnit'' )
:<small>Sets the target to be a specific unit.  Doesn't actually execute anything, just potentially useful for communicating a target between modes/items.</small>

''hUnit'' '''GetTarget'''()
:<small>Gets the target that's been set for a unit.</small>

'''SetNextItemPurchaseValue'''( ''nGold'' )
:<small>Sets the value of the next item to purchase.  Doesn't actually execute anything, just potentially useful for communicating a purchase target for modes like Farm.</small>

int '''GetNextItemPurchaseValue'''()
:<small>Gets the purchase value that's been set.</small>


''[[#Lanes|int]]'' '''GetAssignedLane'''()
:<small>Gets the assigned lane of this unit.</small>


''float'' '''GetOffensivePower'''()
:<small>Gets an estimate of the current offensive power of a unit.  Derived from the average amount of damage it can do to all enemy heroes.</small>

''float'' '''GetRawOffensivePower'''()
:<small>Gets an estimate of the current offensive power of a unit.  Derived from the average amount of damage it can do to all enemy heroes, ignoring cooldown and mana status.</small>

''float'' '''GetEstimatedDamageToTarget'''( ''bCurrentlyAvailable'', ''hTarget'', ''fDuration'', ''[[#Damage_Types|nDamageTypes]]'' )
:<small>Gets an estimate of the amount of damage that this unit can do to the specified unit.  If bCurrentlyAvailable is true, it takes into account mana and cooldown status.</small>

''float'' '''GetStunDuration'''( ''bCurrentlyAvailable'' )
:<small>Gets an estimate of the duration of a stun that a unit can cast.  If bCurrentlyAvailable is true, it takes into account mana and cooldown status.</small>

''float'' '''GetSlowDuration'''( ''bCurrentlyAvailable'' )
:<small>Gets an estimate of the duration of a slow that a unit can cast.  If bCurrentlyAvailable is true, it takes into account mana and cooldown status.</small>


''bool'' '''HasBlink'''( ''bCurrentlyAvailable'' )
:<small>Returns whether the unit has a blink available to them.</small>

''bool'' '''HasMinistunOnAttack'''()
:<small>Returns whether the unit has a ministun when they attack.</small>

''bool'' '''HasSilence'''( ''bCurrentlyAvailable'' )
:<small>Returns whether the unit has a silence available to them.</small>

''bool'' '''HasInvisibility'''( ''bCurrentlyAvailable'' )
:<small>Returns whether the unit has an invisibility-causing item or ability available to them.</small>

''bool'' '''UsingItemBreaksInvisibility'''()
:<small>Returns whether using an item would break the unit's invisibility.</small>


''{ hUnit, ... }'' '''GetNearbyHeroes'''( ''nRadius'', ''bEnemies'', ''[[#Bot_Modes|nMode]]'')
:<small>Returns a table of heroes, sorted closest-to-furthest, that are in the specified mode.  If nMode is BOT_MODE_NONE, searches for all heroes.  If bEnemies is true, nMode must be BOT_MODE_NONE.  nRadius must be less than 1600.</small>

''{ hUnit, ... }'' '''GetNearbyCreeps'''( ''nRadius'', ''bEnemies'' )
:<small>Returns a table of creeps, sorted closest-to-furthest.  nRadius must be less than 1600.</small>

''{ hUnit, ... }'' '''GetNearbyLaneCreeps'''( ''nRadius'', ''bEnemies'' )
:<small>Returns a table of lane creeps, sorted closest-to-furthest.  nRadius must be less than 1600.</small>

''{ hUnit, ... }'' '''GetNearbyNeutralCreeps'''( ''nRadius'' )
:<small>Returns a table of neutral creeps, sorted closest-to-furthest.  nRadius must be less than 1600.</small>

''{ hUnit, ... }'' '''GetNearbyTowers'''( ''nRadius'', ''bEnemies'' )
:<small>Returns a table of towers, sorted closest-to-furthest.  nRadius must be less than 1600.</small>

''{ hUnit, ... }'' '''GetNearbyBarracks'''( ''nRadius'', ''bEnemies'' )
:<small>Returns a table of barracks, sorted closest-to-furthest.  nRadius must be less than 1600.</small>

''{ hUnit, ... }'' '''GetNearbyShrines'''( ''nRadius'', ''bEnemies'' )
:<small>Returns a table of shrines, sorted closest-to-furthest.  nRadius must be less than 1600.</small>

''{ int, ... }'' '''GetNearbyTrees '''( ''nRadius'' )
:<small>Returns a table of Tree IDs, sorted closest-to-furthest.  nRadius must be less than 1600.</small>


''{ int count, vector targetloc }'' '''FindAoELocation'''( ''bEnemies, bHeroes, vBaseLocation, nMaxDistanceFromBase, nRadius, fTimeInFuture, nMaxHealth)
:<small>Gets the optimal location for AoE to hit the maximum number of units described by the parameters.  Returns a table containing the values ''targetloc'' that is a vector for the center of the AoE and ''count'' that will be equal to the number of units within the AoE that mach the description.</small>


''vector'' '''GetExtrapolatedLocation'''( ''fTime'' )
:<small>Returns the extrapolated location of the unit fTime seconds into the future, based on its current movement.</small>

''float'' '''GetMovementDirectionStability'''()
:<small>Returns how stable the direction of the unit's movement is -- a value of 1.0 means they've been moving in a straight line for a while, where 0.0 is completely random movement.</small>

''bool'' '''HasModifier'''( ''sModifierName'' )
:<small>Returns whether the unit has the specified modifer.</small>

''int'' '''GetModifierByName'''( ''sModifierName'' )
:<small>Returns the modifier index for the specified modifier.</small>

''int'' '''NumModifiers'''()
:<small>Returns the number of modifiers on the unit.</small>

''int'' '''GetModifierName'''( ''nModifier'' )
:<small>Returns the name of the specified modifier.</small>

''int'' '''GetModifierStackCount'''( ''nModifier'' )
:<small>Returns stack count of the specified modifier.</small>

''int'' '''GetModifierRemainingDuration'''( ''nModifier'' )
:<small>Returns remaining duration of the specified modifier.</small>

''int'' '''GetModifierAuxiliaryUnits'''( ''nModifier'' )
:<small>Returns a table containing handles to units that the modifier is responsible for, such as Ember Spirit remnants.</small>

''{time, location, normal_ping}'' '''GetMostRecentPing'''()
:<small>Returns a table containing the time and location of the unit's most recent ping, and whether it was a normal or danger ping.</small>


''{ { location, caster, player, ability, is_dodgeable, is_attack }, ... }'' '''GetIncomingTrackingProjectiles'''()
:<small>Returns information about all projectiles incoming towards this unit.</small>

<br>

==== Ability-Scoped ====
* CanAbilityBeUpgraded
* GetAbilityDamage
* GetAutoCastState
* GetBehavior
* GetCaster
* GetCastPoint
* GetCastRange
* GetChannelledManaCostPerSecond
* GetChannelTime
* GetDuration
* GetCooldownTimeRemaining  - Only works on yourself and allies
* GetCurrentCharges
* GetDamageType
* GetHeroLevelRequiredToUpgrade
* GetInitialCharges
* GetLevel
* GetManaCost
* GetMaxLevel
* GetName
* GetSecondaryCharges
* GetSpecialValueFloat
* GetSpecialValueInt
* GetTargetFlags
* GetTargetTeam
* GetTargetType
* GetToggleState
* IsActivated
* IsAttributeBonus
* IsChanneling
* IsCooldownReady  - Only works on yourself and allies
* IsFullyCastable
* IsHidden
* IsInAbilityPhase
* IsItem
* IsOwnersManaEnough
* IsPassive
* IsStealable
* IsStolen
* IsToggle
* IsTrained
* ProcsMagicStick
* ToggleAutoCast

''- Item Only Functions''
* CanBeDisassembled
* IsCombineLocked

== Bot Difficulties ==

There are six bot difficulties:

==== Passive ====
* Cannot use abilities or items or the courier.
* Will always remain in laning mode.
* When attempting to last hit creeps, their estimation of the best time to land the attack randomly varies by 0.4 seconds.
* When attempting to last hit allied creeps, their estimation of the best time to land the attack randomly varies by 0.2 seconds.

==== Easy ====
* Ability and item usage gets a random delay of 0.5 to 1.0 seconds
* Every 8 seconds, ability and item usage is disallowed for 6 seconds.
* Whenever an ability or item is used, ability and item usage is disallowed for 6 seconds.
* When attempting to last hit enemy creeps, their estimation of the best time to land the attack randomly varies by 0.4 seconds.
* When attempting to last hit allied creeps, their estimation of the best time to land the attack randomly varies by 0.2 seconds.

==== Medium ====
* Ability and item usage gets a random delay of 0.3 to 0.6 seconds
* Every 10 seconds, ability and item usage is disallowed for 3 seconds.
* Whenever an ability or item is used, ability and item usage is disallowed for 3 seconds.
* When attempting to last hit creeps, their estimation of the best time to land the attack randomly varies by 0.2 seconds.
* When attempting to last hit allied creeps, their estimation of the best time to land the attack randomly varies by 0.1 seconds.

==== Hard ====
* Ability and item usage gets a random delay of 0.1 to 0.2 seconds.

==== Unfair ====
* Ability and item usage gets a random delay of 0.075 to 0.15 seconds.
* XP and Gold earned gets a 25% bonus.

==== New Player ====

== Debugging == 
There are a number of commands that help you debug what's happening with bots.

<br />
''dota_bot_debug_team''
Brings up a panel for the specified team (2 is Radiant, 3 is Dire) that displays:
* Team-level desires for pushing/defending/farming lanes, and Roshan.
* Bot names and levels
* Bot current and maximum "power" levels (see Appendex D for how power levels are calculated).  Can be disabled with "dota_bot_debug_team_power 0".
* Active modes, and those mode desires.
* All modes for a bot ( individually collapsable), and each of those modes' desires.
* Current bot action along with that action's target if applicable.
* Total bot execution time for the overall team calculations, and each individual bot.

It additionally enables the line-sphere rendering of dota_bot_select_debug for all bots on the specified team.

<br />
''dota_bot_debug_grid''<br />
''dota_bot_debug_grid_cycle''<br />
''dota_bot_debug_minimap''<br />
''dota_bot_debug_minimap_cycle''<br />

Causes a grid to draw on the world or the minimap.  The *_cycle variants just cycle through all the values, whereas the other commands just set the mode directly.
* 0 - Off
* 1 - Radiant avoidance
* 2 - Dire avoidance
* 3 - Potential enemy locations for the Radiant
* 4 - Potential enemy locations for the Dire
* 5 - Enemy visibility to the Radiant
* 6 - Enemy visibility to the Dire
* 7 - Height Values
* 8 - Passability

<br />
''dota_bot_select_debug''

Activates the following displays on the under-the-cursor bot:
* The current mode and action of the selected bot.  
* A white line-sphere list to it current pathfind.
* A blue line-sphere to its current laning last-hit target.
* A red line-sphere to its current attack target.

<br />
''dota_bot_select_debug_attack''

Displays how much the under-the-cursor bot wants to attack any nearby enemies.

<br />
''dota_bot_debug_clear''

Clears the dota_bot_select_debug and dota_bot_select_debug_attack states of the under-the-cursor bot.

<br />
''dota_bot_debug_lanes''

Shows the path of all of the lanes, along with a sphere at the "lane front".

<br />
''dota_bot_debug_ward_locations''

Shows small yellow spheres at each of ward locations the bots will consider.

<br />
''dump_modifier_list''

Dumps a reference list of all modifier names.

== Potential Locations ==

One of the utility functions available to bot scripts is GetUnitPotentialValue(), which returns a value between 0 and 255 that represents an estimation of how likely it is that a hero is within the specified radius of the specified location.  This value is based the potential location grid that is updated during bot games.  
<br /><br />
It works like this:  
* When a team loses visibility of that hero, there's a floodfill that starts through the passable areas of the map, moving at the movement speed of that missing hero.  
* The intensity of the "potential location" starts out high, and then decreases as the potential location becomes larger and more diffuse.  
* This floodfill happens for each enemy hero independently.
<br /><br />
This does have some limitations:
* It doesn't take into account heroes that teleport or otherwise have speed/movement bursts (Lycan's wolf form, AM's blinking, etc)
* It doesn't include any logic about why a hero is missing or where they've gone -- it assumes an equal chance of a hero moving in any direction under FoW
<br /><br />
Still, it can be useful for some decisionmaking, especially when the potential location values are high.  You obviously don't want to stop considering a hero nearby the moment you lose sight of them, so using the potential location grid to help evaluate how dangerous a location is can be helpful.

== Hero Power ==
It's often useful to understand how powerful a teammate bot is, or how dangerous an enemy is.  One rough estimate is the Hero Power concept, which is updated for each hero each frame.
<br /><br />
Here is how it's calculated (done per-hero):
* For each enemy hero, calculate the amount of damage done over a time interval to that enemy hero.
* That time interval is defined as 5 seconds, plus the duration that the hero can stun a unit, plus half the duration that the hero can slow a unit.
* That damage includes both attacking for that duration, plus damage done by abilities.
* Attack damage includes procs as well as debuffs.
* Ability damage is based on available mana, cast time, cooldowns, silence status, etc.
* That damage is then averaged over all enemy heroes.
<br />
Additionally, we calculate each hero's Raw Power as well, which ignores all cooldowns and hero state (mana, debuffs, etc).  It's more a representation of how powerful a hero theoretically is than how powerful they are at any given moment.
<br /><br />
Note that this is an indicator of offensive power only, not tankiness or durability.
<br /><br />
GetRawOffensivePower() can be called on teammates or enemies that you can see.
GetOffensivePower() can be called only on teammates.

== Appendix A - Chaining to a generic implementation in Lua ==

If you're implementing a generic version of a mode or ability/item usage, you should add this code to the bottom of your generic file (adjusting the name of the module appropriately, and including the functions you want to be callable from hero-specific classes):

{| class="wikitable"
|-
| BotsInit = require( "game/botsinit" );<br>
local MyModule = BotsInit.CreateGeneric();<br>
MyModule.OnStart = OnStart;<br>
MyModule.OnEnd = OnEnd;<br>
MyModule.Think = Think;<br>
MyModule.GetDesire = GetDesire;<br>
return MyModule;<br>
|}

Then in your hero-specific implementation, you can start your file with this:

{| class="wikitable"
|-
| mode_defend_ally_generic = dofile( GetScriptDirectory().."/mode_defend_ally_generic" )
|}

which allows you to do things like the following in your bot-specific code:

{| class="wikitable"
|-
| mode_defend_ally_generic.OnStart();
|}

== Appendix B - List of available constants == 

=== Bot Modes === 

* BOT_MODE_NONE
* BOT_MODE_LANING
* BOT_MODE_ATTACK
* BOT_MODE_ROAM
* BOT_MODE_RETREAT
* BOT_MODE_SECRET_SHOP
* BOT_MODE_SIDE_SHOP
* BOT_MODE_PUSH_TOWER_TOP
* BOT_MODE_PUSH_TOWER_MID
* BOT_MODE_PUSH_TOWER_BOT
* BOT_MODE_DEFEND_TOWER_TOP
* BOT_MODE_DEFEND_TOWER_MID
* BOT_MODE_DEFEND_TOWER_BOT
* BOT_MODE_ASSEMBLE
* BOT_MODE_TEAM_ROAM
* BOT_MODE_FARM
* BOT_MODE_DEFEND_ALLY
* BOT_MODE_EVASIVE_MANEUVERS
* BOT_MODE_ROSHAN
* BOT_MODE_ITEM
* BOT_MODE_WARD

=== Action Desires ===

These can be useful for making sure all action desires are using a common language for talking about their desire.

* BOT_ACTION_DESIRE_NONE - 0.0
* BOT_ACTION_DESIRE_VERYLOW - 0.1
* BOT_ACTION_DESIRE_LOW - 0.25
* BOT_ACTION_DESIRE_MODERATE - 0.5
* BOT_ACTION_DESIRE_HIGH - 0.75
* BOT_ACTION_DESIRE_VERYHIGH - 0.9
* BOT_ACTION_DESIRE_ABSOLUTE - 1.0

=== Mode Desires ===

These can be useful for making sure all mode desires as using a common language for talking about their desire.

* BOT_MODE_DESIRE_NONE - 0
* BOT_MODE_DESIRE_VERYLOW - 0.1
* BOT_MODE_DESIRE_LOW - 0.25
* BOT_MODE_DESIRE_MODERATE - 0.5
* BOT_MODE_DESIRE_HIGH - 0.75
* BOT_MODE_DESIRE_VERYHIGH - 0.9
* BOT_MODE_DESIRE_ABSOLUTE - 1.0

=== Damage Types === 

* DAMAGE_TYPE_PHYSICAL
* DAMAGE_TYPE_MAGICAL
* DAMAGE_TYPE_PURE
* DAMAGE_TYPE_ALL

=== Unit Types ===

* UNIT_LIST_ALL
* UNIT_LIST_ALLIES
* UNIT_LIST_ALLIED_HEROES
* UNIT_LIST_ALLIED_CREEPS
* UNIT_LIST_ALLIED_WARDS
* UNIT_LIST_ALLIED_BUILDINGS
* UNIT_LIST_ENEMIES
* UNIT_LIST_ENEMY_HEROES
* UNIT_LIST_ENEMY_CREEPS
* UNIT_LIST_ENEMY_WARDS
* UNIT_LIST_NEUTRAL_CREEPS
* UNIT_LIST_ENEMY_BUILDINGS

=== Difficulties ===

* DIFFICULTY_INVALID
* DIFFICULTY_PASSIVE
* DIFFICULTY_EASY
* DIFFICULTY_MEDIUM
* DIFFICULTY_HARD
* DIFFICULTY_UNFAIR

=== Attribute Types ===

* ATTRIBUTE_INVALID
* ATTRIBUTE_STRENGTH
* ATTRIBUTE_AGILITY
* ATTRIBUTE_INTELLECT

=== Item Purchase Results === 

* PURCHASE_ITEM_SUCCESS
* PURCHASE_ITEM_OUT_OF_STOCK
* PURCHASE_ITEM_DISALLOWED_ITEM
* PURCHASE_ITEM_INSUFFICIENT_GOLD
* PURCHASE_ITEM_NOT_AT_HOME_SHOP
* PURCHASE_ITEM_NOT_AT_SIDE_SHOP
* PURCHASE_ITEM_NOT_AT_SECRET_SHOP
* PURCHASE_ITEM_INVALID_ITEM_NAME

=== Game Modes === 

* GAMEMODE_NONE
* GAMEMODE_AP
* GAMEMODE_CM
* GAMEMODE_RD
* GAMEMODE_SD
* GAMEMODE_AR
* GAMEMODE_REVERSE_CM
* GAMEMODE_MO
* GAMEMODE_CD
* GAMEMODE_ABILITY_DRAFT
* GAMEMODE_ARDM
* GAMEMODE_1V1MID
* GAMEMODE_ALL_DRAFT  (aka Ranked All Pick)

=== Teams ===

* TEAM_RADIANT
* TEAM_DIRE
* TEAM_NEUTRAL
* TEAM_NONE

=== Lanes === 

* LANE_NONE
* LANE_TOP
* LANE_MID
* LANE_BOT

=== Game States === 

* GAME_STATE_INIT
* GAME_STATE_WAIT_FOR_PLAYERS_TO_LOAD
* GAME_STATE_HERO_SELECTION
* GAME_STATE_STRATEGY_TIME
* GAME_STATE_PRE_GAME
* GAME_STATE_GAME_IN_PROGRESS
* GAME_STATE_POST_GAME
* GAME_STATE_DISCONNECT
* GAME_STATE_TEAM_SHOWCASE
* GAME_STATE_CUSTOM_GAME_SETUP
* GAME_STATE_WAIT_FOR_MAP_TO_LOAD
* GAME_STATE_LAST

=== Hero Pick States === 

* HEROPICK_STATE_NONE
* HEROPICK_STATE_AP_SELECT
* HEROPICK_STATE_SD_SELECT
* HEROPICK_STATE_CM_INTRO
* HEROPICK_STATE_CM_CAPTAINPICK
* HEROPICK_STATE_CM_BAN1
* HEROPICK_STATE_CM_BAN2
* HEROPICK_STATE_CM_BAN3
* HEROPICK_STATE_CM_BAN4
* HEROPICK_STATE_CM_BAN5
* HEROPICK_STATE_CM_BAN6
* HEROPICK_STATE_CM_BAN7
* HEROPICK_STATE_CM_BAN8
* HEROPICK_STATE_CM_BAN9
* HEROPICK_STATE_CM_BAN10
* HEROPICK_STATE_CM_SELECT1
* HEROPICK_STATE_CM_SELECT2
* HEROPICK_STATE_CM_SELECT3
* HEROPICK_STATE_CM_SELECT4
* HEROPICK_STATE_CM_SELECT5
* HEROPICK_STATE_CM_SELECT6
* HEROPICK_STATE_CM_SELECT7
* HEROPICK_STATE_CM_SELECT8
* HEROPICK_STATE_CM_SELECT9
* HEROPICK_STATE_CM_SELECT10
* HEROPICK_STATE_CM_PICK
* HEROPICK_STATE_AR_SELECT
* HEROPICK_STATE_MO_SELECT
* HEROPICK_STATE_FH_SELECT
* HEROPICK_STATE_CD_INTRO
* HEROPICK_STATE_CD_CAPTAINPICK
* HEROPICK_STATE_CD_BAN1
* HEROPICK_STATE_CD_BAN2
* HEROPICK_STATE_CD_BAN3
* HEROPICK_STATE_CD_BAN4
* HEROPICK_STATE_CD_BAN5
* HEROPICK_STATE_CD_BAN6
* HEROPICK_STATE_CD_SELECT1
* HEROPICK_STATE_CD_SELECT2
* HEROPICK_STATE_CD_SELECT3
* HEROPICK_STATE_CD_SELECT4
* HEROPICK_STATE_CD_SELECT5
* HEROPICK_STATE_CD_SELECT6
* HEROPICK_STATE_CD_SELECT7
* HEROPICK_STATE_CD_SELECT8
* HEROPICK_STATE_CD_SELECT9
* HEROPICK_STATE_CD_SELECT10
* HEROPICK_STATE_CD_PICK
* HEROPICK_STATE_BD_SELECT
* HERO_PICK_STATE_ABILITY_DRAFT_SELECT
* HERO_PICK_STATE_ARDM_SELECT
* HEROPICK_STATE_ALL_DRAFT_SELECT
* HERO_PICK_STATE_CUSTOMGAME_SELECT
* HEROPICK_STATE_SELECT_PENALTY

=== Rune Types ===
* RUNE_INVALID (used as return value)
* RUNE_DOUBLEDAMAGE
* RUNE_HASTE
* RUNE_ILLUSION
* RUNE_INVISIBILITY
* RUNE_REGENERATION
* RUNE_BOUNTY
* RUNE_ARCANE

=== Rune Status ===

* RUNE_STATUS_UNKNOWN
* RUNE_STATUS_AVAILABLE
* RUNE_STATUS_MISSING

=== Rune Locations ===

* RUNE_POWERUP_1
* RUNE_POWERUP_2
* RUNE_BOUNTY_1
* RUNE_BOUNTY_2
* RUNE_BOUNTY_3
* RUNE_BOUNTY_4

=== Item Slot Types ===

* ITEM_SLOT_TYPE_INVALID
* ITEM_SLOT_TYPE_MAIN
* ITEM_SLOT_TYPE_BACKPACK
* ITEM_SLOT_TYPE_STASH

=== Action Types ===

* BOT_ACTION_TYPE_NONE
* BOT_ACTION_TYPE_IDLE
* BOT_ACTION_TYPE_MOVE_TO
* BOT_ACTION_TYPE_MOVE_TO_DIRECTLY
* BOT_ACTION_TYPE_ATTACK
* BOT_ACTION_TYPE_ATTACKMOVE
* BOT_ACTION_TYPE_USE_ABILITY
* BOT_ACTION_TYPE_PICK_UP_RUNE
* BOT_ACTION_TYPE_PICK_UP_ITEM
* BOT_ACTION_TYPE_DROP_ITEM
* BOT_ACTION_TYPE_SHRINE
* BOT_ACTION_TYPE_DELAY

=== Courier Actions and States ===

* COURIER_ACTION_BURST
* COURIER_ACTION_ENEMY_SECRET_SHOP
* COURIER_ACTION_RETURN
* COURIER_ACTION_SECRET_SHOP
* COURIER_ACTION_SIDE_SHOP
* COURIER_ACTION_SIDE_SHOP2
* COURIER_ACTION_TAKE_STASH_ITEMS
* COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS
* COURIER_ACTION_TRANSFER_ITEMS

* COURIER_STATE_IDLE
* COURIER_STATE_AT_BASE
* COURIER_STATE_MOVING
* COURIER_STATE_DELIVERING_ITEMS
* COURIER_STATE_RETURNING_TO_BASE
* COURIER_STATE_DEAD

=== Towers ===

* TOWER_TOP_1
* TOWER_TOP_2
* TOWER_TOP_3
* TOWER_MID_1
* TOWER_MID_2
* TOWER_MID_3
* TOWER_BOT_1
* TOWER_BOT_2
* TOWER_BOT_3
* TOWER_BASE_1
* TOWER_BASE_2

=== Barracks ===

* BARRACKS_TOP_MELEE
* BARRACKS_TOP_RANGED
* BARRACKS_MID_MELEE
* BARRACKS_MID_RANGED
* BARRACKS_BOT_MELEE
* BARRACKS_BOT_RANGED

=== Shrines ===

* SHRINE_BASE_1
* SHRINE_BASE_2
* SHRINE_BASE_3
* SHRINE_BASE_4
* SHRINE_BASE_5
* SHRINE_JUNGLE_1
* SHRINE_JUNGLE_2

=== Shops ===

* SHOP_HOME
* SHOP_SIDE
* SHOP_SECRET
* SHOP_SIDE2
* SHOP_SECRET2

=== Ability Target Teams ===

* ABILITY_TARGET_TEAM_NONE
* ABILITY_TARGET_TEAM_FRIENDLY
* ABILITY_TARGET_TEAM_ENEMY

=== Ability Target Types ===

* ABILITY_TARGET_TYPE_NONE
* ABILITY_TARGET_TYPE_HERO
* ABILITY_TARGET_TYPE_CREEP
* ABILITY_TARGET_TYPE_BUILDING
* ABILITY_TARGET_TYPE_COURIER
* ABILITY_TARGET_TYPE_OTHER
* ABILITY_TARGET_TYPE_TREE
* ABILITY_TARGET_TYPE_BASIC
* ABILITY_TARGET_TYPE_ALL

=== Ability Target Flags ===

* ABILITY_TARGET_FLAG_NONE
* ABILITY_TARGET_FLAG_RANGED_ONLY
* ABILITY_TARGET_FLAG_MELEE_ONLY
* ABILITY_TARGET_FLAG_DEAD
* ABILITY_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
* ABILITY_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES
* ABILITY_TARGET_FLAG_INVULNERABLE
* ABILITY_TARGET_FLAG_FOW_VISIBLE
* ABILITY_TARGET_FLAG_NO_INVIS
* ABILITY_TARGET_FLAG_NOT_ANCIENTS
* ABILITY_TARGET_FLAG_PLAYER_CONTROLLED
* ABILITY_TARGET_FLAG_NOT_DOMINATED
* ABILITY_TARGET_FLAG_NOT_SUMMONED
* ABILITY_TARGET_FLAG_NOT_ILLUSIONS
* ABILITY_TARGET_FLAG_NOT_ATTACK_IMMUNE
* ABILITY_TARGET_FLAG_MANA_ONLY
* ABILITY_TARGET_FLAG_CHECK_DISABLE_HELP
* ABILITY_TARGET_FLAG_NOT_CREEP_HERO
* ABILITY_TARGET_FLAG_OUT_OF_WORLD
* ABILITY_TARGET_FLAG_NOT_NIGHTMARED
* ABILITY_TARGET_FLAG_PREFER_ENEMIES

=== Ability Behavior Bitfields ===
* ABILITY_BEHAVIOR_NONE					
* ABILITY_BEHAVIOR_HIDDEN				
* ABILITY_BEHAVIOR_PASSIVE				
* ABILITY_BEHAVIOR_NO_TARGET				
* ABILITY_BEHAVIOR_UNIT_TARGET			
* ABILITY_BEHAVIOR_POINT					
* ABILITY_BEHAVIOR_AOE					
* ABILITY_BEHAVIOR_NOT_LEARNABLE			
* ABILITY_BEHAVIOR_CHANNELLED			
* ABILITY_BEHAVIOR_ITEM					
* ABILITY_BEHAVIOR_TOGGLE				
* ABILITY_BEHAVIOR_DIRECTIONAL			
* ABILITY_BEHAVIOR_IMMEDIATE				
* ABILITY_BEHAVIOR_AUTOCAST				
* ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET	
* ABILITY_BEHAVIOR_OPTIONAL_POINT		
* ABILITY_BEHAVIOR_OPTIONAL_NO_TARGET	
* ABILITY_BEHAVIOR_AURA					
* ABILITY_BEHAVIOR_ATTACK				
* ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT	
* ABILITY_BEHAVIOR_ROOT_DISABLES			
* ABILITY_BEHAVIOR_UNRESTRICTED			
* ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE	
* ABILITY_BEHAVIOR_IGNORE_CHANNEL		
* ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT  
* ABILITY_BEHAVIOR_DONT_ALERT_TARGET		
* ABILITY_BEHAVIOR_DONT_RESUME_ATTACK	
* ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN	
* ABILITY_BEHAVIOR_IGNORE_BACKSWING		
* ABILITY_BEHAVIOR_RUNE_TARGET			
* ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL	
* ABILITY_BEHAVIOR_VECTOR_TARGETING		
* ABILITY_BEHAVIOR_LAST_RESORT_POINT		

=== Misc Constants ===
* GLYPH_COOLDOWN

=== Animation Activities ===
* ACTIVITY_IDLE
* ACTIVITY_IDLE_RARE
* ACTIVITY_RUN
* ACTIVITY_ATTACK
* ACTIVITY_ATTACK2
* ACTIVITY_ATTACK_EVENT
* ACTIVITY_DIE
* ACTIVITY_FLINCH
* ACTIVITY_FLAIL
* ACTIVITY_DISABLED
* ACTIVITY_CAST_ABILITY_1
* ACTIVITY_CAST_ABILITY_2
* ACTIVITY_CAST_ABILITY_3
* ACTIVITY_CAST_ABILITY_4
* ACTIVITY_CAST_ABILITY_5
* ACTIVITY_CAST_ABILITY_6
* ACTIVITY_OVERRIDE_ABILITY_1
* ACTIVITY_OVERRIDE_ABILITY_2
* ACTIVITY_OVERRIDE_ABILITY_3
* ACTIVITY_OVERRIDE_ABILITY_4
* ACTIVITY_CHANNEL_ABILITY_1
* ACTIVITY_CHANNEL_ABILITY_2
* ACTIVITY_CHANNEL_ABILITY_3
* ACTIVITY_CHANNEL_ABILITY_4
* ACTIVITY_CHANNEL_ABILITY_5
* ACTIVITY_CHANNEL_ABILITY_6
* ACTIVITY_CHANNEL_END_ABILITY_1
* ACTIVITY_CHANNEL_END_ABILITY_2
* ACTIVITY_CHANNEL_END_ABILITY_3
* ACTIVITY_CHANNEL_END_ABILITY_4
* ACTIVITY_CHANNEL_END_ABILITY_5
* ACTIVITY_CHANNEL_END_ABILITY_6
* ACTIVITY_CONSTANT_LAYER
* ACTIVITY_CAPTURE
* ACTIVITY_SPAWN
* ACTIVITY_KILLTAUNT
* ACTIVITY_TAUNT
