/*
   Author: IT07

   Description: checks the side of given unit and returns it

   Params:
   _this: STRING - unit classname

   Returns: SIDE - unit's side
*/

private ["_return"];
if (_this isEqualType "") then
   {
      private ["_faction"];
      _faction = getText (configFile >> "CfgVehicles" >> _this >> "faction");
      if not(_faction isEqualTo "") then
         {
            scopeName "isNull";
            if (_faction isEqualTo "BLU_G_F") then
               {
                  _return = WEST;
                  breakOut "isNull";
               };
            if (_faction isEqualTo "CIV_F") then
               {
                  _return = civilian;
                  breakOut "isNull";
               };
            if (_faction isEqualTo "IND_F") then
               {
                  _return = independent;
                  breakOut "isNull";
               };
            if (_faction isEqualTo "IND_G_F") then
               {
                  _return = resistance;
                  breakOut "isNull";
               };
            if (_faction isEqualTo "OPF_G_F") then
               {
                  _return = EAST;
               };
         } else
         {
            ["fn_checkSide", 0, format["Failed to find faction of %1", _this]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
         };
         if not isNil "_return" then
            {
               _return
            };
   };
