## VEMFr Changelog

#### `v0752.3`
*Server-side* <br />
**[REMOVED]** setting 'invincible' from SimplePatrol settings <br />
**[TWEAKED]** overrides output to detect not-existent settings <br />
<br />

#### `v0752.2`
*Server-side* <br />
**[ADDED]** scripts that are supposed to be scripts instead of functions <br />
**[REMOVED]** several functions that don't need to be functions <br />
**[TWEAKED]** code speed and syntax <br />
<br />

#### `v0752.1`
*Server-side* <br />
**[FIXED]** BaseAttack warning won't stop if player moves further than 275 meters away from flag <br />
**[FIXED]** launchers are not removed if launchers have enough time to drop on the ground <br />
**[NEW]** SimplePatrol can now understand the "random" mode for behaviour <br />
**[REMOVED]** SteerableParachute_F from Guerilla backpacks <br />
**[TWEAKED]** spawn radius for BaseAttack AI <br />
<br />

#### `v0752.0`
*Server-side* <br />
**[NEW]** addon "SimplePatrol" as requested by CameraChick <br />
**[TWEAKED]** heli waypoint configuration <br />
**[TWEAKED]** config syntax <br />
*Client-side* <br />
**[FIXED]** error: variable does not support serialization (@Lucy2990) <br />
<br />

#### `v0751.7a`
**[FIXED]** Error Undefined variable in expression (spawnStaticAI) <br />
<br />

#### `v0751.7`
#######UPDATE NOTE: update BOTH server files and client files!
*Server-side* <br />
**[ADDED]** config blacklist for thermal scopes <br />
**[ADDED]** minimumWait setting to the BaseAttack mission settings as suggested by Paul <br />
**[CHANGED]** killPercentage setting. Each mission has this setting in its class now <br />
**[NEW]** warning system for BaseAttack missions as requested by HarryNutz <br />
**[TWEAKED]** code performance/speed and syntax <br />
**[TWEAKED]** execution speed of mpKilled code <br />
<br />
*Client-side* <br />
**[ADDED]** RscDisplayBaseAttack <br />
**[TWEAKED]** code speed and syntax <br />
<br />

#### `v0751.6`
#######UPDATE NOTE: re-configure the mine settings!
*Server-side* <br />
**[CHANGED]** mine settings of the DynamicLocationInvasion mission type. They are inside their own class now <br />
**[FIXED]** mines are not working <br />
**[FIXED]** (EPOCH) error in BaseAttack.sqf, line 46 <br />
**[TWEAKED]** error tolerance in some functions <br />
**[TWEAKED]** order of startup reports <br />
**[TWEAKED]** start-up message of VEMFr <br />
<br />

#### `v0751.5`
*Server-side* <br />
**[CHANGED]** headLessClientSupport setting is now headlessClientSupport <br />
**[FIXED]** VEMFr_fnc_hc is unable to find headless clients <br />
**[FIXED]** fn_spawnInvasionAI.sqf does not spawn the correct amounts of AI units and groups. <br />
**[FIXED]** setGroupOwner.sqf was not able to find headless clients <br />
**[TWEAKED]** fail-safe technology for fn_mines.sqf <br />
**[TWEAKED]** parameters for fn_spawnInvasionAI.sqf <br />
**[TWEAKED]** chance of rifles to be present in the loot crates <br />
**[TWEAKED]** reliability/efficiency/speed of REMOTEguard.sqf <br />
<br />

#### `v0751.4`
*Server-side* <br />
**[NEW]** some config settings now use yes/no instead of 1/0 <br />
**[TWEAKED]** spawn chance of rifles in loot crate <br />
**[NEW]** AI now have random amounts of money on them <br />
**[NEW]** The loot crate (DynamicLocationInvasion mission) now has random amount of money in it <br />
<br />

#### `v0751.3`
*Server-side* <br />
**[FIXED]** Error >: Type String, expected Number,Not a Number <br />
**[FIXED]** code trying to get settings from old config layout <br />
<br />

#### `v0751.2`
*Server-side* <br />
**[FIXED]** Error type bool, expected number <br />
<br />

#### `v0751.1`
*Server-side* <br />
**[FIXED]** BaseAttack missions keep spawning on the same flag <br />
**[FIXED]** minimumLevel setting not being used properly <br />
<br />

#### `v0751.0`
#######UPDATE NOTE: completely re-configure your config overrides because many settings have been moved!
*Server-side* <br />
**[ADDED]** new function: retrieve DLC appIDs <br />
**[ADDED]** new faction: Guerilla <br />
**[ADDED]** new faction: Special Forces <br />
**[ADDED]** new faction: Gendarmerie (Apex-only) <br />
**[ADDED]** new faction: Bandits (Apex-only) <br />
**[ADDED]** Exile-items for loot crate <br />
**[ADDED]** Epoch-items for loot crate <br />
**[ADDED]** option to allow/disallow thermal-vision helmets in loot crate <br />
**[ADDED]** location blacklist for Tanoa <br />
**[ADDED]** loot classnames from Apex <br />
**[ADDED]** inventory configs for new factions <br />
**[FIXED]** still using old ExecVM method <br />
**[NEW]** mission "BaseAttack" is now compatible with Epoch <br />
**[NEW]** loot crates will not always have the same loadout now <br />
**[NEW]** randomization of loot amounts <br />
**[REMOVED]** S.W.A.T. faction <br />
**[TWEAKED]** blacklist settings <br />
**[TWEAKED]** aiInventory settings <br />
**[TWEAKED]** crate loot settings <br />
**[TWEAKED]** config comments <br />
**[TWEAKED]** VEMFr startup RPT output <br />
**[TWEAKED]** respect handling of AI kills <br />
**[TWEAKED]** checkClasses.sqf <br />
<br />
*Client-side* <br />
**[TWEAKED]** Gap inbetween the title and message of a mission broadcast <br />
<br />

#### `v0750.1`
*Server-side* <br />
**[FIXED]** Error pushback: Type Number, expected Array <br />
<br />

#### `v0750.0`
*Server-side* <br />
**[CHANGED]** a3_exile_vemf_reloaded is now called a3_vemf_reloaded <br />
**[FIXED]** setting sayKilled has no effect <br />
**[NEW]** VEMFr is now compatible with Exile and Epoch <br />
**[NEW]** VEMFr for Exile and VEMFr for Epoch are now merged into one <br />
**[NEW]** support for Tanoa map <br />
<br />

#### `v0745.1`
*Server-side* <br />
**[ADDED]** option for enabling "reversed-spawning". Feature requested by @CameraChick <br />
**[DELETED]** old functions that were supposed to be gone <br />
**[FIXED]** waypoint issues for helicopters that patrol at DynamicLocationInvasion missions <br />
**[FIXED]** no additional respect as a reward for killing AI
**[NEW]** killing AI will be added to the kill-count of the killer <br />
**[NEW]** kill messages now display the vehicle that was used to kill instead of the gun (on the vehicle) that was used to kill <br />
**[REMOVED]** respect.sqf <br />
**[TWEAKED]** code performance of multiple functions <br />
<br />

#### `v0745.0`
*Server-side* <br />
**[ADDED]** option to enable/disable AI names for kill messages <br />
**[CHANGED]** setting "aiLaunchers" is now called "allowLaunchers" <br />
**[ADDED]** option "allowRepeat" to allow/disallow re-spawning of missions in locations that have been invaded since last restart <br />
**[CHANGED]** loot-crate parachute settings have their own class now <br />
**[CHANGED]** heliPatrol settings have their own class now <br />
**[CHANGED]** setting "marker" is now called "useMarker" <br />
**[CHANGED]** function "checkPlayerPresence" is now called "playerNear" <br />
**[CHANGED]** function "getSetting" is now called "config" <br />
**[CHANGED]** function "headlessClient" is now called "hc" <br />
**[CHANGED]** function "placeMines" is now called "mines" <br />
**[CHANGED]** function "waitForMissionDone" is now a separate sqf file <br />
**[TWEAKED]** overall code execution-speed <br />
<br />

#### `v0744.0`
*Server-side* <br />
**[ADDED]** config option: minimum territory level for BaseAttack mission <br />
**[CHANGED]** primarySlotsMax from 10 to 7 <br />
**[CHANGED]** primarySlotsMin from 4 to 2 <br />
**[CHANGED]** secondarySlotsMax from 4 to 3 <br />
**[CHANGED]** secondarySlotsMin from 2 to 1 <br />
**[CHANGED]** magSlotsMax from 6 to 8 <br />
**[CHANGED]** magSlotsMin from 4 to 6 <br />
**[CHANGED]** vestSlotsMax from 4 to 3 <br />
**[CHANGED]** vestSlotsMin from 2 to 1 <br />
**[CHANGED]** headGearSlotsMax from 4 to 3 <br />
**[CHANGED]** headGearSlotsMin from 2 to 1 <br />
**[CHANGED]** bagSlotsMax from 4 to 2 <br />
**[CHANGED]** bagSlotsMin from 2 to 1 <br />
**[CHANGED]** helicopter at DynamicLocationInvasion mission now searches and destroys instead of loitering <br />
**[FIXED]** high server thread count (thanks to @ServerAtze for reporting the issue) <br />
**[FIXED]** REMOTEguard.sqf was running much too fast under certain conditions, causing thread count spikes <br />
**[TRASHED]** fn_playerCount.sqf <br />
**[TWEAKED]** fn_giveWeaponItems.sqf <br />
**[TWEAKED]** delays before and between exploding mines at DynamicLocationInvasion missions <br />
**[TWEAKED]** fn_missionTimer <br />
<br />

#### `v0743.9`
*Server-side* <br />
**[FIXED]** params error in fn_placeMines.sqf <br />
**[FIXED]** kill messages from AI getting killed by something else other than a player <br />

#### `v0743.8`
*Server-side* <br />
**[TWEAKED]** code performance of functions with params <br />
**[FIXED]** kill messages from AI getting killed by something else other than a player <br />
<br />

#### `v0743.7`
*Server-side* <br />
**[FIXED]** error related to notificationToClient.sqf's params <br />
<br />

#### `v0743.6`
*Server-side* <br />
**[NEW]** separate file for broadcasting notifications <br />
**[NEW]** separate file for broadcasting systemChat messages <br />
**[TWEAKED]** code speed <br />
<br />

#### `v0743.5`
*Server-side* <br />
**[TWEAKED]** broadcast params <br />
*Client-side* <br />
**[FIXED]** error type number, expected string <br />
<br />

#### `v0743.4`
*Client-side* <br />
**[TWEAKED]** duration of mission notification <br />
<br />
*Server-side* <br />
**[ADDED]** option to enable/disable spawning of loot crate before mission completion <br />
**[ADDED]** "Sebjan Mine" to blacklisted locations of Namalsk <br />
**[REMOVED]** a few functions. They are now standalone SQF files <br />
**[TWEAKED]** functions folder is now the fn folder <br />
**[TWEAKED]** order of blacklisted locations <br />
**[TWEAKED]** config overrides. Use config.cpp in exile_vemf_reloaded_config to override VEMFr default settings <br />
<br />

#### `v0743.3 HOTFIX`
*Client-side* <br />
**[FIXED]** serialization error <br />
<br />

#### `v0743.3`
*Server-side* <br />
**[ADJUSTED]** AI brain settings <br />
**[CHANGED]** message broadcast code required to make new messages work <br />
**[FIXED]** AI were given weapons before receiving ammo which results in the AI first required to reload before engaging targets <br />
*Client-side* <br />
**[CHANGED]** mission message design <br />

#### `v0743.2`
*Server-side* <br />
**[FIXED]** AI dropping out of the sky (BaseAttack mission) <br />
<br />

#### `v0743.1`
*Server-side* <br />
**[FIXED]** headless client code <br />
**[REWORKED]** overall code indentation and code structure <br />
<br />

#### `v0743.0`
*Server-side* <br />
**[REMOVED]** a few functions. They are now single SQF files <br />
**[FIXED]** missions do not end if aiDeathRemovalEffect is enabled <br />
<br />

#### `v0742.7`
*Server-side* <br />
**[FIXED]** VEMFr continues to spawn missions even if max global limit has been reached <br />
**[FIXED]** missionTimer loop goes too fast if mission limit has been reached <br />
<br />

#### `v0742.6`
*Server-side* <br />
**[ADDED]** missing aiLauncher settings for BaseAttack missions <br />
**[CHANGED]** VEMFr messages will not be sent to dead players <br />
**[FIXED]** no punishment for killing parachuting from vehicle <br />
**[FIXED]** BaseAttack mission count goes up without running successfully <br />
**[NEW]** BaseAttack mission messages now show name of the base being attacked <br />
<br />

#### `v0742.5`
*Server-side* <br />
**[CHANGED]** the allowTWS option is now a global setting <br />
**[FIXED]** Selekano instead of Selakano <br />
**[FIXED]** AI still have TWS scopes even when allowTWS is set to 0 <br />
**[FIXED]** Error in BaseAttack.sqf <br />
**[FIXED]** VEMFr still starts even if player count is below the threshold <br />
**[REWORKED]** fn_giveAmmo.sqf <br />
<br />

#### `v0742.4`
*Server-side* <br />
**[ADDED]** ability for Admin to set VEMFrForceStart to true on server to force VEMFr to start <br />
**[FIXED]** VEMFr will not start <br />
**[FIXED]** VEMFr version not correctly displayed in RPT <br />
**[IMPROVED]** overall code execution time <br />
<br />

#### `v0742.3`
*Server-side* <br />
**[CHANGED]** heli spawn distance for DynamicLocationInvasion mission in attempt to prevent it from just hovering <br />
*Client-side* <br />
**[IMPROVED]** initClient.sqf <br />
<br />

#### `v0742.2`
*Server-side* <br />
**[CHANGED]** config_override now has its own PBO file: exile_vemf_reloaded_config <br />
**[FIXED]** missions stop spawning after a while <br />
<br />

#### `v0742.1`
*Server-side* <br />
**[ADDED]** heliLocked option to class DynamicLocationInvasion <br />
**[CHANGED]** default unitClass is now "O_G_Sharpshooter_F". Switch to "B_G_Soldier_AR_F" if you are having issues with the new unitClass <br />
**[CHANGED]** heliPatrol of DynamicLocationInvasion mission now spawns higher for increased immersion <br />
**[FIXED]** heliPatrol heli just won't loiter <br />
**[FIXED]** missing code in fn_aiKilled.sqf <br />
**[IMPROVED]** missionTimer now is much smarter <br />
<br />

#### `v0742.0`
*Server-side* <br />
**[ADDED]** New mission "BaseAttack"! <br />
**[ADDED]** "logCowardKills" option to config.cpp | logs information to RPT if player kills a parachuting AI <br />
**[CHANGED]** params of several functions <br />
<br />

#### `v0741.5`
*Server-side* <br />
**[ADDED]** separate sqf file for handling respect <br />
**[ADDED]** separate sqf file for handling kill messages <br />
**[CHANGED]** Order of config classes in config.cpp <br />
**[FIXED]** "failed to get respect from" error if killer has negative respect <br />
**[FIXED]** script error related to fn_placeMines.sqf <br />
**[IMPROVED]** Overal code performance and speed <br />
<br />

#### `v0741.4 HOTFIX`
*Server-side* <br />
**[FIXED]** "Failed to load AI's inventory" error related to AI Static spawns <br />
<br />

#### `v0741.4`
*Server-side* <br />
**[ACTUALLY FIXED]** static AI spawns not working <br />
<br />

#### `v0741.3`
*Server-side* <br />
**[FIXED]** static AI spawns not working <br />
**[FIXED]** no respect gain when killing with Pawnee <br />
**[FIXED]** unreliable detection of roadkills <br />
**[IMRPOVED]** fn_aiKilled's code <br />
<br />

#### `v0741.2 HOTFIX`
*Server-side* <br />
**[FIXED]** spawnStaticAI broken since v0741.1 <br />
<br />

#### `v0741.2`
*Server-side* <br />
**[CHANGED]** Some functions are now not a function anymore <br />
**[CHANGED]** CfgPatches and CfgFunctions now have their own separate file <br />
**[FIXED]** hasLauncherChance was not working at all <br />
**[IMPROVED]** Overall variable structure <br />
**[IMPROVED]** Loggin feedback in RPT. Was sometimes too cryptic <br />
<br />

#### `v0741.1`
*Server-side* <br />
**[FIXED]** .50cals not being deleted <br />
*Client-side* <br />
**[CHANGED]** newer code <br />
*NOTES: Completely remove the current client-side VEMFr stuff from your mission file and install the new files*<br />
<br />

#### `v0.741`
*Server-side* <br />
**[NEW]** config_override.cpp which provides easy custom settings to be applied without ever needing to re-apply them every time there is a new VEMFr update. <br />
**[ADDED]** option to enable/disable helicopter patrol at DynamicLocationInvasion missions <br />
<br />

#### `v0740.30`
*Server-side* <br />
**[ADDED]** Option to prevent AI from having TWS (thermal) scopes <br />
**[CHANGED]** Order of config settings from being a total mess to being alphabetically sorted. <br />
<br />

#### `v0740.27`
*Server-side* <br />
**[ADDED]** More advanced ammo distribution system for AI units <br />
**[FIXED]** Sometimes no .50 cals at missions <br />
**[FIXED]** "Error: no vehicle" when killing AI with Helicopter <br />
**[CHANGED]** A few comments in config.cpp to improve clearness<br />
<br />

#### `v0740.19`
*Server-side* <br />
**[ADDED]** Option to enable/disable respect punishment for roadkilling AI <br />
**[ADDED]** Option to remove "toolbelt" items like GPS, Radio, Map and Compass from AI <br />
**[ADDED]** New options class to control AI cleanup-related settings <br />
**[ADDED]** AI units now randomly have random weapon attachments <br />
**[NEW]** Config.cpp does NOT use -1 anymore to disable things. It is now 0 instead.<br />
**[CHANGED]** Config.cpp option comments <br />
**[CHANGED]** On roadkill, kill message shows [Roadkill] instead of vehicle used <br />
**[IMPROVED]** Overall code performance and use of newer commands <br />
**[FIXED]** Mines are not working <br />
**[REMOVED]** fn_random.sqf, replaced by selectRandom command https://community.bistudio.com/wiki/selectRandom <br />
<br />

#### `v0740.6`
*Server-side* <br />
**[CHANGED]** BIS_fnc_param replaced by new param command <br />
**[CHANGED]** Blacklist method for locations. separate classes for each map for easier use <br />
<br />
*Client-side* <br />
No Changes. <br />
<br />

#### `v0732.8`
*Server-side:* <br />
**[ADDED]** AI static spawns <br />
**[ADDED]** fn_aiKilled: now shows the name of vehicle used to road-kill an AI <br />
**[ADDED]** fn_checkLoot: RPT log message if loot validation is enabled but no debug allowed <br />
**[IMPROVED]** Descriptions and naming of config values <br />
**[IMPROVED]** fn_aiKilled: now shows killer [weapon, range] victim <br />
**[IMPROVED]** fn_log: is now faster and much more simple <br />
**[FIXED]** fn_aiKilled: if killer using vehicle gun, it shows the primaryweapon of the killer instead of the vehicle turret as the weapon used <br />
**[CHANGED]** Mission complete logs now show the name of location in which the mission was <br />
**[CHANGED]** Name of pbo is now all lowercase <br />
<br />
*Client-side:* <br />
**[CHANGED]** mission notification messages now have VEMFr as tag instead of the old VEMF tag <br />
<br />

#### `v0730.21`
**[REMOVED]** Medikit and toolkit from loot crate(s) <br />
<br />

#### `v0730.20`
**[ADDED]** Option to control the classname of the AI units <br />
**[ADDED]** Automatic detection of AI unit's side to make sure they get put into a correct group type <br />
<br />

#### `v0730.15`
**[ADDED]** Option enable/disable the ability to lift loot crate <br />
<br />

#### `v0730.14`
**[FIXED]** Loss of respect when using vehicle turret <br />
**[FIXED]** Server-side script error caused by killTheLights <br />
<br />

#### `v0730.2`
**[NEW]** refreshed mission notification with new animations <br />
**[FIXED]** difficult to see quickly if mission message means new one or a defeated one <br />
**[FIXED]** network load peak and fps lag when mines are placed by mission <br />
**[CHANGED]** server-side message broadcasting to accommodate for including the notification type in the broadcast <br />
<br />

#### `v0729.1`
**[CHANGED]** increased detection speed of players for triggering missions from 200 to 250 <br />
**[REMOVED]** any usage of playableUnits command <br />
**[REMOVED]** any checks for the player's side <br />
**[FIXED]** old stuff in fn_checkLoot.sqf <br />
**[FIXED]** mission amount can go beyond the limit <br />
**[FIXED]** fn_playerCount.sqf: unreliable detection of player amount <br />
**[FIXED]** VEMF_Reloaded started anyway without the actual amount of minimal players to be ingame <br />
**[IMPROVED]** fail-safe "if checks" in fn_missionTimer.sqf <br />

#### `v0728.6`
**[FIXED]** Instabilities in spawning/despawning of missions <br />
**[FIXED]** First mission does not timeout <br />
**[ADDED]** Option to blacklist certain buildings using their classnames <br />
**[NEW]** Each DynamicLocationInvasion mission type has its own marker color <br />
<br />

#### `v0727.15`
**[FIX ATTEMPT]** Missions not spawning anymore under very specific conditions <br />
<br />

#### `v1.0727.13`
**[FIXED]** fn_loadInv not working for the bad guys <br />
**[FIXED]** random missions not working if mission announcements were disabled <br />
<br />

#### `v1.0727.11`
**[FIXED]** Missions stop spawning after a certain amount of time <br />
<br />

#### `v1.0727.9`
**[ADDED]** Option to disable/enable mission announcements <br />
<br />

#### `v1.0727.3`
**[CHANGED]** Exile_VEMF is now called Exile_VEMF_Reloaded because the original creator of VEMF is proceeding on VEMF <br />
**[ADDED]** S.W.A.T. AI <br />
**[ADDED]** Option to send kill messages only to the killer (@KillingRe) <br />
<br />

#### `v1.0725.6`
**[NEW]** Option to control deletion of .50 cals when mission done <br />
**[IMPROVED]** Respect reward system <br />
**[FIXED]** Players getting respect if AI kill other AI <br />
<br />

#### `v1.0724.1`
**[NEW]** Option to control distance between each mission <br />
**[CHANGED]** Server-side folder is now called Exile_VEMF <br />
<br />

#### `v1.0723.1 HOTFIX`
**[FIXED]** fn_aiKilled.sqf: error Undefined variable in expression unit <br />
<br />

#### `v1.0722.15`
**[NEW]** Player now get reputation for killing AI. Dynamically increases depending on kill distance <br />
**[FIXED]** Unstable fn_random.sqf <br />
<br />

#### `v1.0721.15`
**[NEW]** AI will now spawn in houses <br />
**[NEW]** Mounted (bipod) .50 cals in/on houses if enabled <br />
**[ADDED]** Option to enable/disable AI "Cop mode" <br />
**[CHANGED]** fn_spawnAI.sqf to allow spawning in houses <br />
**[TWEAKED]** fn_loadInv.sqf <br />
<br />
#### `v1.0721.1`
**[FIXED]** fn_spawnAI.sqf: Suspending not allowed in this context, line 72 <br />
<br />

#### `v1.0720.6`
**[NEW]** Automatic removal of loot crate marker when player gets close <br />
**[ADDED]** Option to enable/disable mission markers <br />
**[ADDED]** Ability to put `maxGlobalMissions` on -1. Disables the mission limit <br />
**[ADDED]** Exile default safe zones to mission blacklist positions <br />
**[ADDED]** Option to enable/disable loot crate markers <br />
**[ADDED]** Option to enable/disable loot crate parachute spawn <br />
**[ADDED]** Option to enable/disable loot crate visual smoke/chemlights <br />
**[ADDED]** Option to enable/disable loot crate spawn sound (once) <br />
**[ADDED]** Logging of successfull removal/exploding of mines <br />
**[ADDED]** Code changes to fn_missionTimer.sqf to allow ignoring of global mission count <br />
**[ADDED]** Code changes to DLI mission to prevent removal of non-existing mission marker <br />
**[CHANGED]** several config options from negative to positive <br />
**[CHANGED]** Default debug mode from 2 to 0 (errors only) <br />
**[CHANGED]** AI difficulty config now less lines <br />
**[CHANGED]** AI Veteran and Harcore difficulty increased <br />
**[CHANGED]** Mines are now switched off by default <br />
**[CHANGED]** Default mine removal mode is now explode <br />
**[CHANGED]** fn_loadLoot.sqf: now empties the crate instead of the mission itself <br />
**[FIXED]** Error in expression fn_findPos.sqf <br />
**[FIXED]** Error in expression fn_loadInv.sqf with specific set of config settings <br />
<br />

#### `v1.0719.10`
**[ADDED]** Option to enable/disable the placement of a marker on the loot crate <br />
**[ADDED]** Attempt to fix the floating crate problem <br />
**[ADDED]** Fail-safety for fn_checkPlayerPresence.sqf <br />
**[ADDED]** Fail-safety for fn_placeMines.sqf <br />
**[ADDED]** Fail-safety for fn_spawnAI.sqf <br />
**[CHANGED]** Default value of `validateLoot` from 1 to -1 <br />
**[REMOVED]** Option to enable/disable sound on the loot crate <br />
**[FIXED]** Mines not removing or exploding <br />
**[FIXED]** Structure error in fn_findPos.sqf <br />
<br />
#### `v1.0718.11`
**NOTE:** VEMFclient code has been changed! <br />
**[ADDED]** AI difficulty presets<br />
**[CHANGED]** Default cleanMines setting changed from 2 to 1 <br />
**[CHANGED]** fn_broadCast.sqf for new broadcast system <br />
**[CHANGED]** fn_loadLoot.sqf: fail-safety removed <br />
**[CHANGED]** fn_spawnAI.sqf: implementation of AI difficulty presets <br />
**[CHANGED]** Veteran AI difficulty lowered. Too close to aimbots <br />
**[FIXED]** Duplicate spawns on locations <br />
**[FIXED]** Player getting side ENEMY for attacking AI <br />
**[FIXED]** Loot crate not falling down <br />
**[FIXED]** Loot crate not making a sound <br />
<br />
#### `v1.0717.7`
**[FIXED]** No loot in crate <br />
**[FIXED]** AI not shooting at player <br />
<br />

#### `v1.0716.14`
**[NEW]** VEMF ported to Exile :) <br />
<br />
