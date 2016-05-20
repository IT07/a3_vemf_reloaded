class CfgFunctions
{
	class exile_vemf_reloaded
	{
		tag = "VEMFr";
		class serverFunctions
		{
			file = "exile_vemf_reloaded\functions";
			class checkPlayerPresence {};
			class checkSide {};
			class findPos {};
			class getSetting {};
			class giveAmmo {};
			class giveWeaponItems {};
			class headlessClient {};
			class launch { postInit = 1; };
			class loadInv {};
			class loadLoot {};
			class placeMines {};
			class playerCount {};
			class signAI {};
			class spawnInvasionAI {};
			class spawnVEMFrAI {};
			class transferOwner {};
			class waitForPlayers {};
			class waitForMissionDone {};
		};
	};
};
