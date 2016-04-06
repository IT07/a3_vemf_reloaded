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

private["_cfg","_v","_r","_path","_check"];
_r = [];
_check =
{
	if (isNumber _cfg) then
	{
		_v = getNumber _cfg
	};
	if not(isNumber _cfg) then
	{
		if (isText _cfg) then
		{
			_v = getText _cfg
		};
		if not(isText _cfg) then
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
	_cfg = configFile >> "CfgVemfReloaded" >> _this;
	call _check;
	if not(isNil"_v") then
	{
		_r = _v;
	};
};

if (_this isEqualType []) then
{
	if (count _this isEqualTo 2) then
	{
		_cfg = configFile >> "CfgVemfReloaded";
		_path = _cfg;
		{
			_path = _path >> _x; // Build the config path
		} forEach (_this select 0);
		{
			_cfg = _path >> _x;
			call _check;
			if not isNil"_v" then
			{
				_r pushBack _v
			};
		} forEach (_this select 1);
	};
	if (count _this isEqualTo 1) then
	{
		{
			_cfg = configFile >> "CfgVemfReloaded" >> _x;
			call _check;
			_r pushBack _v;
		} forEach (_this select 0);
	};
};

if isNil"_v" then { _r = nil };
_r
