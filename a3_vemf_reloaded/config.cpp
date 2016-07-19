/*
   Author: IT07

   Description:
	cpp config file for a3_vemf_reloaded

	What is a3_vemf_reloaded? (short: VEMFr)
	It is a complete rebuild/remake of VEMF (for Epoch) made by TheVampire.
	a3_vemf_reloaded was originally called VEMF but because the original creator (TheVampire) wanted to continue his work on VEMF,
	this remade version of VEMF had its name changed into a3_vemf_reloaded.
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
		sayKilledName = 0; // Enable/disable the usage of AI's names instead of just "AI"
	 	timeOutTime = 25; // Enable/disable mission timeOutTime (in minutes)
		validateLoot = 1; // Enable/disable validation of all defined loot classnames. Checks if classnames exist in server's game configFile

		class blacklists
		{
			class buildings
			{
				classes[] = {"Land_Pier_F","Land_Shed_02_F"};
			};
			class locations
			{
				// NOTE 1: If the map you use is not listed below, simply add it by yourself or put the locations you want to blacklist into the locations array of the Other class
				// NOTE 2: If not sure about capital letters, just type all names in lowercase
				class Altis { names[] = {"almyra","atsalis","cap makrinos","chelonisi","fournos","kavala","makrynisi","monisi","polemista","pyrgos","pyrgi","sagonisi","savri","selakano","sofia","surf club","syrta","zaros"}; };
				class Stratis { names[] = {"jay cove","kamino bay","keiros bay","kyfi bay","limeri bay","marina bay","nisi bay","strogos bay","tsoukala bay"}; };
				class Namalsk { names[] = {"brensk bay","lubjansk bay","nemsk bay","seraja bay","sebjan mine","tara strait"}; };
				class Other { names[] = {}; };
				class Tanoa { names[] = {"ferry","Regina","nicolet","petit nicolet","galili","la foa","lakatoro","kotomo","comms bravo","pénélo","la rochelle aerodrome","red spring surface mine","ovau","nandai"}; };
			};
			class loot
			{
				classes[] = {
					"DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag",
					"APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag",
					"ChainSaw","srifle_DMR_03_spotter_F"
				};
			};
		};

		class Exile // Exile specific settings
			{
				aiMode = 1; // 0 = Guerilla | 1 = Regular Police | 2 = Police SF (Special Forces) | 3 = Gendarmerie (needs Apex DLC) | 4 = Apex Bandits (needs Apex DLC)
				respectReward = 5; // 0 = no respect for killing AI | respectReward > 0 = amount of minimum respect reward for player
				respectRoadKillDeduct = 20; // 0 = no deduction for roadkilling AI | respectRoadKillDeduct > 0 = amount of respect to take from player;
				// AI Unit settings
				unitClass = "O_G_Sharpshooter_F"; // Default: "O_G_Sharpshooter_F" | optional: "B_G_Soldier_AR_F"
				// NOTE: VEMFr will automatically adjust to the AI's side that belongs to the unit of given unitClass
			};

		class Epoch // Epoch specific settings
			{
				aiMode = 0; // 0 = Guerilla | 1 = Regular Police | 2 = Police SF (Special Forces) | 3 = Gendarmerie (needs Apex DLC) | 4 = Apex Bandits (needs Apex DLC)
				cryptoReward = 5; // Minimal crypto gain. VEMFr dynamically adds more depending on shooting skills
				cryptoRoadKillPunish = 20; // 0 = no punishment for road-killing AI | energyRoadKillPunish > 0 = amount of energy to take from player
				unitClass = "I_G_Soldier_lite_F"; // Default: "I_G_Soldier_lite_F"
				// NOTE: VEMFr will automatically adjust to the AI's side that belongs to the unit of given unitClass
			};

		class missionSettings
			{
				class BaseAttack // BaseAttack (mission) settings
					{
						aiSetup[] = {2,5}; // format: {amountOfGroups,unitsInEachGroup};
						allowLaunchers = 1; // Allow/disallow AI to have rocket launchers
						hasLauncherChance = 25; // In percentage. How big the chance that each AI gets a launcher
						maxAttacks = 5; // Maximum amount of active attacks at the same time | can not be turned off
						minimumLevel = 2; // Minimum required level of base before it can get attacked
						randomModes = 0; // Enable/disable the randomization of the AI mode for this mission-type
						/*
							NOTES:
							1) every territory flag can only be attacked once every restart
							2) only players within a certain range of the attacked territory can see the mission announcement
							3) as a "punishment" for killing AI, players do NOT get any respect increase/decrease for killing AI
						*/
					};

				class DynamicLocationInvasion // DynamicLocationInvasion (mission) settings
					{
						allowCrateLift = 0; // Allow/disallow the loot crate to be lifted with helicopter
						allowLaunchers = 1; // Allow/disallow AI to have rocket launchers
						allowRepeat = 0; // Allow/disallow re-invading of a previously invaded city/town/location
						announce = 1; // Enable/disable mission notificatons
						cal50s = 3; // Max amount of .50 caliber machineguns at mission | Needs to be lower than total unit count per mission
						cal50sDelete = 1; // Enable/disable the removal of .50cal | 2 = destroy (not remove)

						class crateSettings
						{
							allowThermalHelmets = 0; // Allow/disallow special (Apex) thermal-vision helmets in loot crate

							rifleSlotsMax = 7; // Maximum primary weapons in each loot crate
							rifleSlotsMin = 2; // Minimum primary weapons in each loot crate
							pistolSlotsMax = 3; // Maximum number of secondary weapons to be in each loot crate
							pistolSlotsMin = 1; // Minimum number of secondary weapons to be in each loot crate
							magSlotsMax = 8; // Maximum number of magazine slots in each loot crate
							magSlotsMin = 6; // Minimum number of magazine slots in each loot crate
							attSlotsMax = 4; // Maximum number of attachment slots in each loot crate
							attSlotsMin = 2; // Minimum number of attachment slots in each loot crate
							itemSlotsMax = 4; // Maximum number of attachment slots in each loot crate
							itemSlotsMin = 2; // Minimum number of attachment slots in each loot crate
							vestSlotsMax = 3; // Maximum number of vest slots in each loot crate
							vestSlotsMin = 1; // Minimum number of vest slots in each loot crate
							headGearSlotsMax = 3; // Maximum number of headGear slots in each loot crate
							headGearSlotsMin = 1; // Minimum number of headGear slots in each loot crate
							bagSlotsMax = 2;
							bagSlotsMin = 1;
						};

						class crateLootVanilla // Loot crate configuration (vanilla items)
							{
								// format: {classname,amount}
								// WARNING: DO NOT USE NUMBERS WITH DECIMALS!
								attachments[] = {
									{"ItemGPS",2},{"ItemRadio",1},{"ItemMap",2},{"MineDetector",1},{"Binocular",2},{"Rangefinder",1},{"muzzle_snds_H",1},
									{"muzzle_snds_L",1},{"muzzle_snds_M",1},{"muzzle_snds_B",1},{"muzzle_snds_H_MG",1},{"muzzle_snds_H_SW",1},
									{"optic_Arco",1},{"optic_Aco",1},{"optic_ACO_grn",1},{"optic_Aco_smg",1},{"optic_ACO_grn_smg",1},{"optic_Holosight",1},
									{"optic_Holosight_smg",1},{"optic_SOS",1},{"acc_flashlight",1},{"acc_pointer_IR",1},{"optic_MRCO",1},{"muzzle_snds_acp",1},
									{"optic_NVS",1},{"optic_DMS",1},{"optic_Yorris",1},{"optic_MRD",1},{"optic_LRPS",1},{"muzzle_snds_338_black",1},{"muzzle_snds_338_green",1},
									{"muzzle_snds_338_sand",1},{"muzzle_snds_93mmg",1},{"muzzle_snds_93mmg_tan",1},{"optic_AMS",1},{"optic_AMS_khk",1},{"bipod_03_F_oli",1},
									{"optic_AMS_snd",1},{"optic_KHS_blk",1},{"optic_KHS_hex",1},{"optic_KHS_old",1},{"optic_KHS_tan",1},{"bipod_01_F_snd",1},
									{"bipod_01_F_blk",1},{"bipod_01_F_mtp",1},{"bipod_02_F_blk",1},{"bipod_02_F_tan",1},{"bipod_02_F_hex",1},{"bipod_03_F_blk",1}
								};
								backpacks[] = {
									{"B_AssaultPack_khk",1},{"B_AssaultPack_dgtl",1},{"B_AssaultPack_rgr",1},{"B_AssaultPack_sgg",1},{"B_AssaultPack_cbr",1},
									{"B_AssaultPack_mcamo",1},{"B_TacticalPack_rgr",1},{"B_TacticalPack_mcamo",1},{"B_TacticalPack_ocamo",1},{"B_TacticalPack_blk",1},
									{"B_TacticalPack_oli",1},{"B_FieldPack_khk",1},{"B_FieldPack_ocamo",1},{"B_FieldPack_oucamo",1},{"B_FieldPack_cbr",1},
									{"B_FieldPack_blk",1},{"B_Carryall_ocamo",1},{"B_Carryall_oucamo",1},{"B_Carryall_mcamo",1},{"B_Carryall_khk",1},{"B_Carryall_cbr",1},
									{"B_Parachute",1},{"B_FieldPack_oli",1},{"B_Carryall_oli",1},{"B_Kitbag_Base",1},{"B_Kitbag_cbr",1},{"B_Kitbag_mcamo",1},
									{"B_Kitbag_rgr",1},{"B_Kitbag_sgg",1},{"B_OutdoorPack_Base",1},{"B_OutdoorPack_blk",1},{"B_OutdoorPack_tan",1}
								};
								headGear[] = {
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
								itemsExile[] = {
									{"Exile_item_Bandage",5},{"Exile_item_BaseCameraKit",1},{"Exile_Item_BBQSandwich",4},{"Exile_Item_BBQSandwich_Cooked",3},{"Exile_Item_BeefParts",3},{"Exile_Item_Beer",5},{"Exile_Item_BushKit_Green",1},
									{"Exile_Item_CamoTentKit",1},{"Exile_Item_CampFireKit",1},{"Exile_Item_CanOpener",2},{"Exile_Item_CarWheel",2},{"Exile_Item_CatFood",3},{"Exile_Item_CatFood_Cooked",3},{"Exile_Item_Cement",2},{"Exile_Item_Cheathas",5},
									{"Exile_Item_ChocolateMilk",4},{"Exile_Item_ChristmasTinner",4},{"Exile_Item_ChristmasTinner_Cooked",2},{"Exile_Item_CockONut",4},{"Exile_Item_Codelock",1},{"Exile_Item_ConcreteDoorKit",1},{"Exile_Item_ConcreteDoorwayKit",1},
									{"Exile_Item_ConcreteFloorKit",1},{"Exile_Item_ConcreteFloorPortKit",1},{"Exile_Item_ConcreteGateKit",1},{"Exile_Item_ConcreteStairsKit",1},{"Exile_Item_ConcreteSupportKit",1},{"Exile_Item_ConcreteWallKit",1},
									{"Exile_Item_ConcreteWindowKit",1},{"Exile_Item_CookingPot",2},{"Exile_Item_CordlessScrewdriver",1},{"Exile_Item_Defibrillator",1},{"Exile_Item_DogFood",3},{"Exile_Item_DogFood_Cooked",2},{"Exile_Item_DsNuts",3},
									{"Exile_Item_DuctTape",4},{"Exile_Item_EMRE",3},{"Exile_Item_EnergyDrink",4},{"Exile_Item_ExtensionCord",1},{"Exile_Item_FireExtinguisher",1},{"Exile_Item_Flag",1},{"Exile_Item_FlagStolen1",1},{"Exile_Item_FlagStolen2",1},
									{"Exile_Item_FlagStolen3",1},{"Exile_Item_FlagStolen4",1},{"Exile_Item_FloodLightKit",1},{"Exile_Item_Foolbox",1},{"Exile_Item_FortificationUpgrade",2},{"Exile_Item_FuelBarrelEmpty",2},{"Exile_Item_FuelBarrelFull",1},
									{"Exile_Item_FuelCanisterEmpty",2},{"Exile_Item_FuelCanisterFull",1},{"Exile_Item_GloriousKnakworst",5},{"Exile_Item_GloriousKnakworst_Cooked",3},{"Exile_Item_Grinder",1},{"Exile_Item_Hammer",2},{"Exile_Item_Handsaw",2},
									{"Exile_Item_HBarrier5Kit",1},{"Exile_Item_Heatpack",4},{"Exile_Item_InstaDoc",4},{"Exile_Item_InstantCoffee",4},{"Exile_Item_Knife",2},{"Exile_Item_Laptop",1},{"Exile_Item_Leaves",3},{"Exile_Item_LightBulb",2},
									{"Exile_Item_MacasCheese",4},{"Exile_Item_MacasCheese_Cooked",3},{"Exile_Item_Magazine01",4},{"Exile_Item_Magazine02",5},{"Exile_Item_Magazine03",3},{"Exile_Item_Magazine04",3},{"Exile_Item_Matches",3},{"Exile_Item_MetalBoard",2},
									{"Exile_Item_MetalHedgehogKit",2},{"Exile_Item_MetalPole",2},{"Exile_Item_MetalScrews",6},{"Exile_Item_MetalWire",3},{"Exile_Item_MobilePhone",1},{"Exile_Item_Moobar",3},{"Exile_Item_MountainDupe",4},{"Exile_Item_Noodles",3},
									{"Exile_Item_OilCanister",2},{"Exile_Item_PlasticBottleCoffee",3},{"Exile_Item_PlasticBottleEmpty",5},{"Exile_Item_PlasticBottleFreshWater",4},{"Exile_Item_Pliers",2},{"Exile_Item_PortableGeneratorKit",1},{"Exile_Item_PowerDrink",3},
									{"Exile_Item_Raisins",3},{"Exile_Item_RazorWireKit",1},{"Exile_Item_RepairKitConcrete",2},{"Exile_Item_RepairKitMetal",2},{"Exile_Item_RepairKitWood",4},{"Exile_Item_Rope",2},{"Exile_Item_RubberDuck",2},{"Exile_Item_SafeKit",1},
									{"Exile_Item_Sand",1},{"Exile_Item_SandBagsKit_Corner",2},{"Exile_Item_SandBagsKit_Long",1},{"Exile_Item_SausageGravy",4},{"Exile_Item_SausageGravy_Cooked",3},{"Exile_Item_Screwdriver",2},{"Exile_Item_SeedAstics",4},{"Exile_Item_Shovel",2},
									{"Exile_Item_SleepingMat",2},{"Exile_Item_Storagecratekit",1},{"Exile_Item_Surstromming",4},{"Exile_Item_Surstromming_Cooked",3},{"Exile_Item_ThermalScannerPro",1},{"Exile_Item_ToiletPaper",4},{"Exile_Item_Vishpirin",4},
									{"Exile_Item_WaterBarrelKit",1},{"Exile_Item_WaterCanisterDirtyWater",3},{"Exile_Item_WaterCanisterEmpty",5},{"Exile_Item_WireFenceKit",1},{"Exile_Item_WoodDoorKit",1},{"Exile_Item_WoodDoorwayKit",1},{"Exile_Item_WoodFloorKit",1},
									{"Exile_Item_WoodFloorPortKit",1},{"Exile_Item_WoodGateKit",1},{"Exile_Item_WoodLog",2},{"Exile_Item_WoodPlank",4},{"Exile_Item_WoodStairsKit",1},{"Exile_Item_WoodSticks",2},{"Exile_Item_WoodSupportKit",1},{"Exile_Item_WoodWallHalfKit",1},
									{"Exile_Item_WoodWallKit",1},{"Exile_Item_WoodWindowKit",1},{"Exile_Item_WorkBenchKit",2},{"Exile_Item_Wrench",2},{"Exile_Item_ZipTie",3},{"Exile_Magazine_100Rnd_762x54_PK_Green",4},{"Exile_Magazine_10Rnd_303",10},{"Exile_Magazine_10Rnd_762x54",11},
									{"Exile_Magazine_10Rnd_9x39",9},{"Exile_Magazine_20Rnd_762x51_DMR",7},{"Exile_Magazine_20Rnd_762x51_DMR_Green",8},{"Exile_Magazine_20Rnd_762x51_DMR_Red",8},{"Exile_Magazine_20Rnd_762x51_DMR_Yellow",8},{"Exile_Magazine_20Rnd_9x39",9},
									{"Exile_Magazine_30Rnd_545x39_AK",10},{"Exile_Magazine_30Rnd_545x39_AK_Green",8},{"Exile_Magazine_30Rnd_545x39_AK_Red",8},{"Exile_Magazine_30Rnd_545x39_AK_White",8},{"Exile_Magazine_30Rnd_545x39_AK_Yellow",7},{"Exile_Magazine_30Rnd_762x39_AK",11},
									{"Exile_Magazine_45Rnd_545x39_RPK_Green",6},{"Exile_Magazine_5Rnd_22LR",10},{"Exile_Magazine_6Rnd_45ACP",13},{"Exile_Magazine_75Rnd_545x39_RPK_Green",7},{"Exile_Magazine_7Rnd_45ACP",9},{"Exile_Magazine_8Rnd_74Pellets",13},{"Exile_Magazine_8Rnd_74Slug",12},
									{"Exile_Magazine_8Rnd_9x18",11},{"Exile_Magazine_Battery",2},{"Exile_Magazine_Boing",3},{"Exile_Magazine_Swing",3},{"Exile_Magazine_Swoosh",2}
								};
								itemsEpoch[] = {
									{"ChickenCarcass_EPOCH",3},{"CinderBlocks",1},{"clean_water_epoch",4},{"CircuitParts",2},{"ColdPack",4},{"CookedChicken_EPOCH",3},{"CookedDog_EPOCH",2},
									{"CookedGoat_EPOCH",3},{"CookedRabbit_EPOCH",3},{"CookedSheep_EPOCH",3},{"CSGAS",2},{"DogCarcass_EPOCH",2},{"EnergyPack",4},{"EnergyPackLg",2},{"FoodBioMeat",4},
									{"FoodMeeps",4},{"FoodSnooter",4},{"FoodWalkNSons",4},{"GoatCarcass_EPOCH",2},{"Goldenseal",1},{"hatchet_swing",2},{"HeatPack",3},{"honey_epoch",3},{"WoodLog_EPOCH",1},
									{"ItemAluminumBar",2},{"ItemAmethyst",2},{"ItemBarrelE",2},{"ItemBarrelF",1},{"ItemBattery",2},{"ItemBriefcaseE",1},{"ItemBulb",4},{"ItemBurlap",3},{"ItemCables",3},
									{"ItemComboLock",1},{"ItemCooler0",1},{"ItemCooler1",1},{"ItemCooler2",1},{"ItemCooler3",1},{"ItemCooler4",1},{"ItemCoolerE",2},{"ItemCopperBar",2},{"ItemGoldBar",1},
									{"ItemHotwire",1},{"ItemLockbox",1},{"ItemMixOil",1},{"ItemPipe",1},{"ItemPlywoodPack",1},{"ItemRope",3},{"ItemSafe",1},{"ItemSeaBass",4},{"ItemSeaBassCooked",1},
									{"ItemSilverBar",1},{"ItemSodaAlpineDude",2},{"ItemSodaBurst",4},{"ItemSodaMocha",4},{"ItemSodaOrangeSherbet",2},{"ItemSodaPurple",3},{"ItemSodaRbull",2},{"ItemSolar",1},
									{"ItemStick",4},{"ItemTinBar",2},{"ItemTrout",4},{"ItemTroutCooked",2},{"ItemTuna",4},{"ItemTunaCooked",2},{"jerrycan_epoch",1},{"jerrycanE_epoch",2},{"KitCinderWall",1},
									{"KitFirePlace",1},{"KitFoundation",1},{"KitHesco3",1},{"KitMetalTrap",1},{"KitPlotPole",1},{"KitShelf",1},{"KitSolarGen",1},{"KitSpikeTrap",1},{"KitStudWall",1},{"KitTankTrap",1},
									{"KitTiPi",1},{"KitWoodFloor",1},{"KitWoodFoundation",1},{"KitWoodLadder",1},{"KitWoodRamp",1},{"KitWoodStairs",1},{"KitWoodTower",1},{"KitWorkbench",1},{"lighter_epoch",2},
									{"meatballs_epoch",3},{"MortarBucket",1},{"PaintCanBlk",1},{"PaintCanBlu",1},{"PaintCanBrn",1},{"PaintCanClear",1},{"PaintCanGrn",1},{"PaintCanOra",1},{"PaintCanPur",1},
									{"PaintCanRed",1},{"PaintCanTeal",1},{"PaintCanYel",1},{"PartPlankPack",1},{"Pelt_EPOCH",1},{"RabbitCarcass_EPOCH",2},{"sardines_epoch",3},{"scam_epoch",3},{"SheepCarcass_EPOCH",2},
									{"sledge_swing",2},{"SnakeCarcass_EPOCH",2},{"SnakeMeat_EPOCH",2},{"spear_magazine",2},{"stick_swing",2},{"sweetcorn_epoch",4},{"TacticalBacon",3},{"water_epoch",4},{"WhiskeyNoodle",3}
								};
								magazines[] = {
									{"30Rnd_556x45_Stanag",12},{"30Rnd_556x45_Stanag_Tracer_Red",10},{"30Rnd_556x45_Stanag_Tracer_Green",12},
									{"30Rnd_556x45_Stanag_Tracer_Yellow",9},{"30Rnd_65x39_caseless_mag",12},{"30Rnd_65x39_caseless_green",11},{"30Rnd_65x39_caseless_mag_Tracer",10},
									{"30Rnd_65x39_caseless_green_mag_Tracer",11},{"20Rnd_762x51_Mag",8},{"7Rnd_408_Mag",7},{"5Rnd_127x108_Mag",6},{"100Rnd_65x39_caseless_mag",11},
									{"100Rnd_65x39_caseless_mag_Tracer",4},{"200Rnd_65x39_cased_Box",3},{"200Rnd_65x39_cased_Box_Tracer",3},{"30Rnd_9x21_Mag",13},{"16Rnd_9x21_Mag",16},
									{"30Rnd_45ACP_Mag_SMG_01",14},{"30Rnd_45ACP_Mag_SMG_01_Tracer_Green",12},{"9Rnd_45ACP_Mag",14},{"150Rnd_762x51_Box",7},{"150Rnd_762x51_Box_Tracer",6},
									{"150Rnd_762x54_Box",4},{"150Rnd_762x54_Box_Tracer",4},{"11Rnd_45ACP_Mag",11},{"6Rnd_45ACP_Cylinder",9},{"10Rnd_762x51_Mag",11},{"10Rnd_762x54_Mag",14},
									{"5Rnd_127x108_APDS_Mag",7},{"10Rnd_338_Mag",6},{"130Rnd_338_Mag",3},{"10Rnd_127x54_Mag",9},{"150Rnd_93x64_Mag",3},{"10Rnd_93x64_DMR_05_Mag",5}
								};
								pistols[] = {{"hgun_ACPC2_F",3},{"hgun_P07_F",3},{"hgun_Pistol_heavy_01_F",3},{"hgun_Pistol_heavy_02_F",3},{"hgun_Rook40_F",3}};
								rifles[] = {
									{"srifle_DMR_01_F",1},{"srifle_EBR_F",1},{"srifle_GM6_F",1},{"LMG_Mk200_F",1},{"LMG_Zafir_F",1},{"arifle_Katiba_F",1},{"arifle_Katiba_GL_F",1},{"arifle_Mk20_F",2},
									{"arifle_Mk20_plain_F",2},{"arifle_Mk20C_F",2},{"arifle_Mk20C_plain_F",2},{"arifle_Mk20_GL_F",2},{"arifle_Mk20_GL_plain_F",2},{"arifle_MXC_F",1},{"arifle_MX_F",1},
									{"arifle_MX_GL_F",1},{"arifle_MX_SW_F",1},{"arifle_MXM_F",1},{"arifle_MXC_Black_F",1},{"arifle_MX_Black_F",1},{"arifle_MX_GL_Black_F",1},{"arifle_MX_SW_Black_F",1},
									{"arifle_MXM_Black_F",1},{"arifle_SDAR_F",2},{"arifle_TRG21_F",2},{"arifle_TRG20_F",2},{"arifle_TRG21_GL_F",2},{"SMG_01_F",2},{"SMG_02_F",2},{"srifle_GM6_camo_F",1},
									{"srifle_LRR_camo_F",1},{"srifle_DMR_02_F",1},{"srifle_DMR_02_camo_F",1},{"srifle_DMR_02_sniper_F",1},{"srifle_DMR_03_F",1},{"srifle_DMR_03_khaki_F",1},{"srifle_DMR_03_tan_F",1},
									{"srifle_DMR_03_multicam_F",1},{"srifle_DMR_03_woodland_F",1},{"srifle_DMR_04_F",1},{"srifle_DMR_04_Tan_F",1},{"srifle_DMR_05_blk_F",1},{"srifle_DMR_05_hex_F",1},
									{"srifle_DMR_05_tan_f",1},{"srifle_DMR_06_camo_F",1},{"srifle_DMR_06_olive_F",1},{"MMG_01_hex_F",1},{"MMG_01_tan_F",1},{"MMG_02_camo_F",1},{"MMG_02_black_F",1},{"MMG_02_sand_F",1}
								};
								vests[] = {
									{"V_PlateCarrier1_rgr",1},{"V_PlateCarrier2_rgr",1},{"V_PlateCarrier3_rgr",1},{"V_PlateCarrierGL_rgr",1},{"V_PlateCarrier1_blk",1},
									{"V_PlateCarrierSpec_rgr",1},{"V_Chestrig_khk",1},{"V_Chestrig_rgr",1},{"V_Chestrig_blk",1},{"V_Chestrig_oli",1},{"V_TacVest_khk",1},
									{"V_TacVest_brn",1},{"V_TacVest_oli",1},{"V_TacVest_blk",1},{"V_TacVest_camo",1},{"V_TacVest_blk_POLICE",1},{"V_TacVestIR_blk",1},{"V_TacVestCamo_khk",1},
									{"V_HarnessO_brn",1},{"V_HarnessOGL_brn",1},{"V_HarnessO_gry",1},{"V_HarnessOGL_gry",1},{"V_HarnessOSpec_brn",1},{"V_HarnessOSpec_gry",1},
									{"V_PlateCarrierIA1_dgtl",1},{"V_PlateCarrierIA2_dgtl",1},{"V_PlateCarrierIAGL_dgtl",1},{"V_RebreatherB",1},{"V_RebreatherIR",1},{"V_RebreatherIA",1},
									{"V_PlateCarrier_Kerry",1},{"V_PlateCarrierL_CTRG",1},{"V_PlateCarrierH_CTRG",1},{"V_I_G_resistanceLeader_F",1},{"V_Press_F",1}
								};
							};

						class crateLootApex // Classnames of (only) Apex Expansion content | classes will be mixed with vanilla if server has Apex
							{
								// Format: {classname,amount}
								attachments[] = {
									{"optic_Arco_blk_F",1},{"optic_Arco_ghex_F",1},{"optic_DMS_ghex_F",1},{"optic_ERCO_blk_F",1},{"optic_ERCO_khk_F",1},{"optic_ERCO_snd_F",1},{"optic_LRPS_ghex_F",1},
									{"optic_LRPS_tna_F",1},{"optic_Holosight_blk_F",1},{"optic_Holosight_khk_F",1},{"optic_Holosight_smg_blk_F",1},{"optic_SOS_khk_F",1},{"optic_Hamr_khk_F",1},
									{"muzzle_snds_B_khk_F",1},{"muzzle_snds_B_snd_F",1},{"bipod_01_F_khk",1},{"muzzle_snds_58_blk_F",1},{"muzzle_snds_58_wdm_F",1},{"muzzle_snds_H_khk_F",1},
									{"muzzle_snds_H_snd_F",1},{"muzzle_snds_m_khk_F",1},{"muzzle_snds_m_snd_F",1},{"muzzle_snds_65_TI_blk_F",1},{"muzzle_snds_65_TI_ghex_F",1},{"muzzle_snds_65_TI_hex_F",1}
								};
								backpacks[] = {
									{"B_AssaultPack_tna_F",1},{"B_Bergen_dgtl_F",1},{"B_Bergen_hex_F",1},{"B_Bergen_mcamo_F",1},{"B_Bergen_tna_F",1},{"B_Carryall_ghex_F",1},{"B_FieldPack_ghex_F",1},
									{"B_ViperHarness_blk_F",1},{"B_ViperHarness_ghex_F",1},{"B_ViperHarness_hex_F",1},{"B_ViperHarness_khk_F",1},{"B_ViperHarness_oli_F",1},{"B_ViperLightHarness_blk_F",1},
									{"B_ViperLightHarness_ghex_F",1},{"B_ViperLightHarness_hex_F",1},{"B_ViperLightHarness_khk_F",1},{"B_ViperLightHarness_oli_F",1}
								};
								headGear[] = {
									{"H_HelmetSpecO_ghex_F",1},{"H_Booniehat_tna_F",1},{"H_HelmetB_tna_F",1},{"H_HelmetCrew_O_ghex_F",1},{"H_HelmetLeaderO_ghex_F",1},{"H_HelmetB_Enh_tna_F",1},{"H_HelmetB_Light_tna_F",1},
									{"H_MilCap_ghex_F",1},{"H_MilCap_tna_F",1},{"H_HelmetO_ghex_F",1},{"H_Helmet_Skate",1},{"H_HelmetB_TI_tna_F",1}
								};
								headGearSpecial[] = {
									{"H_HelmetO_ViperSP_ghex_F",1},{"H_HelmetO_ViperSP_hex_F",1}
								};
								magazines[] = {
									{"10Rnd_9x21_Mag",5},{"30Rnd_580x42_Mag_F",10},{"30Rnd_580x42_Mag_Tracer_F",8},{"100Rnd_580x42_Mag_F",7},{"100Rnd_580x42_Mag_Tracer_F",6},{"20Rnd_650x39_Cased_Mag_F",8},
									{"10Rnd_50BW_Mag_F",6},{"150Rnd_556x45_Drum_Mag_F",5},{"150Rnd_556x45_Drum_Mag_Tracer_F",4},{"30Rnd_762x39_Mag_F",8},{"30Rnd_762x39_Mag_Green_F",9},{"30Rnd_762x39_Mag_Tracer_F",9},
									{"30Rnd_762x39_Mag_Tracer_Green_F",8},{"30Rnd_545x39_Mag_F",11},{"30Rnd_545x39_Mag_Green_F",9},{"30Rnd_545x39_Mag_Tracer_F",8},{"30Rnd_545x39_Mag_Tracer_Green_F",9},
									{"200Rnd_556x45_Box_F",5},{"200Rnd_556x45_Box_Red_F",4},{"200Rnd_556x45_Box_Tracer_F",4},{"200Rnd_556x45_Box_Tracer_Red_F",4},{"RPG7_F",2}
								};
								pistols[] = {{"hgun_P07_khk_F",2},{"hgun_Pistol_01_F",2}};
								rifles[] = {
									{"arifle_AK12_F",1},{"arifle_AK12_GL_F",1},{"arifle_AKM_F",2},{"arifle_AKS_F",2},{"arifle_CTAR_blk_F",1},{"arifle_CTAR_ghex_F",1},{"arifle_CTAR_hex_F",1},{"arifle_CTAR_GL_blk_F",1},
									{"arifle_CTAR_GL_ghex_F",1},{"arifle_CTAR_GL_hex_F",1},{"arifle_CTARS_blk_F",1},{"arifle_CTARS_ghex_F",1},{"arifle_CTARS_hex_F",1},{"srifle_DMR_07_blk_F",1},{"srifle_DMR_07_ghex_F",1},
									{"srifle_DMR_07_hex_F",1},{"srifle_GM6_ghex_F",1},{"LMG_03_F",1},{"srifle_LRR_tna_F",1},{"arifle_MX_GL_khk_F",1},{"arifle_MX_khk_F",1},{"arifle_MX_SW_khk_F",1},{"arifle_MXC_khk_F",1},
									{"arifle_MXM_khk_F",1},{"SMG_05_F",2},{"arifle_SPAR_01_blk_F",1},{"arifle_SPAR_01_khk_F",1},{"arifle_SPAR_01_snd_F",1},{"arifle_SPAR_01_GL_blk_F",1},{"arifle_SPAR_01_GL_khk_F",1},
									{"arifle_SPAR_01_GL_snd_F",1},{"arifle_SPAR_02_blk_F",1},{"arifle_SPAR_02_khk_F",1},{"arifle_SPAR_02_snd_F",1},{"arifle_SPAR_03_blk_F",1},{"arifle_SPAR_03_khk_F",1},{"arifle_SPAR_03_snd_F",1},
									{"arifle_ARX_blk_F",1},{"arifle_ARX_ghex_F",1},{"arifle_ARX_hex_F",1}
								};
								vests[] = {
									{"V_PlateCarrierGL_tna_F",1},{"V_PlateCarrier1_rgr_noflag_F",1},{"V_PlateCarrier1_tna_F",1},{"V_PlateCarrier2_rgr_noflag_F",1},{"V_PlateCarrier2_tna_F",1},{"V_PlateCarrierSpec_tna_F",1},
									{"V_HarnessOGL_ghex_F",1},{"V_HarnessO_ghex_F",1},{"V_BandollierB_ghex_F",1},{"V_TacChestrig_cbr_F",1},{"V_TacChestrig_grn_F",1},{"V_TacChestrig_oli_F",1}
								};
							};

						class crateParachute
							{
								enabled = 0; // Enable/disable parachute of the loot crate
								altitude = 250; // loot crate spawn-altitude in meters
							};
						crateTypes[] = {"Box_FIA_Ammo_F","Box_FIA_Support_F","Box_FIA_Wps_F","I_SupplyCrate_F","Box_IND_AmmoVeh_F","Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F"};
						flairTypes[] = {"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"};
						groupCount[] = {2,4}; // In format: {minimum, maximum}; VEMF will pick a random number between min and max. If you want the same amount always, use same numbers for minimum and maximum.
						groupUnits[] = {4,6}; // How much units in each group. Works the same like groupCount
						hasLauncherChance = 25; // In percentage. How big the chance that each AI gets a launcher

						class heliPatrol
							{
								enabled = 1;
								classesVanilla[] = {"B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F","O_Heli_Light_02_v2_F","I_Heli_light_03_F"}; // the types of heli(s)
								classesHeliDLC[] = {};
								classesApex[] = {"B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F"};
								locked = 0; // Enable/disable heli lock to prevent/allow players from flying it
							};

						useMarker = 1; // Enable/disable mission markers
						markCrateOnMap = 1; // Enable/disable loot crate marker on map called "Loot"
						markCrateVisual = 1; // Enable/disable loot crate VISUAL marker (smoke and/or chem)
						/* maxDistance NOTE: make sure to keep this number very high. 15000 is for Altis */
						maxDistancePrefered = 7000; // Prefered maximum mission distance from player
						maxInvasions = 7; // Max amount of active uncompleted invasions allowed at the same time
						mines = 0; // Enable/disable mines at mission | 1 = anti-Armor mines | 2 = anti-Personell mines | 3 = both anti-Armor and anti-Personell mines
						minesAmount = 20; // Ignore if mines = 0;
						minesCleanup = 1; // Enable/disable the removal of mines once mission has been completed | 2 = explode mines
						nonPopulated = -1; // Allow/disallow this mission type being placed at locations without buildings | using -1 will ignore this setting and use the global settting
						randomModes = 1; // Enable/disable randomization of AI types (linked to aiMode setting)
				   	skipDistance = 800; // No missions at locations which have players within this range (in meters)
						skipDistanceReversed = 0; // If set higher than 0, missions will only spawn if player is at least given amount (in meters) away from a location whilst at the same time not be further away than twice the given number (in meters)
						smokeTypes[] = {"SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"};
						spawnCrateFirst = 0; // Enable/disable the spawning of loot crate before mission has been completed
				   	streetLights = 0; // Enable/disable street lights at mission location
				   	streetLightsRestore = 1; // Enable/disable restoration of street lights after mission completion
				   	streetLightsRange = 500; // Affects streetlights within this distance from mission's center
					};
			};

		class aiCleanUp // Contains settings for removal of items from each AI that gets eliminated
			{
				aiDeathRemovalEffect = 0; // Enable/disable the "death effect" from Virtual Arsenal. Flashes AI and deletes it after being eliminated
				removeHeadGear = 0; // Enable/disable removal of headgear after AI has been eliminated, obviously
				removeLaunchers = 0; // Enable/disable removal of rocket launchers from AI after they are eliminated
			};

		class aiInventory
			{
				class ApexBandits
					{
						backpacks[] = {
							"B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_ocamo","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_sgg","B_AssaultPack_tna_F",
							"B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ghex_F","B_FieldPack_ocamo","B_FieldPack_khk","B_FieldPack_oli","B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_mcamo","B_Kitbag_sgg","B_TacticalPack_blk",
							"B_TacticalPack_rgr","B_TacticalPack_ocamo","B_TacticalPack_mcamo","B_TacticalPack_oli"
						};
						faceWear[] = {"G_Balaclava_blk","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_tan"};
						headGear[] = {"H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_khk_hs","H_Bandanna_khk","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_camo","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_tan","H_ShemagOpen_khk"};
						launchers[] = {"launch_RPG7_F"};
						rifles[] = {"arifle_AK12_F","arifle_AKM_F","arifle_AKS_F","LMG_03_F"};
						uniforms[] = {"U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_3_F"};
						vests[] = {
							"V_Chestrig_blk","V_Chestrig_rgr","V_Chestrig_khk","V_Chestrig_oli","V_PlateCarrierIA1_dgtl","V_HarnessOGL_brn","V_HarnessOGL_ghex_F","V_HarnessOGL_gry","V_HarnessO_brn","V_HarnessO_ghex_F","V_HarnessO_gry","V_Rangemaster_belt",
							"V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_ghex_F","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli","V_TacChestrig_cbr_F","V_TacChestrig_grn_F","V_TacChestrig_oli_F"
						};
					};
				class Gendarmerie
					{
						headGear[] = {
							"H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_camo","H_Watchcap_khk","H_Beret_gen_F","H_MilCap_gen_F","H_Beret_blk","H_Beret_02","H_Cap_blk",
							"H_Cap_blu","H_Cap_police","H_MilCap_blue","H_MilCap_ghex_F","H_MilCap_gry","H_MilCap_ocamo","H_MilCap_tna_F","H_MilCap_dgtl","H_Cap_headphones"
						};
						faceWear[] = {
							"G_Aviator","G_Bandanna_aviator","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","G_Shades_Black",
							"G_Shades_Blue","G_Shades_Green","G_Shades_Red","G_Spectacles","G_Sport_Red","G_Sport_Blackyellow","G_Sport_BlackWhite","G_Sport_Blackred","G_Sport_Greenblack",
							"G_Squares_Tinted","G_Balaclava_TI_blk_F","G_Tactical_Clear","G_Tactical_Black","G_Spectacles_Tinted"
						};
						pistols[] = {"hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_P07_khk_F","hgun_Pistol_01_F","hgun_Rook40_F"};
						rifles[] = {
							"SMG_01_F","SMG_02_F","SMG_05_F","arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKS_F","arifle_CTAR_blk_F","arifle_CTAR_ghex_F",
							"arifle_CTAR_hex_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_ghex_F","arifle_CTAR_GL_hex_F","arifle_CTARS_blk_F","arifle_CTARS_ghex_F","arifle_CTARS_hex_F",
							"srifle_DMR_07_blk_F","srifle_DMR_07_ghex_F","srifle_DMR_07_hex_F","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_Mk20_plain_F",
							"arifle_Mk20_F","arifle_Mk20_GL_plain_F","arifle_Mk20_GL_F","arifle_Mk20C_plain_F","arifle_Mk20C_F","arifle_MX_F","arifle_MX_Black_F","arifle_MX_khk_F",
							"arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F","arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_MXM_Black_F",
							"arifle_MXM_khk_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F",
							"arifle_TRG20_F","arifle_TRG21_F"
						};
						uniforms[] = {"U_B_GEN_Commander_F","U_B_GEN_Soldier_F"};
						vests[] = {
							"V_TacVest_gen_F","V_Chestrig_blk","V_Chestrig_rgr","V_Chestrig_khk","V_Chestrig_oli","V_HarnessOGL_brn","V_HarnessOGL_ghex_F","V_HarnessO_brn","V_HarnessO_ghex_F",
							"V_TacVestIR_blk","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_ghex_F","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli","V_TacChestrig_cbr_F",
							"V_TacChestrig_grn_F","V_TacChestrig_oli_F","V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVest_blk_POLICE"
						};
					};
				class Guerilla
					{
						backpacks[] = {
							"B_AssaultPack_khk","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_cbr",
							"B_AssaultPack_mcamo","B_TacticalPack_rgr","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_blk",
							"B_TacticalPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_cbr",
							"B_FieldPack_blk","B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_cbr",
							"B_Parachute","B_FieldPack_oli","B_Carryall_oli","B_Kitbag_Base","B_Kitbag_cbr","B_Kitbag_mcamo",
							"B_Kitbag_rgr","B_Kitbag_sgg","B_OutdoorPack_Base","B_OutdoorPack_blk","B_OutdoorPack_blu","B_OutdoorPack_tan"
						};
						faceWear[] = {"G_Aviator","G_Balaclava_blk","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_sport","G_Bandanna_tan"};
						headGear[] = {
							"H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_khk_hs","H_Bandanna_khk","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_camo","H_Watchcap_blk",
							"H_Watchcap_cbr","H_Watchcap_camo","H_Watchcap_khk","H_Beret_blk","H_Cap_blk","H_Cap_grn","H_Cap_oli","H_Cap_oli_hs","H_Cap_tan","H_Cap_brn_SPECOPS","H_MilCap_gry",
							"H_MilCap_ocamo","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_tan","H_ShemagOpen_khk"
						};
						launchers[] = {"launch_NLAW_F","launch_RPG32_F","launch_B_Titan_F","launch_B_Titan_short_F"};
						rifles[] = {
							"arifle_Katiba_F","arifle_Katiba_C_F","srifle_EBR_F","arifle_Mk20_plain_F","arifle_Mk20_F","arifle_Mk20_GL_plain_F","arifle_Mk20_GL_F","LMG_Mk200_F","arifle_Mk20C_plain_F",
							"arifle_Mk20C_F","arifle_MX_F","arifle_MX_Black_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MXC_F","arifle_MXC_Black_F","arifle_MXM_F","arifle_MXM_Black_F",
							"srifle_DMR_01_F","arifle_TRG20_F","arifle_TRG21_F","SMG_01_F","LMG_Zafir_F"
						};
						uniforms[] = {
							"U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_leader"
						};
						vests[] = {
							"V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrier1_blk",
							"V_PlateCarrierSpec_rgr","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_blk","V_Chestrig_oli","V_TacVest_khk",
							"V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVest_blk_POLICE","V_TacVestIR_blk","V_TacVestCamo_khk",
							"V_HarnessO_brn","V_HarnessOGL_brn","V_HarnessO_gry","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry",
							"V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_I_G_resistanceLeader_F"
						};
					};
				class PoliceRegular
					{
						headGear[] = {
							"H_Cap_police","H_Beret_blk_POLICE","H_Cap_blk_ION","H_Cap_khaki_specops_UK","H_Cap_tan_specops_US","H_Cap_brn_SPECOPS","H_Cap_blk_CMMG","H_Cap_blk","H_Cap_blu","H_Cap_red",
							"H_Cap_press","H_Cap_usblack","H_Beret_brn_SF","H_Beret_Colonel"
						};
						pistols[] = {"hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F"};
						rifles[] = {
							"arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_Mk20_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F",
							"arifle_MXC_F","arifle_MX_F","arifle_MX_SW_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_TRG21_F","arifle_TRG20_F","arifle_TRG21_GL_F","hgun_PDW2000_F","SMG_01_F","SMG_02_F"
						};
						uniforms[] = {"U_Marshal","U_Rangemaster"};
						vests[] = {
							"V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_Chestrig_blk","V_Chestrig_rgr","V_Chestrig_khk","V_Chestrig_oli","V_PlateCarrierL_CTRG",
							"V_PlateCarrierH_CTRG","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessO_brn","V_HarnessO_gry","V_Rangemaster_belt","V_TacVestIR_blk",
							"V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli","V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli",
							"V_TacVest_blk_POLICE"
						};
					};
				class PoliceSpecialForces
					{
						faceWear[] = {
							"G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_blk",
							"G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Combat","G_Lowprofile","G_Sport_Red",
							"G_Sport_Blackyellow","G_Sport_BlackWhite","G_Sport_Blackred","G_Sport_Greenblack","G_Tactical_Clear","G_Tactical_Black"
						};
						headGear[] = {
							"H_Watchcap_blk","H_Cap_usblack","H_HelmetB_black","H_HelmetSpecB_blk","H_HelmetB_light_black"
						};
						pistols[] = {"hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F","hgun_Pistol_heavy_02_F"};
						rifles[] = {
							"srifle_GM6_F","srifle_GM6_camo_F","arifle_Katiba_F","arifle_Katiba_C_F","srifle_LRR_F","srifle_EBR_F","LMG_Mk200_F","arifle_MX_Black_F","arifle_MX_SW_Black_F","arifle_MXC_Black_F",
							"arifle_MXM_Black_F","LMG_Zafir_F"
						};
						uniforms[] = {"U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"};
						vests[] = {"V_PlateCarrier1_blk","V_PlateCarrier2_blk","V_Chestrig_blk","V_TacVestIR_blk","V_BandollierB_blk","V_TacVest_blk"};
					};
			};

		class aiSkill
			{
				// Global AI skill settings. They affect each VEMFr unit
				difficulty = "Veteran"; // Options: "Easy" "Normal" "Veteran" "Hardcore" | Default: Veteran
				class Easy { accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.3; };
				class Normal { accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.4; };
				class Veteran { accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.5; };
				class Hardcore { accuracy = 0.4; aimingShake = 0.20; aimingSpeed = 0.3; endurance = 0.25; spotDistance = 0.5; spotTime = 0.85; courage = 1; reloadSpeed = 0.3; commanding = 1; general = 0.7; };
			};

		class aiStatic // Simply spawns units at desired positions
			{
				amount[] = {10,20,12,11,40,21,19}; // How much AI units on each seperate position. Example: 1st location, 10. 2nd location, 20. 3rd location, 12. And so on....
				enabled = 0; // Enable/disable static AI spawning
				positions[] = {}; // Add positions here. Each position must have {} around it and must be seperated with a comma if multiple positions present. Last position in list should NOT have a comma behind it!
				random = 1; // Enable/disable randomization of AI units amount
			};
	};

#include "cpp\CfgPatches.cpp"
#include "cpp\CfgFunctions.cpp"
#include "cpp\CfgVemfrScripts.cpp"
#include "cpp\CfgAppIDs.cpp"
