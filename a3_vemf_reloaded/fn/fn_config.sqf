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

private [("_r"),("_chck"),("_v"),("_cfg")];
_r = [];
_chck =
	{
		if (isNumber _cfg) then { _v = getNumber _cfg };
		if (isText _cfg) then {	_v = toLower (getText _cfg) };
		if (isArray _cfg) then { _v = getArray _cfg };
	};

if (_this isEqualType "") then
	{
		if (isNull (configFile >> "CfgVemfReloadedOverrides" >> _this)) then
			{
				_cfg = configFile >> "CfgVemfReloaded" >> _this;
			} else
			{
				_cfg = configFile >> "CfgVemfReloadedOverrides" >> _this;
			};
			call _chck;
			_r = _v;
	};

if (_this isEqualType []) then
	{
		if (_this isEqualTypeArray [[],[]]) then
			{
				private [("_p"),("_b")];
				_p = _this select 0;
				_b =
					{
						{
							_cfg = _cfg >> _x;
						} forEach _p;
					};
				{
					_cfg = configFile >> "CfgVemfReloadedOverrides";
					call _b;
					_cfg = _cfg >> _x;
					if (isNull _cfg) then
						{
							_cfg = configFile >> "CfgVemfReloaded";
							call _b;
							_cfg = _cfg >> _x;
						};
					call _chck;
					_r pushBack _v;
				} forEach (_this select 1);
			};
		if (_this isEqualTypeArray [[]]) then
			{
				{
					_cfg = configFile >> "CfgVemfReloadedOverrides" >> _x;
					if (isNull _cfg) then
						{
							_cfg = configFile >> "CfgVemfReloaded" >> _x;
						};
					call _chck;
					_r pushBack _v;
				} forEach (_this select 0);
			};
	};

_r
