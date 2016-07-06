/*
   Author: IT07

   Description: checks the side of given unit and returns it

   Params:
   _this: STRING - unit classname

   Returns: SIDE - unit's side
*/

private ["_r","_f"];
_f = getText (configFile >> "CfgVehicles" >> _this >> "faction");
if not(_f isEqualTo "") then
   {
      scopeName "isNull";
      if (_f isEqualTo "BLU_G_F") then
         {
            _r = WEST;
            breakOut "isNull";
         };
      if (_f isEqualTo "CIV_F") then
         {
            _r = civilian;
            breakOut "isNull";
         };
      if (_f isEqualTo "IND_F") then
         {
            _r = independent;
            breakOut "isNull";
         };
      if (_f isEqualTo "IND_G_F") then
         {
            _r = resistance;
            breakOut "isNull";
         };
      if (_f isEqualTo "OPF_G_F") then
         {
            _r = EAST;
         };
   } else
   {
      ["fn_checkSide", 0, format["Failed to find faction of %1", _this]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
   };

if not(isNil "_r") then
   {
      _r
   };
