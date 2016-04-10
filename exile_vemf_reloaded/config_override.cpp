/*
   File: config_override.cpp
   Description: put all of the settings you always change in here and simply put the file back whenever you update VEMFr. Then you don't have to redo all your changes to the config.cpp everytime
   Description 2: the only thing you will have to do now is simply check the CHANGELOG.md on GitHub everytime there is an update to check if there are any deprecated settings
   Description 3: instead of changing the config.cpp settings everytime, just add your changes here. Saves a lot of time. Yes you are welcome you lucky bastard
   Note: it is extremely difficult for a coder to explain with text how to do this so I have put a few examples in this file instead
   Note 2: the already present lines below line 10 are just examples so feel free to delete them
*/

// Put all the settings you want to override below this line
/*
debugMode = 2; // Overrides CfgVemfReloaded >> debugMode
maxGlobalMissions = 5; // Overrides CfgVemfReloaded >> maxGlobalMissions
minServerFPS = 5; // Overrides CfgVemfReloaded >> minServerFPS
class crateLoot
{
   primarySlotsMax = 3; // Overrides CfgVemfReloaded >> crateLoot >> primarySlotsMax
   primarySlotsMin = 1; // Overrides CfgVemfReloaded >> crateLoot >> primarySlotsMin
};
class locationBlackLists
{ // NOTE: If the map you use is not listed below, simply add it by yourself or put the locations you want to blacklist into the locations array of the Other class
   class Altis
   {
      locations[] = {}; // Overrides CfgVemfReloaded >> locationBlackLists >> Altis >> locations
   };
};
class aiGear
{
   aiPistols[] = {"hgun_ACPC2_F","hgun_Rook40_F"}; // Overrides CfgVemfReloaded >> aiGear >> aiPistols
};
*/
