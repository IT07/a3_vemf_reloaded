/*
    Author: IT07

    Description:
    selects a headless client with least (VEMFr) load

    Params:
    None

    Returns:
    OBJECT - the headless client
*/

private ["_r","_n","_arr","_gl"];
_n = "headLessClientNames" call VEMFr_fnc_config;
_arr = [];
_gl = uiNamespace getVariable "VEMFrHcLoad";
{
   if (((side _x) isEqualTo sideLogic) AND ((name _x) in _n)) then
      {
         _arr pushBackUnique _x;
         if not(_x in (_gl select 0)) then
            {
               _i = (_gl select 0) pushBack _x;
               (_gl select 1) set [_i, 0];
            };
      };
} forEach playableUnits;

_l = 99999;
{
   if (_x <= _l) then { _l = _x };
} forEach (_gl select 1);

_r = (_gl select 0) select ((_gl select 1) find _l);
(_gl select 1) set [(_gl select 0) find _r, _l + 1];

_r
