/*
    Author: IT07

    Description:
    gets config value of given var from VEMF config OR cfgPath

	Params:
	method 1:
		_this: STRING - SINGLE config value to get from root of CfgVemfReloaded
	method 2:
		_this select 0: ARRAY of STRINGS - MULTIPLE config values to get from root of VEMFconfig
	method 3:
		_this select 0: ARRAY of STRINGS - config path to get value from. Example: "root","subclass"
		_this select 1: ARRAY of STRINGS - MULTIPLE config values to get from given path

    Returns:
    ARRAY - Result
*/

private["_r","_check","_v"];
_r = [];
_check =
{
	if (isNumber _cfg) then
	{
		_v = getNumber _cfg
	} else
	{
		if (isText _cfg) then
		{
			_v = getText _cfg
		} else
		{
			if (isArray _cfg) then
			{
				_v = getArray _cfg
			};
		};
	};
};

if (_this isEqualType "") then
{
	private ["_cfg"];
	if (isNull (configFile >> "CfgVemfReloadedOverrides" >> _this)) then
	{
		_cfg = configFile >> "CfgVemfReloaded" >> _this;
	} else
	{
		_cfg = configFile >> "CfgVemfReloadedOverrides" >> _this;
	};
	call _check;
	if not isNil"_v" then
	{
		_r = _v;
	};
};

if (_this isEqualType []) then
{
	if (_this isEqualTypeArray [[],[]]) then
	{
		private ["_path","_build"];
		_path = _this select 0;
		//["fn_getSetting", 1, format["_path = %1", _path]] spawn VEMFr_fnc_log;
		_build =
		{
			{
				_cfg = _cfg >> _x;
			} forEach _path;
		};
		{
			private ["_cfg"];
			_cfg = configFile >> "CfgVemfReloadedOverrides";
			call _build;
			_cfg = _cfg >> _x;
			//["fn_getSetting", 1, format["_cfg after first build = %1", _cfg]] spawn VEMFr_fnc_log;
			if (isNull _cfg) then
			{
				//["fn_getSetting", 1, format["_cfg isNull. Resetting _cfg...."]] spawn VEMFr_fnc_log;
				_cfg = configFile >> "CfgVemfReloaded";
				call _build;
				_cfg = _cfg >> _x;
				//["fn_getSetting", 1, format["_cfg after second build = %1", _cfg]] spawn VEMFr_fnc_log;
			};
			//["fn_getSetting", 1, format["_cfg after appending _x = %1", _cfg]] spawn VEMFr_fnc_log;
			call _check;
			if not isNil"_v" then
			{
				_r pushBack _v
			};
		} forEach (_this select 1);
	};
	if (_this isEqualTypeArray [[]]) then
	{
		{
			private ["_cfg"];
			_cfg = configFile >> "CfgVemfReloadedOverrides" >> _x;
			if (isNull _cfg) then
			{
				_cfg = configFile >> "CfgVemfReloaded" >> _x;
			};
			call _check;
			_r pushBack _v;
		} forEach (_this select 0);
	};
};

_r
