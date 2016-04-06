/*
	VEMF AI Killed by Vampire, rewritten by IT07

	Description:
	removes launchers if desired and announces the kill if enabled in config.cpp

	Params:
	_this: ARRAY
	_this select 0: OBJECT - the killed AI
	_this select 1: OBJECT - killer

	Returns:
	nothing
*/

if (_this isEqualType []) then
{
	_target = param [0, objNull, [objNull]];
	if not isNull _target then
	{
		_target removeAllEventHandlers "MPKilled";
		_settings = [["aiCleanup"],["removeLaunchers","aiDeathRemovalEffect","removeHeadGear"]] call VEMFr_fnc_getSetting;
		_removeLaunchers = _settings select 0;
		if (_removeLaunchers isEqualTo 1) then
		{
			_secWeapon = secondaryWeapon _target;
			if not(_secWeapon isEqualTo "") then
			{
				_target removeWeaponGlobal _secWeapon;
				_missiles = getArray (configFile >> "cfgWeapons" >> _secWeapon >> "magazines");
				{
					if (_x in _missiles) then
					{
						_target removeMagazineGlobal _x;
					};
				} forEach (magazines _target);
			};
		};


		_killer = param [1, objNull, [objNull]];
		if isPlayer _killer then // Only allow this function to work if killer is an actual player
		{
			if (vehicle _killer isEqualTo _killer) then // If killer is on foot
			{
				_respectReward = "respectReward" call VEMFr_fnc_getSetting;
				if (_respectReward > 1) then
				{
					_message = [[]];
					_killMsg = selectRandom ["AI WACKED","AI CLIPPED","AI DISABLED","AI DISQUALIFIED","AI WIPED","AI ERASED","AI LYNCHED","AI WRECKED","AI NEUTRALIZED","AI SNUFFED","AI WASTED","AI ZAPPED"];
					(_message select 0) pushBack [_killMsg,_respectReward];
					_dist = _target distance _killer;
					switch true do
					{
						case (_dist <= 5):
						{
							(_message select 0) pushBack ["CQB Master", 25]
						};
						case (_dist <= 10):
						{
							(_message select 0) pushBack ["Close one", 15]
						};
						case (_dist <= 50):
						{
							(_message select 0) pushBack ["Danger close", 15]
						};
						case (_dist <= 100):
						{
							(_message select 0) pushBack ["Lethal aim", 20]
						};
						case (_dist <= 200):
						{
							(_message select 0) pushBack ["Deadly.", 25]
						};
						case (_dist <= 500):
						{
							(_message select 0) pushBack ["Niiiiice.", 30]
						};
						case (_dist <= 1000):
						{
							(_message select 0) pushBack ["Dat distance...", 45]
						};
						case (_dist <= 2000):
						{
							(_message select 0) pushBack ["Danger far.", 50]
						};
						case (_dist > 2000):
						{
							(_message select 0) pushBack [format["hax? %1m!!!", round _dist], 65]
						};
					};
					if not(_killer isEqualTo (driver (vehicle _killer))) then
					{
						_killer = gunner _killer;
					};
					if (_killer isEqualTo (driver(vehicle _killer))) then
					{
						_killer = driver (vehicle _killer);
					};
					_curRespect = _killer getVariable ["ExileScore", 0];
					//diag_log text format["_curRespect of _killer (%1) is %2", _killer, _curRespect];
					_respectToGive = (((_message select 0) select 1) select 1);
					_newRespect = _curRespect + _respectToGive + _respectReward;
					_killer setVariable ["ExileScore", _newRespect];
					ExileClientPlayerScore = _newRespect;
					(owner _killer) publicVariableClient "ExileClientPlayerScore";
					ExileClientPlayerScore = nil;
					[_killer, "showFragRequest", _message] call ExileServer_system_network_send_to;
					format["setAccountMoneyAndRespect:%1:%2:%3", _killer getVariable ["ExileMoney", 0], _newRespect, (getPlayerUID _killer)] call ExileServer_system_database_query_fireAndForget;
				};

				_sayKilled = "sayKilled" call VEMFr_fnc_getSetting;
				if (_sayKilled > 0) then // Send kill message if enabled
				{
					_killer = param [1, objNull, [objNull]];
					_dist = _target distance _killer;
					if (_dist > 1) then
					{
						private ["_curWeapon"];
						if (vehicle _killer isEqualTo _killer) then // If on foot
						{
							_curWeapon = currentWeapon _killer;
						};
						if not(vehicle _killer isEqualTo _killer) then // If in vehicle
						{
							_curWeapon = currentWeapon (vehicle _killer);
						};
						if (_sayKilled isEqualTo 1) then
						{
							_kMsg = format["(VEMFr) %1 [%2, %3m] AI", name _killer, getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist];
							[_kMsg, "sys"] spawn VEMFr_fnc_broadCast;
						};
						if (_sayKilled isEqualTo 2) then
						{
							VEMFrClientMsg = [format["(VEMFr) You [%1, %2m] AI", getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist], "sys"];
							(owner _killer) publicVariableClient "VEMFrClientMsg";
							VEMFrClientMsg = nil;
						};
					};
				};
			};

			if not(vehicle _killer isEqualTo _killer) then // If killer is driver
			{ // Send kill message if enabled
				_dist = _target distance _killer;
				if (_dist < 5) then
				{
					if (("sayKilled" call VEMFr_fnc_getSetting) isEqualTo 1) then
					{
						if (isPlayer _killer) then // Should prevent Error:NoUnit
						{
							_kMsg = format["(VEMFr) %1 [Roadkill] AI", name _killer];
							//_kMsg = format["(VEMFr) %1 [%2] AI", name _killer, getText(configFile >> "CfgVehicles" >> typeOf (vehicle _killer) >> "displayName")];
							[_kMsg, "sys"] spawn VEMFr_fnc_broadCast;
						};
					};
					if (("punishRoadKills" call VEMFr_fnc_getSetting) isEqualTo 1) then
					{
						_respectDeduct = "respectRoadKillDeduct" call VEMFr_fnc_getSetting;
						_curRespect = _killer getVariable ["ExileScore", 0];
						//diag_log text format["_curRespect of _killer (%1) is %2", _killer, _curRespect];
						_newRespect = _curRespect - _respectDeduct;
						_killer setVariable ["ExileScore", _newRespect];
						ExileClientPlayerScore = _newRespect;
						(owner _killer) publicVariableClient "ExileClientPlayerScore";
						ExileClientPlayerScore = nil;
						[_killer, "showFragRequest", [[["ROADKILL..."],["Respect Penalty:", -_respectDeduct]]]] call ExileServer_system_network_send_to;
						format["setAccountMoneyAndRespect:%1:%2:%3", _killer getVariable ["ExileMoney", 0], _newRespect, (getPlayerUID _killer)] call ExileServer_system_database_query_fireAndForget;
					};
				};
			};
		};

		if (_settings select 2 isEqualTo 1) then // If removeHeadGear setting is enabled
		{
			removeHeadGear _target;
		};

		if (_settings select 1 isEqualTo 1) then // If killEffect enabled
		{
			playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _target, false, getPosASL _target, 2, 1, 60];
			for "_u" from 1 to 12 do
			{
				if not(isObjectHidden _target) then
				{
					_target hideObjectGlobal true;
				} else
				{
					_target hideObjectGlobal false;
				};
				uiSleep 0.12;
			};
			_target hideObjectGlobal true;
			removeAllWeapons _target;
			// Automatic cleanup yaaay
			deleteVehicle _target;
		};
	};
};
