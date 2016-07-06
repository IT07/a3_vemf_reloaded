/*
	Author: IT07

	Description:
	can find a location or pos randomly on the map where there are no players

	Params:
	_this select 0: STRING - Mode to use. Options: "loc" or "pos"
	_this select 1: BOOLEAN - True if _pos needs to be a road
	_this select 2: POSITION - Center for nearestLocations check
	_this select 3: SCALAR - Distance in meters. Locations closer than given position will be excluded/included
	_this select 4: SCALAR - Max prefered distance in meters from center. If not achievable, further dest will be selected
	_this select 5: SCALAR - Distance in meters to check from _this2 for players
	_this select 6: STRING (optional) - Exact config name of mission override settings to load

	Returns:
	if mode == loc: LOCATION
	if mode == pos: POSITION
*/

private [
	"_r","_this0","_this1","_this2","_this3","_this4","_this5","_this6",
	"_s0","_s1","_s2","_s3",
	"_ms0",
	"_rad","_arr","_bin","_used","_fltr","_badNames","_maps","_bad",
	"_pos","_xx","_pos","_hi","_low","_dist","_loc"
];

params [
	["_this0", "", [""]],
	["_this1", false, [false]],
	["_this2", [], [[]]],
	["_this3", -1, [0]],
	["_this4", -1, [0]],
	["_this5", -1, [0]],
	["_this6", "", [""]]
];

([["nonPopulated","noMissionPos","missionDistance","missionList"]] call VEMFr_fnc_config) params ["_s0","_s1","_s2","_s3"];
([[_this6],["skipDistanceReversed"]] call VEMFr_fnc_config) params ["_ms0"];

if (_this6 in _s3) then
	{
		_s0 = ([[_this6],["nonPopulated"]] call VEMFr_fnc_config) select 0;
	};

_rad = 5000;
if (_this0 isEqualTo "loc") then
	{
		// Get a list of locations close to _this2 (position of player)
		_arr = nearestLocations [_this2, ["CityCenter","Strategic","StrongpointArea","NameVillage","NameCity","NameCityCapital",if (_s0 isEqualTo 1) then {"nameLocal","Area","BorderCrossing","Hill","fakeTown","Name","RockArea","ViewPoint"}], if (_ms0 > 0) then {_ms0*2} else {worldSize}];
		if ((count _arr) > 0) then
			{
				_maps = "isClass _x" configClasses (configFile >> "CfgVemfReloaded" >> "locationBlackLists");
				{ // Make a list of locationBlackLists's children
					_maps set [_forEachIndex, toLower (configName _x)];
				} forEach _maps;

				if ((toLower worldName) in _maps) then
					{
						_bad = ([["locationBlackLists", worldName],["locations"]] call VEMFr_fnc_config) select 0
					} else
					{
						_bad = ([["locationBlackLists","Other"],["locations"]] call VEMFr_fnc_config) select 0
					};

				_bin = [];
				_used = uiNamespace getVariable ["VEMFrUsedLocs",[]];

				_fltr =
					{
						scopeName "filter";
						_xx = _x;
						{
							if (((_x select 0) distance (locationPosition _xx)) <= (_x select 1)) then { _bin pushBack _xx; breakOut "filter" };
						} forEach _s1;

						if (_x in _used) then { _bin pushBack _x }
							else
							{
								{
									if (((locationPosition _xx) distance (locationPosition _x)) < _s2) then { _bin pushBack _xx; breakOut "filter" };
								} forEach _used;
							};

						if ((text _x) in _bad) then { _bin pushBack _x };
					};
				{
					_dist = _this2 distance (locationPosition _x);
					if (_ms0 > 0) then
						{
							if ((_dist <= (_ms0*2)) AND (_dist > _ms0)) then { call _fltr }
								else { _bin pushBack _x };
						} else
						{
							if (_dist > _this3) then { call _fltr }
								else { _bin pushBack _x };
						};
				} forEach _arr;

				{ // Remove all invalid locations from _arr
					_arr deleteAt (_arr find _x);
				} forEach _bin;

				// Check what kind of distances we have
				_low = []; // Closer then _this4
				_hi = []; // Further than _this4
				{
					_dist = _this2 distance (locationPosition _x);
					if (_dist > _this4) then { _hi pushBack _x };
					if (_dist <= _this4) then { _low pushBack _x };
				} forEach _arr;

				// Check if there are any prefered locations. If yes, randomly select one
				if ((count _low) > 0) then
					{
						_loc = selectRandom _low;
						_r = _loc;
						_used pushBackUnique _loc;
					} else
					{
						if ((count _hi) > 0) then
							{
								_loc = selectRandom _hi;
								_r = _loc;
								_used pushBackUnique _loc;
							};
					};
			};
	};

if (_this0 isEqualTo "pos") then
	{
		for "_p" from 1 to 10 do
			{
				_pos = [_this2, _this3, -1, 2, 0, 50, 0] call BIS_fnc_findSafePos;
				if _this1 then { _pos = position (nearRoads select 0) };
				if not([_pos, _this5] call VEMFr_fnc_playerNear) then
					{
						_r = _pos;
					};
			};
	};

if not(isNil "_r") then { _r };
