	-- Default neutral items table, returns the table, so use 
	-- local <x> = require 'SettingsNeutralItemTable' to include in another file.
	
local	neutrals = 
{ 
	--                                              roles= 1,2,3,4,5
	{name = 'item_arcane_ring', 					tier = 1, ranged = 1, 	melee = 1, 		roles={7,7,7,7,7}, realName = 'Arcane Ring'},
	{name = 'item_broom_handle', 					tier = 1, ranged = 0, 	melee = 2,		roles={7,7,7,7,7}, realName = 'Broom Handle'},
	{name = 'item_faded_broach', 					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Faded Broach'},
	--{name = 'item_keen_optic', 						tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Keen Optic'},
	-- Just going to comment out items we don't want entirely rather than force the code to do a rollup on the roles count
	--{name = 'item_mango_tree', 						tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Mango Tree'},
	--{name = 'item_ocean_heart',						tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ocean Heart'},
	--{name = 'item_poor_mans_shield',			tier = 1, ranged = 1, 	melee = 3,		roles={7,7,7,7,7}, realName = "Poor Man's Shield"},
-- 	{name = 'item_royal_jelly', 					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Royal Jelly'},
--     {name = 'item_safety_bubble', 					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Safety Bubble'},
	--{name = 'item_trusty_shovel',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Trusty Shovel'},
	{name = 'item_ironwood_tree',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ironwood Tree'},
	--{name = 'item_chipped_vest',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Chipped Vest'},	
	--{name = 'item_possessed_mask',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Possessed Mask'},
-- 	{name = 'item_mysterious_hat',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Fairy's Trinket"},
	{name = 'item_unstable_wand',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Pig Pole"},	
-- 	{name = 'item_pogo_stick',						tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Tumbler's Toy"},
	{name = 'item_seeds_of_serenity',			tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Seeds of Serenity"},	
	{name = 'item_lance_of_pursuit',			tier = 1, ranged = 1, 	melee = 3,		roles={7,7,7,7,7}, realName = "Lance of Pursuit"},	
	{name = 'item_occult_bracelet',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Occult Bracelet"},	
    {name = 'item_spark_of_courage',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Spark of Courage"},
	{name = 'item_duelist_gloves',				tier = 1, ranged = 1, 	melee = 2,		roles={7,7,7,7,7}, realName = "Duelist Gloves"},

	-- tier 2                                                                    		
	{name = 'item_dragon_scale', 					tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Dragon Scale'},
    {name = 'item_iron_talon', 						tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Iron Talon'},
	--{name = 'item_essence_ring', 					tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Essence Ring'},
	{name = 'item_grove_bow', 						tier = 2, ranged = 2, 	melee = 0,		roles={7,7,7,7,7}, realName = 'Grove Bow'},
	--{name = 'item_imp_claw', 							tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Imp Claw'},
	--{name = 'item_nether_shawl', 					tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Nether Shawl'},
	{name = 'item_philosophers_stone', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Philosopher's Stone"},
	{name = 'item_pupils_gift',						tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Pupil's Gift"},
-- 	{name = 'item_ring_of_aquila', 				tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ring of Aquila'},
	{name = 'item_vampire_fangs',					tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Vampire Fangs'},
  --{name = 'item_clumsy_net', 						tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Clumsy Net'},	
  --{name = 'item_quicksilver_amulet',		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Quicksilver Amulet'},	
    {name = 'item_bullwhip',							tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Bullwhip'},
  --{name = 'item_paintball',							tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Fae Grenade'},	
  --{name = 'item_misericorde',						tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Brigand's Blade"},
	--{name = 'item_dagger_of_ristul',			tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Dagger of Ristul"},
	{name = 'item_specialists_array',			tier = 2, ranged = 2, 	melee = 0,		roles={7,7,7,7,7}, realName = "Specialist's Array"},
	{name = 'item_eye_of_the_vizier',			tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Eye of the Vizier"},
	{name = 'item_orb_of_destruction', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Orb of Destruction'},
    {name = 'item_gossamer_cape', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Gossamer Cape'},
    {name = 'item_light_collector', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Light Collector'},
    {name = 'item_whisper_of_the_dread', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Whisper of the Dread'},

	-- tier 3
	{name = 'item_craggy_coat', 					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Craggy Coat'},
	{name = 'item_enchanted_quiver', 			tier = 3, ranged = 3, 	melee = 0,		roles={7,7,7,7,7}, realName = 'Enchanted Quiver'},
    {name = 'item_vambrace',							tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Vambrace'},
	--{name = 'item_greater_faerie_fire', 	tier = 3, ranged = 1,		melee = 1,		roles={7,7,7,7,7}, realName = 'Greater Faerie Fire'},
	{name = 'item_paladin_sword',					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Paladin Sword'},
-- 	{name = 'item_quickening_charm',			tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Quickening Charm'},
	--{name = 'item_spider_legs', 					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Spider Legs'},
-- 	{name = 'item_titan_sliver',					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Titan Sliver'},
	--{name = 'item_repair_kit',				    tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Repair Kit'},
	{name = 'item_elven_tunic', 					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Elven Tunic'},
	{name = 'item_cloak_of_flames', 			tier = 3, ranged = 1, 	melee = 2,		roles={7,7,7,7,7}, realName = 'Cloak of Flames'},
	{name = 'item_ceremonial_robe', 			tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ceremonial Robe'},
	{name = 'item_psychic_headband', 			tier = 3, ranged = 3, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Psychic Headband'},
	--{name = 'item_black_powder_bag',			tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Blast Rig'},
    {name = 'item_vindicators_axe',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Vindicator's Axe"},
	{name = 'item_dandelion_amulet',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Dandelion Amulet'},
	{name = 'item_defiant_shell',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Defiant Shell'},
    {name = 'item_doubloon',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Doubloon'},
    {name = 'item_nemesis_curse',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Nemesis Curse'},
--     {name = 'item_unwavering_condition', 					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Unwavering Condition'},


	-- tier 4
    {name = 'item_mind_breaker', 					tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Mind Breaker'},
    {name = 'item_ogre_seal_totem',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ogre Seal Totem'},
    {name = 'item_spy_gadget', 						tier = 4, ranged = 2, 	melee = 0,		roles={7,7,7,7,7}, realName = 'Telescope'},
	--{name = 'item_flicker', 							tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Flicker'},
	{name = 'item_havoc_hammer', 					tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Havoc Hammer'},
	--{name = 'item_illusionsts_cape', 			tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Illusionist's Cape"},
	--{name = 'item_minotaur_horn', 				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Minotaur Horn'},
	{name = 'item_ninja_gear', 						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ninja Gear'},
	--{name = 'item_princes_knife',					tier = 4, ranged = 4, 	melee = 0,		roles={7,7,7,7,7}, realName = "Prince's Knife"},
-- 	{name = 'item_spell_prism',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Spell Prism'},
	--{name = 'item_the_leveller',					tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'The Leveller'},	
	{name = 'item_timeless_relic',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Timeless Relic'},	
	--{name = 'item_witless_shako',					tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Witless Shako'},	
-- 	{name = 'item_penta_edged_sword',			tier = 4, ranged = 1, 	melee = 5,		roles={7,7,7,7,7}, realName = 'Penta-Edged Sword'},
	{name = 'item_stormcrafter',					tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Stormcrafter'},	
	{name = 'item_trickster_cloak',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Trickster Cloak'},	
	{name = 'item_ascetic_cap',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Ascetic's Cap"},
--     {name = 'item_martyrs_plate',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Martyr's Blade"},
	--{name = 'item_heavy_blade',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Witchbane'},
    {name = 'item_ancient_guardian',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Ancient Guardian"},
    {name = 'item_avianas_feather',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Aviana's Feather"},
    {name = 'item_rattlecage',						tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Rattlecage"},

	-- tier 5                                                                    		
	{name = 'item_apex', 									tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Apex'},
	--{name = 'item_ballista', 							tier = 5, ranged = 5, 	melee = 0,		roles={7,7,7,7,7}, realName = 'Ballista'},
	{name = 'item_demonicon', 						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Book of the Dead'},
-- 	{name = 'item_ex_machina', 						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ex Machina'},
-- 	{name = 'item_fallen_sky', 					  tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Fallen Sky'},
	{name = 'item_force_boots', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Force Boots'},
	{name = 'item_mirror_shield',					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Mirror Shield'},
	{name = 'item_pirate_hat',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Pirate Hat'},
	{name = 'item_seer_stone', 						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Seer Stone'},
	{name = 'item_desolator_2',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Stygian Desolator'},	
	{name = 'item_giants_ring',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Giant's Ring"},	
	{name = 'item_book_of_shadows',				tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Book of Shadows'},	
	--{name = 'item_trident',				        tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Trident'},	
	--{name = 'item_woodland_striders',			tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Woodland Striders'},		
	{name = 'item_force_field',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Arcanist's Armor"},
    {name = 'item_panic_button', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Magic Lamp'},
}

return neutrals