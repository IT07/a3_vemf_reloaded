/*
   Author: IT07

   Description:
   returns the appID of given DLC

   Params:
   _this: STRING - name of DLC/Expansion

   Returns:
   SCALAR - appID
*/

getNumber ( configFile >> "CfgAppIDs" >> _this );
