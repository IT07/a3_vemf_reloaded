class CfgFunctions
{
	class exile_vemf_reloaded
	{
		tag = "VEMFr";
		class serverFunctions
		{
			file = "exile_vemf_reloaded\fn";
			class checkPlayerPresence {};
			class checkSide {};
			class findPos {};
			class getSetting {};
			class giveAmmo {};
			class giveWeaponItems {};
			class headlessClient {};
			class launch { postInit = 1; };
			class loadInv {};
			class placeMines {};
			class playerCount {};
			class spawnInvasionAI {};
			class spawnVEMFrAI {};
			class waitForPlayers {};
			class waitForMissionDone {};
		};
	};
};
