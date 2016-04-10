/*
   Author: IT07

   Description: checks the side of given unit and returns it

   Params:
   _this: STRING - unit classname

   Returns: SIDE - unit's side
*/

private ["_return","_cfg","_faction"];
if (_this isEqualType "") then
{
   _cfg = configFile >> "CfgVehicles" >> _this >> "faction";
   if not isNull _cfg then
   {
      _faction = getText _cfg;
      switch _faction do
      {
         case "BLU_G_F":
         {
            _return = WEST;
         };
         case "CIV_F":
         {
            _return = civilian;
         };
         case "IND_F":
         {
            _return = independent;
         };
         case "IND_G_F":
         {
            _return = resistance;
         };
         case "OPF_F":
         {
            _return = EAST;
         };
         default
         {
            ["fn_checkSide", 0, format["Fatal error; Unknown faction '%1'", _faction]] spawn VEMFr_fnc_log;
         };
      };
   };
};

_return
