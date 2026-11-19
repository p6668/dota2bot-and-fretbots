----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
----------------------------------------------------------------------------------------------------


local X = {}


local UltimateSet = {
    ['abaddon_borrowed_time'] = true,
    ['abyssal_underlord_dark_portal'] = true,
    ['alchemist_chemical_rage'] = true,
    ['ancient_apparition_ice_blast'] = true,
    ['antimage_mana_void'] = true,
    ['arc_warden_tempest_double'] = true,
    ['axe_culling_blade'] = true,
    ['bane_fiends_grip'] = true,
    ['batrider_flaming_lasso'] = true,
    ['beastmaster_primal_roar'] = true,
    ['bloodseeker_rupture'] = true,
    ['bounty_hunter_track'] = true,
    ['brewmaster_primal_split'] = true,
    ['bristleback_warpath'] = true,
    ['broodmother_spawn_spiderlings'] = true,
    ['centaur_stampede'] = true,
    ['chaos_knight_phantasm'] = true,
    ['chen_hand_of_god'] = true,
    ['clinkz_wind_walk'] = true,
    ['crystal_maiden_freezing_field'] = true,
    ['dark_seer_wall_of_replica'] = true,
    ['dark_willow_terrorize'] = true,
    ['dawnbreaker_solar_guardian'] = true,
    ['dazzle_nothl_projection'] = true,
    ['dazzle_nothl_projection_end'] = true,
    ['death_prophet_exorcism'] = true,
    ['disruptor_static_storm'] = true,
    ['doom_bringer_doom'] = true,
    ['dragon_knight_elder_dragon_form'] = true,
    ['drow_ranger_marksmanship'] = true,
    ['earth_spirit_magnetize'] = true,
    ['earthshaker_echo_slam'] = true,
    ['elder_titan_earth_splitter'] = true,
    ['enchantress_untouchable'] = true,
    ['enigma_black_hole'] = true,
    ['faceless_void_chronosphere'] = true,
    ['faceless_void_time_zone'] = true,
    ['furion_wrath_of_nature'] = true,
    ['grimstroke_soul_chain'] = true,
    ['gyrocopter_call_down'] = true,
    ['hoodwink_sharpshooter'] = true,
    ['huskar_life_break'] = true,
    ['jakiro_macropyre'] = true,
    ['juggernaut_omni_slash'] = true,
    ['keeper_of_the_light_spirit_form'] = true,
    ['kez_raptor_dance'] = true,
    ['kez_ravens_veil'] = true,
    ['kunkka_ghostship'] = true,
    ['largo_amphibian_rhapsody'] = true,
    ['legion_commander_duel'] = true,
    ['leshrac_pulse_nova'] = true,
    ['lich_chain_frost'] = true,
    ['life_stealer_infest'] = true,
    ['lina_laguna_blade'] = true,
    ['lion_finger_of_death'] = true,
    ['lone_druid_true_form'] = true,
    ['luna_eclipse'] = true,
    ['lycan_shapeshift'] = true,
    ['magnataur_reverse_polarity'] = true,
    ['marci_unleash'] = true,
    ['mars_arena_of_blood'] = true,
    ['medusa_stone_gaze'] = true,
    ['mirana_invis'] = true,
    ['monkey_king_wukongs_command'] = true,
    ['muerta_pierce_the_veil'] = true,
    ['naga_siren_song_of_the_siren'] = true,
    ['necrolyte_reapers_scythe'] = true,
    ['nevermore_requiem'] = true,
    ['night_stalker_darkness'] = true,
    ['nyx_assassin_vendetta'] = true,
    ['obsidian_destroyer_sanity_eclipse'] = true,
    ['ogre_magi_multicast'] = true,
    ['omniknight_guardian_angel'] = true,
    ['pangolier_gyroshell'] = true,
    ['phantom_assassin_coup_de_grace'] = true,
    ['phantom_lancer_juxtapose'] = true,
    ['phoenix_supernova'] = true,
    ['primal_beast_pulverize'] = true,
    ['puck_dream_coil'] = true,
    ['pudge_dismember'] = true,
    ['pugna_life_drain'] = true,
    ['queenofpain_sonic_wave'] = true,
    ['rattletrap_hookshot'] = true,
    ['razor_eye_of_the_storm'] = true,
    ['riki_backstab'] = true,
    ['ringmaster_wheel'] = true,
    ['sandking_epicenter'] = true,
    ['shadow_demon_demonic_purge'] = true,
    ['shadow_shaman_mass_serpent_ward'] = true,
    ['shredder_twisted_chakram'] = true,
    ['silencer_global_silence'] = true,
    ['skeleton_king_reincarnation'] = true,
    ['skywrath_mage_mystic_flare'] = true,
    ['slardar_amplify_damage'] = true,
    ['slark_shadow_dance'] = true,
    ['snapfire_mortimer_kisses'] = true,
    ['sniper_assassinate'] = true,
    ['spirit_breaker_nether_strike'] = true,
    ['sven_gods_strength'] = true,
    ['techies_land_mines'] = true,
    ['templar_assassin_psionic_trap'] = true,
    ['terrorblade_sunder'] = true,
    ['tidehunter_ravage'] = true,
    ['tiny_grow'] = true,
    ['treant_overgrowth'] = true,
    ['troll_warlord_battle_trance'] = true,
    ['tusk_walrus_punch'] = true,
    ['undying_flesh_golem'] = true,
    ['ursa_enrage'] = true,
    ['vengefulspirit_nether_swap'] = true,
    ['venomancer_noxious_plague'] = true,
    ['viper_viper_strike'] = true,
    ['visage_summon_familiars'] = true,
    ['void_spirit_astral_step'] = true,
    ['warlock_rain_of_chaos'] = true,
    ['weaver_time_lapse'] = true,
    ['windrunner_focusfire'] = true,
    ['winter_wyvern_winters_curse'] = true,
    ['witch_doctor_death_ward'] = true,
    ['zuus_thundergods_wrath'] = true,
}


function X.ReplaceUltimateIndex( nAbilityBuildList, sAbilityList )

    -- Make a copy to avoid mutating the original config array
    local nCopy = {}
    for i, v in ipairs(nAbilityBuildList) do
        nCopy[i] = v
    end

    -- Find the max value in the build (the hardcoded ultimate index)
    local nMax = 0
    for i, v in ipairs(nCopy) do
        if v > nMax then
            nMax = v
        end
    end

    -- Find which ability name in sAbilityList is an ultimate
    local nUltimateIndex = -1
    for i, sName in ipairs(sAbilityList) do
        if UltimateSet[sName] then
            nUltimateIndex = i
            break
        end
    end

    -- If no ultimate found, return the copy unchanged
    if nUltimateIndex <= 0 then
        return nCopy
    end

    -- Replace all occurrences of the max value with the actual ultimate index
    if nMax > 0 then
        for i = 1, #nCopy do
            if nCopy[i] == nMax then
                nCopy[i] = nUltimateIndex
            end
        end
    end

    return nCopy

end


X['sAllyUnitAbilityIndex'] = {

		["bloodseeker_bloodrage"] = true,
		["omniknight_purification"] = true,
		["omniknight_repel"] = true,
		["medusa_mana_shield"] = true,
		["grimstroke_spirit_walk"] = true,
		["dazzle_shallow_grave"] = true,
		["dazzle_shadow_wave"] = true,
		["ogre_magi_bloodlust"] = true,
		["lich_frost_shield"] = true,

}


X['sProjectileAbilityIndex'] = {

		["chaos_knight_chaos_bolt"] = true,
		["grimstroke_ink_creature"] = true,
		["lich_chain_frost"] = true,
		["medusa_mystic_snake"] = true,
		["phantom_assassin_stifling_dagger"] = true,
		["phantom_lancer_spirit_lance"] = true,
		["skeleton_king_hellfire_blast"] = true,
		["skywrath_mage_arcane_bolt"] = true,
		["sven_storm_bolt"] = true,
		["vengefulspirit_magic_missile"] = true,
		["viper_viper_strike"] = true,
		["witch_doctor_paralyzing_cask"] = true,

}


X['sOnlyProjectileAbilityIndex'] = {

		["necrolyte_death_pulse"] = true,
		["arc_warden_spark_wraith"] = true,
		["tinker_heat_seeking_missile"] = true,
		["skywrath_mage_concussive_shot"] = true,
		["rattletrap_battery_assault"] = true,
		["queenofpain_scream_of_pain"] = true,

}


X['sStunProjectileAbilityIndex'] = {

		["chaos_knight_chaos_bolt"] = true,
		["skeleton_king_hellfire_blast"] = true,
		["sven_storm_bolt"] = true,
		["vengefulspirit_magic_missile"] = true,
		["witch_doctor_paralyzing_cask"] = true,
		["dragon_knight_dragon_tail"] = true,

}



function X.GetTalentList( bot )

	local sTalentList = {}
	for i = 0, 23
	do
		local hAbility = bot:GetAbilityInSlot( i )
		if hAbility ~= nil and hAbility:IsTalent()
		then
			table.insert( sTalentList, hAbility:GetName() )
		end
	end

	return sTalentList

end


function X.GetAbilityList( bot )

	local sAbilityList = {}
	for slot = 0, 6
	do
		local hAbility = bot:GetAbilityInSlot( slot )
		if hAbility ~= nil then
			table.insert( sAbilityList, bot:GetAbilityInSlot( slot ):GetName() )
		end
	end

	return sAbilityList

end


function X.GetRandomBuild( tBuildList )

	return tBuildList[RandomInt( 1, #tBuildList )]

end


function X.GetTalentBuild( tTalentTreeList )

	local nTalentBuildList = {
							[1] = ( tTalentTreeList['t10'][1] == 0 and 1 or 2 ),
							[2] = ( tTalentTreeList['t15'][1] == 0 and 3 or 4 ),
							[3] = ( tTalentTreeList['t20'][1] == 0 and 5 or 6 ),
							[4] = ( tTalentTreeList['t25'][1] == 0 and 7 or 8 ),
							[5] = ( tTalentTreeList['t10'][1] == 0 and 2 or 1 ),
							[6] = ( tTalentTreeList['t15'][1] == 0 and 4 or 3 ),
							[7] = ( tTalentTreeList['t20'][1] == 0 and 6 or 5 ),
							[8] = ( tTalentTreeList['t25'][1] == 0 and 8 or 7 ),
						  }

	return nTalentBuildList

end

function X.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )
	local sSkillList = {}
	local botName = GetBot():GetUnitName()
	local bMoreMeepoFacet = botName == 'npc_dota_hero_meepo' and true

	--[[
	7.40+ broke "ActionImmediate_LevelAbility"
	ability points are different server side; the distribution is also "wrong", except invoker
	~for most heroes:             (now)					 (before?)
					level  1-17 : 14 points (other 15)   16 points
					level 18-22 :  1 points				 2 points
					level 23-30 :  8 points      		 5 points
	
	will level talents last
	]]

	sSkillList = {
		[ 1] = {done = false, name = sAbilityList[nAbilityBuildList[1]]},
		[ 2] = {done = false, name = sAbilityList[nAbilityBuildList[2]]},
		[ 3] = {done = false, name = sAbilityList[nAbilityBuildList[3]]},
		[ 4] = {done = false, name = sAbilityList[nAbilityBuildList[4]]},
		[ 5] = {done = false, name = sAbilityList[nAbilityBuildList[5]]},
		[ 6] = {done = false, name = sAbilityList[nAbilityBuildList[6]]},
		[ 7] = {done = false, name = sAbilityList[nAbilityBuildList[7]]},
		[ 8] = {done = false, name = sAbilityList[nAbilityBuildList[8]]},
		[ 9] = {done = false, name = sAbilityList[nAbilityBuildList[9]]},
		[10] = {done = false, name = sAbilityList[nAbilityBuildList[10]]},
		[11] = {done = false, name = sAbilityList[nAbilityBuildList[12]]},
		[12] = {done = false, name = sAbilityList[nAbilityBuildList[11]]},
		[13] = {done = false, name = sAbilityList[nAbilityBuildList[13]]},
		[14] = {done = false, name = sAbilityList[nAbilityBuildList[14]]},
		[15] = {done = false, name = nil},
		[16] = {done = false, name = nil},
		[17] = {done = false, name = nil},
		[18] = {done = false, name = sAbilityList[nAbilityBuildList[15]]},
		[19] = {done = false, name = nil},
		[20] = {done = false, name = nil},
		[21] = {done = false, name = nil},
		[22] = {done = false, name = nil},
		[23] = {done = false, name = sTalentList[nTalentBuildList[1]]},
		[24] = {done = false, name = sTalentList[nTalentBuildList[2]]},
		[25] = {done = false, name = sTalentList[nTalentBuildList[3]]},
		[26] = {done = false, name = sTalentList[nTalentBuildList[4]]},
		[27] = {done = false, name = sTalentList[nTalentBuildList[5]]},
		[28] = {done = false, name = sTalentList[nTalentBuildList[6]]},
		[29] = {done = false, name = sTalentList[nTalentBuildList[7]]},
		[30] = {done = false, name = sTalentList[nTalentBuildList[8]]},
	}

	if botName == 'npc_dota_hero_lone_druid_bear' then
		sSkillList = {
			[10] = {done = false, name = sTalentList[nTalentBuildList[1]]},
			[15] = {done = false, name = sTalentList[nTalentBuildList[2]]},
			[20] = {done = false, name = sTalentList[nTalentBuildList[3]]},
			[25] = {done = false, name = sTalentList[nTalentBuildList[4]]},
			[27] = {done = false, name = sTalentList[nTalentBuildList[5]]},
			[28] = {done = false, name = sTalentList[nTalentBuildList[6]]},
			[29] = {done = false, name = sTalentList[nTalentBuildList[7]]},
			[30] = {done = false, name = sTalentList[nTalentBuildList[8]]},
		}
	end

	if botName == 'npc_dota_hero_invoker' then
		sSkillList = {
			[ 1] = {done = false, name = sAbilityList[nAbilityBuildList[1]]},
			[ 2] = {done = false, name = sAbilityList[nAbilityBuildList[2]]},
			[ 3] = {done = false, name = sAbilityList[nAbilityBuildList[3]]},
			[ 4] = {done = false, name = sAbilityList[nAbilityBuildList[4]]},
			[ 5] = {done = false, name = sAbilityList[nAbilityBuildList[5]]},
			[ 6] = {done = false, name = sAbilityList[nAbilityBuildList[6]]},
			[ 7] = {done = false, name = sAbilityList[nAbilityBuildList[7]]},
			[ 8] = {done = false, name = sAbilityList[nAbilityBuildList[8]]},
			[ 9] = {done = false, name = sAbilityList[nAbilityBuildList[9]]},
			[10] = {done = false, name = sAbilityList[nAbilityBuildList[10]]},
			[11] = {done = false, name = sAbilityList[nAbilityBuildList[11]]},
			[12] = {done = false, name = sAbilityList[nAbilityBuildList[12]]},
			[13] = {done = false, name = sAbilityList[nAbilityBuildList[13]]},
			[14] = {done = false, name = sAbilityList[nAbilityBuildList[14]]},
			[15] = {done = false, name = sAbilityList[nAbilityBuildList[15]]},
			[16] = {done = false, name = sAbilityList[nAbilityBuildList[16]]},
			[17] = {done = false, name = sAbilityList[nAbilityBuildList[17]]},
			[18] = {done = false, name = sAbilityList[nAbilityBuildList[18]]},
			[19] = {done = false, name = sAbilityList[nAbilityBuildList[19]]},
			[20] = {done = false, name = sAbilityList[nAbilityBuildList[20]]},
			[21] = {done = false, name = sAbilityList[nAbilityBuildList[21]]},
			[22] = {done = false, name = sTalentList[nTalentBuildList[1]]},
			[23] = {done = false, name = sTalentList[nTalentBuildList[2]]},
			[24] = {done = false, name = sTalentList[nTalentBuildList[3]]},
			[25] = {done = false, name = sTalentList[nTalentBuildList[4]]},
			[26] = {done = false, name = nil},
			[27] = {done = false, name = sTalentList[nTalentBuildList[5]]},
			[28] = {done = false, name = sTalentList[nTalentBuildList[6]]},
			[29] = {done = false, name = sTalentList[nTalentBuildList[7]]},
			[30] = {done = false, name = sTalentList[nTalentBuildList[8]]},
		}
	end

	if bMoreMeepoFacet then
		sSkillList = {
			[ 1] = {done = false, name = sAbilityList[nAbilityBuildList[1]]},
			[ 2] = {done = false, name = sAbilityList[nAbilityBuildList[2]]},
			[ 3] = {done = false, name = sAbilityList[nAbilityBuildList[3]]},
			[ 4] = {done = false, name = sAbilityList[nAbilityBuildList[4]]},
			[ 5] = {done = false, name = sAbilityList[nAbilityBuildList[5]]},
			[ 6] = {done = false, name = sAbilityList[nAbilityBuildList[6]]},
			[ 7] = {done = false, name = sAbilityList[nAbilityBuildList[7]]},
			[ 8] = {done = false, name = sAbilityList[nAbilityBuildList[8]]},
			[ 9] = {done = false, name = sAbilityList[nAbilityBuildList[9]]},
			[10] = {done = false, name = sAbilityList[nAbilityBuildList[10]]},
			[11] = {done = false, name = sAbilityList[nAbilityBuildList[11]]},
			[12] = {done = false, name = sAbilityList[nAbilityBuildList[12]]},
			[13] = {done = false, name = sAbilityList[nAbilityBuildList[13]]},
			[14] = {done = false, name = sAbilityList[nAbilityBuildList[14]]},
			[15] = {done = false, name = nil},
			[16] = {done = false, name = nil},
			[17] = {done = false, name = nil},
			[18] = {done = false, name = sAbilityList[nAbilityBuildList[15]]},
			[19] = {done = false, name = nil},
			[20] = {done = false, name = nil},
			[21] = {done = false, name = nil},
			[22] = {done = false, name = sTalentList[nTalentBuildList[1]]},
			[23] = {done = false, name = sTalentList[nTalentBuildList[2]]},
			[24] = {done = false, name = sAbilityList[nAbilityBuildList[16]]},
			[25] = {done = false, name = sTalentList[nTalentBuildList[3]]},
			[26] = {done = false, name = sTalentList[nTalentBuildList[4]]},
			[27] = {done = false, name = sTalentList[nTalentBuildList[5]]},
			[28] = {done = false, name = sTalentList[nTalentBuildList[6]]},
			[29] = {done = false, name = sTalentList[nTalentBuildList[7]]},
			[30] = {done = false, name = sTalentList[nTalentBuildList[8]]},
		}
	end

	if not bMoreMeepoFacet and #nAbilityBuildList == 16 then
		sSkillList = {
			[ 1] = {done = false, name = sAbilityList[nAbilityBuildList[1]]},
			[ 2] = {done = false, name = sAbilityList[nAbilityBuildList[2]]},
			[ 3] = {done = false, name = sAbilityList[nAbilityBuildList[3]]},
			[ 4] = {done = false, name = sAbilityList[nAbilityBuildList[4]]},
			[ 5] = {done = false, name = sAbilityList[nAbilityBuildList[5]]},
			[ 6] = {done = false, name = sAbilityList[nAbilityBuildList[6]]},
			[ 7] = {done = false, name = sAbilityList[nAbilityBuildList[7]]},
			[ 8] = {done = false, name = sAbilityList[nAbilityBuildList[8]]},
			[ 9] = {done = false, name = sAbilityList[nAbilityBuildList[9]]},
			[10] = {done = false, name = sAbilityList[nAbilityBuildList[10]]},
			[11] = {done = false, name = sAbilityList[nAbilityBuildList[12]]},
			[12] = {done = false, name = sAbilityList[nAbilityBuildList[11]]},
			[13] = {done = false, name = sAbilityList[nAbilityBuildList[13]]},
			[14] = {done = false, name = sAbilityList[nAbilityBuildList[14]]},
			[15] = {done = false, name = nil},
			[16] = {done = false, name = nil},
			[17] = {done = false, name = sAbilityList[nAbilityBuildList[15]]},
			[18] = {done = false, name = sAbilityList[nAbilityBuildList[16]]},
			[19] = {done = false, name = nil},
			[20] = {done = false, name = nil},
			[21] = {done = false, name = nil},
			[22] = {done = false, name = nil},
			[23] = {done = false, name = sTalentList[nTalentBuildList[1]]},
			[24] = {done = false, name = sTalentList[nTalentBuildList[2]]},
			[25] = {done = false, name = sTalentList[nTalentBuildList[3]]},
			[26] = {done = false, name = sTalentList[nTalentBuildList[4]]},
			[27] = {done = false, name = sTalentList[nTalentBuildList[5]]},
			[28] = {done = false, name = sTalentList[nTalentBuildList[6]]},
			[29] = {done = false, name = sTalentList[nTalentBuildList[7]]},
			[30] = {done = false, name = sTalentList[nTalentBuildList[8]]},
		}
	end

	return sSkillList
end


function X.IsHeroInEnemyTeam( sHero )

	for _, id in pairs( GetTeamPlayers( GetOpposingTeam() ) )
	do
		if GetSelectedHeroName( id ) == sHero
		then
			return true
		end
	end

	return false

end


function X.GetOutfitName( bot )

	return 'item_'..string.gsub( bot:GetUnitName(), 'npc_dota_hero_', '' )..'_outfit'

end


return X
-- dota2jmz@163.com QQ:2462331592..
