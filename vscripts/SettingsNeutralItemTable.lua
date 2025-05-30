	-- Default neutral items table, returns the table, so use 
	-- local <x> = require 'SettingsNeutralItemTable' to include in another file.
	
local	neutrals = 
{
	{name = 'item_occult_bracelet', 					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Occult Bracelet'},
	{name = 'item_spark_of_courage',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Spark Of Courage'},
	{name = 'item_polliwog_charm',					tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Polliwog Charm"},
	{name = 'item_rippers_lash',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Ripper's Lash"},	
    {name = 'item_chipped_vest',				tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = "Chipped Vest"},
	{name = 'item_dormant_curio', 		tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Dormant Curio'},
	{name = 'item_kobold_cup', 		tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Kobold Cup'},
	{name = 'item_sisters_shroud', 		tier = 1, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Sisters Shroud'},

	-- tier 2
    {name = 'item_essence_ring', 						tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Essence Ring'},
	{name = 'item_searing_signet', 					tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Searing Signet'},
    {name = 'item_misericorde', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Brigand Balde'},
    {name = 'item_pogo_stick', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Tumbler Toy'},
    {name = 'item_mana_draught', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Mana Draught'},
    {name = 'item_poor_mans_shield', 		tier = 2, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Poor Man Shield'},

	-- tier 3
	{name = 'item_psychic_headband', 		tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Psychic Headband'},
    {name = 'item_whisper_of_the_dread', 						tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Whisper of the Dread'},
    {name = 'item_serrated_shiv',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Serrrated Shiv'},
    {name = 'item_gale_guard',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Gale Guard'},
    {name = 'item_gunpowder_gauntlets',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Gunpowder Gauntlet'},
    {name = 'item_jidi_pollen_bag',				tier = 3, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Jidi Pollen Bag'},

	-- tier 4
    {name = 'item_crippling_crossbow', 					tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Crippling Crossbow'},
    {name = 'item_magnifying_monocle',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Magnifying Monocle'},
    {name = 'item_pyrrhic_cloak',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Pyrrhic Cloak'},
    {name = 'item_dezun_bloodrite',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Dezun Bloodrite'},
    {name = 'item_giant_maul',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Giant Maul'},
    {name = 'item_outworld_staff',				tier = 4, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Outworld Staff'},

	-- tier 5                                                                    		
	{name = 'item_desolator_2',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Stygian Desolator'},
	{name = 'item_demonicon', 						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Book of the Dead'},
	{name = 'item_fallen_sky', 					  tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Fallen Sky'},
	{name = 'item_minotaur_horn',						tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Minotaur Horn'},
    {name = 'item_spider_legs', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Spider Legs'},
    {name = 'item_unrelenting_eye', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Unrelenting Eye'},
    {name = 'item_divine_regalia', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Divine Regalia'},
    {name = 'item_helm_of_the_undying', 					tier = 5, ranged = 1, 	melee = 1,		roles={7,7,7,7,7}, realName = 'Helm of the Undying'},
}

return neutrals