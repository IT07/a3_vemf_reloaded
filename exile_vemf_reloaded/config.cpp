/*
   Author: IT07

   Description:
	cpp config file for exile_vemf_reloaded

	What is exile_vemf_reloaded? (short: VEMFr)
	It is a complete remake (and port to Exile) of VEMF (for Epoch) by TheVampire.
	exile_vemf_reloaded was originally called VEMF but because the original creator (TheVampire) wanted to continue his work on VEMF,
	this remade version of VEMF had its name changed into exile_vemf_reloaded.
*/

///////////////
/// NOTE: settings that are set to 0 means they are DISABLED | settings set to 1 (or higher) are either enabled or have a specific function
///////////////

class CfgVemfReloaded
{
	/////// Debugging/learning/logging ///////
	debugMode = 3; // 0 = no debugging | 1 = ERRORS only | 2 = INFO only | 3 = ERRORS & INFO
	overridesToRPT = 1; // Enable/disable logging of override settings to .RPT
	///////////////////////////////////////

	// Global settings
	addons[] = {}; // Not used for now
	allowTWS = 0; // Enable/disable the usage of TWS scopes by AI
	headLessClientSupport = 0;
	headLessClientNames[] = {"HC1"};
	housesBlackList[] = {"Land_Pier_F"};
	killPercentage = 100; // How much of total AI has to be killed for mission completion (in percentage)
	logCowardKills = 1; // Enable/disable logging of who killed AI whilst it was parachuting down
	maxGlobalMissions = 10; // Enable/disable global mission amount limit
	maxNew = 2; // Enable/disable MAXIMUM time (in minutes) before new mission can run
	minNew = 1; // Enable/disable MINIMUM time (in minutes) before new mission can run
	minPlayers = 1; // Enable/disable minimal required player count for (new) missions to (start) spawn(ing)
	minServerFPS = 20; // Enable/disable minimum server FPS for VEMF to keep spawning missions
	missionDistance = 2000; // Enable/disable minimum distance between missions
	missionList[] = {"DynamicLocationInvasion","BaseAttack"}; // Each entry should represent an .sqf file in the missions folder
	noMissionPos[] = {{{2998.62,18175.4,0.00143886},500},{{14601.3,16799.3,0.00143814},800},{{23334.8,24189.5,0.00132132},600}}; // Format: {{position},radius} | Default: Exile Altis safezones
	nonPopulated = 1; // Enable/disable allowance of missions at locations WITHOUT (enterable) buildings
	punishRoadKills = 1; // Enable/disable respect deduction if player roadkills AI
	removeAllAssignedItems = 0; // Enable/disable removal of Map, Compass, Watch and Radio from all AI
	sayKilled = 1; // Enable/disable AI kill messages
 	timeOutTime = 25; // Enable/disable mission timeOutTime (in minutes)
	validateLoot = 1; // Enable/disable validation of all defined loot classnames. Checks if classnames exist in server's game configFile

	// Exile specific settings
	aiMode = 1; // 0 = normal soldier AI | 1 = regular police AI | 2 = S.W.A.T. AI
	respectReward = 20; // 0 = no respect for killing AI | respectReward > 0 = amount of minimum respect reward for player
	respectRoadKillDeduct = 20; // 0 = no deduction for roadkilling AI | respectRoadKillDeduct > = amount of respect to deduct from player;

	// AI Unit settings
	unitClass = "O_G_Sharpshooter_F"; // Default: "O_G_Sharpshooter_F" | optional: "B_G_Soldier_AR_F"
	// NOTE: VEMFr will automatically adjust the AI's side that belongs to the unit of given unitClass

	class locationBlackLists
	{ // NOTE: If the map you use is not listed below, simply add it by yourself or put the locations you want to blacklist into the locations array of the Other class
		class Altis
		{
			locations[] = {"Almyra","Atsalis","Cap Makrinos","Chelonisi","Fournos","Kavala","Makrynisi","Monisi","Polemista","Pyrgos","Pyrgi","Sagonisi","Savri","Selakano","Sofia","Surf Club","Syrta","Zaros"};
		};
		class Stratis
		{
			locations[] = {"Jay Cove","Kamino Bay","Keiros Bay","Kyfi Bay","Limeri Bay","Marina Bay","Nisi Bay","Strogos Bay","Tsoukala Bay"};
		};
		class Namalsk
		{
			locations[] = {"Brensk Bay","Lubjansk Bay","Nemsk Bay","Seraja Bay","Sebjan Mine","Tara Strait"};
		};
		class Other
		{
			locations[] = {};
		};
	};

	class BaseAttack // WORK IN PROGRESS!!
	{ // BaseAttack (mission) settings
		aiLaunchers = 1; // Allow/disallow AI to have rocket launchers
		aiMode = 1; // 0 = "military" | 1 = Police | 2 = S.W.A.T.
		aiSetup[] = {2,5}; // format: {amountOfGroups,unitsInEachGroup};
		hasLauncherChance = 25; // In percentage. How big the chance that each AI gets a launcher
		maxAttacks = 5; // Maximum amount of active attacks at the same time | can not be turned off
		minimumLevel = 2; // Minimum required level of base before it can get attacked
		/*
			NOTES:
			1) every territory flag can only be attacked once every restart
			2) only players within a certain range of the attacked territory can see the mission announcement
			3) as a "punishment" for killing AI, players do NOT get any respect increase/decrease for killing AI
		*/
	};

	class DynamicLocationInvasion
	{ // DynamicLocationInvasion (mission) settings
		allowCrateLift = 0; // Allow/disallow the loot crate to be lifted with helicopter
		aiLaunchers = 1; // Allow/disallow AI to have rocket launchers
		announce = 1; // Enable/disable mission notificatons
		cal50s = 3; // Max amount of .50 caliber machineguns at mission | Needs to be lower than total unit count per mission
		cal50sDelete = 1; // Enable/disable the removal of .50cal | 2 = destroy (not remove)
		crateTypes[] = {"I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F","I_supplyCrate_F","Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F"};
		flairTypes[] = {"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"};
		groupCount[] = {2,4}; // In format: {minimum, maximum}; VEMF will pick a random number between min and max. If you want the same amount always, use same numbers for minimum and maximum.
		groupUnits[] = {4,6}; // How much units in each group. Works the same like groupCount
		hasLauncherChance = 25; // In percentage. How big the chance that each AI gets a launcher
		heliPatrol[] = {1, {"B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Transport_03_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F"}}; // Enable/disable heli patrol at mission location and set the types of heli(s)
		heliLocked = 0; // Enable/disable heli lock to prevent/allow players from flying it
		marker = 1; // Enable/disable mission markers
		markCrateOnMap = 1; // Enable/disable loot crate marker on map called "Loot"
		markCrateVisual = 1; // Enable/disable loot crate VISUAL marker (smoke and/or chem)
		/* maxDistance NOTE: make sure to keep this number very high. 15000 is for Altis */
		maxDistancePrefered = 7000; // Prefered maximum mission distance from player
		maxInvasions = 7; // Max amount of active uncompleted invasions allowed at the same time
		mines = 0; // Enable/disable mines at mission | 1 = anti-Armor mines | 2 = anti-Personell mines | 3 = both anti-Armor and anti-Personell mines
		minesAmount = 20; // Ignore if placeMines = 0;
		minesCleanup = 1; // Enable/disable the removal of mines once mission has been completed | 2 = explode mines
		nonPopulated = -1; // Allow/disallow this mission type being placed at locations without buildings | using -1 will ignore this setting and use the global settting
		parachuteCrate[] = {0, 250}; // default: {disabled, 250 meters} | use 1 as first number to enable crate parachute spawn
		randomModes = 1; // Enable/disable randomization of AI types (linked to aiMode setting)
	   skipDistance = 800; // No missions at locations which have players within this range (in meters)
	   smokeTypes[] = {"SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"};
		spawnCrateFirst = 0; // Enable/disable the spawning of loot crate before mission has been completed
	   streetLights = 0; // Enable/disable street lights at mission location
	   streetLightsRestore = 1; // Enable/disable restoration of street lights after mission completion
	   streetLightsRange = 500; // Affects streetlights within this distance from mission's center
	};

	class aiStatic
	{ // Simply spawns units at desired positions
		amount[] = {10,20,12,11,40,21,19}; // How much AI units on each seperate position. Example: 1st location, 10. 2nd location, 20. 3rd location, 12. And so on....
		enabled = 0; // Enable/disable static AI spawning
		positions[] = {}; // Add positions here. Each position must have {} around it and must be seperated with a comma if multiple positions present. Last position in list should NOT have a comma behind it!
		random = 1; // Enable/disable randomization of AI units amount
	};

	class aiCleanUp
	{ // Contains settings for removal of items from each AI that gets eliminated
		aiDeathRemovalEffect = 0; // Enable/disable the "death effect" from Virtual Arsenal. Flashes AI and deletes it after being eliminated
		removeHeadGear = 0; // Enable/disable removal of headgear after AI has been eliminated, obviously
		removeLaunchers = 0; // Enable/disable removal of rocket launchers from AI after they are eliminated
	};


	class aiSkill // Minimum: 0 | Maximum: 1
	{ // Global AI skill settings. They affect each VEMF unit for any default VEMF mission
		difficulty = "Veteran"; // Options: "Easy" "Normal" "Veteran" "Hardcore" | Default: Veteran
		class Easy // AI looks stupid with this setting xD
		{
			accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.3;
		};
		class Normal
		{
			accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.4;
		};
		class Veteran
		{
			accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.5;
		};
		class Hardcore // Also known as Aimbots
		{
			accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.7;
		};
	};

	class policeConfig
	{
		backpacks[] = {
			"B_AssaultPack_khk","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_cbr",
			"B_AssaultPack_mcamo","B_TacticalPack_rgr","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_blk",
			"B_TacticalPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_cbr",
			"B_FieldPack_blk","B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_cbr",
			"B_Parachute","B_FieldPack_oli","B_Carryall_oli","B_Kitbag_Base","B_Kitbag_cbr","B_Kitbag_mcamo",
			"B_Kitbag_rgr","B_Kitbag_sgg","B_OutdoorPack_Base","B_OutdoorPack_blk","B_OutdoorPack_blu",
			"B_OutdoorPack_tan"
		};
		headGear[] = {
			"H_Cap_police","H_Beret_blk_POLICE","H_Cap_blk_ION","H_Cap_khaki_specops_UK","H_Cap_tan_specops_US","H_Cap_brn_SPECOPS","H_Cap_blk_CMMG","H_Cap_blk","H_Cap_blu","H_Cap_red",
			"H_Cap_press","H_Cap_usblack","H_Beret_brn_SF","H_Beret_Colonel"
		};
		pistols[] = {"hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F"};
		rifles[] = {
			"arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_Mk20_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F",
			"arifle_MXC_F","arifle_MX_F","arifle_MX_SW_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_TRG21_F","arifle_TRG20_F","arifle_TRG21_GL_F","hgun_PDW2000_F","SMG_01_F","SMG_02_F"
		};
		uniforms[] = {"U_C_Journalist","U_Rangemaster","U_Marshal","U_Competitor"};
		vests[] = {"V_TacVest_blk_POLICE","V_PlateCarrierSpec_blk","V_PlateCarrierGL_blk","V_TacVestCamo_khk","V_TacVest_blk","V_BandollierB_blk","V_Rangemaster_belt"};
	};

	class crateLoot
	{ // Loot crate configuration
		primarySlotsMax = 7; // Maximum primary weapons in each loot crate
		primarySlotsMin = 2; // Minimum primary weapons in each loot crate
		primaryWeaponLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"srifle_DMR_01_F",2},{"srifle_EBR_F",3},{"srifle_GM6_F",1},{"LMG_Mk200_F",3},{"LMG_Zafir_F",3},{"arifle_Katiba_F",3},{"arifle_Katiba_GL_F",2},{"arifle_Mk20_F",2},
			{"arifle_Mk20_plain_F",2},{"arifle_Mk20C_F",2},{"arifle_Mk20C_plain_F",2},{"arifle_Mk20_GL_F",2},{"arifle_Mk20_GL_plain_F",2},{"arifle_MXC_F",2},{"arifle_MX_F",2},
			{"arifle_MX_GL_F",2},{"arifle_MX_SW_F",2},{"arifle_MXM_F",2},{"arifle_MXC_Black_F",2},{"arifle_MX_Black_F",2},{"arifle_MX_GL_Black_F",2},{"arifle_MX_SW_Black_F",2},
			{"arifle_MXM_Black_F",2},{"arifle_SDAR_F",2},{"arifle_TRG21_F",2},{"arifle_TRG20_F",2},{"arifle_TRG21_GL_F",2},{"SMG_01_F",2},{"SMG_02_F",2},{"srifle_GM6_camo_F",2},
			{"srifle_LRR_camo_F",2},{"srifle_DMR_02_F",2},{"srifle_DMR_02_camo_F",2},{"srifle_DMR_02_sniper_F",2},{"srifle_DMR_03_F",2},{"srifle_DMR_03_khaki_F",2},{"srifle_DMR_03_tan_F",2},
			{"srifle_DMR_03_multicam_F",2},{"srifle_DMR_03_woodland_F",2},{"srifle_DMR_04_F",2},{"srifle_DMR_04_Tan_F",2},{"srifle_DMR_05_blk_F",2},{"srifle_DMR_05_hex_F",2},{"srifle_DMR_05_tan_f",2},{"srifle_DMR_06_camo_F",2},{"srifle_DMR_06_olive_F",2},{"MMG_01_hex_F",2},{"MMG_01_tan_F",2},{"MMG_02_camo_F",2},
			{"MMG_02_black_F",2},{"MMG_02_sand_F",2}
		};

		secondarySlotsMax = 3; // Maximum number of secondary weapons to be in each loot crate
		secondarySlotsMin = 1; // Minimum number of secondary weapons to be in each loot crate
		secondaryWeaponLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"hgun_ACPC2_F",3},{"hgun_P07_F",3},{"hgun_Pistol_heavy_01_F",3},{"hgun_Pistol_heavy_02_F",3},{"hgun_Rook40_F",3}
		};

		magSlotsMax = 8; // Maximum number of magazine slots in each loot crate
		magSlotsMin = 6; // Minimum number of magazine slots in each loot crate
		magLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"30Rnd_556x45_Stanag",20},{"30Rnd_556x45_Stanag_Tracer_Red",20},{"30Rnd_556x45_Stanag_Tracer_Green",20},
			{"30Rnd_556x45_Stanag_Tracer_Yellow",20},{"30Rnd_65x39_caseless_mag",20},{"30Rnd_65x39_caseless_green",20},{"30Rnd_65x39_caseless_mag_Tracer",20},
			{"30Rnd_65x39_caseless_green_mag_Tracer",20},{"20Rnd_762x51_Mag",20},{"7Rnd_408_Mag",20},{"5Rnd_127x108_Mag",20},{"100Rnd_65x39_caseless_mag",20},
			{"100Rnd_65x39_caseless_mag_Tracer",20},{"200Rnd_65x39_cased_Box",20},{"200Rnd_65x39_cased_Box_Tracer",20},{"30Rnd_9x21_Mag",20},{"16Rnd_9x21_Mag",20},
			{"30Rnd_45ACP_Mag_SMG_01",20},{"30Rnd_45ACP_Mag_SMG_01_Tracer_Green",20},{"9Rnd_45ACP_Mag",20},{"150Rnd_762x51_Box",20},{"150Rnd_762x51_Box_Tracer",20},
			{"150Rnd_762x54_Box",20},{"150Rnd_762x54_Box_Tracer",20},{"11Rnd_45ACP_Mag",20},{"6Rnd_45ACP_Cylinder",20},{"10Rnd_762x51_Mag",20},{"10Rnd_762x54_Mag",20},
			{"5Rnd_127x108_APDS_Mag",20},{"10Rnd_338_Mag",20},{"130Rnd_338_Mag",20},{"10Rnd_127x54_Mag",20},{"150Rnd_93x64_Mag",20},{"10Rnd_93x64_DMR_05_Mag",20}
		};

		attSlotsMax = 4; // Maximum number of attachment slots in each loot crate
		attSlotsMin = 2; // Minimum number of attachment slots in each loot crate
		attLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"ItemGPS",5},{"ItemRadio",4},{"ItemMap",6},{"MineDetector",1},{"Binocular",4},{"Rangefinder",2},{"muzzle_snds_H",2},
			{"muzzle_snds_L",2},{"muzzle_snds_M",2},{"muzzle_snds_B",2},{"muzzle_snds_H_MG",2},{"muzzle_snds_H_SW",2},
			{"optic_Arco",3},{"optic_Aco",3},{"optic_ACO_grn",3},{"optic_Aco_smg",3},{"optic_ACO_grn_smg",3},{"optic_Holosight",3},
			{"optic_Holosight_smg",3},{"optic_SOS",3},{"acc_flashlight",3},{"acc_pointer_IR",3},{"optic_MRCO",3},{"muzzle_snds_acp",3},
			{"optic_NVS",3},{"optic_DMS",3},{"optic_Yorris",2},{"optic_MRD",2},{"optic_LRPS",3},{"muzzle_snds_338_black",3},{"muzzle_snds_338_green",3},
			{"muzzle_snds_338_sand",3},{"muzzle_snds_93mmg",3},{"muzzle_snds_93mmg_tan",3},{"optic_AMS",3},{"optic_AMS_khk",3},{"bipod_03_F_oli",3},
			{"optic_AMS_snd",3},{"optic_KHS_blk",3},{"optic_KHS_hex",3},{"optic_KHS_old",3},{"optic_KHS_tan",3},{"bipod_01_F_snd",3},
			{"bipod_01_F_blk",3},{"bipod_01_F_mtp",3},{"bipod_02_F_blk",3},{"bipod_02_F_tan",3},{"bipod_02_F_hex",3},{"bipod_03_F_blk",3}
		};

		itemSlotsMax = 4; // Maximum number of attachment slots in each loot crate
		itemSlotsMin = 2; // Minimum number of attachment slots in each loot crate
		itemLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"Exile_Item_Flag",3},{"Exile_Item_FuelCanisterFull",2},{"Exile_Item_FuelCanisterEmpty",1},{"Exile_Item_InstaDoc",4},{"Exile_Item_Matches",3},{"Exile_Item_PlasticBottleFreshWater",5}
		};

		vestSlotsMax = 3; // Maximum number of vest slots in each loot crate
		vestSlotsMin = 1; // Minimum number of vest slots in each loot crate
		vestLoot[] = // NOTE ABOUT VESTS: it is recommended to keep amount for each vest at 1 because vests do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"V_PlateCarrier1_rgr",1},{"V_PlateCarrier2_rgr",1},{"V_PlateCarrier3_rgr",1},{"V_PlateCarrierGL_rgr",1},{"V_PlateCarrier1_blk",1},
			{"V_PlateCarrierSpec_rgr",1},{"V_Chestrig_khk",1},{"V_Chestrig_rgr",1},{"V_Chestrig_blk",1},{"V_Chestrig_oli",1},{"V_TacVest_khk",1},
			{"V_TacVest_brn",1},{"V_TacVest_oli",1},{"V_TacVest_blk",1},{"V_TacVest_camo",1},{"V_TacVest_blk_POLICE",1},{"V_TacVestIR_blk",1},{"V_TacVestCamo_khk",1},
			{"V_HarnessO_brn",1},{"V_HarnessOGL_brn",1},{"V_HarnessO_gry",1},{"V_HarnessOGL_gry",1},{"V_HarnessOSpec_brn",1},{"V_HarnessOSpec_gry",1},
			{"V_PlateCarrierIA1_dgtl",1},{"V_PlateCarrierIA2_dgtl",1},{"V_PlateCarrierIAGL_dgtl",1},{"V_RebreatherB",1},{"V_RebreatherIR",1},{"V_RebreatherIA",1},
			{"V_PlateCarrier_Kerry",1},{"V_PlateCarrierL_CTRG",1},{"V_PlateCarrierH_CTRG",1},{"V_I_G_resistanceLeader_F",1},{"V_Press_F",1}
		};

		headGearSlotsMax = 3; // Maximum number of headGear slots in each loot crate
		headGearSlotsMin = 1; // Minimum number of headGear slots in each loot crate
		headGearLoot[] = // NOTE ABOUT HEADGEAR: it is recommended to keep amount for each headGear item at 1 because headGear items do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"H_HelmetB",1},{"H_HelmetB_camo",1},{"H_HelmetB_paint",1},{"H_HelmetB_light",1},{"H_Booniehat_khk",1},{"H_Booniehat_oli",1},{"H_Booniehat_indp",1},
			{"H_Booniehat_mcamo",1},{"H_Booniehat_grn",1},{"H_Booniehat_tan",1},{"H_Booniehat_dirty",1},{"H_Booniehat_dgtl",1},{"H_Booniehat_khk_hs",1},{"H_HelmetB_plain_mcamo",1},
			{"H_HelmetB_plain_blk",1},{"H_HelmetSpecB",1},{"H_HelmetSpecB_paint1",1},{"H_HelmetSpecB_paint2",1},{"H_HelmetSpecB_blk",1},{"H_HelmetIA",1},{"H_HelmetIA_net",1},
			{"H_HelmetIA_camo",1},{"H_Helmet_Kerry",1},{"H_HelmetB_grass",1},{"H_HelmetB_snakeskin",1},{"H_HelmetB_desert",1},{"H_HelmetB_black",1},{"H_HelmetB_sand",1},
			{"H_Cap_red",1},{"H_Cap_blu",1},{"H_Cap_oli",1},{"H_Cap_headphones",1},{"H_Cap_tan",1},{"H_Cap_blk",1},{"H_Cap_blk_CMMG",1},{"H_Cap_brn_SPECOPS",1},{"H_Cap_tan_specops_US",1},
			{"H_Cap_khaki_specops_UK",1},{"H_Cap_grn",1},{"H_Cap_grn_BI",1},{"H_Cap_blk_Raven",1},{"H_Cap_blk_ION",1},{"H_Cap_oli_hs",1},{"H_Cap_press",1},{"H_Cap_usblack",1},{"H_Cap_police",1},
			{"H_HelmetCrew_B",1},{"H_HelmetCrew_O",1},{"H_HelmetCrew_I",1},{"H_PilotHelmetFighter_B",1},{"H_PilotHelmetFighter_O",1},{"H_PilotHelmetFighter_I",1},
			{"H_PilotHelmetHeli_B",1},{"H_PilotHelmetHeli_O",1},{"H_PilotHelmetHeli_I",1},{"H_CrewHelmetHeli_B",1},{"H_CrewHelmetHeli_O",1},{"H_CrewHelmetHeli_I",1},{"H_HelmetO_ocamo",1},
			{"H_HelmetLeaderO_ocamo",1},{"H_MilCap_ocamo",1},{"H_MilCap_mcamo",1},{"H_MilCap_oucamo",1},{"H_MilCap_rucamo",1},{"H_MilCap_gry",1},{"H_MilCap_dgtl",1},
			{"H_MilCap_blue",1},{"H_HelmetB_light_grass",1},{"H_HelmetB_light_snakeskin",1},{"H_HelmetB_light_desert",1},{"H_HelmetB_light_black",1},{"H_HelmetB_light_sand",1},{"H_BandMask_blk",1},
			{"H_BandMask_khk",1},{"H_BandMask_reaper",1},{"H_BandMask_demon",1},{"H_HelmetO_oucamo",1},{"H_HelmetLeaderO_oucamo",1},{"H_HelmetSpecO_ocamo",1},{"H_HelmetSpecO_blk",1},
			{"H_Bandanna_surfer",1},{"H_Bandanna_khk",1},{"H_Bandanna_khk_hs",1},{"H_Bandanna_cbr",1},{"H_Bandanna_sgg",1},{"H_Bandanna_sand",1},{"H_Bandanna_surfer_blk",1},{"H_Bandanna_surfer_grn",1},
			{"H_Bandanna_gry",1},{"H_Bandanna_blu",1},{"H_Bandanna_camo",1},{"H_Bandanna_mcamo",1},{"H_Shemag_khk",1},{"H_Shemag_tan",1},{"H_Shemag_olive",1},{"H_Shemag_olive_hs",1},
			{"H_ShemagOpen_khk",1},{"H_ShemagOpen_tan",1},{"H_Beret_blk",1},{"H_Beret_blk_POLICE",1},{"H_Beret_red",1},{"H_Beret_grn",1},{"H_Beret_grn_SF",1},{"H_Beret_brn_SF",1},
			{"H_Beret_ocamo",1},{"H_Beret_02",1},{"H_Beret_Colonel",1},{"H_Watchcap_blk",1},{"H_Watchcap_cbr",1},{"H_Watchcap_khk",1},{"H_Watchcap_camo",1},{"H_Watchcap_sgg",1},
			{"H_TurbanO_blk",1},{"H_Cap_marshal",1}
		};

		bagSlotsMax = 2;
		bagSlotsMin = 1;
		backpackLoot[] = // NOTE ABOUT BACKPACKS: it is recommended to keep amount for each bag at 1 because bags do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"B_AssaultPack_khk",1},{"B_AssaultPack_dgtl",1},{"B_AssaultPack_rgr",1},{"B_AssaultPack_sgg",1},{"B_AssaultPack_cbr",1},
			{"B_AssaultPack_mcamo",1},{"B_TacticalPack_rgr",1},{"B_TacticalPack_mcamo",1},{"B_TacticalPack_ocamo",1},{"B_TacticalPack_blk",1},
			{"B_TacticalPack_oli",1},{"B_FieldPack_khk",1},{"B_FieldPack_ocamo",1},{"B_FieldPack_oucamo",1},{"B_FieldPack_cbr",1},
			{"B_FieldPack_blk",1},{"B_Carryall_ocamo",1},{"B_Carryall_oucamo",1},{"B_Carryall_mcamo",1},{"B_Carryall_khk",1},{"B_Carryall_cbr",1},
			{"B_Parachute",1},{"B_FieldPack_oli",1},{"B_Carryall_oli",1},{"B_Kitbag_Base",1},{"B_Kitbag_cbr",1},{"B_Kitbag_mcamo",1},
			{"B_Kitbag_rgr",1},{"B_Kitbag_sgg",1},{"B_OutdoorPack_Base",1},{"B_OutdoorPack_blk",1},{"B_OutdoorPack_blu",1},
			{"B_OutdoorPack_tan",1}
		};

		blackListLoot[] =
		{
			"DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag",
			"APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag",
			"ChainSaw","srifle_DMR_03_spotter_F"
		};
		// End of loot crate configuration
	};
	class aiGear
	{ // Configuration of what AI have
		aiHeadGear[] =
		{
			"H_HelmetB","H_HelmetB_camo","H_HelmetB_paint","H_HelmetB_light","H_Booniehat_khk","H_Booniehat_oli","H_Booniehat_indp",
			"H_Booniehat_mcamo","H_Booniehat_grn","H_Booniehat_tan","H_Booniehat_dirty","H_Booniehat_dgtl","H_Booniehat_khk_hs","H_HelmetB_plain_mcamo",
			"H_HelmetB_plain_blk","H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk","H_HelmetIA","H_HelmetIA_net",
			"H_HelmetIA_camo","H_Helmet_Kerry","H_HelmetB_grass","H_HelmetB_snakeskin","H_HelmetB_desert","H_HelmetB_black","H_HelmetB_sand",
			"H_Cap_red","H_Cap_blu","H_Cap_oli","H_Cap_headphones","H_Cap_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US",
			"H_Cap_khaki_specops_UK","H_Cap_grn","H_Cap_grn_BI","H_Cap_blk_Raven","H_Cap_blk_ION","H_Cap_oli_hs","H_Cap_press","H_Cap_usblack","H_Cap_police",
			"H_HelmetCrew_B","H_HelmetCrew_O","H_HelmetCrew_I","H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I",
			"H_PilotHelmetHeli_B","H_PilotHelmetHeli_O","H_PilotHelmetHeli_I","H_CrewHelmetHeli_B","H_CrewHelmetHeli_O","H_CrewHelmetHeli_I","H_HelmetO_ocamo",
			"H_HelmetLeaderO_ocamo","H_MilCap_ocamo","H_MilCap_mcamo","H_MilCap_oucamo","H_MilCap_rucamo","H_MilCap_gry","H_MilCap_dgtl",
			"H_MilCap_blue","H_HelmetB_light_grass","H_HelmetB_light_snakeskin","H_HelmetB_light_desert","H_HelmetB_light_black","H_HelmetB_light_sand","H_BandMask_blk",
			"H_BandMask_khk","H_BandMask_reaper","H_BandMask_demon","H_HelmetO_oucamo","H_HelmetLeaderO_oucamo","H_HelmetSpecO_ocamo","H_HelmetSpecO_blk",
			"H_Bandanna_surfer","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn",
			"H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_camo","H_Bandanna_mcamo","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs",
			"H_ShemagOpen_khk","H_ShemagOpen_tan","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_red","H_Beret_grn","H_Beret_grn_SF","H_Beret_brn_SF",
			"H_Beret_ocamo","H_Beret_02","H_Beret_Colonel","H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_camo","H_Watchcap_sgg",
			"H_TurbanO_blk","H_Cap_marshal"
		};
		aiUniforms[] =
		{
			"U_I_CombatUniform","U_I_CombatUniform_tshirt","U_I_CombatUniform_shortsleeve","U_I_pilotCoveralls",
			"U_I_GhillieSuit","U_I_OfficerUniform","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3",
			"U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_leader","U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_Guerilla2_3",
			"U_BG_Guerilla3_1","U_BG_Guerilla3_2","U_BG_leader","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_2",
			"U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_C_WorkerCoveralls","U_C_HunterBody_grn",
			"U_C_HunterBody_brn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_B_survival_uniform","U_I_G_Story_Protagonist_F",
			"U_I_G_resistanceLeader_F","U_IG_Guerrilla_6_1","U_BG_Guerrilla_6_1","U_OG_Guerrilla_6_1","U_B_FullGhillie_lsh",
			"U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard",
			"U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"
		};
		aiVests[] =
		{
			"V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrier1_blk",
			"V_PlateCarrierSpec_rgr","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_blk","V_Chestrig_oli","V_TacVest_khk",
			"V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVest_blk_POLICE","V_TacVestIR_blk","V_TacVestCamo_khk",
			"V_HarnessO_brn","V_HarnessOGL_brn","V_HarnessO_gry","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry",
			"V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_RebreatherB","V_RebreatherIR","V_RebreatherIA",
			"V_PlateCarrier_Kerry","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_I_G_resistanceLeader_F","V_Press_F"
		};
		aiRifles[] =
		{
			"srifle_EBR_F","srifle_DMR_01_F","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_MXC_F",
			"arifle_MX_F","arifle_MX_GL_F","arifle_MXM_F","arifle_SDAR_F","arifle_TRG21_F","arifle_TRG20_F",
			"arifle_TRG21_GL_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F",
			"arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F","arifle_MXM_Black_F",
			"arifle_MX_GL_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","LMG_Mk200_F","arifle_MX_SW_F",
			"LMG_Zafir_F","arifle_MX_SW_Black_F"
		};
		aiBackpacks[] =
		{
			"B_AssaultPack_khk","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_cbr",
			"B_AssaultPack_mcamo","B_TacticalPack_rgr","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_blk",
			"B_TacticalPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_cbr",
			"B_FieldPack_blk","B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_cbr",
			"B_Parachute","B_FieldPack_oli","B_Carryall_oli","B_Kitbag_Base","B_Kitbag_cbr","B_Kitbag_mcamo",
			"B_Kitbag_rgr","B_Kitbag_sgg","B_OutdoorPack_Base","B_OutdoorPack_blk","B_OutdoorPack_blu",
			"B_OutdoorPack_tan"
		};
		aiLaunchers[] =
		{
			"launch_NLAW_F","launch_RPG32_F","launch_B_Titan_F","launch_B_Titan_short_F"
		};
		aiPistols[] =
		{
			"hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F"
		};
	};
};

#include "cpp\CfgPatches.cpp"
#include "cpp\CfgFunctions.cpp"
