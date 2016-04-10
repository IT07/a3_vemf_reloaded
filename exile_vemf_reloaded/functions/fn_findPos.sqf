/*
	Author: IT07

	Description:
	can find a location or pos randomly on the map where there are no players

	Params:
	_this select 0: STRING - Mode to use. Options: "loc" or "pos"
	_this select 1: BOOLEAN - True if _pos needs to be a road
	_this select 2: POSITION - Center for nearestLocations check
	_this select 3: SCALAR - Distance in meters. Locations closer than that will be excluded
	_this select 4: SCALAR - Max prefered distance in meters from center. If not achievable, further dest will be selected
	_this select 5: SCALAR - Distance in meters to check from _cntr for players
	_this select 6: STRING (optional) - Exact config name of mission override settings to load

	Returns:
	if mode = loc then: ARRAY - format [name of town/location, town position]
	if mode = pos then POSITION
*/

private ["_settings","_locPos","_loc","_locName","_ret","_continue","_settings","_blackList","_usedLocs","_checkRange","_tooCloseRange","_maxPrefered","_skipDistance","_nonPopulated","_mode","_pos","_hasPlayers","_blackPos","_checkBlackPos"];

_ret = false;
// Define settings
_settings = [["nonPopulated","noMissionPos","missionDistance"]] call VEMFr_fnc_getSetting;
_nonPopulated = _settings param [0, 1, [0]];
_blackPos = _settings param [1, [], [[]]];
_missionDistance = _settings param [2, 3000, [0]];
_range = worldSize;
// Settings override system
_missionConfigName = param [6, "", [""]];
if not(_missionConfigName isEqualTo "") then
{
	_nonPopulatedOverride = ([[_missionConfigName],["nonPopulated"]] call VEMFr_fnc_getSetting) select 0;
	if not isNil"_nonPopulatedOverride" then
	{
		if not(_nonPopulatedOverride isEqualTo -1) then
		{
			_nonPopulated = _nonPopulatedOverride;
		};
	};
};
_checkBlackPos = false;
if (count _blackPos > 0) then
{
	_checkBlackPos = true;
};
_mode = param [0, "", [""]];
if not(_mode isEqualTo "") then
{
	_onRoad = param [1, false, [false]];
	_roadRange = 5000;
	_cntr = param [2, [], [[]]];
	if (_cntr isEqualTypeArray [0,0,0]) then
	{
		_tooCloseRange = param [3, -1, [0]];
		if (_tooCloseRange > -1) then
		{
			_maxPrefered = param [4, -1, [0]];
			if (_maxPrefered > -1) then
			{
				_skipDistance = param [5, -1, [0]];
				if (_skipDistance > -1) then
				{
					if (_mode isEqualTo "loc") then
					{
						// Get a list of locations close to _cntr (position of player)
						_locs = nearestLocations [_cntr, ["CityCenter","Strategic","StrongpointArea","NameVillage","NameCity","NameCityCapital",if(_nonPopulated isEqualTo 1)then{"nameLocal","Area","BorderCrossing","Hill","fakeTown","Name","RockArea","ViewPoint"}], _range];
						if (count _locs > 0) then
						{
							_usedLocs = uiNamespace getVariable "VEMFrUsedLocs";
							_remLocs = [];
							_blackListMapClasses = "true" configClasses (configFile >> "CfgVemfReloaded" >> "locationBlackLists");
							_listedMaps = []; // Define
							{ // Make a list of locationBlackLists's children
								_listedMaps pushBack (configName _x);
							} forEach _blackListMapClasses;
							private ["_blackList"];
							if (worldName in _listedMaps) then { _blackList = ([["locationBlackLists", worldName],["locations"]] call VEMFr_fnc_getSetting) select 0 };
							if not(worldName in _listedMaps) then { _blackList = ([["locationBlackLists","Other"],["locations"]] call VEMFr_fnc_getSetting) select 0 };

							{ // Check _locs for invalid locations (too close, hasPlayers or inBlacklist)
								_hasPlayers = [locationPosition _x, _skipDistance] call VEMFr_fnc_checkPlayerPresence;
								if _hasPlayers then
								{
									_remLocs pushBack _x;
								};
								if not _hasPlayers then
								{
									if _checkBlackPos then
									{
										private ["_locPos","_loc"];
										_locPos = locationPosition _x;
										_loc = _x;
										{
											if (count _x isEqualTo 2) then
											{
												_pos = _x param [0, [0,0,0], [[]]];
												if not(_pos isEqualTo [0,0,0]) then
												{
													_range = _x param [1, 600, [0]];
													if ((_pos distance _locPos) < _range) then
													{
														_remLocs pushBack _loc;
													};
												};
											};
											if not(count _x isEqualTo 2) then
											{
												["fn_findPos", 0, format["found invalid entry in mission blacklist: %1", _x]] spawn VEMFr_fnc_log;
											};
										} forEach _blackPos;
									};
									if ((text _x) in _blackList) then
									{
										_remLocs pushBack _x;
									};
									if not((text _x) in _blackList) then
									{
										if (_cntr distance (locationPosition _x) < _tooCloseRange) then
										{
											_remLocs pushBack _x;
										};
										if (_cntr distance (locationPosition _x) > _tooCloseRange) then
										{
											if (([text _x, locationPosition _x]) in _usedLocs) then
											{
												_remLocs pushBack _x;
											};
										};
									};
									if (count _usedLocs > 0) then
									{
										private ["_loc"];
										_loc = _x;
										{
											if (((locationPosition _loc) distance (_x select 1)) < _missionDistance) then
											{
												_remLocs pushBack _loc;
											};
										} forEach _usedLocs;
									};
								};
							} forEach _locs;

							{ // Remove all invalid locations from _locs
								_index = _locs find _x;
								_locs deleteAt _index;
							} forEach _remLocs;

							// Check what kind of distances we have
							_far = []; // Further than _maxPrefered
							_pref = []; // Closer then _maxPrefered
							{
								_dist = _cntr distance (locationPosition _x);
								if (_dist > _maxPrefered) then
								{
									_far pushBack _x;
								};
								if (_dist < _maxPrefered) then
								{
									_pref pushBack _x;
								};
							} forEach _locs;

							// Check if there are any prefered locations. If yes, randomly select one
							if (count _pref > 0) then
							{
								_loc = selectRandom _pref;
							};

							// Check if _far has any locations and if _pref is empty
							if (count _far > 0) then
							{
								if (count _pref isEqualTo 0) then
								{
									_loc = selectRandom _far;
								};
							};

							// Validate _locs just to prevent the .RPT from getting spammed
							if (count _locs > 0) then
							{
								// Return Name and POS
								_ret = [text _loc, locationPosition _loc];
								(uiNamespace getVariable "VEMFrUsedLocs") pushBack _ret;
							};
						};
					};
					if (_mode isEqualTo "pos") then
					{
						_valid = false;
						for "_p" from 1 to 10 do
						{
							if (_ret isEqualType true) then
							{
								if not _ret then
								{
									_pos = [_cntr, _tooCloseRange, -1, 2, 0, 50, 0] call BIS_fnc_findSafePos;
									if _onRoad then
									{
										_roads = _pos nearRoads _roadRange;
										if (count _roads > 0) then
										{
											private ["_closest","_dist"];
											_closest = ["", _roadRange];
											{ // Find the closest road
												_dist = _x distance _pos;
												if (_dist < (_closest select 1)) then
												{
													_closest = [_x, _dist];
												};
											} forEach _roads;
											_pos = position (_closest select 0);
										};
									};
									_hasPlayers = [_pos, _skipDistance] call VEMFr_fnc_checkPlayerPresence;
									if not(_hasPlayers) then
									{
										_ret = _pos;
									};
								};
							};
						};
					};
				};
			};
		};
	};
};

_ret
