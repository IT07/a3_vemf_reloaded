class CfgFunctions
{
	class exile_vemf_reloaded
	{
		tag = "VEMFr";
		class serverFunctions
		{
			file = "exile_vemf_reloaded\functions";
			class log {};
			class getSetting {};
			class aiKilled {};
			class findPos {};
			class broadCast {};
			class playerCount {};
			class headLessClient {};
			class signAI {};
			class transferOwner {};
			class checkPlayerPresence {};
			class loadInv {};
			class giveAmmo {};
			class giveWeaponItems {};
			class spawnInvasionAI {};
			class spawnVEMFrAI {};
			class loadLoot {};
			class placeMines {};
			class waitForPlayers {};
			class waitForMissionDone {};
			class checkSide {};
			class launch { postInit = 1; };
		};
	};
};
