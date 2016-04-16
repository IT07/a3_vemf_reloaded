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
   private ["_cfg"];
   _cfg = configFile >> "CfgVehicles" >> _this >> "faction";
   if not isNull _cfg then
   {
      scopeName "isNull";
      private ["_faction"];
      _faction = getText _cfg;
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
      if (_faction isEqualTo "OPF_F") then
      {
         _return = EAST;
      };
   };
   _return
};
