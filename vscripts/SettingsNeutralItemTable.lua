	-- Default neutral items table, returns the table, so use 
	-- local <x> = require 'SettingsNeutralItemTable' to include in another file.
	
local	neutrals = 
{
	{name = 'item_mana_draught', 					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Mana Draught'},
	{name = 'item_trusty_shovel',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Trusty Shovel'},
	{name = 'item_unstable_wand',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Pig Pole"},
	{name = 'item_occult_bracelet',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Occult Bracelet"},	
    {name = 'item_spark_of_courage',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Spark of Courage"},
	{name = 'item_orb_of_destruction', 		tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Orb of Destruction'},
	{name = 'item_polliwog_charm', 		tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Polliwog Charm'},
	{name = 'item_rippers_lash', 		tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Rippers Lash'},

	-- tier 2
    {name = 'item_iron_talon', 						tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Iron Talon'},
	{name = 'item_essence_ring', 					tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Essence Ring'},
    {name = 'item_gossamer_cape', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Gossamer Cape'},
    {name = 'item_searing_signet', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Searing Signet'},
    {name = 'item_pogo_stick', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Tumblers Toy'},
    {name = 'item_misericorde', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Brigands Blade'},

	-- tier 3
	{name = 'item_whisper_of_the_dread', 		tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Whisper of the Dread'},
    {name = 'item_ninja_gear', 						tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ninja Gear'},
    {name = 'item_nemesis_curse',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Nemesis Curse'},
    {name = 'item_serrated_shiv',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Serrated Shiv'},
    {name = 'item_gale_guard',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Gale Guard'},
    {name = 'item_gunpowder_gauntlets',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Gunpowder Gauntlets'},

	-- tier 4
    {name = 'item_mind_breaker', 					tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Mind Breaker'},
    {name = 'item_ogre_seal_totem',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ogre Seal Totem'},
    {name = 'item_ceremonial_robe',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Ceremonial Cloak'},
    {name = 'item_crippling_crossbow',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Crippling Crossbow'},
    {name = 'item_magnifying_monocle',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Magnifying Monocle'},
    {name = 'item_pyrrhic_cloak',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Pyrrhic Cloak'},

	-- tier 5                                                                    		
	{name = 'item_pirate_hat',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Pirate Hat'},
	{name = 'item_demonicon', 						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Book of the Dead'},
	{name = 'item_fallen_sky', 					  tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Fallen Sky'},
	{name = 'item_desolator_2',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Stygian Desolator'},
    {name = 'item_panic_button', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Magic Lamp'},
    {name = 'item_spider_legs', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Spider Legs'},
    {name = 'item_unrelenting_eye', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Unrelenting Eye'},
    {name = 'item_minotaur_horn', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Minotaur Horn'},
}

return neutrals