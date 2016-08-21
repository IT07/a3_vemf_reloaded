/*
   Author: IT07

   Description:
   returns the appID of given DLC

   Params:
   _this: STRING - name of DLC/Expansion

   Returns:
   SCALAR - appID
*/

private "_r";
_r = getNumber ( configFile >> "CfgAppIDs" >> _this );
if not ( isNil "_r" ) then { _r };
